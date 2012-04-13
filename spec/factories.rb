FactoryGirl.define do
	factory :rsvp do
		sequence(:email) { |n| "person_#{n}@example.com" }
	end

	factory :user do
		sequence(:email) { |n| "person_#{n}@example.com" }
		password 'password'
		country  'United States of America'
		state    'California'

		factory :admin do
			admin true
		end
	end
end