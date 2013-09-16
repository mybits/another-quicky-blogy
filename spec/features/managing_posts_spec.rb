require 'spec_helper'


feature 'Managing blog post' do 
	scenario 'Guests cannot create posts' do
		visit root_path
		click_link 'New Post'

		expect(page).to_not have_link 'New Post'
	end

	context 'as an admin user' do
		background do 
			email = "admin@example.com"
			password = "password"
			@admin = AdminUser.create(:email => email, :password => password)

			log_in_admin_user
		end

		def log_in_admin_user(email = "admin@example.com", password = "password")
			reset_session!
			visit admin_root_path
			fill_in 'Email', with: email
			fill_in 'Password', with: password
			click_button 'Login'
		end


		scenario 'Posting a new blog' do
			# click_link 'Posts'
			visit root_path
			click_link 'New Post'

			fill_in 'post_title', with: "New Blog Post."
			fill_in 'post_body', with: "This post is made from the Admin Interface."
			
			click_button 'Create Post'

			expect(page).to have_content "This post is made from the Admin Interface."
		end

		context 'with an existing blog post' do 
			background do 
				@post = Post.create(title: "Here is my blog post.", body: "A lot of stuff in here.")
			end

			scenario 'editing and existing blog post' do 
				visit admin_post_path(@post)
				# visit root_path

				first(:link, "Edit").click

				fill_in 'Title', with: "Here is an update to my blog post."
				click_button 'Update Post'

				expect(page).to have_content "Here is an update to my blog post."
			end
		end
	end
end