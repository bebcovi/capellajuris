$ = jQuery

class Video
  constructor: (@obj) ->
    @obj.find('.edit').click @edit
    @obj.find('.delete input[type="submit"]').click @remove

  @getAll: (obj) ->
    obj.find('#videos > ul > li')

  @add: ->
    if not $(@).attr('disabled')?
      $(@).attr('disabled', 'disabled')
      button = $(@).parent()
      xhr = $.get $(@).attr('href'), (data) =>
        form = $(data).find 'form.video'
        button.fadeOut 'fast'
        button.after form
        form.fadeOut(0).delay('fast').fadeIn 'fast'

        form.find('.submit').click =>
          params = Ajax.params form

          xhr = $.ajax
            type: 'POST'
            url: form.attr 'action'
            data: params
            success: (data) =>
              obj = Video.getAll($(data)).last()

              $('#videos > ul').append obj

              form.fadeOut 'fast', -> $(@).remove()
              obj.fadeOut(0).delay('fast').fadeIn 'fast'
              button.delay().fadeIn 'fast'
              $(@).removeAttr('disabled')

              new Video obj

            error: Ajax.fail

          event.preventDefault()

        form.find('.cancel').click =>
          form.fadeOut 'fast', -> $(@).remove()
          button.delay('fast').fadeIn 'fast'
          $(@).removeAttr('disabled')
          event.preventDefault()

    event.preventDefault()

  edit: =>
    button = @obj.find('.edit')

    if not button.attr('disabled')?
      button.attr('disabled', 'disabled')
      xhr = $.get button.attr('href'), (data) =>
        form = $(data).find 'form.video'
        @obj.fadeOut 'fast'
        @obj.before form
        form.fadeOut(0).delay('fast').fadeIn 'fast'

        form.find('.submit').click =>
          xhr = $.ajax
            type: 'PUT'
            url: form.attr 'action'
            data:
              title: form.find('input[name="title"]').val()
              url: form.find('input[name="url"]').val()
            success: (data) =>
              form.fadeOut 'fast', -> $(@).remove()
              index = @obj.siblings().andSelf().index @obj
              @obj = Video.getAll($(data)).eq(index).replaceAll @obj
              @obj.fadeOut(0).delay('fast').fadeIn 'fast'
              button.removeAttr('disabled')

            error: Ajax.fail

          event.preventDefault()

        form.find('.cancel').click =>
          form.fadeOut 'fast', -> $(@).remove()
          @obj.delay('fast').fadeIn 'fast'
          button.removeAttr('disabled')
          event.preventDefault()

      xhr.fail Ajax.fail

    event.preventDefault()

  remove: =>
    controls = @obj.find '.center'
    url = controls.find('.delete').attr 'action'

    xhr = $.ajax
      type: 'DELETE'
      url: url
      success: (data) =>
        confirm = $(data).find '.confirm'
        controls.after confirm
        controls.fadeOut 'fast'
        confirm.fadeOut(0).delay('fast').fadeIn 'fast'
        confirm.addClass('center')

        confirm.find('.submit').click =>
          params = Ajax.params confirm

          $.ajax
            type: 'DELETE'
            url: url
            data: params

          @obj.fadeOut 'fast', -> $(@).remove()

          event.preventDefault()

        confirm.find('.cancel').click =>
          confirm.fadeOut 'fast', -> $(@).remove()
          controls.delay('fast').fadeIn 'fast'
          event.preventDefault()

      error: Ajax.fail

    event.preventDefault()

exports = @
exports.Video = Video
