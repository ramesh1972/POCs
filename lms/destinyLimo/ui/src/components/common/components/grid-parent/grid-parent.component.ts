import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ButtonDirective } from '@coreui/angular';

import { DataGridComponentHelper } from './data-grid.helper';

@Component({
  selector: 'app-grid-parent',
  standalone: true,
  imports: [CommonModule, ButtonDirective],
  templateUrl: './grid-parent.component.html',
  styleUrl: './grid-parent.component.css'
})
export class GridParentComponent {

  @Input() dataGridHelper?: DataGridComponentHelper;
  @Input() title: string = 'Make Bulk Changes & Save';
  @Input() addEntityString: string = 'Add Item';
  @Input() saveButtonEnabled = false;
  @Input() resetButtonEnabled = false;

  // button events
  onAdd() {
    console.log('onAdd');
    this.dataGridHelper?.onAppendEmptyRecord();
  }

  onSave() {
    this.dataGridHelper?.onSaveRecords();
  }

  onReset() {
    console.log('onReset');
    this.dataGridHelper?.resetChanges();
  }
}
