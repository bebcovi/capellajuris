$ = jQuery

$ ->
  $('.new').append($('<span class="icon">').text(' V'))
  $('.edit').append($('<span class="icon">').text(' e'))
  $('.delete').append($('<span class="icon">').text(' x'))
  $('#clanovi .delete').html($('<span class="icon">').text('X'))

  $.GollumEditor()
  $('#gollum-editor-function-bar a')
    .each ->
      title = $(this).find('span').text()
      title = title.replace(/h(\d)/, 'Heading $1')
      $(this).attr('title', title)
    .twipsy()

  fake = $('<div class="fakefile">').prepend($('<input type="text">'), $('<input type="button">').val('Potraži'))
  $('input[type="file"]').each ->
    f = $(fake)
    i = f.find('input[type="text"]')
    b = f.find('input[type="button"]')
    c = =>
      $(@).click()
      i.blur()

    $(@).addClass 'invisible'
    $(@).after f
    i.click c
    b.click c
    $(@).change -> i.val($(@).val())
