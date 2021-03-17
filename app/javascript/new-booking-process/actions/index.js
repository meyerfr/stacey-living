const BASE_URL = '/api/v2';

export const PROJECT_SELECTED = 'PROJECT_SELECTED'
export const ROOMTYPE_SELECTED = 'ROOMTYPE_SELECTED'
export const FETCH_PROJECTS = 'FETCH_PROJECTS'
export const FETCH_ROOMTYPES = 'FETCH_ROOMTYPES'
export const FETCH_USER = 'FETCH_USER'
export const USER_UPDATED = 'USER_UPDATED'
export const COMPLETE_BOOKING = 'COMPLETE_BOOKING'
export const UPDATE_BOOKING = 'UPDATE_BOOKING'
export const CONTRACT_SIGNED = 'CONTRACT_SIGNED'
export const USER_ADDRESS_CREATED = 'USER_ADDRESS_CREATED'
export const ROOM_CHOSEN = 'ROOM_CHOSEN'
export const PAYMENT_INTENT_CREATED = 'PAYMENT_INTENT_CREATED'


export function createPaymentIntent(booking_id, callback) {
  const url = `${BASE_URL}/bookings/${booking_id}/payments/new`;
  const promise = fetch(url)
    .then(r => r.json())
    .then((r) => typeof callback === 'function' && callback(r));

  return {
    type: PAYMENT_INTENT_CREATED,
    payload: promise
  }
}

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

export function updateUser(user, callback) {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  console.log(user)
  const url = `${BASE_URL}/users/${user.id}`
  const promise = fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(user)
  }).then(r => r.json())
    .then(() => console.log('Callback function?', typeof callback == 'function'))
    .then(() => typeof callback === 'function' && callback());

  return {
    type: USER_UPDATED,
    payload: user
  }
}

export function completeBooking(booking_id, booking, callback) {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  const url = `${BASE_URL}/bookings/${booking_id}`

  const body = {
    ...booking,
    state: 'deposit outstanding'
  }

  const promise = fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(body)
  }).then(r => r.json())
    .then((r) => typeof callback === 'function' && callback(r));

  return {
    type: UPDATE_BOOKING,
    payload: booking
  }
}

export function createUserAddress(user_id, address, callback) {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;
  const url = `${BASE_URL}/users/${user_id}/addresses`;

  const promise = fetch(url, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(address)
  }).then(r => r.json())
    .then(() => typeof callback === 'function' && callback());

    // .then(() => callback());

  return {
    type: USER_ADDRESS_CREATED,
    payload: address
  }
}

export function createContract(booking_id, contract, callback) {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;
  const url = `${BASE_URL}/bookings/${booking_id}/contracts`;
  console.log(contract)

  const promise = fetch(url, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(contract)
  }).then(r => r.json())
    .then(() => typeof callback === 'function' && callback());

    // .then(() => callback());

  return {
    type: CONTRACT_SIGNED,
    payload: contract
  }
}


export function chooseRoom(booking_id, booking, callback) {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  const url = `${BASE_URL}/bookings/${booking_id}`
  const price = booking.price
  let body = booking
  delete body.price
  body = {
    ...body,
    price_id: price.id
  }

  const promise = fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(body)
  }).then(r => r.json())
    .then(() => typeof callback === 'function' && callback());

  return {
    type: ROOM_CHOSEN,
    payload: booking
  }
}
