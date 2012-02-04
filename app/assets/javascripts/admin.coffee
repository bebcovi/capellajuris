jQuery ->
  i = '<span class="icon">'

  $('.new').append($(i).text(' V'))
  $('.edit').append($(i).text(' e'))
  $('article .delete').append($(i).text(' x'))
  $('.uploaded .delete').html($(i).text('X'))
  $('#clanovi .delete').html($(i).text('X'))
  $('.upload').append($(i).text(' ]'))
  $('.remove').append($(i).text(' x'))
