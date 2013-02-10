jQuery ->
	$('.datatable').dataTable
  	sPaginationType: "bootstrap"
  	sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
  	iDisplayLength: 15

jQuery ->
  $('.toggle').toggleButtons
    label:
      enabled: $('.toggle').data('on-label')
      disabled: $('.toggle').data('off-label')
    style:
      # Accepted values ["primary", "danger", "info", "success", "warning"] or nothing
      enabled: $('.toggle').data('on-color')
      disabled: $('.toggle').data('off-color')