import { FETCH_ROOMTYPES, PROJECT_SELECTED } from '../actions'

export default function roomtypesReducer(state = null, action) {
  switch (action.type) {
    case FETCH_ROOMTYPES:
      return action.payload;
    case PROJECT_SELECTED:
      return []
    default:
      return state;
  }
}
