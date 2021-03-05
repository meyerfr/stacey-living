import { ROOM_CHOSEN, USER_UPDATED, CONTRACT_SIGNED } from '../actions'

export default function bookingReducer(state = null, action) {
  switch (action.type) {
    case ROOM_CHOSEN:
      return action.payload;
    case USER_UPDATED:
      return {
        ...state,
        user: action.payload
      }
    case CONTRACT_SIGNED:
      return {
        ...state,
        user: action.payload.user
      }
    default:
      return state;
  }
}
