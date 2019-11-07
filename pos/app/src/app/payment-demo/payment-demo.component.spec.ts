import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PaymentDemoComponent } from './payment-demo.component';

describe('PaymentDemoComponent', () => {
  let component: PaymentDemoComponent;
  let fixture: ComponentFixture<PaymentDemoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PaymentDemoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PaymentDemoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
