import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { RouterLinkActive } from '@angular/router';
import { ChangeDetectorRef } from '@angular/core';

import { Store } from '@ngrx/store';

import { IconSetService } from '@coreui/icons-angular';
import { iconSubset } from '../components/console/icons/icon-subset';

import { LandingComponent } from '@src/components/landing/landing.component';
import { ConsoleComponent } from '../components/console/console.component';
import { AdminDefaultLayoutComponent } from '../components/console/admin-console-app/layout';
import { LearnerDefaultLayoutComponent } from '../components/console/learner-console-app/layout';

import { invokeContentFetchAPI } from '../store/actions/content.action';
import { invokeMaterialCategoryFetchAPI } from '../store/actions/material.action';
import { VisibilityService } from '@src/components/common/VisibilityService';
import { AuthenticateUser_Success, invokeAuthenticateUser } from '@src/store/actions/user.action';
import { Actions, ofType } from '@ngrx/effects';
import { selectMaterialCategorys } from '@src/store/selectors/material.selector';
import { take } from 'rxjs';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, CommonModule, RouterLink, RouterLinkActive, LandingComponent, ConsoleComponent, AdminDefaultLayoutComponent, LearnerDefaultLayoutComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent {

  constructor(private store: Store, private iconSetService: IconSetService,
    private visibilityService: VisibilityService, private cdr: ChangeDetectorRef, private actions$: Actions) {
    // iconSet singleton
    this.iconSetService.icons = { ...iconSubset };
  }

  title = 'Destiny Limo LMS';
  isHomeVisible: boolean = false;
  isConsoleVisible: boolean = true;

  ngOnInit() {
    console.log('App component initialized');

    this.store.dispatch(invokeContentFetchAPI());
    this.store.dispatch(invokeMaterialCategoryFetchAPI());

    

    this.visibilityService.homeVisible$.subscribe((visible: any) => {
      this.isHomeVisible = visible;
      this.isConsoleVisible = !visible;
      this.cdr.detectChanges();
    });

    this.visibilityService.consoleVisible$.subscribe((visible: any) => {
      this.isConsoleVisible = visible;
      this.isHomeVisible = !visible;
      this.cdr.detectChanges();
    });

    // dummy login : TODO remove
    //this.dummyLogin();
  }

  dummyLogin() {
    this.store.dispatch(invokeAuthenticateUser({ userName: 'driver1', password: 'Driver1' }));
    //this.store.dispatch(invokeAuthenticateUser({ userName: 'admin', password: 'Admin1' }));

    this.actions$.pipe(
      ofType(AuthenticateUser_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("auth success", data);
    });
  }
}
