$ = jQuery

class Ajax
  @register: (obj) ->
    obj.find('.delete').submit ->
      post = new Post($(@).closest('article'))
      post.remove()
  @fail: (xhr, status, msg) ->
    console.error msg
    $(@).click()

exports = @
exports.Ajax = Ajax
