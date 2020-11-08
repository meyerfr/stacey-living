const BASE_URL = '/api/v1';

export const FETCH_PROJECTS = 'FETCH_PROJECTS'
export const FETCH_ROOMTYPES = 'FETCH_ROOMTYPES'
export const FETCH_AMENITIES = 'FETCH_AMENITIES'

export function fetchRoomtypes(project_id) {
	const url = `${BASE_URL}/projects/${project_id}/roomtypes`;
	const promise = fetch(url)
		.then(r => r.json());

	return {
		type: FETCH_ROOMTYPES,
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

export function fetchAmenities(project_id) {
	const url = `${BASE_URL}/projects/${project_id}/amenities`;
	const promise = fetch(url)
		.then(r => r.json())

	return {
		type: FETCH_AMENITIES,
		payload: promise
	}
}
