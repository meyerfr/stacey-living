const BASE_URL = '/api/v2';

const PROJECT_SELECTED = 'PROJECT_SELECTED'
const ROOMTYPE_SELECTED = 'ROOMTYPE_SELECTED'
const FETCH_PROJECTS = 'FETCH_PROJECTS'
const FETCH_ROOMTYPES = 'FETCH_ROOMTYPES'
const FETCH_USER = 'FETCH_USER'
const UPDATE_USER = 'UPDATE_USER'
const COMPLETE_BOOKING = 'COMPLETE_BOOKING'


function selectProject() {
  // body...
}

function selectedRoomtype() {
  // body...
}

function fetchRoomtypes(project_id) {
  const url = `${BASE_URL}/projects/${project_id}/roomtypes`;
  const promise = fetch(url)
    .then(r => r.json());

  return {
    type: FETCH_ROOMTYPES,
    payload: promise
  }
}

function fetchProjects(argument) {
  const url = `${BASE_URL}/projects/`;
  const promise = fetch(url)
    .then(r => r.json());

  return {
    type: FETCH_PROJECTS,
    payload: promise
  }
}

function fetchUser() {
  // body...
}

function updateUser(user_id, user) {
  // body...
}

function completeBooking(booking_id, booking) {
  // body...
}
