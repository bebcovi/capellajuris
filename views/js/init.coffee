$ = jQuery

$ ->


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
