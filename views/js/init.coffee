# preloadImg = (src) ->
#   $("<img src='/images/#{src}'>")

$ ->

  Post.update()

  $('.add a').click ->
    post = new Post $(@).parent()
    post.init()
