require 'spec_helper'

describe "StaticPages" do

	subject { page }

	describe "Help page" do
		before { visit help_path }
		it { should have_content 'help' }
		it { should have_selector 'title', text: full_title('Help') } 
	end
end
