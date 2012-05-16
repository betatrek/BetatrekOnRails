require 'spec_helper'

describe "StaticPages" do

	subject { page }

	describe "Help page" do
		before { visit help_path }
		it { should have_content 'help' }
		it { should have_selector 'title', text: full_title('Help') } 
	end

	describe "Sign up page" do
		before { visit signup_path}

		describe "account sign in" do
			let(:user) { FactoryGirl.create :user }

			describe "with valid credentials", js: true do
				before do
					fill_signin_form_for user 
					click_on 'sign in'
				end

				it { should have_content 'sign out' }
			end
			
			describe "with invalid credentials", js: true do
				let(:false_user) { User.new email: "false@example.com", password: "password" }
				before do 
					fill_signin_form_for false_user 
					click_on 'sign in'
				end

				it { should_not have_content 'sign out' }
			end	
		end
	end
end
