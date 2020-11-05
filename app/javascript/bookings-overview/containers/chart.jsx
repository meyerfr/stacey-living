import React, { Component } from "react";
import Chart from "react-apexcharts";
import { applyFilter } from '../actions';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import moment from 'moment'
// import DatePicker from 'react-datepicker'


class ChartView extends Component {
  constructor(props) {
    super(props);

    this.state = {
      options: {
        plotOptions: {
          bar: {
            horizontal: true,
            barHeight: '50%',
            rangeBarGroupRows: true
          }
        },
        dataLabels: {
          enabled: true,
          formatter: function(val) {
            var a = moment(val[0])
            var b = moment(val[1])
            var diff = b.diff(a, 'months')
            return diff + (diff > 1 ? ' months' : ' month')
          }
        },
        colors: [
          "#008FFB", "#00E396", "#FEB019", "#FF4560", "#775DD0",
          "#3F51B5", "#546E7A", "#D4526E", "#8D5B4C", "#F86624",
          "#D7263D", "#1B998B", "#2E294E", "#F46036", "#E2C044"
        ],
        fill: {
          type: 'solid'
        },
        xaxis: {
          // tickPlacement: 'on',
          type: 'datetime'
        },
        legend: {
          position: 'right'
        }
      },
      start_date: '2019-01-01',
      end_date: '2022-01-01'
    };
  }

  createChartSeries = () => {
    let series = []
    this.props.bookings.map((booking) => {
      series.push({
        name: booking.user_name,
        data: [
          {
            x: booking.room_number,
            y: [
              new Date(booking.move_in).getTime(),
              new Date(booking.move_out).getTime()
            ]
          }
        ]
      })
    })
    return series
  }

  updateStart = (event) => {
    console.log(event.target.value)
    this.setState({ 
      start_date: event.target.value,
      options: {
        xaxis: {
          type: 'datetime', 
          min: new Date(event.target.value).getTime(),
          max: new Date(event.target.nextElementSibling.value).getTime()
        }
      }
    });
    // console.log(this.state.dates.start_date);
  }

  updateEnd = () => {
    console.log(event);
    this.setState({
      end_date: event.target.value,
      options: {
        xaxis: {
          type: 'datetime', 
          min: new Date(event.target.previousElementSibling.value).getTime(),
          max: new Date(event.target.value).getTime()
        }
      }
    });
  }

  render() {
    return (
      <div className="table-container" id="chart">
        <div className="field">
          <input onChange={this.updateStart} className="form-control" type="date" id="start" name="trip-start"
          value={this.state.start_date} min="2019-01-01"/>
          <input onChange={this.updateEnd} className="form-control" type="date" id="end" name="trip-start"
          value={this.state.end_date} min="2019-01-01"/>
        </div>
        <Chart options={this.state.options} series={this.createChartSeries()} type="rangeBar" />
      </div>
    );
  }
}


function mapStateToProps(state) {
  return {
    bookings: state.app.bookings
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ applyFilter }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(ChartView);