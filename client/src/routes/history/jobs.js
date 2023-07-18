import {inject} from 'aurelia-framework';
import {DialogService} from 'aurelia-dialog-lite';

@inject(DialogService, 'AjaxService')
export class Jobs {

  jobs = null;
  isProcessing = false;

  constructor(dialogService, ajax) {
    this.dialogService = dialogService;
    this.ajax = ajax;
  }

  bind() {
    this.getJobs();
  }

  getJobs() {
    this.isProcessing = true;
    this.ajax.getJobs()
      .then(json => {
        this.jobs = json.content.jobs;
        this.isProcessing = false;
      });
  }
}