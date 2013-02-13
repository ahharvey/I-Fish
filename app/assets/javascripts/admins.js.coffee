# sets Admin.approved status from index view via Ajax
$('.admin-approve-cb').change ->
  $.ajax
    url: 'en/panel/admins/' + @value + '/set_approved'
    type: 'PUT'
    data: { approved: $(this).attr('checked') }
    success: -> alert('User updated')