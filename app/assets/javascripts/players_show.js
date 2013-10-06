
// Load the Visualization API and the piechart package.
google.load('visualization', '1.0', {'packages':['corechart']});

// Set a callback to run when the Google Visualization API is loaded.
google.setOnLoadCallback(drawChart);

// Callback that creates and populates a data table,
// instantiates the pie chart, passes in the data and
// draws it.
function drawChart() {

  // Create the data table.
  var data = new google.visualization.DataTable();
  var dataPoints;
  data.addColumn('string', 'Time');
  data.addColumn('number', 'Price');
  dataPoints = $('#services').data('data-points');
  if (dataPoints.length > 0){
    data.addRows();
  }

  // Set chart options
  var options = {'title':'',
                 'width':1000,
                 'height':300};

  // Instantiate and draw our chart, passing in some options.
  var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
  chart.draw(data, options);
}

