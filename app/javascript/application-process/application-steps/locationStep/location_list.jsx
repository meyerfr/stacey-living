import React from 'react';
import LocationCard from './location_card';

const LocationList = (props) => {
  const renderLocationList = () => {
    return props.locations.map((location, index) => {
      return (
        <LocationCard
          location={location}
          key={location.lat}
          selected={props.selectedLocation && props.selectedLocation.name  === location.name}
          index={index}
          selectLocation={props.selectLocation}
        />
      );
    });
  };

  return (
    <div className="location-list-wrapper step-container">
      <h3 className="underline step-header">Select your prefered Location in Hamburg</h3>
      <div className="step-form-container location-list">
        {renderLocationList()}
      </div>
    </div>
  );
};

export default LocationList;
