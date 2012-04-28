module SessionsHelper

	def sign_into_session user, options
		if options[:permanently]
			cookies.permanent[:remember_token] = user.remember_token
		else
			session[:remember_token] = user.remember_token
		end 
		current_user = user
	end

	def signed_in?
		false
	end
end
