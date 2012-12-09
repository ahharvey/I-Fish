function render_chart(container, title, y_axis_name, chart_type, col_headers, counts){
		var chart;
        window.user_chart = new Highcharts.Chart({
            chart: {
                renderTo: container,
                type: chart_type,
                marginRight: 130,
                marginBottom: 25
            },
            title: {
                text: title,
                x: -20 //center
            },
            subtitle: {
                text: '',
                x: -20
            },
            xAxis: {
                categories: col_headers
            },
            yAxis: {
                title: {
                    text: y_axis_name
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'°C';
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 100,
                borderWidth: 0
            },
            series: [{
                name: 'Survey',
                data: counts
            }]
        });
	};