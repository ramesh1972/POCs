import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { UserExam }  from '../models/Exam';
import { UserExamAnswer } from '../models/UserExamAnswer';

@Injectable({
  providedIn: 'root'
})
export class ExamService {
  constructor(private _http: HttpClient) { }

  getExams(onlyExamsNotStarted: boolean = false): Observable<UserExam[]> {
    console.log("Exam service :", environment.baseURL);
    return this._http.get<UserExam[]>(environment.baseURL + "Exam/" + onlyExamsNotStarted);
  }

  getExamsForUser(userId: number): Observable<UserExam[]> {
    console.log("Exam service :", environment.baseURL);
    return this._http.get<UserExam[]>(environment.baseURL + "Exam/user/" + userId);
  }

  getUserExamsByExamId(examId: number): Observable<UserExamAnswer[]> {
    console.log("Exam service :", environment.baseURL);
    return this._http.get<UserExamAnswer[]>(environment.baseURL + "exam/answers/" + examId);
  }

  getUserExamByExamId(examId: number): Observable<UserExam> {
    console.log("Exam service :", environment.baseURL);
    return this._http.get<UserExam>(environment.baseURL + "exam/questions/" + examId);
  }

  submitExam(exam: UserExam): Observable<any> {
    console.log("Exam service :", exam);
    return this._http.put(environment.baseURL + "Exam", exam);
  }

  createExam(userId: number): Observable<any> {
    console.log("Exam service :", userId);
    return this._http.post(environment.baseURL + "Exam/" + userId, null);
  }

  createExamByAdmin(userId: number): Observable<any> {
    console.log("Exam service :", userId);
    return this._http.post(environment.baseURL + "Exam/admin/" + userId, null);
  }
}
