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

  @ContentChild(TemplateRef, { static: false }) myAccordianBodyTemplate!: TemplateRef<{ listItem: any; }>;

  @Input() list: any = [];
  @Input() title: string = 'View & Manage Items';
  @Input() onSlotComplete = (i: number) => { };

  ngOnInit() {
    console.log('accordian parent init');

  }

  onComplete(i: number) {
    console.log('cancel', i);
    this.list[i].is_completed = true;
    this.onSlotComplete(i);
  }
}
