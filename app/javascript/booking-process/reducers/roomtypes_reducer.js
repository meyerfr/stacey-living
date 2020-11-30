import { FETCH_ROOMTYPES } from '../actions'

export default function roomtypesReducer(state = null, action) {
  switch (action.type) {
    case FETCH_ROOMTYPES:
      return action.payload;
    default:
      return state;
  }
}
