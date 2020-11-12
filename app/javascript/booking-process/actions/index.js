const BASE_URL = '/api/v1';

export const FETCH_PROJECTS = 'FETCH_PROJECTS'
export const FETCH_ROOMTYPES = 'FETCH_ROOMTYPES'
export const FETCH_ROOMTYPE = 'FETCH_ROOMTYPE'
export const FETCH_AMENITIES = 'FETCH_AMENITIES'
export const FETCH_PROJECT = 'FETCH_PROJECT'
export const FETCH_DESCRIPTIONS = 'FETCH_DESCRIPTIONS'
export const UPDATE_BOOKING = 'UPDATE_BOOKING'

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

export function updateBooking(booking_id, booking, csrfToken, callback) {
	console.log(booking)
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