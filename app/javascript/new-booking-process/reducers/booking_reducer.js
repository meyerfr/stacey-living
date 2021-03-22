import { ROOM_CHOSEN, USER_UPDATED, USER_ADDRESS_CREATED, UPDATE_BOOKING } from '../actions'

export default function bookingReducer(state = null, action) {
  switch (action.type) {
    case ROOM_CHOSEN:
      return {
        ...state,
        'move_in': action.payload.move_in,
        'move_out': action.payload.move_out,
        'room_id': action.payload.room_id,
        'price': action.payload.price,
      }
    case UPDATE_BOOKING:
      return {
        ...state,
        'state': 'deposit outstanding'
      }
    case USER_UPDATED:
      return {
        ...state,
        user: action.payload
      }
    case USER_ADDRESS_CREATED:
      return {
        ...state,
        user: {
          ...state.user,
          address: action.payload
        }
      }
    default:
      return state;
  }
}
