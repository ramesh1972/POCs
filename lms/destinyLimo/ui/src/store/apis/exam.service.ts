import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { ApiResponse }  from '../models/ApiResponse';
import { UserExam } from '../models/Exam';

@Injectable({
  providedIn: 'root'
})
export class ExamService {
  constructor(private _http: HttpClient) { }

  getExams(onlyExamsNotStarted: boolean = false): Observable<ApiResponse> {
    console.log("Exam service :", environment.baseURL);
    return this._http.get<ApiResponse>(environment.baseURL + "Exam/" + onlyExamsNotStarted);
  }

  getExamsForUser(userId: number): Observable<ApiResponse> {
    console.log("Exam service :", environment.baseURL);
    return this._http.get<ApiResponse>(environment.baseURL + "Exam/user/" + userId);
  }

  getUserExamsByExamId(examId: number): Observable<ApiResponse> {
    console.log("Exam service :", environment.baseURL);
    return this._http.get<ApiResponse>(environment.baseURL + "exam/answers/" + examId);
  }

  getUserExamByExamId(examId: number): Observable<ApiResponse> {
    console.log("Exam service :", environment.baseURL);
    return this._http.get<ApiResponse>(environment.baseURL + "exam/questions/" + examId);
  }

  submitExam(exam: UserExam): Observable<ApiResponse> {
    console.log("Exam service :", exam);
    return this._http.put<ApiResponse>(environment.baseURL + "Exam", exam);
  }

  createExam(userId: number): Observable<ApiResponse> {
    console.log("Exam service :", userId);
    return this._http.post<ApiResponse>(environment.baseURL + "Exam/" + userId, null);
  }

  createExamByAdmin(userId: number): Observable<ApiResponse> {
    console.log("Exam service :", userId);
    return this._http.post<ApiResponse>(environment.baseURL + "Exam/admin/" + userId, null);
  }
}
