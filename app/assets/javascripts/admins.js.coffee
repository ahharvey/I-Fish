# sets Admin.approved status from index view via Ajax
$('.admin-approve-cb').on 'switchChange.bootstrapSwitch', (event, state) ->
  $.ajax
    url: 'en/panel/admins/' + @value + '/set_approved'
    type: 'PUT'
    data: { approved: $(this).attr('checked') }
    success: -> alert('User updated')

jQuery ->
  if $('#admin_crop_x').length
    new AdminAvatarCropper()

class AdminAvatarCropper
  constructor: ->
    $('#admin_cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update
  
  update: (coords) =>
    $('#admin_crop_x').val(coords.x)
    $('#admin_crop_y').val(coords.y)
    $('#admin_crop_w').val(coords.w)
    $('#admin_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
          $('#preview').css
                  width: Math.round(100/coords.w * $('#admin_cropbox').width()) + 'px'
                  height: Math.round(100/coords.h * $('#admin_cropbox').height()) + 'px'
                  marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
                  marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'