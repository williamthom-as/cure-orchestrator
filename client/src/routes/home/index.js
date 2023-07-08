import { inject } from 'aurelia-framework';

@inject('AjaxService')
export class Index {

  constructor(ea, ajax) {
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