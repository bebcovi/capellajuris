jQuery ->
  $.GollumEditor()
  $('#gollum-editor-function-bar a')
    .each ->
      title = $(this).find('span').text()
      title = title.replace(/h(\d)/, 'Heading $1')
      $(this).attr('title', title)
    .twipsy()
