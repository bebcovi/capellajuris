# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

$ ->
  $('.new').append($('<span class="icon">').text(' V'))
  $('.edit').append($('<span class="icon">').text(' e'))
  $('.delete').append($('<span class="icon">').text(' x'))
  $('#clanovi .delete').html($('<span class="icon">').text('X'))
