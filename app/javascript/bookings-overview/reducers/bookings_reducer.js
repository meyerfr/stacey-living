import { FETCH_ROOMS, SET_SORT_PARAMS, APPLY_FILTER } from '../actions';
import { UPDATE_BOOKING } from '../../booking-process/actions'


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
   		return {bookings: action.payload, sortParams: {sortKey: 'move_in', order: 'asc'}}
    case UPDATE_BOOKING:
      copiedBookings = state.bookings.slice(0)
      console.log(action.payload)
      return {
        bookings: copiedBookings.map((booking) => {
          if (booking.id === action.payload.id) {
            return action.payload
          }

          return booking
        }),
        sortParams: state.sortParams
      }
      // return {bookings: newBookings, sortParams: state.sortParams}
    default:
      return state;
  }
}
