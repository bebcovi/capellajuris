
$ ->

  Post.update()

  $('.add a').click ->
    add = new AddButton $(@).parent()
    add.fetch()
