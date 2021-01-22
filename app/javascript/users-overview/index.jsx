import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, combineReducers, applyMiddleware } from 'redux';
import logger from 'redux-logger'
import ReduxPromise from 'redux-promise';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import usersReducer from './reducers/users_reducer'
import paginationReducer from './reducers/pagination_reducer'
// import sortParamsReducer from './reducers/sort_params_reducer'

import UsersOverview from './components/users_overview';

const usersOverviewContainer = document.getElementById('user-overview-container');

const initialState = {
  users: [],
  pagination: {
    page: 0
  }
  // bookings: JSON.parse(overviewContainer.dataset.bookings),
  // sortParams: {
  //   key: null,
  //   order: null,
  //   type: 'string'
  // }
};


const reducers = combineReducers({
  users: usersReducer,
  pagination: paginationReducer
  // bookings: bookingsReducer,
  // sortParams: sortParamsReducer
});

const middlewares = applyMiddleware(logger, ReduxPromise);
const store = createStore(reducers, initialState, middlewares);

ReactDOM.render(
  <Provider store={store}>
    <BrowserRouter>
      <Switch>
        <Route path="/users" component={UsersOverview} />
      </Switch>
    </BrowserRouter>
  </Provider>,
  usersOverviewContainer
);
