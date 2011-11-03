$ = jQuery

$ ->

  $('#gollum-editor-function-bar a')
    .each ->
      title = $(this).find('span').text().toLowerCase()
      title = title.replace(/h(\d)/, 'heading $1')
      $(this).attr('title', title)
    .twipsy()

  Post.getAll($('body')).each -> new Post $(@)
  $('#main .add a').click Post.add

  Member.getAll($('body')).each -> new Member $(@)
  $('#members .add a').unbind('click').click Member.add

  Video.getAll($('body')).each -> new Video $(@)
  $('#videos .add a').unbind('click').click Video.add

  $('article, #photos').find('img').each ->
    rhythm = parseInt $('footer').last().css('margin-bottom')
    oldHeight = parseInt $(@).attr('height')
    newHeight = Math.floor(oldHeight/rhythm) * rhythm + 'px'
    margin = []
    for dir in ['top', 'right', 'bottom', 'left']
      margin.push $(@).css("margin-#{dir}")

    wrapper = $('<div>')
      .addClass('img')
      .css('height' , newHeight)
      .css('float', $(@).css('float'))
      .css('margin', margin.join(' '))

    $(@).wrap(wrapper)
