class PostsController < ApplicationController

	def index
		@posts = Post.where("user_id = ?", session[:user_id])
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
			redirect_to action: 'index'
		else
			render 'new'
		end
	end

	def update
		@post = Post.where(date: params[:date], user_id: session[:user_id]).first

		if @post.update(post_params)
			redirect_to action: 'index'
		else
			render 'edit'
		end
	end

	def destroy
		#@post = Post.find(params[:id])
		@post = Post.where(date: params[:date], user_id: session[:user_id]).first
		puts @post
		@post.destroy

		redirect_to action: 'index'
	end

	private
		def post_params
			params.require(:post).permit(:user_id, :date, :workout, :notes)
		end
end
