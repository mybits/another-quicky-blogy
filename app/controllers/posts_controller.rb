class PostsController < ApplicationController
	respond_to :html

	def index
		@posts = Post.order("created_at desc")
		respond_with @posts
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
		post = Post.find_by_id(params[:id])
		post.update_columns(params[:post])
		redirect_to posts_path
	end

	def destroy
		post = Post.find_by_id(params[:id])
		post.destroy
		flash[:notice] = "#{post.title} was deleted"
		redirect_to posts_path
	end

	private 
		def post_params
			params.require(:post).permit(:title, :body)
		end

end
