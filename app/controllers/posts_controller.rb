class PostsController < ApplicationController

	def index
		@posts = Post.where("user_id = ?", session[:user_id])
		@nothing = "hi"
	end

	def show
		@post = Post.find(params[:id])
	end
	
	def new
		@post = Post.new
		if params[:date]
			@date = Date.parse(params[:date])
		else
			@date = Date.today
		end
	end

	def edit
		@post = Post.where(date: params[:date], user_id: session[:user_id]).first
		if not @post
			#redirect_to controller: 'posts/new', date: params[:date]
			redirect_to controller: 'posts', action: 'new', date: params[:date]
		end		
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private
		def post_params
			params.require(:post).permit(:user_id, :date, :workout, :notes)
		end
end
