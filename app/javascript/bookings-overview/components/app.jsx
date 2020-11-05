import React from 'react';
import BookingOverview from './booking_overview'


const App = (props) => {
	// const query = new URLSearchParams(props.location.search);
	// const roomtype_name = query.get('roomtype_name')
	// const start_date = query.get('start_date')
	// const end_date = query.get('end_date')
	// const project_id = query.get('project_id')
	// const apartment_id = query.get('apartment_id')
	// const room_id = query.get('room_id')
	return (
    	<div className="overview-wrapper">
    		<BookingOverview />
    	</div>
	);
};

export default App;
