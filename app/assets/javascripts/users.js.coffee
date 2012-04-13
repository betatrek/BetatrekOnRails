# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# modal create account window
bindModalToLink $('#begin_account_creation'), $('#creation'), $('body'), ->
	# Copy the email address and password entered in the "begin here" form
	$('#user_email').val $('#signup_email').val()
	$('#user_password').val $('#signup_password').val()