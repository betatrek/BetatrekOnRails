# Function for binding a modal window to open when an object is pressed
window.bindModalToLink = ($link, $modal, $body, $initializer) ->
    $link.click (evt) ->
      evt.preventDefault()

      if $initializer 
          $initializer()

       $modal.addClass 'intermediate'
       setTimeout -> 
          $modal.addClass 'active'
       , 50

       $modal.find('.dismiss').click (evt) ->
          evt.preventDefault()
          dismiss()

       $modal.find('form').submit (evt) -> dismiss()

       $body.keyup (evt) ->
          if evt.keyCode is 27 # ESC key
             dismiss()
            
    dismiss = ->
           $modal.addClass 'minimize'
           $modal.removeClass 'active' 
           setTimeout ->
               $modal.removeClass 'intermediate minimize'
           , 550
           $body.unbind 'keyup'
           $modal.find('.dismiss').unbind 'click'
    return