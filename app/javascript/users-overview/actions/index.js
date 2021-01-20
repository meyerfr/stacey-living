const BASE_URL = '/api/v1';

export const FETCH_USERS = 'FETCH_USERS'
export const APPLY_FILTER = 'APPLY_FILTER'
export const CREATE_BOOKING = 'CREATE_BOOKING'

export function fetchUsers() {
  const url = `${BASE_URL}/users`;
  const promise = fetch(url, { credentials: "same-origin" }).then(r => r.json());

  return {
    type: FETCH_USERS,
    payload: promise // Will be resolved by redux-promise
  };
}


//  export function applyFilter(searchquery, filterKey) {
//   return {
//     type: APPLY_FILTER,
//     payload: {
//       sortParams: {
//         key: sortKey
//       }
//     }
//   }
// }

export function applyFilter(searchquery, filterKey) {
  const url = `${BASE_URL}/users${searchquery ? `?filter=${filterKey}&searchquery=${searchquery}` : ''}`
  const promise = fetch(url, { credentials: 'same-origin' }).then(r => r.json());
  return {
    type: APPLY_FILTER,
    payload: promise
  }
}


export function createBooking(user_id) {
  const url = `${BASE_URL}/users/${user_id}/bookings`;
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const promise = fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    }
  }).then(response => response.json())
    // .then(r => typeof callback === 'function' ? callback(r) : r);

  return {
    type: CREATE_BOOKING,
    payload: promise
  }
}
