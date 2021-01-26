import { FETCH_USERS } from '../actions';

export default function filterReducer(state = null, action) {
  switch (action.type) {
    case FETCH_USERS:
      return action.payload.filter;
    default:
      return state;
  }
}
