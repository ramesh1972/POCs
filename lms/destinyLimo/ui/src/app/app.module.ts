import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { HTTP_INTERCEPTORS } from '@angular/common/http';

import {
  provideRouter,
  withEnabledBlockingInitialNavigation,
  withHashLocation,
  withInMemoryScrolling,
  withRouterConfig,
  withViewTransitions
} from '@angular/router';

import { AppComponent } from './app.component';
import { CommonModule } from '@angular/common';
import { BrowserModule } from '@angular/platform-browser';

import { routes } from './app.routes';
import { MyHttpInterceptor } from '../components/common/MyHttpInterceptor';

import { ConsoleModule } from '@src/components/console/console.module';
import { LandingComponent } from '@src/components/landing/landing.component';

import { StoreModule } from '@ngrx/store';
import { EffectsModule } from '@ngrx/effects';

import { bulkUpdateReducer} from '../store/reducers/bulk-update.reducer';
import { BulkUpdateEffect } from '@src/store/effects/bulk-update.effect';
import { contentReducer } from '../store/reducers/content.reducer';
import { ContentEffect } from '../store/effects/content.effect';
import { materialReducer } from '../store/reducers/material.reducer';
import { MaterialEffect } from '../store/effects/material.effect';
import { examReducer } from '../store/reducers/exam.reducer';
import { ExamEffect } from '../store/effects/exam.effect';
import { userAskedQuestionReducer } from '@src/store/reducers/user-question.reducer';
import { UserAskedQuestionEffect } from '@src/store/effects/user-question.effect';
import { userReducer } from '@src/store/reducers/user.reducer';
import { UserEffect } from '@src/store/effects/user.effect';
import { userProfileReducer } from '@src/store/reducers/user-profile.reducer';
import { UserProfileEffect } from '@src/store/effects/user-profile.effect';

import { ConsoleComponent } from '@src/components/console/console.component';

@NgModule({
    declarations: [],
    imports: [AppRoutingModule, CommonModule, BrowserModule,
        StoreModule.forRoot({}),
        StoreModule.forFeature('content', contentReducer),
        EffectsModule.forRoot([]),
        EffectsModule.forFeature([ContentEffect]),
        StoreModule.forFeature('material', materialReducer),
        EffectsModule.forFeature([MaterialEffect]),
        StoreModule.forFeature('bulk-update', bulkUpdateReducer),
        EffectsModule.forFeature([BulkUpdateEffect]),
        StoreModule.forFeature('exams', examReducer),
        EffectsModule.forFeature([ExamEffect]),
        StoreModule.forFeature('user-questions', userAskedQuestionReducer),
        EffectsModule.forFeature([UserAskedQuestionEffect]),
        StoreModule.forFeature('users', userReducer),
        EffectsModule.forFeature([UserEffect]),
        StoreModule.forFeature('user_profiles', userProfileReducer),
        EffectsModule.forFeature([UserProfileEffect]),
        AppComponent, LandingComponent, ConsoleComponent,
        ConsoleModule
    ],
    providers: [
        provideHttpClient(withInterceptorsFromDi()),
        { provide: HTTP_INTERCEPTORS, useClass: MyHttpInterceptor, multi: true }
        /* ,
        provideRouter(routes,
          withRouterConfig({
            onSameUrlNavigation: 'reload'
          }),
          withInMemoryScrolling({
            scrollPositionRestoration: 'top',
            anchorScrolling: 'enabled'
          }),
          withEnabledBlockingInitialNavigation(),
          withViewTransitions()
        ), */
    ],
    bootstrap: [AppComponent]
})
export class AppModule {
  constructor() {
  }
 }