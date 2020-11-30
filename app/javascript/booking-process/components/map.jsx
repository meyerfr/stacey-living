import React, { Component } from 'react';
import GoogleMapReact from "google-map-react";
import Marker from './marker'


export default class Map extends Component {
	centerMap() {
		if (this.props.input.length > 0) {
			return {
	      lat: 53.567344,
	      lng: 9.988367
			}
		} else{
			return {
				lat: this.props.input.marker.lat,
	      lng: this.props.input.marker.lng
			}
		}
	}

	render() {
		const input = this.props.input;
		return (
			<div key='map' className="map-container" style={{width: '100%', height: '500px'}}>
				<GoogleMapReact
					defaultCenter={this.centerMap()}
					defaultZoom={13}
					bootstrapURLKeys={{ key: 'AIzaSyBCw-g1ofOTPw7H6Ub1wAe5cFSheaw-k7c' }}
				>
					{
						input.length > 0 ?
							input.map((value) => {
								return <Marker key={value.id} lat={value.marker.lat} lng={value.marker.lng} />
							})
						:
							<Marker key={input.id} lat={input.marker.lat} lng={input.marker.lng} />
					}
				</GoogleMapReact>
			</div>
		)
	}
}