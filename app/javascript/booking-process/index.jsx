import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, combineReducers, applyMiddleware } from 'redux';
import reduxPromise from 'redux-promise';
import logger from 'redux-logger';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { useHistory as history } from 'react-router-dom';

import ProjectsIndex from './containers/projects_index';
import RoomtypesIndex from './containers/roomtypes_index';
import RoomtypeShow from './containers/roomtype_show';
import Contract from './containers/contract';
import Payment from './containers/payment';
import Success from './containers/success';
// import '../assets/stylesheets/application.scss';

import projectsReducer from './reducers/projects_reducer.js';
import projectReducer from './reducers/project_reducer.js';
import roomtypesReducer from './reducers/roomtypes_reducer.js';
import roomtypeReducer from './reducers/roomtype_reducer.js';
import amenitiesReducer from './reducers/amenities_reducer.js';
import descriptionsReducer from './reducers/descriptions_reducer.js';
import contractsReducer from './reducers/contracts_reducer.js';
import bookingsReducer from './reducers/bookings_reducer.js';
import clientSecretsReducer from './reducers/client_secrets_reducer.js';
import { reducer as formReducer } from 'redux-form';
// [...]

// State and reducers
const initialState = {
  projects: [],
  roomtypes: [],
  amenities: []
};

const reducers = combineReducers({
  projects: projectsReducer,
  roomtypes: roomtypesReducer,
  amenities: amenitiesReducer,
  project: projectReducer,
  roomtype: roomtypeReducer,
  form: formReducer,
  contract: contractsReducer,
  booking: bookingsReducer,
  client_secret: clientSecretsReducer
});

const middlewares = applyMiddleware(reduxPromise, logger);

// render an instance of the component in the DOM
ReactDOM.render(
  <Provider store={createStore(reducers, initialState, middlewares)}>
    <BrowserRouter history={history}>
      <div className="view-container">
        <Switch>
          <Route path="/bookings/:booking_auth_token?/:booking_id/success" exact component={Success} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/payment" exact component={Payment} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/contract" exact component={Contract} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/projects/:project_id/roomtypes/:id" component={RoomtypeShow} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/projects/:project_id/roomtypes" component={RoomtypesIndex} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/projects" component={ProjectsIndex} />
        </Switch>
      </div>
    </BrowserRouter>
  </Provider>,
  document.getElementById('booking-process')
);
