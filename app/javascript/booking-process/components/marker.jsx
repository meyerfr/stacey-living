import React from 'react';
import end_call from '../../../assets/images/maps_marker.png'


// const Marker = () => <div className="marker" style={{height: '20px', width: '20px', backgroundColor: 'red', borderRadius: '50%'}}>&nbsp;</div>;

const Marker = () => <img src={end_call}
					            alt="logo"
					            className="tab end_call"
					            style={{height: '30px', width: '30px'}}
					            />

export default Marker;