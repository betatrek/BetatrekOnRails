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
		it { should have_selector 'button', text: 'Begin!'}

		describe "account creation", js: true do
			let(:email) { "person_1@example.com" }
			let(:password) { "password" }
			before do
				fill_in 'email', with: email
				fill_in 'password', with: password
				click_on 'Begin!' 
			end

			it { should have_content 'Create a New Account' }
			specify { find_field('user_email').value.should == email }
			specify { find_field('user_password').value.should == password }
			it { should have_content 'By creating a new account you agree to our terms and conditions' }
			it { should have_link 'terms and conditions', href: 'terms-and-conditions.html' }
			it { should have_content 'Cancel' }
			it { should have_content 'Create Account' }

			describe "with valid information" do
				before do
					fill_signup_form_with_valid_information
				end

				it "should create the new user" do
					expect { click_on 'Create Account' }.should change(User, :count).by(1)
				end
			end
		end
	end
end