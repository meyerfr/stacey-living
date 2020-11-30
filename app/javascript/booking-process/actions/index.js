const BASE_URL = '/api/v1';

export const FETCH_PROJECTS = 'FETCH_PROJECTS'
export const FETCH_ROOMTYPES = 'FETCH_ROOMTYPES'
export const FETCH_ROOMTYPE = 'FETCH_ROOMTYPE'
export const FETCH_AMENITIES = 'FETCH_AMENITIES'
export const FETCH_PROJECT = 'FETCH_PROJECT'
export const FETCH_DESCRIPTIONS = 'FETCH_DESCRIPTIONS'
export const FETCH_BOOKING = 'FETCH_BOOKING'
export const UPDATE_BOOKING = 'UPDATE_BOOKING'
export const FETCH_CONTRACT = 'FETCH_CONTRACT'
export const CREATE_CONTRACT = 'CREATE_CONTRACT'
export const UPDATE_CONTRACT = 'UPDATE_CONTRACT'
export const UPDATE_USER = 'UPDATE_USER'
export const UPDATE_USER_ADDRESS = 'UPDATE_USER_ADDRESS'
export const CREATE_USER_ADDRESS = 'CREATE_USER_ADDRESS'
export const FETCH_INTENT = 'FETCH_INTENT'

export function fetchRoomtypes(project_id) {
	const url = `${BASE_URL}/projects/${project_id}/roomtypes`;
	const promise = fetch(url)
		.then(r => r.json());

	return {
		type: FETCH_ROOMTYPES,
		payload: promise
	}
}

export function fetchRoomtype(roomtype_id) {
	const url = `${BASE_URL}/roomtypes/${roomtype_id}`
	const promise = fetch(url)
		.then(r => r.json());

	return {
		type: FETCH_ROOMTYPE,
		payload: promise
	}
}

export function fetchProjects() {
	const url = `${BASE_URL}/projects/`;
	const promise = fetch(url)
		.then(r => r.json());

	return {
		type: FETCH_PROJECTS,
		payload: promise
	}
}

export function fetchProject(project_id, page) {
	const url = `${BASE_URL}/projects/${project_id}${page && '?page=' + page}`;
	const promise = fetch(url)
		.then(r => r.json());

	return {
		type: FETCH_PROJECT,
		payload: promise
	}
}

export function fetchAmenities(type, type_id) {
	const url = `${BASE_URL}/amenities?type=${type}&type_id=${type_id}`;
	const promise = fetch(url)
		.then(r => r.json())

	return {
		type: FETCH_AMENITIES,
		payload: promise
	}
}

export function fetchDescriptions(type, type_id) {
	const url = `${BASE_URL}/descriptions?type=${type}&type_id=${type_id}`;
	const promise = fetch(url)
		.then(r => r.json());

	return {
		type: FETCH_DESCRIPTIONS,
		payload: promise
	}
}

export function fetchBooking(booking_id) {
	const url = `${BASE_URL}/bookings/${booking_id}`;
	const promise = fetch(url)
		.then(r => r.json());

	return {
		type: FETCH_BOOKING,
		payload: promise
	}
}

export function updateBooking(booking_id, booking, csrfToken, callback) {
	const url = `${BASE_URL}/bookings/${booking_id}`
	const request = fetch(url, {
    method: 'PATCH',
    headers: {
    	'Content-Type': 'application/json',
    	'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(booking)
  }).then(r => r.json())
    .then(() => callback());
}


export function fetchContract(booking_id) {
	const url = `${BASE_URL}/bookings/${booking_id}/contracts`;
	const promise = fetch(url)
		.then(r => r.json());

	return {
		type: FETCH_CONTRACT,
		payload: promise
	}
}

export function createContract(booking_id, contract) {
	const url = `${BASE_URL}/bookings/${booking_id}/contracts`;
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;

  const promise = fetch(url, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(contract)
  }).then(r => r.json())
    // .then(() => callback());

  return {
    type: CREATE_CONTRACT,
    payload: promise // Will be resolved by redux-promise
  };
}

export function updateContract(contract) {
	const url = `${BASE_URL}/contracts/${contract.id}`;
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;

	const promise = fetch(url, {
    method: 'PUT',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(contract)
  }).then(r => r.json())

	return {
		type: UPDATE_CONTRACT,
		payload: promise
	}
}

export function updateUser(user) {
	const url = `${BASE_URL}/users/${user.id}`;
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;

	const promise = fetch(url, {
    method: 'PUT',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(user)
  }).then(r => r.json())

	return {
		type: UPDATE_USER,
		payload: promise
	}
}

export function createUserAddress(user_id, address) {
	const url = `${BASE_URL}/users/${user_id}/addresses`;
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;

  const promise = fetch(url, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(address)
  }).then(r => r.json())
    // .then(() => callback());

  return {
    type: CREATE_USER_ADDRESS,
    payload: promise // Will be resolved by redux-promise
  };
}

export function updateUserAddress(address) {
	const url = `${BASE_URL}/addresses/${address.id}`;
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;

	const promise = fetch(url, {
    method: 'PUT',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(address)
  }).then(r => r.json())

	return {
		type: UPDATE_USER_ADDRESS,
		payload: promise
	}
}

export function fetchIntent(booking_id) {
	const url = `${BASE_URL}/bookings/${booking_id}/secret`;
	const promise = fetch(url)
		.then(r => r.json());

	return {
		type: FETCH_INTENT,
		payload: promise
	}	
}