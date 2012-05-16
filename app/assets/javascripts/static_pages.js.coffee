# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Enables the sign in button to submit the sign in form 
$("#sign_in_button").click (event) -> 
	event.preventDefault()
	$("#sign_in_form").submit()
	false