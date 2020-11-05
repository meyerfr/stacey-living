const BASE_URL = '/api/v1';

// export const FETCH_BOOKINGS = 'FETCH_BOOKINGS'

// export function fetchBookings() {
//   const url = `${BASE_URL}/sections/${section_id}/scripts`;
//   const promise = fetch(url, { credentials: "same-origin" }).then(r => r.json());

//   return {
//     type: FETCH_BOOKINGS,
//     payload: promise // Will be resolved by redux-promise
//   };
// }

export const FETCH_ROOM_INFO = 'FETCH_ROOM_INFO'
export const FETCH_ROOMS = 'FETCH_ROOMS'
export const SET_SORT_PARAMS = 'SET_SORT_PARAMS'
export const APPLY_FILTER = 'APPLY_FILTER'

export function fetchRoomInfo(room_id) {
	const url = `${BASE_URL}/rooms/${room_id}`;
	const promise = fetch(url, { credentials: "same-origin" }).then(r => r.json());

	return {
		type: FETCH_ROOM_INFO,
		payload: promise
	}
}

// export function fetchRooms(params) {
// 	const param_entries = Object.entries(params)
// 	let query_string = ''
// 	for (const [param_key, param_value] of param_entries) {
// 		if (param_value) {
// 			query_string += `${query_string == '' ? '?' : '&'}${param_key}=${param_value}`
// 		}
// 	}
// 	const url = `${BASE_URL}/rooms${query_string}`;
// 	const promise = fetch(url, { credentials: "same-origin" }).then(r => r.json());

// 	return {
// 		type: FETCH_ROOMS,
// 		payload: promise
// 	}
// }

 export function setSortParams(sortKey) {
	return {
		type: SET_SORT_PARAMS,
		payload: {
			sortParams: {
				key: sortKey
			}
		}
	}
}

export function applyFilter(searchquery, filterKey) {
	const url = `${BASE_URL}/rooms${searchquery ? `?filter=${filterKey}&${filterKey}=${searchquery}` : ''}`
  	const promise = fetch(url, { credentials: 'same-origin' }).then(r => r.json());
  	return {
    	type: APPLY_FILTER,
    	payload: promise
  	}
}