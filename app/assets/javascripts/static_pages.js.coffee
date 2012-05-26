# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Enables the sign in button to submit the sign in form 
$("#sign_in_button").click (event) -> 
	event.preventDefault()
	$("#sign_in_form").submit()
	false

# Load the Visualization API and the piechart package.
#google.load 'visualization', '1.0', 'packages': ['corechart']
      
# Set a callback to run when the Google Visualization API is loaded.
#google.setOnLoadCallback () ->
#    alert 'drawing'
#    # Create the data table.
#    data = new google.visualization.DataTable()
#    data.addColumn 'string', 'Topping'
#    data.addColumn 'number', 'Slices'
#    data.addRows [['Mushrooms', 3], ['Onions', 1], ['Olives', 1], ['Zucchini', 1], ['Pepperoni', 2]]

    # Set chart options
#    options = 
#       'title':  'How Much Pizza I Ate Last Night'
#       'width':  400
#       'height': 300

    # Instantiate and draw our chart, passing in some options.
#    chart = new google.visualization.PieChart $('#chart_div')
#    chart.draw data, options