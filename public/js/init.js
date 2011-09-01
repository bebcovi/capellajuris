$(function() {

  if (!Modernizr.audio.mp3) {
    $('audio').css('display', 'none')
    $('.flash').css('display', 'inline')
  }

  $('.members .first').append(': ')
  $('.members li').not('.first').not('.last').append(', ')
  $('.members .last').append('.')

})
