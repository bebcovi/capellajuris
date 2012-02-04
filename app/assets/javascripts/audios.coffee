# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('input[type="file"]').each ->
    i = $('<input type="text">')
    b = $('<input type="button">').val('Potraži')
    f = $('<div class="fakefile">').append(i, b)
    c = =>
      $(@).click()
      i.blur()

    $(@).addClass 'invisible'
    $(@).after f
    i.click c
    b.click c
    $(@).change ->
      i.val $(@).val().match(/[^\/\\]+$/)
