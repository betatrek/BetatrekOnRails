# == Schema Information
#
# Table name: rsvps
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  uid        :string(255)
#

require 'spec_helper'

describe Rsvp do

	before { @rsvp = Rsvp.new email: "test@example.com" }

	subject { @rsvp }

	it { should respond_to :email }

	describe "when email not present" do
		before { @rsvp.email = " " }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		invalid_addresses = %w[uesr@mail,com user_at_mail.org example.user@mail.]
		invalid_addresses.each do |invalid_address|
			before { @rsvp.email = invalid_address }
			it { should_not be_valid }
		end
	end

	describe "when email format is valid" do
		valid_addresses = %w[user@mail.com A_USER@g.m.org frst.lst@mail.jp a+b@baz.cn]
		valid_addresses.each do |valid_address|
			before { @rsvp.email = valid_address }
			it { should be_valid }
		end
	end

	describe "when email is already taken" do
	    before do
	      rsvp_with_same_email = @rsvp.dup
	      rsvp_with_same_email.save
	    end

	    it { should_not be_valid }
	end
end
