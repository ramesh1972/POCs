import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ConsoleComponent } from './console.component';

import { AdminConsoleAppComponent } from './admin-console-app/admin-console-app.component';
import { LearnerConsoleAppComponent } from './learner-console-app/learner-console-app.component';

import { consoleAppConfig } from './admin-console-app/admin-console-app.config';
// update this module based on console-app.config.ts and AdminConsoleAppComponent

@NgModule({
  declarations: [],
  imports: [
    CommonModule, ConsoleComponent, AdminConsoleAppComponent, LearnerConsoleAppComponent
  ],
  providers: consoleAppConfig.providers
})
export class ConsoleModule {
}
