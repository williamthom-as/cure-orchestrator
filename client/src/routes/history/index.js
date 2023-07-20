import {inject} from 'aurelia-framework';
import {DialogService} from 'aurelia-dialog-lite';
import {Router} from 'aurelia-router';

@inject(Router, DialogService, 'AjaxService')
export class Index {

  jobs = null;
  isProcessing = false;

  constructor(router, dialogService, ajax) {
    this.router = router;
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
        this.jobs = json.content.jobs.reverse();
        this.isProcessing = false;
      });
  }

  reload() {
    this.getJobs();
  }

  add() {
    this.router.navigateToRoute('perform');
  }
}