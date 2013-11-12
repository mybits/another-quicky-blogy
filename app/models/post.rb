class Post < ActiveRecord::Base
	
	has_many :comments, dependent: :destroy
	validates_presence_of :title, :body

	def content
		MarkdownService.new.render(body)
	end
end
