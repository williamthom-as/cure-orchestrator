import {inject, computedFrom} from 'aurelia-framework';
import {DialogController} from 'aurelia-dialog-lite';

@inject(DialogController)
export class ViewTemplateDialog {

  constructor(controller) {
    this.controller = controller;
  }

  activate(model) {
    this.model = model;
  }

}