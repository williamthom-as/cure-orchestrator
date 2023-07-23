import {inject, computedFrom} from 'aurelia-framework';
import {watch} from 'aurelia-watch-decorator';

@inject('AjaxService')
export class Index {

  isProcessing = false;
  templates = null;
  validConfig = null;
  jobs = null;

  constructor(ajax) {
    this.ajax = ajax;
  }

  bind() {
    this.getDashboardData();
  }

  getDashboardData() {
    Promise.all([
      this.ajax.getTemplates(),
      this.ajax.getConfigValidation(),
      this.ajax.getJobs()
    ])
      .then((responses) => {
        this.templates = responses[0].content.templates;
        this.validConfig = responses[1].content.result;
        this.jobs = responses[2].content.jobs;

        this.isProcessing = false;
      });
  }

  @computedFrom('jobs')
  get lastRun() {
    if (!this.jobs || this.jobs.length === 0) {
      return 'Never'
    } else {
      return this.jobs[this.jobs.length - 1].created_at;
    }
  }

  @computedFrom('jobs')
  get lastJobsRun() {
    if (!this.jobs || this.jobs.length === 0) {
      return []
    } else {
      return this.jobs.slice(0).slice(-5).reverse();
    }
  }
}
