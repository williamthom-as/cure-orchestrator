import { inject } from 'aurelia-framework';

@inject('AjaxService')
export class Templates {

  templates = null;
  isProcessing = false;

  constructor(ajax) {
    this.ajax = ajax;
  }

  bind() {
    this.getTemplates();
  }

  getTemplates() {
    this.isProcessing = true;
    this.ajax.getTemplates()
      .then(json => {
        this.templates = json.content.templates;
        this.isProcessing = false;
      });
  }

}