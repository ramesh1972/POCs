import { Component } from '@angular/core';
import { RouterLink, RouterOutlet } from '@angular/router';
import { NgScrollbar } from 'ngx-scrollbar';

import { IconDirective } from '@coreui/icons-angular';
import {
  ContainerComponent,
  ShadowOnScrollDirective,
  SidebarBrandComponent,
  SidebarComponent,
  SidebarFooterComponent,
  SidebarHeaderComponent,
  SidebarNavComponent,
  SidebarToggleDirective,
  SidebarTogglerDirective
} from '@coreui/angular';
import { HeaderNavComponent, NavItemComponent, NavLinkDirective } from '@coreui/angular';

import { RouterLinkActive } from '@angular/router';

import {AdminDefaultFooterComponent, AdminDefaultHeaderComponent } from '.';
import { navItems } from './_nav';

function isOverflown(element: HTMLElement) {
  return (
    element.scrollHeight > element.clientHeight ||
    element.scrollWidth > element.clientWidth
  );
}

@Component({
  selector: 'app-admin-dashboard',
  templateUrl: './default-layout.component.html',
  styleUrls: ['./default-layout.component.scss', './default-layout.component.css'],
  standalone: true,
  imports: [
    SidebarComponent,
    SidebarHeaderComponent,
    SidebarBrandComponent,
    RouterLink,
    IconDirective,
    NgScrollbar,
    SidebarNavComponent,
    SidebarFooterComponent,
    SidebarToggleDirective,
    SidebarTogglerDirective,
    AdminDefaultHeaderComponent,
    ShadowOnScrollDirective,
    ContainerComponent,
    RouterOutlet,
    AdminDefaultFooterComponent,
    HeaderNavComponent, NavItemComponent, NavLinkDirective, RouterLink, RouterLinkActive,
  ]
})
export class AdminDefaultLayoutComponent {
  public navItems = navItems;

  onScrollbarUpdate($event: any) {
    // if ($event.verticalUsed) {
    // console.log('verticalUsed', $event.verticalUsed);
    // }
  }
}
