import {inject} from 'aurelia-framework';
import {DialogService} from 'aurelia-dialog-lite';
import {ViewTemplateDialog} from './dialog/view-template-dialog';

@inject(DialogService, 'AjaxService')
export class Templates {

  templates = null;
  isProcessing = false;

  constructor(dialogService, ajax) {
    this.dialogService = dialogService;
    this.ajax = ajax;
  }

  bind() {
    this.getTemplates();
  }

  getTemplates() {
    this.isProcessing = true;
    this.ajax.getTemplates()
      .then(json => {
        this.templates = json.content.templates;
        this.isProcessing = false;
      });
  }

  view(template) {
    this.dialogService.open({
      viewModel: ViewTemplateDialog,
      model: {},
    }).then(
      (resp) => {
        console.log(resp);
      },
      (resp) => {
        console.log("cancelled", resp);
      }
    )
  }

}