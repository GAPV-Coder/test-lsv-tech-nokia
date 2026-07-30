import { Component, Input } from '@angular/core';
import { IconComponent } from '../icon/icon.component';

export type TipoAlerta = 'success' | 'error';

/**
 * Única responsabilidad: mostrar un mensaje con estilo e ícono según
 * el tipo (éxito o error). No sabe de dónde viene el mensaje ni qué
 * lo disparó — eso lo decide quien lo usa (EmpleadoFormComponent,
 * EmpleadosPageComponent).
 */
@Component({
  selector: 'app-alert-banner',
  standalone: true,
  imports: [IconComponent],
  templateUrl: './alert-banner.component.html',
  styleUrl: './alert-banner.component.css'
})
export class AlertBannerComponent {
  @Input({ required: true }) tipo!: TipoAlerta;
  @Input({ required: true }) mensaje!: string;

  get icono(): string {
    return this.tipo === 'success' ? 'check_circle' : 'error';
  }
}
