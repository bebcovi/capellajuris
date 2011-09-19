class Post

  constructor: (@add) ->

  @preloader: $('<div class="preloader">')

  @update: ->

    $('.controls form input[type="submit"]').click ->
      xhr = $.ajax
        type: 'DELETE'
        url: $(@).closest('form').attr('action')

      xhr.fail Post.fail

      $(@).closest('article').fadeOut 'fast', -> $(@).remove()
      event.preventDefault()

  @fail: (xhr, status, msg) ->
    console.error msg
    $(@).click()

  @always: ->
    Post.preloader.remove()

  ok: =>
    @form.append @constructor.preloader

    xhr = $.post @form.attr('action'),
      title: @form.find('input[type="text"]').val(),
      body: @form.find('textarea').val()
    , (data) =>
      @article = $(data).find('#news article').first()

      @form.fadeOut 'fast', -> $(@).remove()
      @add.after @article
      @article.fadeOut 0
      @article.delay('fast').fadeIn 'fast'
      @add.delay().fadeIn 'fast'

      @id = @article.find('form').attr('action').match(/\d+/)[0] - 0

      @constructor.update()

    xhr.fail @constructor.fail
    xhr.always @constructor.always

    event.preventDefault()

  cancel: =>
    @form.fadeOut 'fast', -> $(@).remove()
    @add.delay('fast').fadeIn 'fast'

  init: =>
    @add.append @constructor.preloader

    xhr = $.get @add.find('a').attr('href'), (data) =>
      @form = $(data).find 'form'
      @add.fadeOut 'fast'
      @add.before @form
      @form.fadeOut 0
      @form.delay('fast').fadeIn 'fast'

      submit = @form.find('input[type="submit"]')

      submit.first().click @ok
      submit.last().click @cancel

    xhr.fail @constructor.fail
    xhr.always @constructor.always

    event.preventDefault()

exports = @
exports.Post = Post
