jQuery ->
  if $('.datatable-remote').length
    $('.datatable-remote').each (index) ->
      #console.log( $(this).data('url') )
      DataTables.init( $(this) )

@DataTables =
  init: ($elm) ->
    table = $elm.DataTable
      'ajax': {
        'url': $elm.data('url')
        'dataSrc': ""
      }
#      'sDom': '<"row view-filter"<"col-sm-12"<"pull-left"l><"pull-right"f><"clearfix">>>t<"row view-pager"<"col-sm-12"<"text-center"pi>>>'
#      'columns': [
#        {
#          'className': 'details-control'
#          'orderable': false
#          'data': null
#          'defaultContent': ''
#        }
#        {
#          'className': 'details-link'
#          'orderable': false
#          'data': 'id'
#        }
#        { 'data': 'time_out' }
#        { 'data': 'time_in' }
#        { 'data': 'etp' }
#        { 'data': 'fuel' }
#        { 'data': 'ice' }
#        { 'data': 'vessel_id' }
#        { 'data': 'port_id' }
#        { 'data': 'wpp_id' }
#      ]
#      'order': [ [
#        1
#        'asc'
#      ]]
#      'createdRow': (row, data, dataIndex) ->
#        $(row).addClass 'survey-row'

    $('.datatable-remote tbody').on 'click', 'td.details-link', ->
      win = window.open($elm.data('rooturl') + '/' +$(this).html() + '/edit', '_blank')
      if win
        #Browser has allowed it to be opened
        win.focus()
      else
        #Browser has blocked it
        alert 'Please allow popups for this website'

    $('.datatable-remote tbody').on 'click', 'td.details-control', ->
      tr = $(this).closest('tr')
      row = table.row(tr)
      if row.child.isShown()
        # This row is already open - close it
        row.child.hide()
        tr.removeClass 'shown'
      else
        # Open this row
        #row.child(DataTables.format(tr.data('sightings'))).show()
        row.child(DataTables.format(row.data())).show()
        tr.addClass 'shown'
      return

  format: (d) ->
    # `d` is the original data object for the row

    sightings = ''
    $.each d.unloading_catches, (index, value) ->
      console.log(value)
      sightings += '<tr>' +
        '<td style="width:50px;"></td>' +
        '<td>' + value.fish + '</td>' +
        '<td>' + value.quantity + '</td>' +
        '<td>' + value.cut_type + '</td>' +
        '<td>' + value.catch_type + '</td>' +
        '<td style="width:50px;"></td>' +
        '</tr>'
    details = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;width:100%;">' +
      '<tr>' +
      '<td colspan=4 class="text-center">S I G H T I N G S</td>' +
      '</tr>' +
      sightings +
      '</table>'
#			'<tr>' +
#			'<td>Extension number:</td>' +
#			'<td>' + d.date + '</td>' +
#			'</tr>' +
#			'<tr>' +
#			'<td>Extra info:</td>' +
#			'<td>And any further details here (images etc)...</td>' +
#			'</tr>' +
    details
#	  template = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
#		  '<tr>' +
#		  '<td colspan=3>S I G H T I N G S</td>' +
#		  '</tr>' +
#		  '<tr>' +
#		  '<td>' + d.date + '</td>' +
#		  '</tr>' +
#		  '<tr>' +
#		  '<td>Extension number:</td>' +
#		  '<td>' + d.date + '</td>' +
#		  '</tr>' +
#		  '<tr>' +
#		  '<td>Extra info:</td>' +
#		  '<td>And any further details here (images etc)...</td>' +
#		  '</tr>' +
#		  '</table>'
