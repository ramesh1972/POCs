import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { filter, max, take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';
import { CommonModule } from '@angular/common';

import * as VTable from '@visactor/vtable';

import { invokeMaterialMCQFetchAPI, materialMCQFetchAPI_Success } from '@src/store/actions/material.action';
import { selectMaterialCategorys, selectMaterialMCQs } from '@src/store/selectors/material.selector';

import { invokeUserExamsForUserFetchAPI, UserExamsForUserFetchAPI_Success } from '@src/store/actions/exam.action';
import { selectUserExamsById } from '@src/store/selectors/exam.selector';

import { invokeUserExamByIdFetchAPI, UserExamByIdFetchAPI_Success } from '@src/store/actions/exam.action';
import { selectExamAnswers } from '@src/store/selectors/exam.selector';

import { DataGridComponentHelper } from '@src/components/common/components/grid-parent/data-grid.helper';

import { UserExamAnswersComponent } from './exam/user-exam-answers.component';
import { UserExam } from '@src/store/models/Exam';
import { AlignDirective } from '@coreui/angular';
import { cilAlignCenter } from '@coreui/icons';

@Component({
  selector: 'app-user-exams',
  standalone: true,
  imports: [CommonModule, UserExamAnswersComponent],
  templateUrl: './user-exams.component.html',
  styleUrl: './user-exams.component.css'
})
export class UserExamsComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
    // setup the data grid helper
    this.dataGridHelper = new DataGridComponentHelper(this, this.store);
  }

  dataGridHelper?: DataGridComponentHelper;

  saveButtonEnabled = false;
  resetButtonEnabled = false;

  categories: any[] = [];
  mcqs: any[] = [];
  examAnswers: any[] = [];
  currentExam: any = {};

  ngOnInit() {
    console.log('file component initialized');

    this.dataGridHelper?.setTableInfo('user_exams', "exam_id", false);

    // set columns
    this.dataGridHelper?.setColumns(this.getColDefs());

    // fetch data
    // set data
    console.log("material fetch dispatched");
    this.store.select(selectMaterialCategorys).subscribe((data: any) => {
      console.log('cats fetched', data);

      this.categories = [...data];
    });

    this.store.dispatch(invokeMaterialMCQFetchAPI({ isPublic: false }));

    // Wait for the action to complete
    this.actions$.pipe(
      ofType(materialMCQFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("cats ", this.categories);
      console.log('material fetched', data);

      const mcqs = data.allMaterialMCQs.map((mcq: any) => {
        console.log("mat cat", mcq.material_category_id);
        const catName = this.categories.find((cat: any) => cat.id === mcq.material_category_id)?.category_name || 'Undefined';
        console.log('catName', catName);

        return {
          ...mcq,
          title: mcq.question_text || 'MCQ Question',
          category_name: catName,
          editing: false,
          adding: false
        };
      });

      this.mcqs = [...mcqs];
      console.log("mods mcqs", this.mcqs)
    });

    // set data
    this.store.dispatch(invokeUserExamsForUserFetchAPI({ userId: 2 }));
    this.actions$.pipe(
      ofType(UserExamsForUserFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("exams fetch dispatched", data);

      const exams = data.allUserExams.map((exam: UserExam) => {
        return {
          ...exam
        };
      });

      console.log("modified files :", exams)
      this.dataGridHelper!.setData(exams);

      // ----> draw the table
      this.drawVTable();
    });
  }

  // columns definition
  getColDefs() {
    return [
      {
        field: 'examId',
        title: 'View QnAs',
        width: 100,
        columnResizeMode: 'none',
        disableColumnResize: true,
        maxWidth: 100,
        style: {
          textAlign: 'center',
          bgColor: 'rgba(184, 132, 132, 0.1)',
          textBaseline: "middle",
        },
        fieldFormat: ((record: any) => {
          return "";
        }),
        icon: [
          {
            name: 'view',
            type: 'svg',
            positionType: VTable.TYPES.IconPosition.left,
            marginLeft: 26,
            width: 20,
            height: 20,
            svg: '/images/buttons/view.png',
            tooltip: {
              title: 'view answers',
              placement: VTable.TYPES.Placement.right
            }
          },
        ]
      },
      {
        title: "Dates", field: "dateCreated",
        cellType: 'text',
        width: 260,
        maxWidth: 260,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          bgColor: 'white',
          textBaseline: "middle",
          selfAlign: 'center',
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
            flexDirection: 'column',
            flexWrap: 'nowrap',
          });

          const containerLeft: any = new VTable.CustomLayout.Group({
            height: percentCalc(100, -60).percent,
            width: percentCalc(100, -60).percent,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'flex-start',
            background: 'white',
            boundsPadding: [10, 10, 10, 10],
            justifyContent: 'space-between',
            cornerRadius: 6,
          });

          container.add(containerLeft);

          const dateCreated = new VTable.CustomLayout.Text({
            text: "Created On " + new Date(record.dateCreated).toLocaleString(),
            fontSize: 13,
            fontFamily: 'sans-serif',
            fill: 'black',
            lineHeight: 20,
            boundsPadding: [4, 4]

          });

          containerLeft.add(dateCreated);

          const dateStarted = new VTable.CustomLayout.Text({
            text: "Started On " + new Date(record.dateStarted).toLocaleString(),
            fontSize: 13,
            fontFamily: 'sans-serif',
            fill: 'black',
            lineHeight: 20,
            boundsPadding: [4, 4]
          });

          containerLeft.add(dateStarted);

          const dateCompleted = new VTable.CustomLayout.Text({
            text: "Completed On " + new Date(record.dateCompleted).toLocaleString(),
            fontSize: 13,
            fontFamily: 'sans-serif',
            fill: 'black',
            lineHeight: 20,
            boundsPadding: [4, 4]
          });

          containerLeft.add(dateCompleted);

          return {
            rootContainer: container,
            renderDefault: false
          };
        }
      },
      {
        title: "Results", field: "score",
        cellType: 'text',
        width: 280,
        maxWidth: 280,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          bgColor: 'lightblue',
          textBaseline: "middle",
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
            flexWrap: 'nowrap'
          });

          const containerLeft: any = new VTable.CustomLayout.Group({
            height: percentCalc(100, -60).percent,
            width: percentCalc(100, -60).percent,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'flex-start',
            background: 'lightblue',
            boundsPadding: [10, 10, 10, 10],
            justifyContent: 'space-between',
            cornerRadius: 6,
          });

          container.add(containerLeft);

          containerLeft.add(new VTable.CustomLayout.Text({
            text: "Correct Answers: " + record.num_correct + "/" + record.num_questions,
            fontSize: 13,
            fontFamily: 'sans-serif',
            fill: 'black',
            background: 'lightgreen',
            lineHeight: 20,
            backgroundCornerRadius: 4,
            boundsPadding: [2, 4],
            shadowColor: 'rgba(0,0,0,.6)',
            shadowBlur: 1.5,
            shadowOffsetX: .7,
            shadowOffsetY: .7
          }));

          containerLeft.add(new VTable.CustomLayout.Text({
            text: "Wrong Answers: " + (record.num_questions - record.num_correct) + "/" + record.num_questions,
            fontSize: 13,
            fontFamily: 'sans-serif',
            fill: 'black',
            background: 'red',
            lineHeight: 20,
            backgroundCornerRadius: 4,
            boundsPadding: [2, 4],
            shadowColor: 'rgba(0,0,0,.6)',
            shadowBlur: 1.5,
            shadowOffsetX: .7,
            shadowOffsetY: .7

          }));

          containerLeft.add(new VTable.CustomLayout.Text({
            text: "Attempted: " + record.num_attempted + "/" + record.num_questions,
            fontSize: 13,
            fontFamily: 'sans-serif',
            fill: 'black',
            background: 'yellow',
            lineHeight: 20,
            backgroundCornerRadius: 4,
            boundsPadding: [2, 4],
            shadowColor: 'rgba(0,0,0,.6)',
            shadowBlur: 1.5,
            shadowOffsetX: .7,
            shadowOffsetY: .7

          }));

          const containerRight: any = new VTable.CustomLayout.Group({
            height: percentCalc(100, -60).percent,
            width: percentCalc(100, -60).percent,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'flex-start',
            background: 'lightgoldenrodyellow',
            boundsPadding: [10, 10, 10, 10],
            justifyContent: 'space-around',
            cornerRadius: 6,
            shadowColor: 'rgba(0,0,0,.6)',
            shadowBlur: 1.5,
            shadowOffsetX: .7,
            shadowOffsetY: .7
          });

          var percentage = record.num_questions !== 0 ? (record.num_correct / record.num_questions * 100) : 0;
          percentage = Math.round(percentage);

          containerRight.add(new VTable.CustomLayout.Text({
            text: "Score " + percentage + "%",
            fontSize: 13,
            fontFamily: 'sans-serif',
            fill: 'black',
            background: 'transparent',
            lineHeight: 20,
            backgroundCornerRadius: 4,
            alignSelf: 'center',
          }));

          containerRight.add(new VTable.CustomLayout.Text({
            text: percentage >= 50 ? "Pass" : "Fail",
            fontSize: 16,
            fontFamily: 'sans-serif',
            fill: 'white',
            background: percentage >= 50 ? 'lightgreen' : 'red',
            lineHeight: 32,
            backgroundCornerRadius: 4,
            boundsPadding: [2, 20, 2, 20],
            alignSelf: 'center',
          }));

          container.add(containerRight);

          return {
            rootContainer: container,
            renderDefault: false
          };
        }
      },
      {
        title: "Certificate", field: "certificateUrl",
        cellType: 'link',
        width: 200,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          bgColor: 'lightgoldenrodyellow',
          textBaseline: "middle",
        }
      }
    ];
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

      animationAppear: {
        duration: 100,
        delay: 50,
        type: 'one-by-one', // all
        direction: 'row' // colunm
      },

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
        width: 16,
      },
      defaultStyle: {
        autoWrapText: true,
        color: 'black',
        textBaseline: "top",
      },
      headerStyle: {
        bgColor: '#a881e1',
        borderColor: '#a881e1',
        borderLineWidth: .3,
        color: 'white',
        lineHeight: 40,
        textBaseline: "middle",
        autoWrapText: false
      },
      checkboxStyle: { defaultFill: 'grey' },
      frameStyle: { cornerRadius: 6, borderColor: '#a881e1', borderLineWidth: .4, shadowColor: 'rgba(0,0,0,.6)', shadowBlur: 2.5, shadowOffsetX: 1.5, shadowOffsetY: 1.5 },
    });

    return option;
  }

  // styling and drawing the table
  drawVTable() {

    const option = this.getTableOptions();

    // create table
    this.dataGridHelper?.createTable(option);

    this.dataGridHelper?.table?.on('click_cell', (args: any) => {
      console.log('cell clicked', args);

      if (args.col === 0) {
        this.showUserExamAnswers(args.dataValue);
      }
    });
  }

  // user exam answers
  showUserExamAnswers(examId: number) {
    console.log("examId", examId);

    this.examAnswers = [];

    this.currentExam = this.dataGridHelper?.data.find((exam: any) => exam.examId === examId);
    this.currentExam.dateStartedString = new Date(this.currentExam.dateStarted).toLocaleString();
    console.log("currentExam", this.currentExam);

    this.store.dispatch(invokeUserExamByIdFetchAPI({ examId: examId }));

    this.actions$.pipe(
      ofType(UserExamByIdFetchAPI_Success),
      take(1)
    ).subscribe((answers: any) => {
      console.log("exam answers fetched");

      const exAnswers = answers.examAnswers.map((exam: any) => {
        console.log("exam", exam);
        return {
          ...exam,
          question_text: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.question_text || 'Undefined',
          answer_1: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.answer_1 || 'Undefined',
          answer_2: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.answer_2 || 'Undefined',
          answer_3: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.answer_3 || 'Undefined',
          answer_4: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.answer_4 || 'Undefined',
          correct_1: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.correct_1 || false,
          correct_2: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.correct_2 || false,
          correct_3: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.correct_3 || false,
          correct_4: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.correct_4 || false,

          category_name: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.category_name || 'Undefined',
          title: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.title || 'Undefined',
          description: this.mcqs.find((mcq: any) => mcq.question_id === exam.mcq_id)?.description || 'Undefined',
        };
      });

      const anss = exAnswers.map((exam: any) => {
        return {
          ...exam,
          is_correctly_answered: exam.choice_1_answer === exam.correct_1 && exam.choice_2_answer === exam.correct_2 && exam.choice_3_answer === exam.correct_3 && exam.choice_4_answer === exam.correct_4
        };
      });

      this.examAnswers = anss.filter((ans: any) => ans.question_text !== 'Undefined');
      console.log("exam answers modified", this.examAnswers);
    });
  };
}