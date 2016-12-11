jQuery ->
  $('.datatable').dataTable
    "pageLength": 15
    "aoColumnDefs": [{
      'bSortable': false
      'aTargets': ['nosort']
    }]

  $('div.dataTables_filter input').addClass('form-control input-sm');
  $('div.dataTables_length select').addClass('form-control input-sm')
    # sDom: "<'row'<'col-xs-6'l><'col-xs-6'f>r>t<'row'<'col-xs-6'i><'col-xs-6'p>>"

jQuery ->
  $.fn.select2.defaults.set('theme', 'bootstrap');

jQuery ->
  if Modernizr.touch # or !Modernizr.inputtypes.date
    # If user is on a touch enabled device
    # we use OS's native date and time selectors
    $("input.datepicker[type=text]").attr('type', 'date')
    $("input.datetimepicker[type=text]").attr('type', 'datetime')
  else
    # Otherwise we use Bootstrap 3 Datepicker
    # http://eonasdan.github.io/bootstrap-datetimepicker/
    $("input.datepicker[type=text]").datetimepicker
      format: 'MMMM DD, YYYY'
    $("input.datetimepicker[type=text]").datetimepicker
      format: 'MMMM DD, YYYY HH:mm'
      sideBySide: true


jQuery -> #infinite scroll
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination #pagination_next a').attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 225
        $('.pagination').html('<div class="loading-spinner text-center"><i class="fa fa-circle-o-notch fa-spin fa-4x"></i></div>')
        $.getScript(url)
  $(window).scroll()
# ---
# generated by js2coffee 2.0.3

jQuery ->
  $(".toggle-switch").bootstrapSwitch()


jQuery ->

  elems = Array::slice.call(document.querySelectorAll('.js-switch'))
  elems.forEach (html) ->
    console.log(html)
    color              = $(html).data('color') || '#64bd63'
    secondaryColor     = $(html).data('secondary-color') || '#dfdfdf'
    jackColor          = $(html).data('jackColor') || '#fff'
    jackSecondaryColor = $(html).data('jackSecondaryColor')  || null
    disabled           = $(html).data('disabled')  || false
    disabledOpacity    = $(html).data('disabledOpacity') || 0.5
    speed              = $(html).data('speed') || '0.1s'
    size               = $(html).data('size')  || 'small'
    switchery = new Switchery(html,
      color             : color
      secondaryColor    : secondaryColor
      jackColor         : jackColor
      jackSecondaryColor: jackSecondaryColor
      disabled          : disabled
      disabledOpacity   : disabledOpacity
      speed             : speed
      size              : size )




jQuery ->  #initialize Bootstrap datepicker on date select field
  if $('.datetime-select-input').length

    $('.datetime-select-input').each ->

      date  = $(this).data('date')
      id    = $(this).prop('id').replace('_1i', "") #replace(/\(.*?\)\s/g, '')
      name  = $(this).prop('name').replace('(1i)', "") #.replace(/\(.*?\)\s/g, '')
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
      id    = $(this).prop('id').replace('_1i', "") #.replace(/\(.*?\)\s/g, '')
      name  = $(this).prop('name').replace('(1i)', "") #.replace(/\(.*?\)\s/g, '')
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
  if $('.select2-select').length

    $('.select2-select').select2
      placeholder: $(this).attr('prompt') || "Select..."
      allowClear: true

jQuery ->
  $(".approve-toggle:checkbox").on 'switchChange.bootstrapSwitch', (event, state) ->
    $.ajax
      type: "PUT"
      url: $(this).data("href")
      dataType: "html"
      data:
        approved: $(this).prop('checked')

show_ajax_message = (msg, type) ->

  $(".flash-container").html("<div class='alert alert-#{type} fade in' data-alert='alert' style='margin-top:17px'><a class='close' href='#' onclick='$('.alert').remove();''>×</a><p>#{msg}</p></div>")
  $(".alert-#{type}").delay(7000).slideUp 'slow'

$(document).ajaxComplete (event, request) ->
  msg = request.getResponseHeader("X-Message")
  type = request.getResponseHeader("X-Message-Type")
  if msg
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
