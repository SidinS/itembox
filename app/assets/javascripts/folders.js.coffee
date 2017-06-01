class Folders
  initializeBestInPlace: ->
    $('.best_in_place').on 'ajax:success', (data) ->
      console.log(data)
    $('.best_in_place').best_in_place()

  initializeFileUpload: ->
    $('#item_file').fileupload
      dataType: 'script',
      done: (e, data) ->
        window.location.reload()
      add: (e, data) ->
        $.each data.files, (index, file) ->
          if (data.originalFiles[index]['size'] > 50000000)
            alert('Вы не можете загружать файлы размером больше 50 МБ')
          else
            data.submit()
      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $("#progress .bar").css('width', progress + '%')

  initializeListeners: ->
    @initializeBestInPlace()
    @initializeFileUpload()

$ ->
  (new Folders()).initializeListeners()

