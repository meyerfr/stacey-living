const BASE_URL = '/api/v1';

const CREATE_APPLICATION = 'CREATE_APPLICATION'

export function createApplication(application, callback) {
  const url = `${BASE_URL}/applications`;
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const promise = fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(application)
  }).then(r => r.json())
    .then(r => typeof callback === 'function' ? callback(r) : r);

  return {
    type: CREATE_APPLICATION,
    payload: promise
  }
}
