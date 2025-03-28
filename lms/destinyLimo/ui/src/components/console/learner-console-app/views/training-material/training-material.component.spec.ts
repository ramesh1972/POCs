import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TrainingMaterialComponent } from './training-material.component';

describe('TrainingMaterialComponent', () => {
  let component: TrainingMaterialComponent;
  let fixture: ComponentFixture<TrainingMaterialComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TrainingMaterialComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TrainingMaterialComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
