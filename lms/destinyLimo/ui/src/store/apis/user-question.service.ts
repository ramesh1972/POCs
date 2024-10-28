import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { UserAskedQuestion } from '../models/UserAskedQuestion';

@Injectable({
    providedIn: 'root'
})
export class UserAskedQuestionService {
    constructor(private _http: HttpClient) { }

    getQuestions(includeOnlyAnswered: boolean = false): Observable<UserAskedQuestion[]> {
        console.log("UserAskedQuestion service :", environment.baseURL);
        return this._http.get<UserAskedQuestion[]>(environment.baseURL + "UserQuestion/" + includeOnlyAnswered);
    }

    getQuestionsForUser(userId: number): Observable<UserAskedQuestion[]> {
        console.log("UserAskedQuestion service :", environment.baseURL);
        return this._http.get<UserAskedQuestion[]>(environment.baseURL + "UserQuestion/user/" + userId);
    }

    getQuestionById(questionId: number): Observable<UserAskedQuestion> {
        console.log("UserAskedQuestion service :", environment.baseURL);
        return this._http.get<UserAskedQuestion>(environment.baseURL + "UserQuestion/question/" + questionId);
    }

    getPublicQuestions(): Observable<UserAskedQuestion[]> {
        console.log("UserAskedQuestion service :", environment.baseURL);
        return this._http.get<UserAskedQuestion[]>(environment.baseURL + "UserQuestion/public");
    }

    answerQuestion(questionId: number, answer: string, admin_user_id: number): Observable<any> {
        console.log("UserAskedQuestion service :", questionId);
        return this._http.post(environment.baseURL + "UserQuestion/answer/" + questionId + "adminUserId="+ admin_user_id, answer);
    }

    makePublic(questionId: number): Observable<any> {
        console.log("UserAskedQuestion service :", questionId);
        return this._http.post(environment.baseURL + "UserQuestion/public/" + questionId, true);
    }

    makePrivate(questionId: number): Observable<any> {
        console.log("UserAskedQuestion service :", questionId);
        return this._http.post(environment.baseURL + "UserQuestion/public/" + questionId, false);
    }

    submitNewQuestion(question: UserAskedQuestion): Observable<any> {
        console.log("UserAskedQuestion service :", question);
        return this._http.post(environment.baseURL + "UserQuestion/", question);
    }

    updateQuestion(questionId: number, question: UserAskedQuestion): Observable<any> {
        console.log("UserAskedQuestion service :", question);
        return this._http.put(environment.baseURL + "UserQuestion/" + questionId, question);
    }

    deleteQuestion(questionId: number): Observable<any> {
        console.log("UserAskedQuestion service :", questionId);
        return this._http.delete(environment.baseURL + "UserQuestion/" + questionId);
    }
}