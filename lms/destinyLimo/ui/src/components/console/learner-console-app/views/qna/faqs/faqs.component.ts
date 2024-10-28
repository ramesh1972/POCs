import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

import * as VTable from '@visactor/vtable';

import { ButtonDirective, FormModule, ButtonGroupComponent, FormCheckLabelDirective } from '@coreui/angular';
import { ReactiveFormsModule, UntypedFormBuilder, UntypedFormControl, UntypedFormGroup } from '@angular/forms';

import { DataGridComponentHelper } from '@src/components/common/components/grid-parent/data-grid.helper';
import { invokeUserQuestionCreateAPI, invokeUserQuestionDeleteAPI, invokeUserQuestionsForUserFetchAPI, UserQuestionsForUserFetchAPI_Success } from '@src/store/actions/user-question.action';
import { UserAskedQuestion } from '@src/store/models/UserAskedQuestion';
import { selectQuestion } from '@src/store/selectors/user-question.selector';

@Component({
  selector: 'app-faqs',
  standalone: true,
  imports: [FormsModule, CommonModule, ButtonDirective, FormModule, ButtonGroupComponent, FormCheckLabelDirective, ReactiveFormsModule],
  templateUrl: './faqs.component.html',
  styleUrl: './faqs.component.scss'
})
export class FAQsComponent {
  constructor(private readonly store: Store, private actions$: Actions, private readonly formBuilder: UntypedFormBuilder) {
    // setup the data grid helper
    this.dataGridHelper = new DataGridComponentHelper(this, this.store);
  }

  formRadio1 = new UntypedFormGroup({
    radio1: new UntypedFormControl('All')
  });

  setRadioValue(value: string): void {
    this.formRadio1.setValue({ radio1: value });

    if (value === 'All') {
      this.dataGridHelper?.table?.updateFilterRules([]);
    }
    else if (value === 'Answered') {
      this.dataGridHelper?.table?.updateFilterRules([{ filterFunc: (record: Record<string, any>) => { 
        console.log('record', record);
        return record['answer'] !== null; } }]);
    }
    else if (value === 'Unanswered') {
      this.dataGridHelper?.table?.updateFilterRules([{ filterFunc: (record: Record<string, any>) => { 
        console.log('record not answered', record['answer']);
        return record['answer'] === null; } }]);
    }
  }

  dataGridHelper?: DataGridComponentHelper;

  saveButtonEnabled = true;
  resetButtonEnabled = true;
  addQuestionButtonEnabled = true;
  newQuestion = false;
  newQuestionText = '';
  newQ: UserAskedQuestion | undefined;

  ngOnInit() {
    console.log('faq component initialized');

    // set content table info
    const defaultColumns = [
      { colName: "is_deleted", colValue: false },
    ];

    this.dataGridHelper?.setTableInfo('user_asked_questions', "user_question_id", true, defaultColumns);

    // set columns
    this.dataGridHelper?.setColumns(this.getColDefs());

    // set data
    this.store.dispatch(invokeUserQuestionsForUserFetchAPI({ userId: 2 }));

    // Wait for the action to complete
    this.actions$.pipe(
      ofType(UserQuestionsForUserFetchAPI_Success),
      take(1)
    ).subscribe((questions: any) => {
      console.log("user questions fetch dispatched", questions);

      this.dataGridHelper?.setData(questions.allUserQuestions);

      // ----> draw the table
      this.drawVTable();
    });
  }

  // columns definition
  getColDefs() {
    return [
      {
        title: "Question", field: "question",
        cellType: 'text',
        width: 250,
        sort: true,
        textStick: true,
        style: {
          bgColor: 'rgba(0,20,0, .6)',
          color: 'white',
        }
      },
      {
        title: "Answer", field: "answer",
        cellType: 'text',
        width: 300,

        style: {
          bgColor: (args: any) => {
            return args.value !== 'Not Answered Yet' ? 'white' : 'red';
          }
        },
        fieldFormat: (value: any) => {
          return value.answer ? value.answer : 'Not Answered Yet';
        }
      },
      {
        title: "Date Asked", field: "dateAsked",
        cellType: 'text',
        width: 120,
        sort: true,
        style: {
          bgColor: 'rgba(0,20,0, .6)',
          color: 'white',
        },
        fieldFormat: (value: any) => {
          const nullDate = '0001-01-01T00:00:00';
          return value.dateAsked && value.dateAsked !== nullDate ? value.dateAsked : 'Not Recorded';
        }
      },
      {
        title: "Date Answered", field: "dateAnswered",
        cellType: 'text',
        width: 120,
        sort: true,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          bgColor: 'rgba(0,20,0, .6)',
          color: 'white',
        },
        fieldFormat: (value: any) => {
          const nullDate = '0001-01-01T00:00:00';
          return value.dateAnswered && value.dateAnswered !== nullDate ? value.dateAnswered : 'Not Answered';
        }
      }
    ]
  }

  getTableOptions() {

    const container = document.getElementById('tableContainer');

    // add delete column to the end
    const option = {
      container: container!,
      columns: this.dataGridHelper?.columns,


      widthMode: 'autoWidth',
      heightMode: 'autoHeight',
      autoFillHeight: false,
      autoFillWidth: true,
      textOverflow: 'string',

      animationAppear: {
        duration: 100,
        delay: 50,
        type: 'one-by-one', // all
        direction: 'row' // colunm
      },

      defaultHeaderRowHeight: 40,

      theme: VTable.themes.ARCO
    };

    option.theme = VTable.themes.ARCO.extends({
      underlayBackgroundColor: 'transparent',
      scrollStyle: {
        visible: 'always',
        scrollSliderColor: 'purple',
        scrollRailColor: '#bac3cc',
        scrollSliderCornerRadius: 6,
        hoverOn: false,
        barToSide: false,
        width:16,
      },
      defaultStyle: {
        borderLineWidth: .6,
        autoWrapText: true,
        color: 'black',
        textBaseline: "top",
        borderColor: 'white'
      },
      headerStyle: {
        lineHeight: 40,
        textBaseline: "middle",
        fontSize: 16,
        color: 'white',
        bgColor: 'rgba(0,0,0, .9)',
        autoWrapText: false,
        fontWeight: 400,
        hover: { cellBgColor: 'lightgrey' }
      },

      bodyStyle: {
        borderColor: 'white',
        hover: {
          cellBgColor: 'lightgrey',
        }
      },
      checkboxStyle: { defaultFill: 'grey' },
      frameStyle: { cornerRadius: 0, borderColor: 'rgba(255, 255, 255, 1)', borderLineWidth: 7.456, shadowColor: 'rgba(0,0,0, 1)', shadowBlur: 4, shadowOffsetX: 0, shadowOffsetY: 0 },
    });

    return option;
  }

  // styling and drawing the table
  drawVTable() {

    // draw it up!
    const option = this.getTableOptions();

    // create table
    this.dataGridHelper?.createTable(option);
  }

  // button events
  onAdd() {
    console.log('onAdd');
    this.newQuestion = true;

  }

  onSave() {
    console.log('newQuestion', this.newQuestionText);
    if (!this.newQuestion)
      return;

    this.newQuestion = false;

    const question: UserAskedQuestion = {
      askedBy: 2,
      question: this.newQuestionText,
      dateAsked: new Date(),
      is_deleted: false,
      is_public: false,
      is_active: true
    };

    this.store.dispatch(invokeUserQuestionCreateAPI({ question: question }));
    this.dataGridHelper?.table?.updateRecords([question], [this.dataGridHelper?.data.length - 1]);
    this.newQuestionText = '';
  }

  onReset() {
    console.log('onReset');
    this.newQuestion = false;
    this.newQuestionText = '';
  }

  onDeleteRecord(questionId: number) {
    console.log('onDeleteRecord', questionId);

    this.store.dispatch(invokeUserQuestionDeleteAPI({ questionId: questionId }));
  }
}
