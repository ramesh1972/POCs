import { Component, Input, Output, ContentChild, TemplateRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  FormsModule
} from '@angular/forms';
import {
  AccordionButtonDirective,
  AccordionComponent,
  AccordionItemComponent,
  TemplateIdDirective,
  FormCheckComponent
} from '@coreui/angular';
import { Content } from '@src/store/models/Content';

import { ButtonDirective, FormModule } from '@coreui/angular';

@Component({
  selector: 'app-accordian-parent',
  standalone: true,
  imports: [CommonModule, FormsModule, FormModule, FormCheckComponent,
    AccordionComponent,
    AccordionItemComponent,
    TemplateIdDirective,
    AccordionButtonDirective,
    ButtonDirective],
  templateUrl: './accordian-parent.component.html',
  styleUrl: './accordian-parent.component.scss'
})
export class AccordianParentComponent {

  editButtonEnabled = true;
  saveButtonEnabled = false;
  cancelButtonEnabled = false;
  deleteButtonEnabled = false;
  addButtonEnabled = true;

  @ContentChild(TemplateRef, { static: false }) myAccordianBodyTemplate!: TemplateRef<{ listItem: any; }>;

  @Input() list: any = [];
  @Input() addEntityString: string = 'Add Item';
  @Input() title: string = 'View & Manage Items';
  @Input() onSlotAdd = () => { };
  @Input() onSlotEdit = (i: number) => { };
  @Input() onSlotDelete = (i: number) => { };
  @Input() onSlotSave = (i: number) => { };
  @Input() onSlotCancel = (i: number) => { };

  @Input() publicFlag: boolean = false;
  @Input() activeFlag: boolean = false;
  @Input() softDeleteFlag: boolean = false;

  ngOnInit() {
    console.log('accordian parent init');
  }

  onAdd() {
    console.log('onAdd');
    this.addButtonEnabled = false;
    this.editButtonEnabled = false;
    this.saveButtonEnabled = true;
    this.cancelButtonEnabled = true;
    this.deleteButtonEnabled = false;

    this.onSlotAdd();
   }

  onEdit(i: number) {
    console.log('edit', i);
    this.saveButtonEnabled = true;
    this.cancelButtonEnabled = true;
    this.editButtonEnabled = false;
    this.deleteButtonEnabled = true;
    this.addButtonEnabled = false;

    this.onSlotEdit(i);
  }

  onDelete(i: number) {
    this.saveButtonEnabled = false;
    this.cancelButtonEnabled = false;
    this.editButtonEnabled = true;
    this.deleteButtonEnabled = false;
    this.addButtonEnabled = true;

    this.onSlotDelete(i);
    
    console.log('deleted', i);
  }

  onSave(i: number) {
    console.log('save', i);

    this.onSlotSave(i);

    this.saveButtonEnabled = false;
    this.cancelButtonEnabled = false;
    this.editButtonEnabled = true;
    this.deleteButtonEnabled = false;
    this.addButtonEnabled = true;
  }

  onCancel(i: number) {
    console.log('cancel', i);
    this.saveButtonEnabled = false;
    this.cancelButtonEnabled = false;
    this.editButtonEnabled = true;
    this.deleteButtonEnabled = false;
    this.addButtonEnabled = true;

    this.onSlotCancel(i);

  }
}
