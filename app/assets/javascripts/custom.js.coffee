jQuery ->
  $('.datatable').dataTable
    sPaginationType: "bootstrap"
    sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
    iDisplayLength: 15
  
jQuery ->
  $(".approve-toggle:checkbox").change ->
    $.ajax
      type: "PUT"
      url: $(this).data("href")
      dataType: "html"
      data:
        approved: $(this).prop('checked')

show_ajax_message = (msg, type) ->
  $(".flash-container").html "<div class='alert alert-#{type} fade in' data-alert='alert' style='margin-top:17px'><a class='close' href='#' onclick='$('.alert').remove();''>×</a><p>#{msg}</p></div>"
  $(".alert-#{type}").delay(3000).slideUp 'slow'
 
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