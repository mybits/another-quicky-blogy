class PostsController < ApplicationController
	respond_to :html, :atom

	def index
		@posts = Post.order("created_at desc")
		respond_with @posts
	end

	def show
		@post = Post.find_by_id(params[:id])
		respond_with @post
	end

	def new
		@post = Post.new
	end

	def create
		@post =	Post.new(post_params)
		if @post.save
			redirect_to posts_path
		else
			render "new"
		end
	end	

	def edit
		@post = Post.find_by_id(params[:id])
	end

	def update
		@post = Post.find_by_id(params[:id])

		if @post.update(post_params)
			redirect_to posts_path
		else
			render "edit"
		end
	end

	def destroy
		post = Post.find_by_id(params[:id])
		post.destroy
		redirect_to posts_path, notice: "#{post.title} was deleted"
	end

	private 
		def post_params
			params.require(:post).permit(:title, :body)
		end

end
