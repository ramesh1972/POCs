import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewExamsComponent } from './new-exams.component';

describe('NewExamsComponent', () => {
  let component: NewExamsComponent;
  let fixture: ComponentFixture<NewExamsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewExamsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(NewExamsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
