import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MainHomeComponent } from './main-home';

describe('MainHomeComponent', () => {
  let component: MainHomeComponent;
  let fixture: ComponentFixture<MainHomeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MainHomeComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MainHomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
