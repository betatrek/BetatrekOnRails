time = 1000
$('.arrow, .grey-arrow').addClass 'right'
$('.subnav').slideUp time

$('nav a:not(.subnav a)').click (event) ->
  # disable default behavior
  event.preventDefault()

  # close expanded subsection
  if nav_clicked
    $(nav_clicked).find('div').addClass('right').removeClass('down')
    $(nav_clicked).next('.subnav').slideUp time 
  if nav_clicked == this 
    nav_clicked = undefined
  else
    nav_clicked = this
    $(this).find('div').addClass('down').removeClass('right')
    $(this).next('.subnav').slideDown time

  false
.hover -> $(this).find('div').addClass 'active',
-> $(this).find('div').removeClass 'active'