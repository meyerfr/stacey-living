import React, { Component } from 'react';
import GoogleMapReact from "google-map-react";
import Marker from './marker'

export default class Map extends Component {
  centerMap = () => {
    if (this.props.selectedLocation) {
      return{
        lat: this.props.selectedLocation.marker.lat,
        lng: this.props.selectedLocation.marker.lng
      }
    } else {
      return{
        lat: 53.567344,
        lng: 9.988367
      }
    }
  }

  render() {
    return(
      <div key='map' className="map-container" style={{width: '100%', height: '500px'}}>
        <GoogleMapReact
          defaultCenter={this.centerMap()}
          defaultZoom={13}
          bootstrapURLKeys={{ key: 'AIzaSyBCw-g1ofOTPw7H6Ub1wAe5cFSheaw-k7c' }}
        >
          {
            this.props.locations.map((location) => {
              return <Marker key={location.id} input_id={location.id} lat={location.marker.lat} lng={location.marker.lng} />
            })
          }
        </GoogleMapReact>
      </div>
    )
  }
}
