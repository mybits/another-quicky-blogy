class PostsController < ApplicationController
	respond_to :html, :json, :xml, :atom

	before_filter :authenticate, except: [:index, :show]
	before_filter :set_post, only: [:show, :edit, :update, :destroy]


	def index
		@posts = Post.order("created_at desc").page(params[:page])
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
		flash[:notice] = @post.save ? "#{@post.title} post was added." : "Post failed to add."
		respond_with @post
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
