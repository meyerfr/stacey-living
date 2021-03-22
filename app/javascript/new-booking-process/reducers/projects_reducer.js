import { FETCH_PROJECTS } from '../actions'

export default function projectsReducer(state = null, action) {
  switch (action.type) {
    case FETCH_PROJECTS:
      return action.payload;
    default:
      return state;
  }
}
