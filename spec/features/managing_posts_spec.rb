require 'spec_helper'


feature 'Managing blog post' do 
	scenario 'Guests can not create post' do
		visit root_path
		click_link 'New Post'

		expect(page).to have_content 'Access denied'
	end

	scenario 'Posting a new blog' do
		visit root_path

		page.driver.browser.authorize 'admin', 'secret'
		click_link 'New Post'

		expect(page).to have_content "Create a new post"

		fill_in 'Title', with: "A bit of spaghetti code?"
		fill_in 'Content', with: "It's not so tasty as you would imagine."

		click_button 'Create Post'
		expect(page).to have_content "A bit of spaghetti code?"
	end

	context 'with an existing blog post' do 
		background do 
			@post = Post.create(title: "Here is my blog post.", body: "A lot of stuff in here.")
		end

		scenario 'editing and existing blog post' do 
			visit root_path

			page.driver.browser.authorize 'admin', 'secret'
			first(:link, "Edit").click

			fill_in 'Title', with: "Here is an update to my blog post."
			click_button 'Update Post'

			expect(page).to have_content "Here is an update to my blog post."
		end
	end
end