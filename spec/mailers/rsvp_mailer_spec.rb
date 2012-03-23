require "spec_helper"

describe RsvpMailer do
  
	describe "email_confirmation" do
		let(:rsvp) { FactoryGirl.create :rsvp }

		it "should send an email" do
			expect do 
				RsvpMailer.email_confirmation(rsvp).deliver
			end.to change(ActionMailer::Base.deliveries, :count).by(1)
		end

		describe "content" do
			let(:email) { RsvpMailer.email_confirmation rsvp }

			subject { email }

			its(:to) { should include rsvp.email }
			its(:subject) { should == 'Thank you for RSVPing' }
			its(:body) { should have_link 'Please let us know we got the correct email address.', 
										  href: confirm_url(rsvp.uid, rsvp.confirmation_code, host: "localhost:3000"),
										  method: :put }
		end
	end
end
