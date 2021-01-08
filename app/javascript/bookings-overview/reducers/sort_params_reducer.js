import { SET_SORT_PARAMS } from '../actions';

export default function sortParamsReducer(state = null, action) {
  switch (action.type) {
    case SET_SORT_PARAMS:
      return action.payload;
    default:
      return state;
  }
}
