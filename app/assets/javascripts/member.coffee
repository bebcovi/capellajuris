$ = jQuery

class Member
  constructor: (@obj) ->
    @obj.find('.delete input[type="submit"]').click @remove

  @getAll: (obj) ->
    obj.find '#members section > ol > li'

  @add: ->
    if not $(@).attr('disabled')?
      $(@).attr('disabled', 'disabled')
      button = $(@).parent()
      xhr = $.get $(@).attr('href'), (data) =>
        form = $(data).find 'form.member'
        button.fadeOut 'fast'
        button.before form
        form.fadeOut(0).delay('fast').fadeIn 'fast'

        form.find('.submit').click =>
          params = Ajax.params form

          xhr = $.ajax
            type: 'POST'
            url: form.attr 'action'
            data: params
            success: (data) =>
              oldParent = $(@).closest('section')
              newParent = $(data).find('#members section').eq oldParent.siblings().andSelf().index(oldParent)
              obj = []
              index = 0
              newParent.find('> ol > li').each (i) ->
                if $(@).find('div').text() is "#{params['member[last_name]']} #{params['member[first_name]']}"
                  obj = $(@)
                  index = i

              ol = oldParent.children('ol')

              if index >= ol.children('li').length - 1
                ol.append obj
              else
                ol.children('li').eq(index).before obj

              obj.addClass('recent')
              form.fadeOut 'fast', -> $(@).remove()
              button.delay('fast').fadeIn 'fast'
              $(@).removeAttr('disabled')

              new Member obj

            error: Ajax.fail

          event.preventDefault()

        form.find('.cancel').click =>
          form.fadeOut 'fast', -> $(@).remove()
          button.delay('fast').fadeIn 'fast'
          $(@).removeAttr('disabled')
          event.preventDefault()

    event.preventDefault()

  edit: =>

  remove: =>
    url = @obj.find('.delete').attr 'action'

    xhr = $.ajax
      type: 'DELETE'
      url: url
      success: (data) =>
        confirm = $(data).find('.confirm')
        @obj.after confirm
        @obj.fadeOut 'fast'
        confirm.fadeOut(0).delay('fast').fadeIn 'fast'

        confirm.find('.submit').click =>
          params = Ajax.params confirm

          $.ajax
            type: 'DELETE'
            url: url
            data: params

          confirm.fadeOut 'fast', -> $(@).remove()
          @obj.remove()

          event.preventDefault()

        confirm.find('.cancel').click =>
          confirm.fadeOut 'fast', -> $(@).remove()
          @obj.delay('fast').fadeIn 'fast'
          event.preventDefault()

      error: Ajax.fail

    event.preventDefault()

exports = @
exports.Member = Member
