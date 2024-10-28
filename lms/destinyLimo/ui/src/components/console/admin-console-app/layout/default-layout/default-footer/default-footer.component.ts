import { Component } from '@angular/core';
import { FooterComponent } from '@coreui/angular';

@Component({
    selector: 'app-admin-default-footer',
    templateUrl: './default-footer.component.html',
    styleUrls: ['./default-footer.component.scss'],
    imports: [FooterComponent],
    standalone: true,
})
export class AdminDefaultFooterComponent extends FooterComponent {
  constructor() {
    super();
  }
}
