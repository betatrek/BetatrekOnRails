require 'spec_helper'

describe "StaticPages" do

	subject { page }
  
	describe "Home page" do
		before { get root_path }
		specify { response.should redirect_to rsvp_path }
	end

	describe "Help page" do
		before { visit help_path }
		it { should have_content 'help' }
		it { should have_selector 'title', text: full_title('Help') } 
	end
end
