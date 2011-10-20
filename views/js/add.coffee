$ = jQuery

class AddButton
  constructor: (@obj) ->

  submit: =>
    xhr = $.ajax
      type: 'POST'
      url: @editor.find('form').attr 'action'
      data:
        page: @editor.find('input[name="page"]').val()
        text: @editor.find('#gollum-editor-body').val()
      success: (data) =>

        articles = $(data).find('#news article')
        @data = articles.first()

        @editor.fadeOut 'fast', -> $(@).remove()
        @obj.after @data
        @data.fadeOut 0
        @data.delay('fast').fadeIn 'fast'
        @obj.delay().fadeIn 'fast'

        Ajax.register @data

      error: (xhr, status, msg) ->
        console.error msg
        $(@).click()

    event.preventDefault()

  cancel: =>
    @editor.fadeOut 'fast', -> $(@).remove()
    @obj.delay('fast').fadeIn 'fast'

    event.preventDefault()

  fetch: =>
    url = @obj.find('a').attr 'href'
    @appended = @obj
    @replaced = @obj
    @request = 'POST'

    xhr = $.get url, (data) =>
      @editor = $(data).find '#gollum-editor'
      @obj.fadeOut 'fast'
      @obj.before @editor
      @editor.fadeOut 0
      @editor.delay('fast').fadeIn 'fast'

      @editor.find('#gollum-editor-submit').click @submit
      @editor.find('#gollum-editor-cancel').click @cancel

      $.GollumEditor()

    xhr.fail Ajax.fail

    event.preventDefault()

exports = @
exports.AddButton = AddButton
