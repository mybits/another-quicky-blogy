class CommentsController < ApplicationController
	before_filter :set_post

	def create
		@post.comments.create(comment_params)
		respond_to do |format|
			format.html { redirect_to @post }
			format.js
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
