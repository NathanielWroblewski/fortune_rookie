if $('#services').length > 0
  player_id = $('#services').data 'player-id'
  setInterval ->
    $.ajax
      url: "/services/#{player_id}"
      success: (data) ->
        window.dataPoints = data.dataPoints
        drawChart()
    , 3000

google.load 'visualization', '1.0',
  'packages':['corechart']

google.setOnLoadCallback drawChart

drawChart = ->
  data = new google.visualization.DataTable()
  data.addColumn 'string', 'Time'
  data.addColumn 'number', 'Price'
  data.addRows(window.dataPoints) if window.dataPoints

  options =
    'title':''
    'width': 1000
    'height': 300

  chart = new google.visualization.LineChart(document.getElementById('chart_div'))
  chart.draw data, options
