import { Component } from '@angular/core';
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
import { ButtonGroupComponent } from '@coreui/angular';
import { ReactiveFormsModule, UntypedFormBuilder, UntypedFormControl, UntypedFormGroup } from '@angular/forms';
import { FormCheckLabelDirective } from '@coreui/angular';

import { AccordianParentComponent } from '@src/components/common/components/accordian-parent/accordian-parent.component';
import { selectMaterialCategorys } from '@src/store/selectors/material.selector';
import { UserExamAnswer } from '@src/store/models/UserExamAnswer';
import { createUserExamSuccess, invokeUserExamCreateAPI, invokeSubmitUserExamAPI, invokeUserExamsForUserFetchAPI, UserExamsForUserFetchAPI_Success, invokeUserExamByIdFetchAPI, UserExamByIdFetchAPI_Success, invokeExamByIdFetchAPI, ExamFetchById_Success } from '@src/store/actions/exam.action';
import { UserExamAnswersComponent } from '../exams/exam/user-exam-answers.component';
import { UserExam } from '@src/store/models/Exam';

@Component({
  selector: 'app-exams',
  standalone: true,
  imports: [CommonModule, FormModule, FormCheckComponent, ButtonDirective, ButtonGroupComponent, ReactiveFormsModule,
    FormCheckLabelDirective,
    FormsModule,
    ButtonModule,
    CardModule,
    FormModule,
    DropdownModule,
    AccordianParentComponent,
    UserExamAnswersComponent],
  templateUrl: './exams.component.html',
  styleUrl: './exams.component.css'
})
export class ExamsComponent {
  newExams?: UserExam[] = [];

  constructor(private readonly store: Store, private actions$: Actions) {
  }

  formRadio1 = new UntypedFormGroup({
    radio1: new UntypedFormControl('All')
  });

  setRadioValue(value: string): void {
    this.formRadio1.setValue({ radio1: value });
    console.log('setRadioValue', value);
    console.log('examQuestions', this.examQuestions);

    this.filteredMCQs = this.examQuestions;

    if (value === 'All') {
      this.filteredMCQs = this.examQuestions;
    }
    else if (value === 'Attempted') {
      this.filteredMCQs = this.examQuestions.filter((mcq: any) => mcq.attempted);
    }
    else if (value === 'NotAttempted') {
      this.filteredMCQs = this.examQuestions.filter((mcq: any) => !mcq.attempted);
    }

    console.log('filteredMCQs', this.filteredMCQs);
  }

  categories: any[] = [];
  examQuestions: any[] = [];
  newExam: any = {};
  filteredMCQs: any[] = [];

  attemptedCount = 0;
  unAttemptedCount = 15;
  examStarted = false;
  examCompleted = false;

  ngOnInit() {

    console.log("onint in exams component");
    // set data
    console.log("material fetch dispatched");
    this.store.select(selectMaterialCategorys).subscribe((data: any) => {
      console.log('cats fetched', data);

      this.categories = [...data];
    });

    this.loadUnansweredExams();
  }

  adjustTextareaHeight(event: Event): void {
    console.log('adjustTextareaHeight');
    const textarea = event.target as HTMLTextAreaElement;
    textarea.style.height = 'auto';
    textarea.style.height = `${textarea.scrollHeight}px`;
  }

  loadUnansweredExams() {
    // set data
    this.store.dispatch(invokeUserExamsForUserFetchAPI({ userId: 2 }));
    this.actions$.pipe(
      ofType(UserExamsForUserFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("exams fetch dispatched", data);

      const nullDate = '0001-01-01T00:00:00';
      const newExams2 = data.allUserExams.map((exam: UserExam) => {
        if (exam.dateStarted === null || exam.dateStarted.toString() === nullDate) {
          return {
            ...exam,
            dateCreatedString: new Date(exam.dateCreated).toLocaleString()
          };
        }

        return null; // Add this return statement
      });

      this.newExams = newExams2?.filter((f: any) => f !== null);

      console.log("unanswered exams ", this.newExams);
    });
  }

  onStartAssignedExam(id: number) {
    console.log("examid: ", id);

    this.examCompleted = false;
    this.newExam = {};
    this.examQuestions = [];
    this.filteredMCQs = [];

    this.store.dispatch(invokeExamByIdFetchAPI({ examId: id }));

    this.actions$.pipe(
      ofType(ExamFetchById_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("exam fetch dispatched ", data);

      this.setupQuestions(data.newExam.examQuestions);
      this.newExam = data.newExam;
    });
  }

  onStart() {
    this.examCompleted = false;
    this.newExam = {};
    this.examQuestions = [];
    this.filteredMCQs = [];

    this.store.dispatch(invokeUserExamCreateAPI({ userId: 2 }));

    this.actions$.pipe(
      ofType(createUserExamSuccess),
      take(1)
    ).subscribe((data: any) => {
      console.log("exam fetch dispatched ", data);

      this.setupQuestions(data.newExam.examQuestions);
      this.newExam = data.newExam;
    });
  }

  setupQuestions(questions: any[]) {
    const mcqs = questions.map((mcq: any) => {
      console.log("mat cat", mcq.material_category_id);
      const catName = this.categories.find((cat: any) => cat.id === mcq.material_category_id)?.category_name || 'Undefined';
      console.log('catName', catName);

      return {
        ...mcq,
        question_text: mcq.question_text || 'Undefined',
        answer_1: mcq.answer_1 || 'Undefined',
        answer_2: mcq.answer_2 || 'Undefined',
        answer_3: mcq.answer_3 || 'Undefined',
        answer_4: mcq.answer_4 || 'Undefined',
        correct_1: mcq.correct_1 || false,
        correct_2: mcq.correct_2 || false,
        correct_3: mcq.correct_3 || false,
        correct_4: mcq.correct_4 || false,
        category_name: catName || 'Undefined',
        title: mcq.title || 'Undefined',
        description: mcq.description || 'Undefined',
        correct_1_answer: false,
        correct_2_answer: false,
        correct_3_answer: false,
        correct_4_answer: false,
        attempted: false,
        is_correct: false,
      };
    });


    this.examQuestions = mcqs;

    this.filteredMCQs = this.examQuestions;
    this.attemptedCount = 0;
    this.unAttemptedCount = this.filteredMCQs.length;

    this.examStarted = true;
    console.log('exam questions', this.examQuestions);
  }

  onAttempted(event: any, id: number, choice: string) {
    console.log('onAttempted', event, id, choice);
    var question = this.examQuestions.find((mcq: any) => mcq.question_id === id);

    if (choice === 'choice1')
      question.correct_1_answer = event;
    if (choice === 'choice2')
      question.correct_2_answer = event;
    if (choice === 'choice3')
      question.correct_3_answer = event;
    if (choice === 'choice4')
      question.correct_4_answer = event;

    if (question.correct_1_answer || question.correct_2_answer || question.correct_3_answer || question.correct_4_answer)
      question.attempted = true;
    else
      question.attempted = false;

    if (question.correct_1_answer === question.correct_1 && question.correct_2_answer === question.correct_2 && question.correct_3_answer === question.correct_3 && question.correct_4_answer === question.correct_4) {
      question.is_correct = true;
    }

    this.attemptedCount = this.examQuestions.filter((mcq: any) => mcq.attempted).length;
    this.unAttemptedCount = this.examQuestions.length - this.attemptedCount;
  }

  onComplete() {
    console.log('onComplete', this.examQuestions);

    var examAnswers: UserExamAnswer[] = this.examQuestions.map((mcq: any) => {
      return {
        exam_id: this.newExam.examId,
        mcq_id: mcq.question_id,
        choice_1_answer: mcq.correct_1_answer,
        choice_2_answer: mcq.correct_2_answer,
        choice_3_answer: mcq.correct_3_answer,
        choice_4_answer: mcq.correct_4_answer,
        attempted: mcq.attempted,
        is_correct: mcq.is_correct,
      };
    });

    console.log('examAnswers', examAnswers);

    const newExam = { ...this.newExam };
    newExam.userExamAnswers = examAnswers;
    newExam.dateCompleted = new Date();

    newExam.num_questions = this.examQuestions.length;
    newExam.num_attempted = this.examQuestions.filter((mcq: any) => mcq.attempted).length;
    newExam.num_correct = this.examQuestions.filter((mcq: any) => mcq.correct).length;
    newExam.num_incorrect = this.examQuestions.filter((mcq: any) => !mcq.correct).length;

    this.store.dispatch(invokeSubmitUserExamAPI({ exam: newExam }));

    var examAnswers2: UserExamAnswer[] = this.examQuestions.map((mcq: any) => {
      return {
        ...mcq,
        exam_id: this.newExam.examId,
        mcq_id: mcq.question_id,
        choice_1_answer: mcq.correct_1_answer,
        choice_2_answer: mcq.correct_2_answer,
        choice_3_answer: mcq.correct_3_answer,
        choice_4_answer: mcq.correct_4_answer,
      };
    });

    this.newExam = { ...newExam };
    this.newExam.userExamAnswers = examAnswers2;

    this.examStarted = false;
    this.examCompleted = true;

    console.log("examid:", newExam.examId);
    const i: number = this.newExams?.findIndex((exam: any) => exam.examId == newExam.examId)!;
    console.log("exam index", i );
    if (i >= 0)
       this.newExams?.splice(i, 1);

    console.log("new newExams", this.newExams);
  }
}
