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

       $modal.find('.close').click (evt) ->
          evt.preventDefault()
          close()

       $modal.find('form').submit (evt) -> close()

       $body.keyup (evt) ->
          if evt.keyCode is 27 # ESC key
             close()
            
    close = ->
           $modal.addClass 'minimize'
           $modal.removeClass 'active' 
           setTimeout ->
               $modal.removeClass 'intermediate minimize'
           , 550
           $body.unbind 'keyup'
           $modal.find('.close').unbind 'click'
    return