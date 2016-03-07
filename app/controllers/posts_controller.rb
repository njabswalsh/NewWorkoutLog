class PostsController < ApplicationController

	def index
		if not params[:start_date]
			redirect_to action: 'index', start_date: Date.today
		end
		@posts = Post.where("user_id = ?", session[:user_id])
	end

	def new
		if params[:date]
			@date = Date.parse(params[:date])
		else
			@date = Date.today
		end
		@post = Post.find_by(date: @date, user_id: session[:user_id])
		if @post
			redirect_to controller: 'posts', action: 'edit', date: @date
		else
			@post = Post.new
		end
	end

	def edit
		@post = Post.find_by(date: params[:date], user_id: session[:user_id])
		if not @post
			redirect_to controller: 'posts', action: 'new', date: params[:date]
		end
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			if params[:return_to]
				redirect_to params[:return_to] + "?start_date=" + @post.date.to_s
			else
				redirect_to action: 'index', start_date: @post.date
			end
		else
			render 'new'
		end
	end

	def update
		@post = Post.find_by(date: params[:date], user_id: session[:user_id])

		if @post.update(post_params)
			if params[:return_to]
				redirect_to params[:return_to] + "?start_date=" + @post.date.to_s
			else
				redirect_to action: 'index', start_date: params[:date]
			end
		else
			render 'edit'
		end
	end

	def destroy
		#@post = Post.find(params[:id])
		@post = Post.find_by(id: params[:id])
		date = @post.date
		@post.destroy
		if params[:return_to]
			redirect_to params[:return_to] + "?start_date=" + @post.date.to_s
		else
			redirect_to action: 'index', start_date: date
		end
	end

	private
		def post_params
			params.require(:post).permit(:user_id, :date, :workout, :notes)
		end
end
