import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Store } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';

// CoreUI Modules
import { ButtonModule, DropdownModule } from '@coreui/angular';
import { CardModule } from '@coreui/angular';
import { FormModule, FormCheckComponent } from '@coreui/angular';
import { ButtonDirective } from '@coreui/angular';
import { FormCheckLabelDirective } from '@coreui/angular';
import { ButtonGroupComponent } from '@coreui/angular';
import { ReactiveFormsModule, UntypedFormBuilder, UntypedFormControl, UntypedFormGroup } from '@angular/forms';

@Component({
  selector: 'app-user-exam-answers',
  standalone: true,
  imports: [CommonModule, FormModule, FormCheckComponent, ButtonDirective, FormCheckLabelDirective,
    ButtonGroupComponent, ReactiveFormsModule,
    FormsModule,
    ButtonModule,
    CardModule,
    FormModule,
    DropdownModule],
  templateUrl: './user-exam-answers.component.html',
  styleUrl: './user-exam-answers.component.css'
})
export class UserExamAnswersComponent {
  constructor() {
  }

  formRadio1 = new UntypedFormGroup({
    radio1: new UntypedFormControl('All')
  });

  setRadioValue(value: string): void {
    this.formRadio1.setValue({ radio1: value });
    this.filteredUserAnswers = this.userAnswers;

    if (value === 'Correct') {
      this.filteredUserAnswers = this.userAnswers.filter((ua: any) => ua.is_correct === true);
    }
    else if (value === 'Incorrect') {
      this.filteredUserAnswers = this.userAnswers.filter((ua: any) => ua.is_correct === false);
    }
  }

  @Input() exam: any = {};
  @Input() categories: any[] = [];
  @Input() mcqs: any[] = [];
  @Input() userAnswers: any[] = [];
  filteredUserAnswers: any[] = [];

  ngOnInit() {
    console.log('user exam answers component initialized', this.exam, this.categories, this.mcqs, this.userAnswers);
    this.formRadio1.setValue({ radio1: 'All' });
    this.filteredUserAnswers = this.userAnswers;

  }
}
