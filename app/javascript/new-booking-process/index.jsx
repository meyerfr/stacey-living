import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, combineReducers, applyMiddleware } from 'redux';
import reduxPromise from 'redux-promise';
import logger from 'redux-logger';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { useHistory as history } from 'react-router-dom';

import App from './components/app'
// import ProjectsIndex from './containers/projects_index';
// import RoomtypesIndex from './containers/roomtypes_index';
// import RoomtypeShow from './containers/roomtype_show';
// import Contract from './containers/contract';
// import Payment from './containers/payment';
// import Success from './containers/success';
// // import '../assets/stylesheets/application.scss';

// import projectsReducer from './reducers/projects_reducer.js';
// import selectedProjectReducer from './reducers/selected_project_reducer.js';
// import roomtypesReducer from './reducers/roomtypes_reducer.js';
// import selectedRoomtypeReducer from './reducers/selected_roomtype_reducer.js';
// import contractReducer from './reducers/contract_reducer.js';
// import bookingReducer from './reducers/booking_reducer.js';
// [...]

const bookingProcessContainer = document.getElementById('new-booking-process');

// State and reducers
const initialState = {
  // projects: [],
  // roomtypes: [],
  // selectedProject: null,
  // selectedRoomtype: null,
  // contract: { signature: null, signed_date: new Date() },
  booking: JSON.parse(bookingProcessContainer.dataset.booking)
};

const reducers = combineReducers({
  // projects: projectsReducer,
  // roomtypes: roomtypesReducer,
  // selectedRoomtype: selectedRoomtypeReducer,
  // selectedProject: selectedProjectReducer,
  // contract: contractReducer,
  booking: (state = null, action) => state
});

const middlewares = (process.env.NODE_ENV !== 'production') ?
                      applyMiddleware(reduxPromise, logger)
                    :
                      applyMiddleware(reduxPromise)


// const middlewares = process.env.NOVE_ENV === 'development' ?  applyMiddleware(logger) : applyMiddleware(reduxPromise, logger);

// console.log(middlewares)

// render an instance of the component in the DOM
ReactDOM.render(
  <Provider store={createStore(reducers, initialState, middlewares)}>
    <BrowserRouter history={history}>
      <div className="view-container">
        <Switch>
        {
          // <Route path="/bookings/:booking_auth_token?/:booking_id/success" exact component={App} />
          // <Route path="/bookings/:booking_auth_token?/:booking_id/payment" exact component={App} />
          // <Route path="/bookings/:booking_auth_token?/:booking_id/contract" exact component={App} />
          // <Route path="/bookings/:booking_auth_token?/:booking_id/projects/:project_id/roomtypes/:id" component={App} />
          // <Route path="/bookings/:booking_auth_token?/:booking_id/projects/:project_id/roomtypes" component={App} />
        }
          <Route path="/bookings/:booking_auth_token?/:booking_id/projects" component={App} />
          <Route path="/bookings/:booking_auth_token?/:booking_id/" component={App} />
        </Switch>
      </div>
    </BrowserRouter>
  </Provider>,
  bookingProcessContainer
);
