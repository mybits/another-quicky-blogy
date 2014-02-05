class CommentsController < ApplicationController
	before_filter :set_post
	respond_to :html, :json, :xml

	def create
		@post.comments.create(comment_params)
		respond_with @post, location: post_path
		end
	end

	def destroy
		comment = Comment.find_by_id(params[:id])
		comment.destroy
		redirect_to @post
	end

	private
		def comment_params
			params.require(:comment).permit(:author, :body)
		end

		def set_post
			@post = Post.find_by_id(params[:post_id])
		end
end
