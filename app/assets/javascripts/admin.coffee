jQuery ->
  i = '<span class="icon">'

  $('.new').append($(i).text(' V'))
  $('.edit').append($(i).text(' e'))
  $('.delete').append($(i).text(' x'))
  $('#clanovi .delete').html($(i).text('X'))
  $('.upload').append($(i).text(' ]'))
