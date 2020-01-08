array			DCD		2,3,5,7,11,13,17,19,23 ;array
				
				LDR		r0, =array
QSORT			;Registros auxiliares
				;r0,		puntero a la base del arreglo a ordenar
				;r1,		primer indice en el rango a ordenar (por izquierda) (debe ser mayor que el pivote)
				;r2,		primer indice en el rango a ordenar (por derecha) (debe ser menor que el pivote)
				
				STMFD	SP!, {R4, R6, LR} ; PUSH en el stack de r4, r6 y LR
				MOV		R6, R2 ;mueve la "derecha" en r6
				
ENTRADA_COLA
				SUB		R7, R6, R1	; si la diferencia entre derecha e izquierda 
				CMP		R7, #1 		; es menor o igual  que 1 ya está ordenado
				LDMFD	SP!, {R4, R6, PC} ; POP en el stack de r4, r6 y PC
				LDR		R7, [R0, R1, LSL #2] ; define r7 como pivote
				ADD		R2, R1, #1 ;L <- indice por izquierda + 1
				MOV		R4, R6 ;R <-Derecha
				
CICLO_PARTICION
				LDR		R3, [R0, R1, LSL #2] ;r3 <-a[L]
				CMP		R3, R7 ; compara si a[L] es menor o igual al pivote
				ADDLE	R2, R2, #1 ; incrementa en 1
				BLE		PRUEBA_PARTICION ;continua a la siguiente iteracion
				SUB		R4, R4, #1 ;o bien, decrementa en 1
				LDR		R5, [R0, R4, LSL #2] ;cambia a[L] & a[R]
				STR		R5, [R0, R2, LSL #2]
				STR		R3, [R0, R4, LSL #2]
				
PRUEBA_PARTICION
				CMP		R2, R4 ; si L<R
				BLT		CICLO_PARTICION ;continua iterando
				
FINAL_PARTICION
				SUB		R2, R2, #1 ; decremento en 1
				LDR		R3, [R0, R2, LSL #2] ;cambio de pivote a a[L]
				STR		R3, [R0, R1, LSL #2] ;
				STR		R3, [R0, R2, LSL #2] ;
				BL		QSORT ; llamada recursiva por la izquierda, registros iniciales se mentienen
				MOV		R1, R4 ;
				B		ENTRADA_COLA ; Llamada a la cola por la derecha ahora a(r0), L(r1) y R(r6)
