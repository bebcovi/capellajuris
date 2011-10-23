$ = jQuery

class Member
  constructor: (@obj) ->
    @obj.find('.delete input[type="submit"]').click @remove
    @voice = Member.croToEn[@obj.closest('section').find('h2').text().toLowerCase()]
    Member.items[@voice].push @
    Member.items[@voice].sort Member.alphabetical

  @items:
    sopran: []
    alt: []
    tenor: []
    bass: []

  @voicesCro: ['soprani', 'alti', 'tenori', 'basi']
  @croToEn:
    soprani: 'sopran'
    alti: 'alt'
    tenori: 'tenor'
    basi: 'bass'

  @alphabetical: (a, b) ->
    aString = a.obj.text().trim().split(' ')[1]
    bString = b.obj.text().trim().split(' ')[1]

    if aString < bString
      return -1
    else if aString == bString
      return 0
    else if aString > bString
      return 1

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
        label = form.find('label')
        text = form.find('input[type="text"]')
        label.each (i) ->
          $(@).unwrap()
          text.eq(i).attr('placeholder', $(@).text())
          $(@).remove()
        form.fadeOut(0).delay('fast').fadeIn 'fast'

        form.find('.submit').click =>
          fname = form.find('input[name="first_name"]').val()
          lname = form.find('input[name="last_name"]').val()
          xhr = $.ajax
            type: 'POST'
            url: form.attr 'action'
            data:
              first_name: fname
              last_name: lname
            success: (data) =>
              oldSection = $(@).closest('section')
              newSection = $(data).find('#members section').eq oldSection.siblings().andSelf().index(oldSection)
              obj = []
              index = 0
              newSection.find('> ol > li').each (i) ->
                if $(@).find('div').text() is "#{fname} #{lname}"
                  obj = $(@)
                  index = i

              console.log oldSection
              console.log newSection

              ol = oldSection.children('ol')

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
          $.ajax
            type: 'DELETE'
            url: url
            data:
              confirmation: confirm.find('.submit').val()
            success: =>
              Member.items[@voice].remove Member.items[@voice].indexOf(@)

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
