class PostsController < ApplicationController
	helper ExercisesHelper

	def index
		if not params[:start_date]
			redirect_to action: 'index', start_date: Date.today
		end
		@posts = Post.where("user_id = ?", session[:user_id])
	end

	def edit
		@user = User.find(session[:user_id])
		@post = Post.find_by(date: params[:date], user_id: session[:user_id])
		if params[:return_to]
			@return_to = params[:return_to]
		end
		if params[:note_id]
			@note_id = params[:note_id]
			@note_to_edit = Note.find(@note_id)
		end
	end

	def create
		if params[:date]
			@date = Date.parse(params[:date])
		else
			@date = Date.today
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
	end


	def destroy
		@post = Post.find_by(id: params[:id])
		date = @post.date
		@post.destroy
		if params[:return_to]
			redirect_to params[:return_to] + "?start_date=" + @post.date.to_s
		else
			redirect_to action: 'index', start_date: date
		end
	end

end
