import { Component } from '@angular/core';
import { EmpleadosPageComponent } from './empleados/empleados-page.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [EmpleadosPageComponent],
  template: `<app-empleados-page></app-empleados-page>`
})
export class AppComponent {}
