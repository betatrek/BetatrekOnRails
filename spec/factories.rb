FactoryGirl.define do
	factory :rsvp do
		sequence(:email) { |n| "person_#{n}@example.com" }
	end
end