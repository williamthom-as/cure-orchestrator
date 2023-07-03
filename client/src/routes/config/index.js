import { inject } from 'aurelia-framework';

@inject('AjaxService')
export class Index {

  message = null;
  configFile = null;

  constructor(ajax) {
    this.ajax = ajax;
  }

  bind() {
    this.ajax.getConfig()
      .then(json => {
        this.message = json.content.message;
        this.configFile = json.content.config_file;
      });
  }

}