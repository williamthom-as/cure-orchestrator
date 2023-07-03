import {computedFrom, bindable} from 'aurelia-framework';

export class Viewer {
  @bindable watch = null;
  opened = 'json';

  updateJson() {
    if (this.watch === null) {
      this.json = 'null';
    } else if (this.watch === undefined) {
      this.json = 'undefined'
    } else {
      this.object = this.watch 
      this.json = JSON.stringify(this.watch, null, 2);
    }
  }
  
  bind() {
    this.updateJson();
    
    window.setInterval(() => {
      this.updateJson()
    }, 500);
  }
  
  unbind() {
    this.watch = null;
    clearInterval(this.interval);
  }
}