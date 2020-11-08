import React, { Component } from 'react'
import FilterBar from '../containers/filter_bar';
import Chart from '../containers/chart'
import RoomList from '../containers/room_list'

class BookingOverview extends Component {
	constructor(props){
		super(props)
		this.state = {
			view: 'table'
		}
	}


	handleViewChange = (event) => {
		console.log(event.target.value)
		this.setState({
			view: event.target.value
		})
	}

	render() {
		return(
			<div className="overview-container" style={{width: '100%'}}>
		        <FilterBar onChange={this.handleViewChange} />
		        {
		        	this.state.view === 'table' ?
					<RoomList />
					:
					<Chart />
		        }
			</div>
		)
	}
}

export default BookingOverview;