const BASE_URL = '/api/v2';

export const PROJECT_SELECTED = 'PROJECT_SELECTED'
export const ROOMTYPE_SELECTED = 'ROOMTYPE_SELECTED'
export const FETCH_PROJECTS = 'FETCH_PROJECTS'
export const FETCH_ROOMTYPES = 'FETCH_ROOMTYPES'
export const FETCH_USER = 'FETCH_USER'
export const USER_UPDATED = 'USER_UPDATED'
export const COMPLETE_BOOKING = 'COMPLETE_BOOKING'
export const CONTRACT_SIGNED = 'CONTRACT_SIGNED'
export const ROOM_CHOSEN = 'ROOM_CHOSEN'


export function selectProject() {
  // body...
}

export function selectRoomtype() {
  // body...
}

export function fetchRoomtypes(project_id) {
  const url = `${BASE_URL}/projects/${project_id}/roomtypes`;
  const promise = fetch(url)
    .then(r => r.json());

  return {
    type: FETCH_ROOMTYPES,
    payload: promise
  }
}

export function fetchProjects(argument) {
  const url = `${BASE_URL}/projects/`;
  const promise = fetch(url)
    .then(r => r.json());

  return {
    type: FETCH_PROJECTS,
    payload: promise
  }
}

export function fetchUser(user_id) {
  const url = `${BASE_URL}/users/${user_id}${page && '?page=' + page}`;
  const promise = fetch(url)
    .then(r => r.json());

  return {
    type: FETCH_PROJECT,
    payload: promise
  }
}

export function updateUser(user_id, user, callback) {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  const url = `${BASE_URL}/users/${user_id}`
  const promise = fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(user)
  }).then(r => r.json())
    .then(() => callback());

  debugger

  return {
    type: USER_UPDATED,
    payload: user
  }
}

export function completeBooking(booking_id, booking) {
  // body...
}

export function signContract(contract, user, callback) {
  // console.log('actions callback', callback)
  // console.log('user', user)
  // setTimeout(function() {
    callback()
  // }, 10);
  return {
    type: CONTRACT_SIGNED,
    payload: {contract: contract, user: user}
  }
}

export function chooseRoom(booking, callback) {
  if (typeof callback === 'function') {
    callback()
  }

  return {
    type: ROOM_CHOSEN,
    payload: booking
  }
}
