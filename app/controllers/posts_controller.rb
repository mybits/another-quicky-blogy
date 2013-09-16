class PostsController < ApplicationController
	respond_to :html, :atom

	before_filter :authenticate, except: [:index, :show]
	before_filter :set_post, only: [:show, :edit, :update, :destroy]


	def index
		@posts = Post.order("created_at desc")
		respond_with @posts
	end

	def show
		respond_with @post
	end

	def new
		@post = Post.new
	end

	def create
		@post =	Post.new(post_params)
		if @post.save
			redirect_to posts_path, notice: "'#{@post.title}' post was added."
		else
			render "new"
		end
	end	

	def edit
	end

	def update
		if @post.update_attributes(post_params)
			redirect_to posts_path, notice: "#{@post.title} post was updated."
		else
			render "edit"
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path, notice: "#{@post.title} was deleted."
	end


	private 
		def post_params
			params.require(:post).permit(:title, :body)
		end

		def set_post
			@post = Post.find_by_id(params[:id])
		end

		def authenticate
			authenticate_or_request_with_http_basic do |name, password|
				name == "admin" && password == "secret"
			end
		end

end
