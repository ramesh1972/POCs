import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { max, take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

import * as VTable from '@visactor/vtable';
import { InputEditor, ListEditor, TextAreaEditor } from '@visactor/vtable-editors';

import { ButtonDirective, FormModule, ButtonGroupComponent, FormCheckLabelDirective } from '@coreui/angular';
import { ReactiveFormsModule, UntypedFormBuilder, UntypedFormControl, UntypedFormGroup } from '@angular/forms';

import { DataGridComponentHelper } from '@src/components/common/components/grid-parent/data-grid.helper';
import { invokeUserProfilesFetchAPI, UserProfilesFetchAPI_Success } from '@src/store/actions/user-profile.action';
import { invokeUserQuestionsFetchAPI, UserQuestionsFetchAPI_Success } from '@src/store/actions/user-question.action';
import { UserAskedQuestion } from '@src/store/models/UserAskedQuestion';
import { GridParentComponent } from '../../../../../common/components/grid-parent/grid-parent.component';
import { UserProfile } from '@src/store/models/UserProfile';
import { FilePaths } from '@src/components/common/file-paths';

@Component({
  selector: 'app-faqs',
  standalone: true,
  imports: [FormsModule, CommonModule, ButtonDirective, FormModule, ButtonGroupComponent, FormCheckLabelDirective, ReactiveFormsModule, GridParentComponent],
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
      this.dataGridHelper?.table?.updateFilterRules([{
        filterFunc: (record: Record<string, any>) => {
          return record['admin_answer'] !== null;
        }
      }]);
    }
    else if (value === 'Unanswered') {
      this.dataGridHelper?.table?.updateFilterRules([{
        filterFunc: (record: Record<string, any>) => {
          return record['admin_answer'] === null;
        }
      }]);
    }
  }

  dataGridHelper?: DataGridComponentHelper;

  users: UserProfile[] = [];
  saveButtonEnabled = false;
  resetButtonEnabled = false;

  ngOnInit() {
    console.log('faq component initialized');

    // set content table info
    const defaultColumns = [
      { colName: "is_public", defaultValue: "false" },
      { colName: "is_active", defaultValue: "true" },
      { colName: "is_deleted", defaultValue: "false" }
    ];

    this.dataGridHelper?.setTableInfo('user_asked_questions', "user_question_id", true, defaultColumns);

    // set columns
    this.dataGridHelper?.setColumns(this.getColDefs());

    // users
    // users
    this.store.dispatch(invokeUserProfilesFetchAPI());

    var users: UserProfile[] = [];
    this.actions$.pipe(
      ofType(UserProfilesFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("users fetch dispatched", data);

      this.users = [...data.allUserProfiles];
      console.log("users2", this.users);
    });

    // set data
    this.store.dispatch(invokeUserQuestionsFetchAPI({ includeOnlyAnswered: false }));

    // Wait for the action to complete
    this.actions$.pipe(
      ofType(UserQuestionsFetchAPI_Success),
      take(1)
    ).subscribe((questions: any) => {
      console.log("user questions fetch dispatched", questions);

      // set the data
      const questions2 = questions.allQuestions.map((q: any) => {
        var user = this.users.find((user: any) => user.userId === q.askedBy);
        console.log("user found", user);

        return {
          id: q.id,
          user_question_id: q.id,
          asked_question: q.question,
          admin_answer: q.answer,
          date_asked: q.dateAsked,
          date_answered: q.dateAnswered,
          user_id: q.askedBy,
          userFullName: user ? user.firstName + " " + user.lastName : "Not Found",
          avatar: user ? FilePaths.GetAvatarPath(user.avatar!) : "",
          is_active: q.is_active,
          is_deleted: q.is_deleted,
          is_public: q.is_public
        }
      });

      this.dataGridHelper?.setData(questions2);

      // ----> draw the table
      this.drawVTable();
    });
  }

  // columns definition
  getColDefs() {
    return [
      {
        title: "Asked By", field: "user_id",
        cellType: 'text',
        width: 200,
        maxWidth: 200,
        sort: true,
        textStick: true,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          bgColor: 'rgba(0,20,0, .1)',
          color: 'white',
        },
        customLayout: (args: any) => {
          const { table, row, col, rect } = args;
          const record = table.getCellOriginRecord(col, row);
          const { height, width } = rect ?? table.getCellRect(col, row);
          const percentCalc = VTable.CustomLayout.percentCalc;

          const container = new VTable.CustomLayout.Group({
            height,
            width,
            display: 'flex',
            flexDirection: 'row',
            flexWrap: 'nowrap',
            alignItems: 'center',
            boundsPadding: [10, 10, 10, 10],
          });

          const containerLeft: any = new VTable.CustomLayout.Group({
            width: 200,

            display: 'flex',
            flexDirection: 'row',
            background: 'transparent',
            boundsPadding: [10, 10],
            cornerRadius: 6,
            alignItems: 'center',
          });

          container.add(containerLeft);

          const avatar = new VTable.CustomLayout.Image({
            src: record.avatar,
            width: 40,
            height: 40,
            boundsPadding: [4, 4],
            cornerRadius: 20,
          });

          containerLeft.add(avatar);

          const userName = new VTable.CustomLayout.Text({
            text: record.userFullName,
            fontSize: 13,
            fontFamily: 'sans-serif',
            fill: 'black',
            lineHeight: 20,
            boundsPadding: [4, 10],
            marginTop: 8
          });

          containerLeft.add(userName);

          return {
            rootContainer: container,
            renderDefault: false
          };
        }
      },
      {
        title: "Question", field: "asked_question",
        cellType: 'text',
        editor: 'name-editor',
        width: 150,
        sort: true,
        textStick: true,
        style: {
          bgColor: 'rgba(0,20,0, .6)',
          color: 'white',
        }
      },
      {
        title: "Answer", field: "admin_answer",
        cellType: 'text',
        width: 200,
        editor: 'textArea-editor',
        style: {
          bgColor: (args: any) => {
            return args.value !== 'Not Answered Yet' ? 'white' : 'red';
          }
        },
        fieldFormat: (value: any) => {
          return value.admin_answer ? value.admin_answer : 'Not Answered Yet';
        }
      },
      {
        title: "Date Asked", field: "date_asked",
        cellType: 'text',
        width: 130,
        sort: true,
        style: {
          bgColor: 'rgba(0,20,0, .6)',
          color: 'white',
        },
        fieldFormat: (value: any) => {
          const nullDate = '0001-01-01T00:00:00';
          return value.date_asked && value.date_asked !== nullDate ? new Date(value.date_asked).toLocaleString() : 'Not Recorded';
        }
      },
      {
        title: "Date Answered", field: "date_answered",
        cellType: 'text',
        width: 130,
        sort: true,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          bgColor: 'rgba(0,20,0, .6)',
          color: 'white',
        },
        fieldFormat: (value: any) => {
          const nullDate = '0001-01-01T00:00:00';
          return value.date_answered && value.date_answered !== nullDate ? new Date(value.date_answered).toLocaleString() : 'Not Answered';
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


    this.dataGridHelper?.registerEditors([{ name: 'name-editor', editor: new InputEditor() }, { name: 'textArea-editor', editor: new TextAreaEditor() }]);
    // draw it up!
    const option = this.getTableOptions();

    // create table
    this.dataGridHelper?.createTable(option);
  }
}
