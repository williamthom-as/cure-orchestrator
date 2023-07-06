import { inject } from 'aurelia-framework';
import { EventAggregator } from 'aurelia-event-aggregator';

@inject(EventAggregator, 'AjaxService')
export class ConfigValidation {
  result = null;
  isProcessing = false;

  constructor(ea, ajax) {
    this.ea = ea;
    this.ajax = ajax;
  }

  attached() {
    this.subscriber = this.ea.subscribe('config-saved', () => {
      this.getConfigValidation();
    });
  }

  bind() {
    this.getConfigValidation();

  }

  reload() {
    console.log("Reloading!")
    this.getConfigValidation();
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