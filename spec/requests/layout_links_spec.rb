require 'spec_helper'
#the following was added as part of integration testing.  These tests can be called application wide and are not bound to a specific request URL
describe "LayoutLinks" do

    it "Should have the right links on the layout" do
      visit root_path
      click_link "About"
      response.should have_selector('title', :content => "About")
      click_link "Help"
      response.should have_selector('title', :content => "Help")
      click_link "Contact"
      response.should have_selector('title', :content => "Contact")
      click_link "Home"
      response.should have_selector('title', :content => "Home")
      click_link "Sign up now!"
      response.should have_selector('title', :content => "Sign up")
    end

	it "should havea  Home page at '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
	end
	
	it "should have a Contact page at '/contact'" do
		get '/contact'
		response.should have_selector('title', :content => "Contact")
	end
	
	it "should have an About page at '/about'" do
		get '/about'
		response.should have_selector('title', :content => "About")
	end
	
	it "should have a Help page at '/help'" do
		get '/help'
		response.should have_selector('title', :content => "Help")
	end
	
	#not that this is requesting a page inside a different controller from the above...integration tests are cool!
	it "should have a signup page at '/signup'" do
	  get '/signup'
	  response.should have_selector('title', :content => "Sign up")
	end
end