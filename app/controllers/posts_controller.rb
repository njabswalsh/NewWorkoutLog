require "net/http"
require "uri"

class PostsController < ApplicationController
	helper ExercisesHelper
	helper PostsHelper
	helper NotesHelper
	include PostsHelper
	include ExercisesHelper

	def index
		if session[:user]
			if not params[:start_date]
				redirect_to action: 'index', start_date: Time.zone.now.to_date
			end
			@posts = Post.where("user_id = ?", session[:user_id])
		else
			flash[:error] = "You must be logged in to access that page"
			redirect_to controller: 'users', action: 'home'
		end	
	end

	def edit
		if session[:user]
			@user = User.find(session[:user_id])
			@post = Post.find_by(date: params[:date], user_id: session[:user_id])
			if params[:return_to]
				@return_to = params[:return_to]
			end
			if params[:note_id]
				@note_id = params[:note_id]
				@note_to_edit = Note.find(@note_id)
				@note_visibility = @note_to_edit.visibility.split(',').map(&:to_i)
			else
				@note_visibility = [-1]
			end
		else
			flash[:error] = "You must be logged in to access that page"
			redirect_to controller: 'users', action: 'home'
		end
	end

	def create
		if session[:user]
			if params[:date]
				@date = Date.parse(params[:date])
			else
				@date = Time.zone.now.to_date
				params[:date] = @date
			end

			@post = Post.find_by(date: @date, user_id: session[:user_id])
			if not @post
				@post = Post.new(:user_id => session[:user_id], :date => @date)
				if not @post.save
					redirect_to action: 'index', start_date: @date
					return
				end
			end
			redirect_to controller: 'posts', action: 'edit', date: @date, return_to: params[:return_to]
		else
			flash[:error] = "You must be logged in to access that page"
			redirect_to controller: 'users', action: 'home'
		end
	end


	def destroy
		if session[:user]
			@post = Post.find_by(id: params[:id])
			date = @post.date
			@post.destroy
			if params[:return_to]
				redirect_to params[:return_to] + "?start_date=" + @post.date.to_s
			else
				redirect_to action: 'index', start_date: date
			end
		else
			flash[:error] = "You must be logged in to access that page"
			redirect_to controller: 'users', action: 'home'
		end
	end

	def export
		if session[:user]
			@post = Post.find_by(id: params[:id])
			date = @post.date

			# Sign in to wolt
			signin_uri = URI.parse("http://www.workoutlogthing.com/?action=signIn")
			puts params[:wolt_email]
			puts params[:wolt_password]
			resp = Net::HTTP.post_form(signin_uri, {'email'=>params[:wolt_email],'signIn'=>'Sign+In', 'password'=>params[:wolt_password]})
			cookie = resp.response['set-cookie'].split('; ')[0]
			puts "########################################"
			day = date.day
			month = date.month
			year = date.year
			post_uri = URI('http://www.workoutlogthing.com/?action=saveEntry&day=' + day.to_s + '&month=' + month.to_s + '&year=' + year.to_s)
			http = Net::HTTP.new(post_uri.host, 80)
			post_html = get_post_html_for_wolt(@post)
			data = 'from=2016-9-23&workout=' + post_html + '&save=Update'
			headers = {'Cookie' => cookie}
			resp = http.post(post_uri.request_uri, data, headers)
			puts resp.body

			redirect_to controller: 'posts', action: 'edit', date: date, return_to: params[:return_to]
		else
			flash[:error] = "You must be logged in to access that page"
			redirect_to controller: 'users', action: 'home'
		end
	end

end
