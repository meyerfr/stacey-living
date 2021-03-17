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
import RoomtypesShow from './containers/roomtypes_show';
import ContractWrapper from './containers/contract_wrapper';
import Payment from './containers/payment';
// import Success from './containers/success';
// import '../assets/stylesheets/application.scss';
import ScrollToTop from './components/scroll_to_top';

import projectsReducer from './reducers/projects_reducer.js';
import roomtypesReducer from './reducers/roomtypes_reducer.js';
import contractReducer from './reducers/contract_reducer.js';
import bookingReducer from './reducers/booking_reducer.js';

const bookingProcessContainer = document.getElementById('new-booking-process');

const booking = JSON.parse(bookingProcessContainer.dataset.booking)

// State and reducers
const initialState = {
  projects: [],
  roomtypes: [],
  // selectedProject: null,
  // selectedRoomtype: null,
  contract: { signature: '', signed_date: new Date() },
  booking: booking
};

const reducers = combineReducers({
  projects: projectsReducer,
  roomtypes: roomtypesReducer,
  contract: contractReducer,
  booking: bookingReducer
});

const middlewares = (process.env.NODE_ENV !== 'production') ?
                      applyMiddleware(reduxPromise, logger)
                    :
                      applyMiddleware(reduxPromise)

// render an instance of the component in the DOM
ReactDOM.render(
  <Provider store={createStore(reducers, initialState, middlewares)}>
    <BrowserRouter onUpdate={() => window.scrollTo(0, 0)} history={history}>
      <ScrollToTop />
      <div className="view-container">
        <Switch>
          {
            // <Route path="/bookings/:booking_auth_token?/:booking_id/success" exact component={Success} />
          }
          <Route path="/bookings/:booking_auth_token?/:booking_id/projects/:project_id/roomtypes/:roomtype_id/payment" exact component={Payment} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/projects/:project_id/roomtypes/:roomtype_id/contract" exact component={ContractWrapper} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/projects/:project_id/roomtypes/:roomtype_id" component={RoomtypesShow} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/projects/:project_id/roomtypes" component={RoomtypesIndex} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/projects" component={ProjectsIndex} />
        </Switch>
      </div>
    </BrowserRouter>
  </Provider>,
  bookingProcessContainer
);
