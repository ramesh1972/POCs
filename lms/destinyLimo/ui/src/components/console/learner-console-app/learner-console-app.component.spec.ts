import { TestBed } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { LearnerConsoleAppComponent } from './learner-console-app.component';

describe('LearnerConsoleAppComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
    imports: [
        RouterTestingModule,
        LearnerConsoleAppComponent
    ],
}).compileComponents();
  });

  it('should create the app', () => {
    const fixture = TestBed.createComponent(LearnerConsoleAppComponent);
    const app = fixture.componentInstance;
    expect(app).toBeTruthy();
  });

  it(`should have as title 'CoreUI Angular Admin Template'`, () => {
    const fixture = TestBed.createComponent(LearnerConsoleAppComponent);
    const app = fixture.componentInstance;
    expect(app.title).toEqual('CoreUI Angular Admin Template');
  });
});
