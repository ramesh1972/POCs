import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { ApiResponse } from '../models/ApiResponse';
import { UserAskedQuestion } from '../models/UserAskedQuestion';

@Injectable({
    providedIn: 'root'
})
export class UserAskedQuestionService {
    constructor(private _http: HttpClient) { }

    getQuestions(includeOnlyAnswered: boolean = false): Observable<ApiResponse> {
        console.log("ApiResponse service :", environment.baseURL);
        return this._http.get<ApiResponse>(environment.baseURL + "UserQuestion/" + includeOnlyAnswered);
    }

    getQuestionsForUser(userId: number): Observable<ApiResponse> {
        console.log("ApiResponse service :", environment.baseURL);
        return this._http.get<ApiResponse>(environment.baseURL + "UserQuestion/user/" + userId);
    }

    getQuestionById(questionId: number): Observable<ApiResponse> {
        console.log("ApiResponse service :", environment.baseURL);
        return this._http.get<ApiResponse>(environment.baseURL + "UserQuestion/question/" + questionId);
    }

    getPublicQuestions(): Observable<ApiResponse> {
        console.log("ApiResponse service :", environment.baseURL);
        return this._http.get<ApiResponse>(environment.baseURL + "UserQuestion/public");
    }

    answerQuestion(questionId: number, answer: string, admin_user_id: number): Observable<ApiResponse> {
        console.log("ApiResponse service :", questionId);
        return this._http.post<ApiResponse>(environment.baseURL + "UserQuestion/answer/" + questionId + "adminUserId="+ admin_user_id, answer);
    }

    makePublic(questionId: number): Observable<ApiResponse> {
        console.log("ApiResponse service :", questionId);
        return this._http.post<ApiResponse>(environment.baseURL + "UserQuestion/public/" + questionId, true);
    }

    makePrivate(questionId: number): Observable<ApiResponse> {
        console.log("ApiResponse service :", questionId);
        return this._http.post<ApiResponse>(environment.baseURL + "UserQuestion/public/" + questionId, false);
    }

    submitNewQuestion(question: UserAskedQuestion): Observable<ApiResponse> {
        console.log("ApiResponse service :", question);
        return this._http.post<ApiResponse>(environment.baseURL + "UserQuestion/", question);
    }

    updateQuestion(questionId: number, question: UserAskedQuestion): Observable<ApiResponse> {
        console.log("ApiResponse service :", question);
        return this._http.put<ApiResponse>(environment.baseURL + "UserQuestion/" + questionId, question);
    }

    deleteQuestion(questionId: number): Observable<ApiResponse> {
        console.log("ApiResponse service :", questionId);
        return this._http.delete<ApiResponse>(environment.baseURL + "UserQuestion/" + questionId);
    }
}