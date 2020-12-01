import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { applyFilter } from '../actions';

class FilterBar extends Component {
  applyFilter = (searchquery, filterKey) => {
    this.props.applyFilter(searchquery, filterKey)
  }

  handleChange = (filterKey) => {
    this.applyFilter(event.target.value, filterKey)
  }

  render() {
    return (
      <div className="filter-container">
        <label htmlFor="view">Change View</label>
        <select className="form-control form-search" name="view" id="view" onChange={this.props.onChange}>
          <option value="table">table</option>
          <option value="chart">chart</option>
        </select>
        <div className="inputs">
          <select className="form-control form-search" defaultValue='all' name="project_name" onChange={() => this.handleChange('project_name')}>
            <option value="all">all</option>
            <option value="mühlenkamp">Mühlenkamp</option>
            <option value="eppendorf">Eppendorf</option>
            <option value="st. pauli">St. Pauli</option>
          </select>
          <input type="text" placeholder="search Roomtype..." className="form-control form-search" onChange={() => this.handleChange('roomtype_name')} />
          <input type="text" placeholder="search Apartment..." className="form-control form-search" onChange={() => this.handleChange('apartment_number')} />
          <input type="text" placeholder="search Room..." className="form-control form-search" onChange={() => this.handleChange('room_number')} />
          <input type="text" placeholder="search Tenant..." className="form-control form-search" onChange={() => this.handleChange('user_name')} />
          <div className='date-filter'>
            <select className="form-control form-search" defaultValue='current' name="move_in" onChange={() => this.handleChange('move_in')}>
              <option value="all">all</option>
              <option value="current">current</option>
              <option value="upcoming">upcoming</option>
              <option value="past">past</option>
            </select>
          </div>
        </div>
      </div>
    )
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

export default connect(mapStateToProps, mapDispatchToProps)(FilterBar);
