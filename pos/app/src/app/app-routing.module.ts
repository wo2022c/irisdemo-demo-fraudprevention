import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {PaymentDemoComponent} from './payment-demo/payment-demo.component';

const routes: Routes = [
  {path: '**', component: PaymentDemoComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
