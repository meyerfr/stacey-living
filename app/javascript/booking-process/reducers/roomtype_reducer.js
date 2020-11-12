import { FETCH_ROOMTYPE } from '../actions'

export default function roomtypeReducer(state = null, action) {
  switch (action.type) {
    case FETCH_ROOMTYPE:
      return action.payload;
    default:
      return state;
  }
}
