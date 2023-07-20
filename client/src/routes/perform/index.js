import {bindable, computedFrom, inject} from 'aurelia-framework';
import {AppRouter} from "aurelia-router";
import {EventAggregator} from "aurelia-event-aggregator";
import {watch} from 'aurelia-watch-decorator';
import {combo} from 'aurelia-combo';

import _ from "lodash";

@inject(AppRouter, EventAggregator, 'AjaxService', 'Validation', 'AppService')
export class Index {
  @bindable model = {
    template_file: "",
    input_file: null,
    name: null,
    start_time: null
  };

  isProcessing = false;
  activeStep = 0;

  formProcessing = false;
  triedOnce = false;

  templates = null;
  config = null;

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
        this.templates.unshift({
          name: "Select a template",
          path: ""
        });

        this.config = responses[1].content.config_file;

        this.isProcessing = false;
      });
  }

  submit() {
    if (this.formProcessing) return;

    this.triedOnce = true;
    if (this.hasError) return;
    this.ajax.createJob(this.model)
      .then(
        (json) => {
          if (json.success) {
            this.errorMessage = null;

            this.ea.publish('job-saved');
            this.app.showInfo("Success!", json.content.message);
          } else {
            this.app.showError("Error!", json.content.message);
          }
        },
        _err => {
          this.app.showError("Error!", json.content.message);
        }
      )
      .finally(() => this.formProcessing = false);
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
    } else {
      this.template = null;
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
