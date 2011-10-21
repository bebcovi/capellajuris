$ = jQuery

class Post
  constructor: (@obj) ->
    @obj.find('.edit').click @edit
    @obj.find('.delete input[type="submit"]').click @remove
    if @obj.parent('#news') then Post.items.push(@) else Post.items.unshift(@)

  @items: []

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
          xhr = $.ajax
            type: 'POST'
            url: editor.find('form').attr 'action'
            data:
              page: editor.find('input[name="page"]').val()
              text: editor.find('#gollum-editor-body').val()
            success: (data) =>
              post = Post.getAll($(data)).first()

              editor.fadeOut 'fast', -> $(@).replaceWith post
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
          xhr = $.ajax
            type: 'PUT'
            url: editor.find('form').attr 'action'
            data:
              page: editor.find('input[name="page"]').val()
              text: editor.find('#gollum-editor-body').val()
            success: (data) =>
              editor.fadeOut 'fast', -> $(@).remove()
              @obj = Post.getAll($(data)).eq(Post.items.indexOf(@)).replaceAll @obj
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
        confirm.fadeOut 0
        confirm.delay('fast').fadeIn 'fast'

        confirm.find('.submit').click =>
          $.ajax
            type: 'DELETE'
            url: url
            data:
              confirmation: confirm.find('.submit').val()
            success: =>
              Post.items.remove Post.items.indexOf(@)

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
