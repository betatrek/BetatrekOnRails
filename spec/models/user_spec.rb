# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  email             :string(255)
#  password_digest   :string(255)
#  admin             :boolean
#  uid               :string(255)
#  confirmation_code :string(255)
#  country           :string(255)
#  state             :string(255)
#  remember_token    :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  status            :string(255)
#

require 'spec_helper'

describe User do

	before { @user = User.new name: "Example User", email: "user@example.com", 
							  password: "password", country: "United States of America", state: "California" }

	subject { @user }

	it { should respond_to :name }
	it { should respond_to :email }
	it { should respond_to :admin }
	it { should respond_to :password }
	it { should respond_to :uid }
	it { should respond_to :status }
	it { should respond_to :confirmation_code }
	it { should respond_to :country }
	it { should respond_to :state }
	it { should respond_to :remember_token }

	it { should be_valid }
	it { should_not be_admin }

	describe "with admin attribute set to true" do
		before { @user.toggle! :admin }

		it { should be_admin }
	end

	describe "Validation" do
		describe "when name is too long" do
			before { @user.name = "a" * 51 }
			it { should_not be_valid }
		end

		describe "when email not present" do
			before { @user.email = " " }
				it { should_not be_valid }
		end

		describe "when email format is invalid" do
			invalid_addresses = %w[uesr@mail,com user_at_mail.org example.user@mail.]
			invalid_addresses.each do |invalid_address|
				before { @user.email = invalid_address }
				it { should_not be_valid }
			end
		end

		describe "when email format is valid" do
			valid_addresses = %w[user@mail.com A_USER@g.m.org frst.lst@mail.jp a+b@baz.cn]
			valid_addresses.each do |valid_address|
				before { @user.email = valid_address }
				it { should be_valid }
			end
		end

		describe "when email address is already taken" do
			before do
				user_with_same_email = @user.dup
				user_with_same_email.email = @user.email.upcase
				user_with_same_email.save
			end

			it { should_not be_valid }
		end

		describe "when password is not present" do
			before { @user.password = " " }
			it { should_not be_valid }
		end

		describe "with a password that's too short" do
			before { @user.password = "a" * 5 } 
			it { should_not be_valid }
		end

		describe "when country is not present" do
			before { @user.country = " " }
			it { should_not be_valid }
		end

		describe "when country format is invalid" do
			invalid_countries = %w[Finite Rock usa Im]
			invalid_countries.each do |invalid_countries|
				before { @user.country = invalid_countries }
				it { should_not be_valid }
			end
		end

		describe "when country format is valid" do
			User::COUNTRIES.each do |valid_country|
				before { @user.country = valid_country }
				it { should be_valid }
			end
		end

		describe "when state is not present" do
			before { @user.state = " " }
			it { should_not be_valid }
		end

		describe "when state format is invalid" do
			invalid_states = %w[Finite Rock arz]
			invalid_states.each do |invalid_state|
				before { @user.state = invalid_state }
				it { should_not be_valid }
			end
		end

		describe "when state format is valid" do
			valid_states = %w[California Arizona Georgia]
			User::STATES.each do |valid_state|
				before { @user.state = valid_state }
				it { should be_valid }
			end
		end
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_email @user.email }

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate "invalid" }

			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end

	describe "columns generated at save time" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
		its(:confirmation_code) { should_not be_blank }
		its(:uid) { should_not be_blank }
		its(:status) { should_not be_blank }
	end
end
