import { Component, OnInit } from '@angular/core';
import { NavigationEnd, Router, RouterOutlet } from '@angular/router';
import { Title } from '@angular/platform-browser';

import { IconSetService } from '@coreui/icons-angular';
import { iconSubset } from '../icons/icon-subset';

import { AdminDefaultLayoutComponent } from './layout';

@Component({
  selector: 'app-admin-console-root',
  template: '<app-admin-dashboard></app-admin-dashboard>',
  standalone: true,
  imports: [RouterOutlet, AdminDefaultLayoutComponent]
})
export class AdminConsoleAppComponent implements OnInit {
  title = 'Destiny Limo LMS - Admin Console';

  constructor(
    private router: Router,
    private titleService: Title,
    private iconSetService: IconSetService
  ) {
    this.titleService.setTitle(this.title);
    
    // iconSet singleton
    this.iconSetService.icons = { ...iconSubset };
  }

  ngOnInit(): void {
    this.router.events.subscribe((evt) => {
      if (!(evt instanceof NavigationEnd)) {
        return;
      }
    });

    this.router.navigate(['/admin/console/dashboard']);
  }
}
