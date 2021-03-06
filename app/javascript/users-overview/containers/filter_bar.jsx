import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { fetchUsers } from '../actions';

class FilterBar extends Component {
  fetchUsers = (searchquery, filterKey) => {
    this.props.fetchUsers(null, searchquery, filterKey)
  }

  changeFilter = event => {
    console.log('changeFilter')
    console.log(event.target)
    // console.log(event.target.attributes['filter'].value)
    const filterKey = event.target.options ? event.target.options[event.target.selectedIndex].attributes['filter'].value : event.target.attributes["filter"].value
    this.fetchUsers(event.target.value, filterKey)
  }


  render() {
    return (
      <div className="filter-container">
        {
          // Download CSV -> Action to call on User index
        }
        <select className="form-control form-search" name="filter" id="filter" defaultValue="applicants" onChange={this.changeFilter}>
          <option value="all" filter="invite">all</option>
          <option value="invite send" filter="invite">invite send</option>
          <option value="invite outstanding" filter="invite">invite outstanding</option>
          <option value="current Tenants" filter="role">current Tenants</option>
          <option value="next Tenants" filter="role">next Tenants</option>
          <option value="prev Tenants" filter="role">prev Tenants</option>
          <option value="applicants" filter="role">applicants</option>
        </select>
        <input type="text" placeholder="search User..." filter="name" className="form-control form-search" onChange={this.changeFilter} />
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    users: state.users,
    filter: state.filter,
    pagination: state.pagination
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchUsers }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(FilterBar);
