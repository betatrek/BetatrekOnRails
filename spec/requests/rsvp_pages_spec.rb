require 'spec_helper'

describe "RsvpPages" do

	subject { page }

	describe "new" do
		before { visit rsvp_path }
		
		it { should have_selector 'title', text: full_title('Invitation') }
		it { should have_content 'Get Invited' }
		it { should have_content 'betatrek' }
	end
end
