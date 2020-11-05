import { FETCH_ROOMS, SET_SORT_PARAMS, APPLY_FILTER } from '../actions';

export default function bookingsReducer(state = null, action) {
  switch (action.type) {
    case FETCH_ROOMS:
      return action.payload;
    case SET_SORT_PARAMS:
    	let sortParams = action.payload.sortParams
    	let copiedBookings = state.bookings.slice(0)
    	let key = sortParams.key
    	sortParams.order = key === state.sortParams.key ? (state.sortParams.order === 'asc' ? 'desc' : 'asc') : 'asc'
    	console.log(sortParams)
    	if (sortParams.order === 'asc') {
    		copiedBookings.sort((a,b) => (a[key] > b[key]) ? 1 : ((b[key] > a[key]) ? -1 : 0))
    	} else {
    		copiedBookings.sort((a,b) => (a[key] > b[key]) ? -1 : ((b[key] > a[key]) ? 1 : 0))
    	}
    	return {bookings: copiedBookings, sortParams: sortParams}
   	case APPLY_FILTER:
   		return {bookings: action.payload, sortParams: {sortKey: null, order: 'asc'}}
    default:
      return state;
  }
}
