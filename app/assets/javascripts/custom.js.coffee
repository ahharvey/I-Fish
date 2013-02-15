jQuery ->
	$('.datatable').dataTable
  	sPaginationType: "bootstrap"
  	sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
  	iDisplayLength: 15

jQuery ->
  $('.toggle').toggleButtons()
  
jQuery ->
  $('.approve-toggle:checkbox').change ->
    $.ajax
      type: 'PUT'
      url: $(this).data('href')
      dataType: 'html'
      data: 
      	approved: $(this).is(':checked')
      success: -> alert('Record updated')  

show_ajax_message = (msg, type) ->
  $(".flash-container").html "<div class='alert alert-#{type} fade in' data-alert='alert' style='margin-top:17px'>#{msg}</div>"
  $(".alert-#{type}").delay(5000).slideUp 'slow'
 
$(document).ajaxComplete (event, request) ->
  msg = request.getResponseHeader("X-Message")
  type = request.getResponseHeader("X-Message-Type")
  show_ajax_message msg, type #use whatever popup, notification or whatever plugin you want