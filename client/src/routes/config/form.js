import { AppRouter, Redirect } from 'aurelia-router';
import { inject, computedFrom, bindable } from 'aurelia-framework';
import _ from 'lodash';

@inject(AppRouter, 'AjaxService', 'Validation', 'AppService')
export class Form {
  @bindable model = null;

  isProcessing = false;
  triedOnce = false;
  errorMessage = null;

  constructor(router, ajax, validation, app) {
    this.router = router;
    this.ajax = ajax;
    this.app = app;
    this.validator = validation.generateValidator({
      input_directory: ['mandatory'],
      template_directory: ['mandatory']
    });
  }

  submit() {
    console.log("here!")
    if (this.isProcessing) return;

    this.triedOnce = true;
    if (this.hasError) return;

    this.isProcessing = true;
    this.ajax.updateConfig(this.model)
      .then(
        (json) => {
          if (json.success) {
            this.errorMessage = null;

            this.router.navigateToRoute('config');
            this.app.showInfo("Success!", json.content.message);
          } else {
            this.app.showError("Error!", json.content.message);
          }
        },
        err => {
          this.errorMessage = 'Invalid options chosen';
          this.app.showError("Error!", this.errorMessage);
        }
      )
      .finally(() => this.isProcessing = false);
  }

  @computedFrom(
    'triedOnce',
    'model.input_directory',
    'model.template_directory'
  )
  get errors() {
    if (!this.triedOnce) return {};
    return this.validator(this.model) || {};
  }

  @computedFrom('errors')
  get hasError() {
    return !_.isEmpty(this.errors);
  }

}