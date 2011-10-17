# preloadImg = (src) ->
#   $("<img src='/images/#{src}'>")

$ ->

  Post.update()

  $('.add a').click ->
    add = new AddButton $(@).parent()
    add.fetch()
