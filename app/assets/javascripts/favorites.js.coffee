class Favorities
  initializeListeners: ->
    $('.icon-star, .icon-star-empty').on 'click', ->
      url = $(@).attr('href')
      method = $(@).data('method') || 'get'

      $.ajax
        url: url
        method: method
        complete: -> window.location.reload()

      false

$ ->
  (new Favorities()).initializeListeners()
