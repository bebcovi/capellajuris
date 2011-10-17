$ = jQuery

$ ->

  $('.add a').click ->
    add = new AddButton $(@).parent()
    add.fetch()

  Post.register $('article').not('#intro article')
