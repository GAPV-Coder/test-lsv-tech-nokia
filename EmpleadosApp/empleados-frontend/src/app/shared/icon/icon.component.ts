import { Component, Input } from '@angular/core';

/**
 * Única responsabilidad: renderizar un ícono de Material Symbols dado
 * su nombre. Evita repetir <span class="material-symbols-outlined">
 * por todo el código y centraliza el tamaño/color por defecto.
 *
 * Uso: <app-icon name="search"></app-icon>
 */
@Component({
  selector: 'app-icon',
  standalone: true,
  template: `<span class="material-symbols-outlined" [style.font-size.px]="size">{{ name }}</span>`,
  styles: [`
    :host {
      display: inline-flex;
    }
  `]
})
export class IconComponent {
  @Input({ required: true }) name!: string;
  @Input() size = 20;
}
