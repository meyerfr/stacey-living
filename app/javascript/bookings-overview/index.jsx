import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, combineReducers, applyMiddleware } from 'redux';
import logger from 'redux-logger'
import ReduxPromise from 'redux-promise';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import bookingsReducer from './reducers/bookings_reducer'
// import sortParamsReducer from './reducers/sort_params_reducer'

import App from './components/app';

const overviewContainer = document.getElementById('overview-container');

const initialState = {
  app: {
    bookings: JSON.parse(overviewContainer.dataset.bookings),
    sortParams: {
      key: 'move_in',
      order: 'asc'
    }
  }
  // bookings: JSON.parse(overviewContainer.dataset.bookings),
  // sortParams: {
  //   key: null,
  //   order: null,
  //   type: 'string'
  // }
};


const reducers = combineReducers({
  app: bookingsReducer
  // bookings: bookingsReducer,
  // sortParams: sortParamsReducer
});

const middlewares = applyMiddleware(logger, ReduxPromise);
const store = createStore(reducers, initialState, middlewares);

ReactDOM.render(
  <Provider store={store}>
    <BrowserRouter>
      <Switch>
        <Route path="/bookings" component={App} />
      </Switch>
    </BrowserRouter>
  </Provider>,
  overviewContainer
);
