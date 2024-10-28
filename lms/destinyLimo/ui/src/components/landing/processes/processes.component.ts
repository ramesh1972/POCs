import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { Content } from '@src/store/models/Content';
import { selectContents } from '@src/store/selectors/content.selector';

@Component({
  selector: 'app-processes',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './processes.component.html',
  styleUrl: './processes.component.scss'
})
export class ProcessesComponent {
  constructor(private store: Store) { }

  processes: Content[] = [];
  
  ngOnInit() {
    console.log('proceses component initialized');

    this.store.select(selectContents).subscribe((content) => {
      this.processes = content.filter((c) => c.content_type_id === 3);

      console.log('proceses ', this.processes);
    });
  }
}
