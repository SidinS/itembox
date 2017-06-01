class Share
  initializeListeners: ->
    $('.icon-share, .icon-check').on 'click', ->
      url = $(@).attr('href')
      method = $(@).data('method') || 'get'

      $.ajax
        url: url
        method: method
        complete: -> window.location.reload()

      false
$ ->
  (new Share()).initializeListeners()
