import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Store } from '@ngrx/store';
import { Content } from '@src/store/models/Content';
import { selectContents } from '@src/store/selectors/content.selector';

@Component({
  selector: 'app-services',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './services.component.html',
  styleUrl: './services.component.scss'
})
export class ServicesComponent {
  constructor(private store: Store) { }

  services: Content[] = [];
  
  ngOnInit() {
    console.log('services component initialized');

    this.store.select(selectContents).subscribe((content) => {
      this.services = content.filter((c) => c.content_type_id === 2);

      console.log('services ', this.services);
    });
  }
}
