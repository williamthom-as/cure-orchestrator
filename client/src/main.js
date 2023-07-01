import { AppService } from "./services/app-service";
import { AjaxService } from "./services/ajax-service";

export function configure(aurelia) {
  aurelia.use.standardConfiguration();
  aurelia.use.feature('resources');
  if (process.env.NODE_ENV === 'production') {
    aurelia.use.developmentLogging('warn');
  } else {
    aurelia.use.developmentLogging('info');
    aurelia.use.plugin('aurelia-testing');
  }

  aurelia.use.plugin('aurelia-dialog-lite', {
    host: document.body,
    overlayClassName: 'dialog-lite-overlay',
    escDismiss: true,
    overlayDismiss: false
  });

  // Service registry
  aurelia.use.singleton('AppService', AppService);
  aurelia.use.singleton('AjaxService', AjaxService);

  aurelia.start().then(() => aurelia.setRoot());
}
