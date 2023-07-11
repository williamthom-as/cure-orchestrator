import {bindable, computedFrom, inject} from 'aurelia-framework';
import {AppRouter} from "aurelia-router";
import {EventAggregator} from "aurelia-event-aggregator";
import {watch} from 'aurelia-watch-decorator';
import {combo} from 'aurelia-combo';

import _ from "lodash";

@inject(AppRouter, EventAggregator, 'AjaxService', 'Validation', 'AppService')
export class Index {
  @bindable model = {
    template_file: null,
    input_file: null,
    name: null,
    start_time: null
  };

  isProcessing = false;
  triedOnce = false;

  activeStep = 0;

  templates = null;

  steps = [
    {title: "Job Inputs"},
    {title: "Job Details"},
    {title: "Summary"},
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
    this.isProcessing = true;

    Promise.all([this.ajax.getTemplates(), this.ajax.getConfig()])
      .then((responses) => {
        this.templates = responses[0].content.templates;
        this.config = responses[1].content.config_file;

        this.isProcessing = false;
      });
  }

  submit() {
    if (this.isProcessing) return;

    this.triedOnce = true;
    if (this.hasError) return;
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

  @combo('left')
  previous() {
    if (this.activeStep > 0) {
      this.activeStep -= 1;
    }
  }

  @combo('right')
  next() {
    if (this.activeStep < this.steps.length) {
      this.activeStep += 1;
    }
  }
}
