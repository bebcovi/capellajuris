$ = jQuery

class Ajax
  @fail: (xhr, status, msg) -> $(@).click()

exports = @
exports.Ajax = Ajax
