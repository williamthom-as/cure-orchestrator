import { inject, inlineView } from 'aurelia-framework';

@inject('AjaxService')
export class ConfigTile {
  status = null;
  isProcessing = false;

  constructor(ajax) {
    this.ajax = ajax;
  }

  bind() {
    this.isProcessing = true;
    this.ajax.getConfigValidation()
      .then(json => {
        this.status = json.content.result.status;
        this.isProcessing = false;
      });
  }

}