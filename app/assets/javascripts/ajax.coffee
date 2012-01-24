$ = jQuery

class Ajax
  @fail: (xhr, status, msg) -> $(@).click()
  @params: (obj) ->
    result = {}
    obj.find('input[name], textarea[name]').each ->
      if $(@).val() isnt "" then result[$(@).attr('name')] = $(@).val()
    result

exports = @
exports.Ajax = Ajax
