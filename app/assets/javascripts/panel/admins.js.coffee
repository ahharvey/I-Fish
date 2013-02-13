# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# sets Admin.approved status from index view via Ajax
jQuery ->
  $('.admin-approve-cb:checkbox').change ->
    $.ajax
      type: 'PUT'
      url: $('.admin-approve-cb').data('href')
      dataType: 'html'
      data: 
      	approved: $(this).is(':checked')
      success: -> alert('User updated')