import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ExecutionService {
  private apiUrl = 'http://localhost:3000/execute'; // Adjust as needed

  constructor(private http: HttpClient) {}

  executeScript(project: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/${project}`, { responseType: 'text' });
  }
}
