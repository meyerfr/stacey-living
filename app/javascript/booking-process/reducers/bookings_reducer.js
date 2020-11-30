import { FETCH_BOOKING } from '../actions'

export default function bookingsReducer(state = null, action) {
  switch (action.type) {
    case FETCH_BOOKING:
      return action.payload;
    default:
      return state;
  }
}
