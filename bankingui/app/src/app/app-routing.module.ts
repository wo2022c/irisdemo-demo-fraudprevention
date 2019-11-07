import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {AccountDemoComponent} from './account-demo/account-demo.component';

const routes: Routes = [
  {path: '**', component: AccountDemoComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

