import React, { Component } from 'react';

class LocationCard extends Component {
  handleClick = () => {
    this.props.selectLocation(this.props.index, true);
  }

  render() {
    return (
      <div className={`location-card${this.props.selected ? ' active' : ''}`} title="Click me" onClick={this.handleClick}>
        <img src={this.props.location.imageUrl} />
        <div className="location-card-infos">
          <div>
            <h2>{this.props.location.name}</h2>
            <p>{this.props.location.address}</p>
          </div>
          <div>
            <p className="center">starting from</p>
            <h3 className="card-trip-pricing">{this.props.location.price} € / month</h3>
          </div>
        </div>
      </div>
    );
  }
}

export default LocationCard;
