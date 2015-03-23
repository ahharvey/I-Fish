jQuery ->
  $('.datatable').dataTable
    "pageLength": 15
  $('div.dataTables_filter input').addClass('form-control input-sm');
  $('div.dataTables_length select').addClass('form-control input-sm')
    # sDom: "<'row'<'col-xs-6'l><'col-xs-6'f>r>t<'row'<'col-xs-6'i><'col-xs-6'p>>"


jQuery ->
  $(".toggle-switch").bootstrapSwitch()


jQuery ->  #initialize Bootstrap datepicker on date select field
  if $('.datetime-select-input').length

    $('.datetime-select-input').each ->

      date  = $(this).data('date')
      id    = $(this).prop('id')
      name  = $(this).prop('name')
      max   = $(this).data('max')
      min   = $(this).data('min')
      label = $(this).data('label')

      $(this).closest(".datetime-select-wrapper").replaceWith ->
        open_wrapper = "<div class='col-md-12'>"
        input = "<input class='form-control datetime-select-bootstrapped' type='text' placeholder='" + label + "' name='" + name + "' id='" + id + "' value='" + date + "'>"
        close_wrapper = "</div>"
        $ open_wrapper + input + close_wrapper

      $(".datetime-select-bootstrapped").datetimepicker
        minDate: min
        maxDate: max
        sideBySide: true
        format: 'DD/MM/YYYY HH:mm'

jQuery ->  #initialize Bootstrap datepicker on date select field
  if $('.date-select-input').length

    $('.date-select-input').each ->

      date  = $(this).data('date')
      id    = $(this).prop('id')
      name  = $(this).prop('name')
      max   = $(this).data('max')
      min   = $(this).data('min')
      label = $(this).data('label')

      $(this).closest(".date-select-wrapper").replaceWith ->
        open_wrapper = "<span class='col-md-12'>"
        input = "<input class='form-control date-select-bootstrapped' type='text' placeholder='" + label + "' name='" + name + "' id='" + id + "' value='" + date + "'>"
        close_wrapper = "</span>"
        $ open_wrapper + input + close_wrapper

      $(".date-select-bootstrapped").datetimepicker
        minDate: min
        maxDate: max
        sideBySide: true
        format: 'DD/MM/YYYY'



jQuery ->
  $(".approve-toggle:checkbox").on 'switchChange.bootstrapSwitch', (event, state) ->
    $.ajax
      type: "PUT"
      url: $(this).data("href")
      dataType: "html"
      data:
        approved: $(this).prop('checked')

show_ajax_message = (msg, type) ->
  $(".flash-container").html "<div class='alert alert-#{type} fade in' data-alert='alert' style='margin-top:17px'><a class='close' href='#' onclick='$('.alert').remove();''>×</a><p>#{msg}</p></div>"
  $(".alert-#{type}").delay(7000).slideUp 'slow'
 
$(document).ajaxComplete (event, request) ->
  msg = request.getResponseHeader("X-Message")
  type = request.getResponseHeader("X-Message-Type")
  show_ajax_message msg, type #use whatever popup, notification or whatever plugin you want

$(document).ready ->
  
  # Activating Best In Place 
  jQuery(".best_in_place").best_in_place()



jQuery -> #initialize Twitter Bootstrap tooltips
  $("a[rel*=popover]").tooltip
    trigger: "hover"
    placement: "right"

#jQuery ->
#  if $(".file").length > 0

@validateFiles = (inputFile) ->
  maxExceededMessage = "This file exceeds the maximum allowed file size (1 MB)"
  extErrorMessage = "Only image file with extension: .jpg, .jpeg, .gif or .png is allowed"
  allowedExtension = [
    "jpg"
    "jpeg"
    "gif"
    "png"
    "JPG"
    "JPEG"
    "PNG"
    "GIF"
  ]
  extName = undefined
  maxFileSize = $(inputFile).data("max-file-size")
  sizeExceeded = false
  extError = false
  $.each inputFile.files, ->
    sizeExceeded = true  if @size and maxFileSize and @size > parseInt(maxFileSize)
    extName = @name.split(".").pop()
    extError = true  if $.inArray(extName, allowedExtension) is -1
    return

  if sizeExceeded
    window.alert maxExceededMessage
    $(inputFile).val ""
  if extError
    window.alert extErrorMessage
    $(inputFile).val ""
  return

