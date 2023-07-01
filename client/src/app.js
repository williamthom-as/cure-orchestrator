import {inject} from 'aurelia-framework';

@inject('AppService')
export class App {
  scheme = 'auto';

  constructor(appService) {
    this.appService = appService;
  }

  configureRouter(config, router) {
    this.router = router;
    config.title = "Cure Orchestrator";
    config.options.pushState = true;
    config.options.root = '/';

    config.mapUnknownRoutes('not-found.html');
    config.map([{
      route: ['', 'home'],
      moduleId: './routes/home',
      name: 'home',
      title: 'Home',
      nav: true,
      settings: {
        icon: 'fas fa-home',
        description: 'Get started here'
      }
    },{
      route: 'templates',
      moduleId: './routes/templates/index',
      name: 'templates',
      title: 'Templates',
      nav: true,
      settings: {
        icon: 'fas fa-file-code',
        description: 'Manage templates'
      }
    },{
      route: 'config',
      moduleId: './routes/config/index',
      name: 'config',
      title: 'Configuration',
      nav: true,
      settings: {
        icon: 'fas fa-wrench',
        description: 'Change configuration'
      }
    }]);
  }

  navigateMenu(routeHref) {
    this.opened = null;
    this.router.navigate(routeHref, {});
  }

  changeScheme(scheme) {
    this.scheme = scheme;
    document.firstElementChild.setAttribute('color-scheme', scheme);
  }
}
