# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  if $('#company_crop_x').length
    new CompanyAvatarCropper()

class CompanyAvatarCropper
  constructor: ->
    $('#company_cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update
  
  update: (coords) =>
    $('#company_crop_x').val(coords.x)
    $('#company_crop_y').val(coords.y)
    $('#company_crop_w').val(coords.w)
    $('#company_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
          $('#preview').css
                  width: Math.round(100/coords.w * $('#company_cropbox').width()) + 'px'
                  height: Math.round(100/coords.h * $('#company_cropbox').height()) + 'px'
                  marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
                  marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'