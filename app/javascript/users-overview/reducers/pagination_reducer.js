import { FETCH_USERS } from '../actions';

export default function paginationReducer(state = null, action) {
  switch (action.type) {
    case FETCH_USERS:
      return action.payload.pagination;
    default:
      return state;
  }
}
