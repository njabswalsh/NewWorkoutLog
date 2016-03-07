class PostsController < ApplicationController

	def index
		if not params[:start_date]
			redirect_to action: 'index', start_date: Date.today
		end
		@posts = Post.where("user_id = ?", session[:user_id])
	end

	def edit
		@post = Post.find_by(date: params[:date], user_id: session[:user_id])
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
			@post = Post.new(post_params)
			@post.save
		end
		redirect_to controller: 'posts', action: 'edit', date: @date
	end

	def destroy
		#@post = Post.find(params[:id])
		@post = Post.find_by(id: params[:id])
		date = @post.date
		@post.destroy
		if params[:return_to]
			redirect_to params[:return_to]
		else
			redirect_to action: 'index', start_date: date
		end
	end

	private
		def post_params
			params.require(:post).permit(:user_id, :date)
		end
end
