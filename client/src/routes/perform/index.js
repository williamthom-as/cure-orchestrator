import {bindable, computedFrom, inject} from 'aurelia-framework';
import {AppRouter} from "aurelia-router";
import {EventAggregator} from "aurelia-event-aggregator";
import {watch} from 'aurelia-watch-decorator';

import _ from "lodash";

@inject(AppRouter, EventAggregator, 'AjaxService', 'Validation', 'AppService')
export class Index {
  @bindable model = {
    template_file: null,
    input_file: null
  };

  isProcessing = false;
  triedOnce = false;

  activeStep = 0;

  templates = null;

  steps = [
    {title: "Template"},
    {title: "Input"},
    {title: "Execute"},
  ]

  constructor(router, ea, ajax, validation, app) {
    this.router = router;
    this.ea = ea;
    this.ajax = ajax;
    this.app = app;
    this.validator = validation.generateValidator({
      input_file: ['mandatory'],
      template_file: ['mandatory']
    });
  }

  bind() {
    this.ajax.getTemplates()
      .then(json => {
        this.templates = json.content.templates;
        this.isProcessing = false;
      });
  }

  @computedFrom('triedOnce', 'model.template_file', 'model.input_file')
  get errors() {
    if (!this.triedOnce) return {};
    return this.validator(this.model) || {};
  }

  @computedFrom('errors')
  get hasError() {
    return !_.isEmpty(this.errors);
  }

  @watch('model.template_file')
  templateChanged(n, _o) {
    if (n) {
      const fileDetails = this.templates.find(t => { return t.path === n });
      this.ajax.getTemplate(fileDetails.name)
        .then(json => {
          this.template = json.content.template;
        });
    }
  }
}
