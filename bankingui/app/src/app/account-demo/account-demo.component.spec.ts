import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AccountDemoComponent } from './account-demo.component';

describe('AccountDemoComponent', () => {
  let component: AccountDemoComponent;
  let fixture: ComponentFixture<AccountDemoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AccountDemoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AccountDemoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
