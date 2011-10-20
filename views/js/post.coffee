$ = jQuery

class Post
  constructor: (@obj) ->

  remove: =>
    controls = @obj.find '.controls'
    url = controls.find('.delete').attr 'action'

    xhr = $.ajax
      type: 'DELETE'
      url: url
      success: (data) =>
        @data = $(data).find '.confirm'
        controls.after @data
        controls.fadeOut 'fast'
        @data.fadeOut 0
        @data.delay('fast').fadeIn 'fast'

        @data.submit =>
          $.ajax
            type: 'DELETE'
            url: url
            data:
              confirmation: @data.find('input[name="confirmation"]').val()

          controls.closest('article').fadeOut 'fast', -> $(@).remove()

          event.preventDefault()

        @data.find('a').click =>
          @data.fadeOut 'fast', -> $(@).remove()
          controls.delay('fast').fadeIn 'fast'

          event.preventDefault()

      error: (xhr, status, msg) ->
        console.error msg
        $(@).click()

    event.preventDefault()

exports = @
exports.Post = Post
