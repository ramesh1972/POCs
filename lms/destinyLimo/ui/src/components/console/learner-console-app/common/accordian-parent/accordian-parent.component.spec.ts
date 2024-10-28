import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AccordianParentComponent } from './accordian-parent.component';

describe('AccordianParentComponent', () => {
  let component: AccordianParentComponent;
  let fixture: ComponentFixture<AccordianParentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AccordianParentComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AccordianParentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
