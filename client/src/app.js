import {inject} from 'aurelia-framework';
import {DialogService} from 'aurelia-dialog-lite';
import {combo} from 'aurelia-combo';
import {QuickMenuDialog} from "./dialog/quick_menu_dialog";

@inject(DialogService, 'AppService')
export class App {
  scheme = 'auto';
  modalOpen = false;

  constructor(dialogService, appService) {
    this.dialogService = dialogService;
    this.appService = appService;
  }

  bind() {

    const scheme = localStorage.getItem('color_scheme');
    if (scheme) {
      this.changeScheme(scheme);
    }
  }

  configureRouter(config, router) {
    this.router = router;
    config.title = "Cure Orchestrator";
    config.options.pushState = true;
    config.options.root = '/';

    config.mapUnknownRoutes('not-found.html');
    config.map([{
      route: ['', 'home'],
      moduleId: './routes/home/index',
      name: 'home',
      title: 'Home',
      nav: true,
      settings: {
        icon: 'fas fa-home',
        description: 'Get started here'
      }
    },{
      route: 'perform',
      moduleId: './routes/perform/index',
      name: 'perform',
      title: 'Run',
      nav: true,
      settings: {
        icon: 'fas fa-play',
        description: 'Perform transforms'
      }
    },{
      route: 'history',
      moduleId: './routes/history/index',
      name: 'history',
      title: 'Jobs',
      nav: true,
      settings: {
        icon: 'fas fa-history',
        description: 'See jobs history'
      }
    },{
      route: 'history/:id/show',
      moduleId: './routes/history/show',
      name: 'show-job',
      title: 'Job',
      nav: false,
      settings: {
        description: 'Show job'
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

  @combo('ctrl+j', 'command+j')
  quickMenu() {
    if (this.modalOpen === false) {
      this.modalOpen = true
      this.dialogService.open({
        viewModel: QuickMenuDialog,
        model: {},
      }).then(
        (_resp) => {},
        () => {}
      ).finally(
        () => {
          this.modalOpen = false;
        }
      )
    }
  }

  changeScheme(scheme) {
    this.scheme = scheme;
    localStorage.setItem('color_scheme', scheme);

    document.firstElementChild.setAttribute('color-scheme', scheme);
  }
}
