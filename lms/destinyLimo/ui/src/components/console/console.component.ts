import { Component } from '@angular/core';
import { NavigationEnd, Router, } from '@angular/router';
import { CommonModule } from '@angular/common';
import { ChangeDetectorRef } from '@angular/core';

import { Title } from '@angular/platform-browser';

import { Store } from '@ngrx/store';

import { IconSetService } from '@coreui/icons-angular';
import { iconSubset } from './icons/icon-subset';

import { AdminConsoleAppComponent } from './admin-console-app/admin-console-app.component';
import { LearnerConsoleAppComponent } from './learner-console-app/learner-console-app.component';
import { invokeAuthenticateUser } from '@src/store/actions/user.action';
import { selectContentState } from '@src/store/selectors/content.selector';
import { selectLoggedInUser } from '@src/store/selectors/user.selector';
import { UserProfile } from '@src/store/models/UserProfile';
import { VisibilityService } from '../common/VisibilityService';

@Component({
  selector: 'app-console',
  standalone: true,
  imports: [CommonModule, AdminConsoleAppComponent, LearnerConsoleAppComponent],
  templateUrl: './console.component.html',
  styleUrl: './console.component.css'
})
export class ConsoleComponent {
  constructor(private store: Store, private router: Router,
    private titleService: Title,
    private iconSetService: IconSetService,
    private visibilityService: VisibilityService,
    private cdr: ChangeDetectorRef
  ) {
    this.titleService.setTitle("destiny-limo admin console");
    // iconSet singleton
    this.iconSetService.icons = { ...iconSubset };
  }

  isVisible: boolean = true;
  loggedInUser?: UserProfile;
  loggedInUserRole?: number;

  ngOnInit() {
    console.log('console component initialized');

    this.visibilityService.setHeaderVisible(false);
    this.visibilityService.setHomeVisible(false);
    this.visibilityService.setConsoleVisible(true);

     this.store.select(selectLoggedInUser).subscribe((user: any) => {
      console.log('console User:', user);
      this.loggedInUser = user;

      if (user && user.roles && user.roles.length > 0) {
        console.log('console User Role:', user.roles[0].role_id);
        this.loggedInUserRole = user.roles[0].role_id;
      }
    });

    this.visibilityService.consoleVisible$.subscribe((visible: any) => {
      console.log('console visible:', visible);
      this.isVisible = visible;
      this.cdr.detectChanges();
    });

    this.router.events.subscribe((evt) => {
      if (!(evt instanceof NavigationEnd)) {
        return;
      }
    });
  }
}
