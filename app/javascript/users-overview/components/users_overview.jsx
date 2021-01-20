import React, { Component } from 'react'
import FilterBar from '../containers/filter_bar';
import UsersList from '../containers/users_list'

const UsersOverview = (props) => {
  return(
    <div className="overview-container">
      <FilterBar />
      <UsersList />
    </div>
  )
}

export default UsersOverview;
