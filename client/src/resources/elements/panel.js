import {bindable} from 'aurelia-framework'

export class Panel {
  @bindable expanded = true;
  @bindable maxHeight = null;

  panelCss() {
    if (this.maxHeight) {
      return `max-height: ${this.maxHeight}rem;`;
    }
  }
}