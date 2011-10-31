$ = jQuery

class Post
  constructor: (@obj) ->
    @obj.find('.edit').click @edit
    @obj.find('.delete input[type="submit"]').click @remove

  @isInNews: (obj) -> obj.closest('#news').length > 0

  @getAll: (obj) ->
    obj.find('#main article').not('#intro article, #members')

  @add: ->
    if not $(@).attr('disabled')?
      $(@).attr('disabled', 'disabled')
      button = $(@).parent()
      xhr = $.get $(@).attr('href'), (data) =>
        editor = $(data).find '#gollum-editor'
        button.fadeOut 'fast'
        button.after editor
        editor.fadeOut(0).delay('fast').fadeIn 'fast'

        $.GollumEditor()

        editor.find('#gollum-editor-submit').click =>
          params = Ajax.params editor

          xhr = $.ajax
            type: 'POST'
            url: editor.find('form').attr 'action'
            data: params
            success: (data) =>
              if Post.isInNews $(@)
                post = Post.getAll($(data)).first()
                button.after post
              else
                post = Post.getAll($(data)).last()
                button.before post

              editor.fadeOut 'fast', -> $(@).remove()
              post.fadeOut(0).delay('fast').fadeIn 'fast'
              button.delay().fadeIn 'fast'
              $(@).removeAttr('disabled')

              new Post post

            error: Ajax.fail

          event.preventDefault()

        editor.find('#gollum-editor-preview').click =>
          event.preventDefault()

        editor.find('#gollum-editor-cancel').click =>
          editor.fadeOut 'fast', -> $(@).remove()
          button.delay('fast').fadeIn 'fast'
          $(@).removeAttr('disabled')
          event.preventDefault()

    event.preventDefault()

  edit: =>
    button = @obj.find('.edit')

    if not button.attr('disabled')?
      button.attr('disabled', 'disabled')
      xhr = $.get button.attr('href'), (data) =>
        editor = $(data).find '#gollum-editor'
        @obj.fadeOut 'fast'
        @obj.before editor
        editor.fadeOut(0).delay('fast').fadeIn 'fast'

        $.GollumEditor()

        editor.find('#gollum-editor-submit').click =>
          params = Ajax.params editor

          xhr = $.ajax
            type: 'PUT'
            url: editor.find('form').attr 'action'
            data: params
            success: (data) =>
              editor.fadeOut 'fast', -> $(@).remove()
              index = @obj.siblings('article').andSelf().index @obj
              @obj = Post.getAll($(data)).add('#members').eq(index).replaceAll @obj
              @obj.fadeOut(0).delay('fast').fadeIn 'fast'
              button.removeAttr('disabled')

            error: Ajax.fail

          event.preventDefault()

        editor.find('#gollum-editor-preview').click =>
          event.preventDefault()

        editor.find('#gollum-editor-cancel').click =>
          editor.fadeOut 'fast', -> $(@).remove()
          @obj.delay('fast').fadeIn 'fast'
          button.removeAttr('disabled')
          event.preventDefault()

      xhr.fail Ajax.fail

    event.preventDefault()

  remove: =>
    controls = @obj.find '.controls'
    url = controls.find('.delete').attr 'action'

    xhr = $.ajax
      type: 'DELETE'
      url: url
      success: (data) =>
        confirm = $(data).find '.confirm'
        controls.after confirm
        controls.fadeOut 'fast'
        confirm.fadeOut(0).delay('fast').fadeIn 'fast'

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
exports.Post = Post
