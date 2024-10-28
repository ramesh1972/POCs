import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
    providedIn: 'root'
})
export class VisibilityService {
    private headerVisible = new BehaviorSubject<boolean>(true);
    private homeVisible = new BehaviorSubject<boolean>(true);
    private consoleVisible = new BehaviorSubject<boolean>(false);

    headerVisible$ = this.headerVisible.asObservable();
    homeVisible$ = this.homeVisible.asObservable();
    consoleVisible$ = this.consoleVisible.asObservable();
    
    setHeaderVisible(visible: boolean) {
        this.headerVisible.next(visible);
    }

    setHomeVisible(visible: boolean) {
        this.homeVisible.next(visible);
    }

    setConsoleVisible(visible: boolean) {
        this.consoleVisible.next(visible);
    }
}