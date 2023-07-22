import {inject} from 'aurelia-framework';
import {DialogService} from 'aurelia-dialog-lite';
import {Router} from 'aurelia-router';

@inject(Router, DialogService, 'AjaxService')
export class Show {

  job = null;
  isProcessing = false;

  constructor(router, dialogService, ajax) {
    this.router = router;
    this.dialogService = dialogService;
    this.ajax = ajax;
  }

  activate(params) {
    this.id = params.id;
    this.getJob();
  }

  getJob() {
    this.isProcessing = true;
    this.ajax.getJob(this.id)
      .then(json => {
        this.job = json.content.job;
        console.log(this.job);
        this.isProcessing = false;
      });
  }

  reload() {
    this.getJob();
  }

}