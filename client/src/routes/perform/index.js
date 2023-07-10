import { inject } from 'aurelia-framework';

@inject('AjaxService')
export class Index {

  activeStep = 0;

  steps = [
    {title: "Template"},
    {title: "Input"},
    {title: "Execute"},
  ]

  constructor(ajax) {
    this.ajax = ajax;
  }
}
