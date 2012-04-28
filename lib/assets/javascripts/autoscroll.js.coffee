# Function to automatically scroll to make an object visible above the fold
window.scrollToElement = (element) ->
	window_height  = $(window).window_height
	fold           = window_height
	element_height = element.height()
	element_bottom = element_height + element.offset().top

	if fold <= element_bottom
		$('html, body').animate { scrollTop: element_bottom - fold + 25 }, 2500

	# interrupt animation on scroll or click
	stopScrollAnimation = () -> $('html, body').stop()
	lastScrollTop = 0

	$(window).click(stopScrollAnimation).scroll () ->
		st = $(this).scrollTop();
		# if the user changes scroll direction stop scroll animation
		if st < lastScrollTop
			stopScrollAnimation()
		lastScrollTop = st 