# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#user_crop_x').val(coords.x)
    $('#user_crop_y').val(coords.y)
    $('#user_crop_w').val(coords.w)
    $('#user_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    console.log $('#cropbox').width()
    $('#preview').css
      # width: Math.round(500/coords.w * $('#cropbox').width()) + 'px'
      # height: Math.round(500/coords.h * $('#cropbox').height()) + 'px'
      # marginLeft: '-' + coords.x + 'px'
      # marginTop: '-' + coords.y + 'px'
      # width: Math.round(coords.w / ($('#cropbox').width() - coords.x)) * 100 + 'px'
      # height: Math.round(coords.h / ($('#cropbox').height() - coords.y)) * 100 + 'px'
      width: Math.round(100/coords.w * $('#cropbox').width()) + 'px'
      height: Math.round(100/coords.h * $('#cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
