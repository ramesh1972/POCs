import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { Store } from '@ngrx/store';
import { VisibilityService } from '@src/components/common/VisibilityService';
import { logoutUser } from '@src/store/actions/user.action';

import { UserProfile } from '@src/store/models/UserProfile';
import { selectLoggedInUser } from '@src/store/selectors/user.selector';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [CommonModule, RouterOutlet, RouterLink, RouterLinkActive],
  templateUrl: './header.component.html',
  styleUrl: './header.component.css',
})
export class HeaderComponent {

  constructor(private store: Store, private visibilityService: VisibilityService) { }

  loggedInUser?: UserProfile;

  ngOnInit() {
    this.store.select(selectLoggedInUser).subscribe((user: any) => {
      console.log('header User:', user);
      this.loggedInUser = user;
    });
  }

  onLogout() {
    this.store.dispatch(logoutUser());
    this.loggedInUser = undefined;
  }
}
