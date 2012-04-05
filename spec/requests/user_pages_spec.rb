require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector 'title', text: full_title('create account') }
		it { should have_content 'sign in' }
		it { should have_content 'register' }
		it { should have_content 'Algorithmic advice no matter the class.' }
		it { should have_content 'Begin Here' }
	end
end