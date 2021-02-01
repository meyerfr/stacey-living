import React, { Component } from 'react'
import FilterBar from '../containers/filter_bar';
import UsersList from '../containers/users_list'
import ListPagination from '../containers/list_pagination'


const UsersOverview = (props) => {
  return(
    <div className="overview-container">
      <div className="filter-wrapper">
        <FilterBar />
        <ListPagination />
      </div>
      <UsersList />
    </div>
  )
}

export default UsersOverview;
