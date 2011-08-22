$(function() {
  
  $('ul.members li.first').append(': ');
  $('ul.members li').not('.first').not('.last').append(', ');
  $('ul.members li.last').append('.');
  
});
