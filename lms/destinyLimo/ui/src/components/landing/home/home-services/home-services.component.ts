import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

import {Store} from '@ngrx/store';

import { Content } from '../../../../store/models/Content';
import { selectContents } from '../../../../store/selectors/content.selector';

@Component({
  selector: 'app-home-services',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home-services.component.html',
  styleUrl: './home-services.component.css'
})
export class HomeServicesComponent {
  constructor(private store: Store) { }

  services: Content[] = [];
  
  ngOnInit() {
    console.log('Home services component initialized');

    this.store.select(selectContents).subscribe((contents) => {
      this.services = contents.filter((content) => content.content_type_id === 2);

      if (this.services.length === 0) {
        this.services = [];
        return;
      }

      if (this.services.length > 3) {
        this.services = this.services.slice(0, 3);
      }


      console.log('services ', this.services);
      console.log('service 0 title ', this.services[0].title);
    });
  }
}
