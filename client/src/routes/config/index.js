import { inject, bindable, bindingMode, BindingEngine } from 'aurelia-framework';

@inject('AjaxService')
export class Index {
  @bindable({ defaultBindingMode: bindingMode.twoWay }) configFile = null;

  message = null;

  constructor(ajax) {
    this.ajax = ajax;
  }

  bind() {
    this.getConfig();
  }

  getConfig() {
    this.ajax.getConfig()
      .then(json => {
        this.message = json.content.message;
        this.configFile = json.content.config_file;
      });
  }
}