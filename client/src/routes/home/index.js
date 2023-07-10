import { inject } from 'aurelia-framework';

@inject('AjaxService')
export class Index {

  isProcessing = false;

  constructor(ajax) {
    this.ajax = ajax;
  }

  getConfigValidation() {
    this.isProcessing = true;
    this.ajax.getConfigValidation()
      .then(json => {
        this.result = json.content.result;
        this.isProcessing = false;
      });
  }

}