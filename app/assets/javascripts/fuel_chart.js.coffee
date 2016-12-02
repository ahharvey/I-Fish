jQuery ->

#  if $('#fuel_utilization').length
#    drawChart = ->
#      url = $('#fuel_utilization').data('url')
#      data = undefined
#      $.get url, (response) ->
#        data = response
#        data = google.visualization.arrayToDataTable(data)
#        options =
#          title: null
#          hAxis:
#            title: 'Fuel'
#            minValue: 0
#            maxValue: 15
#          vAxis:
#            title: 'Catch'
#            minValue: 0
#            maxValue: 15
#          legend: 'none'
#        chart = new (google.visualization.ScatterChart)(document.getElementById('fuel_utilization'))
#        chart.draw data, options
#        return
#      return

#    google.load 'visualization', '1', packages: [ 'corechart' ]
#    google.setOnLoadCallback drawChart
