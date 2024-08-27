.include "m328pdef.inc"  ; Incluir definición del microcontrolador ATmega328P

.org 0x0000             ; Dirección de inicio del programa
rjmp RESET              ; Salto al inicio del programa (rutina de reinicio)

.org 0x0024             ; Dirección del Timer/Counter1 Overflow Interrupt
rjmp TIMER1_OVF_ISR     ; Rutina de interrupción del desbordamiento del Timer1

; Rutina de inicialización
RESET:
    ldi r16, (1 << CS11)         ; Configurar Timer1 en modo Normal (prescaler 8)
    out TCCR1B, r16             ; Guardar en TCCR1B
    
    ldi r16, (1 << TOIE1)        ; Habilitar interrupción por desbordamiento
    out TIMSK1, r16              ; Guardar en TIMSK1
    
    ldi r16, 0x00                ; Inicializar el valor del Timer1
    out TCNT1H, r16
    out TCNT1L, r16

    ldi r16, 0x00                ; Inicializar el selector de frecuencia
    out DDRB, r16                ; Configurar el puerto B como salida (PWM)
    
    sei                          ; Habilitar interrupciones globales
    
    rjmp MAIN_LOOP                ; Saltar al bucle principal

; Rutina de interrupción por desbordamiento del Timer1 
TIMER1_OVF_ISR:
    ldi r16, 0x00                ; Resetear el Timer1
    out TCNT1H, r16
    out TCNT1L, r16
    
    ; Código para cambiar la frecuencia
    ; Aquí se puede implementar la lógica de selección de frecuencia
    ; Incrementar o cambiar el valor del Timer1 para ajustar la frecuencia
    
    reti                         ; Regresar de la interrupción

; Bucle principal
MAIN_LOOP:
    ; Aquí puede ir el código principal si es necesario
    
    rjmp MAIN_LOOP               ; Bucle infinito

; Nota: La lógica de ajuste de frecuencia debería estar implementada en la ISR
; dependiendo del valor del selector o el conteo del Timer1

.end
