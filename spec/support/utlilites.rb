def full_title page_title
	base_title = "betatrek"
	if page_title.empty?
		base_title
	else
		"#{base_title} > #{page_title}"
	end
end

def fill_signup_form_with_valid_information
	fill_in 'user_email',    with: "user@example.com"
	fill_in 'user_password', with: "password"
	select  'United States of America', from: 'user_country'
	select  'California',               from: 'user_state'
end

def fill_signup_form_with_invalid_information
	fill_in 'user_email',    with: "user@example"
	fill_in 'user_password', with: "pass"  	
end

def fill_signin_form_for user
	fill_in 'email', with: user.email
	fill_in 'password', with: user.password 
end