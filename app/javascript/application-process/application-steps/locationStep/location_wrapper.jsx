import React from 'react';
import GoogleMapReact from 'google-map-react';

import LocationList from './location_list';
import Marker from './marker';

const LocationWrapper = (props) => {
  const center = () => {
    return {
      lat: 53.567344,
      lng: 9.988367
    };
  }

  return (
    <div className={`location-wrapper${props.hidden ? ' hidden' : ''}`}>
      <div className="map-container">
        <GoogleMapReact
          defaultCenter={center()}
          defaultZoom={13}
          bootstrapURLKeys={{ key: 'AIzaSyBCw-g1ofOTPw7H6Ub1wAe5cFSheaw-k7c' }}
        >
          {
            props.locations.map((location, index) => {
              return <Marker key={location.name} lat={location.lat} lng={location.lng} index={index} selectLocation={props.selectLocation} />
            })
          }
        </GoogleMapReact>
      </div>
      <LocationList
        locations={props.locations}
        selectedLocation={props.selectedLocation}
        selectLocation={props.selectLocation}
      />
    </div>
  );
}

export default LocationWrapper;
