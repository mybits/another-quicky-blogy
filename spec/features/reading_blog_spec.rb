require 'spec_helper'

feature 'Reading the blog' do
	background do
		@post = Post.create(title: "Here is my blog post.", body: "A lot of stuff in here.")
		Post.create(title: "Another blog post.", body: "A lot of other stuff.")
	end

	scenario 'Reading the blog index' do
		visit root_path

		expect(page).to have_content "Here is my blog post."
		expect(page).to have_content "Another blog post."
	end

	scenario 'Reading individual blog' do
		visit root_path
		first(:link, "Here is my blog post.").click
		# click_link "Here is my blog post."     --> that was causing ambiguous match

		expect(current_path).to eq post_path(@post)
	end
end