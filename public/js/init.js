$(function() {

  if (Modernizr.audio && !Modernizr.audio.mp3) {
    $('audio').css('display', 'none')
    $('.flash').css('display', 'inline')
  }

  $('.members .first').append(': ')
  $('.members li').not('.first').not('.last').append(', ')
  $('.members .last').append('.')

  $('#intro aside article h1').append(':')
  $('form#login label').append(':')
  $('#facebook p').append(':')

})
