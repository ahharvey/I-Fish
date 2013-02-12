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