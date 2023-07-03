import _ from 'lodash';
import {HttpClient} from 'aurelia-fetch-client';
import {inject, computedFrom} from 'aurelia-framework';

@inject(HttpClient)
export class AjaxService {
  user = null;

  constructor(client) {
    this.client = client;
  }

  @computedFrom('client.isRequesting')
  get isRequesting() {
    return this.client.isRequesting;
  }

  _fetch(url, options = {}) {
    let opts = {};

    // Removed for now
    // let token = localStorage.getItem('access_token');
    //
    // if (token) {
    //     opts.headers = {
    //         Authorization: `Bearer ${token}`
    //     };
    // }

    _.merge(opts, options);
    return this.client.fetch(url, opts);
  }

  fetch(url, options = {}) {
    return this._fetch('http://127.0.0.1:4567' + url, options)
      .then(response => {
        if (response.ok) {
          return response.json();
        }

        // Removed for now
        // if (response.status === 401) { // Unauthorized
        //     localStorage.removeItem('access_token');
        //     this.user = null;
        // }

        return response.json().then(
          json => {
            if (json.errors) {
              return Promise.reject(json.errors);
            }
            throw new Error(json);
          },
          error => {
            throw new Error(error);
          }
        );
      });
  }

  postUsingJSON(url, params = {}) {
    return this.fetch(url, {
      method: 'POST',
      body: JSON.stringify(params),
      headers: {
        'Content-Type': 'application/json'
      }
    });
  }

  putUsingJSON(url, params = {}) {
    return this.fetch(url, {
      method: 'PUT',
      body: JSON.stringify(params),
      headers: {
        'Content-Type': 'application/json'
      }
    });
  }

  delete(url) {
    return this.fetch(url, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json'
      }
    });
  }

  generateQueryString(payload) {
    const results = [];
    _.forOwn(payload, (value, key) => {
      if (Array.isArray(value)) {
        _.forOwn(value, value => {
          results.push(`${key}=${value}`);
        });
      } else {
        results.push(`${key}=${value}`);
      }
    });

    return results.join('&');
  }

  // User endpoints
  login(username, password) {
    return this.postUsingJSON('/auth/login', {username, password})
      .then(json => {
          this.user = {username, token: json.access_token};
          localStorage.setItem('access_token', json.access_token);
        },
        error => {
          localStorage.removeItem('access_token');
          this.user = null;
          throw error;
        });
  }

  logout() {
    this.user = null;
    localStorage.removeItem('access_token');
  }
  getConfig() {
    return this.fetch('/api/v1/config')
      .then(json => {
          return json;
        },
        error => {
          throw error;
        });
  }
}