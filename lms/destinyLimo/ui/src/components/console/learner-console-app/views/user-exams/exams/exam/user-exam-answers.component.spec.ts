import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UserExamAnswersComponent } from './user-exam-answers.component';

describe('UserExamAnswersComponent', () => {
  let component: UserExamAnswersComponent;
  let fixture: ComponentFixture<UserExamAnswersComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [UserExamAnswersComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(UserExamAnswersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
