## initializes ajax form errors for modal popup 

$(document).ready ->
  $(document).bind 'ajaxError', 'form#new_unloading', (event, jqxhr, settings, exception) ->
    # note: jqxhr.responseJSON undefined, parsing responseText instead
    $(event.data).render_form_errors $.parseJSON(jqxhr.responseText)
    return
  return

## sets up modal form, clears fields, closes on submit
(($) ->

  $.fn.modal_success = ->
    # close modal
    @modal 'hide'
    # clear form input elements
    # todo/note: handle textarea, select, etc
    @find('form input[type="text"]').val ''
    @find('form input[type="number"]').val ''
    @find('form input[type="checkbox"]').prop 'checked', false
    @find('.toggle-switch').bootstrapSwitch 'state', false, false
    # clear error state
    @clear_previous_errors()
    return

  $.fn.render_form_errors = (errors) ->
    $form = this
    @clear_previous_errors()
    model = @data('model')
    # show error messages in input form-group help-block
    $.each errors, (field, messages) ->
      $input = $('input[name="' + model + '[' + field + ']"]')
      $input.closest('.form-group').addClass('has-error').find('.help-block').html messages.join(' & ')
      return
    return

  $.fn.clear_previous_errors = ->
    $('.form-group.has-error', this).each ->
      $('.help-block', $(this)).html ''
      $(this).removeClass 'has-error'
      return
    return

  return
) jQuery



jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()