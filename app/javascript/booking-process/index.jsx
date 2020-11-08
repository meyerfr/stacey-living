import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, combineReducers, applyMiddleware } from 'redux';
import reduxPromise from 'redux-promise';
import logger from 'redux-logger';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
// import { createHistory as history } from 'history';

import ProjectsIndex from './containers/projects_index';
import RoomtypesIndex from './containers/roomtypes_index';
import RoomtypesShow from './containers/roomtypes_show';
// import '../assets/stylesheets/application.scss';

import projectsReducer from './reducers/projects_reducer.js';
import roomtypesReducer from './reducers/roomtypes_reducer.js';
import amenitiesReducer from './reducers/amenities_reducer.js';

// State and reducers
const initialState = {
  projects: [],
  roomtypes: [],
  amenities: []
};

const reducers = combineReducers({
  projects: projectsReducer,
  roomtypes: roomtypesReducer,
  amenities: amenitiesReducer
});

const middlewares = applyMiddleware(reduxPromise, logger);

// render an instance of the component in the DOM
ReactDOM.render(
  <Provider store={createStore(reducers, initialState, middlewares)}>
    <Router>
      <div className="view-container">
        <Switch>
          <Route path="/projects/:id" component={ProjectsIndex} />
          <Route path="/projects/:id/roomtypes" component={RoomtypesIndex} />
          <Route path="/projects/:project_id/roomtypes/:id" component={RoomtypesShow} />
        </Switch>
      </div>
    </Router>
  </Provider>,
  document.getElementById('booking-process')
);
