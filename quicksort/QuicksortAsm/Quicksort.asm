;Wersja 0.6 Dawid Wolny
; Funkcja bedzie zwracala operacje sortowania dla tablicy liczb. Bedzie ona sortowana algorytmem Quick Sort.
; Polegac on bedzie na rekurencyjnym podziale tablicy na dwie podtablice, na ktorych nastepnie wykonywane bedzie sortowanie.
.DATA
.CODE

QuicksortAsm PROC EXPORT
   ;zapisanie wartoœci na stosie(bez tego wyskakiwal mi blad zwiazany z pamiecia)
   push rbp             ; Zapisanie wartoœci rejestru rbp na stosie.
   push rbx             ; Zapisanie wartoœci rejestru rbx na stosie.
   push rsi             ; Zapisanie wartoœci rejestru rsi na stosie.
   push rdi             ; Zapisanie wartoœci rejestru rdi na stosie.
   push rax             ; Zapisanie wartoœci rejestru rax na stosie.
   push rcx             ; Zapisanie wartoœci rejestru rcx na stosie.

   ;wskaŸnik na pierwszy element tablicy do rsi
   mov rsi, rcx         ; Przeniesienie wartoœci rejestru rcx (pierwszy argument) do rejestru rsi (wskaŸnik na tablicê).
   ;wielkoœæ tablicy do rejestru rax
   mov rax, rdx         ; Przeniesienie wartoœci rejestru rdx (drugi argument) do rejestru rax (rozmiar tablicy).

   ;mno¿ymy wielkoœæ tablicy razy 4 aby wielkoœæ podana by³a w bajtach
   mov rcx, 4           ; Ustawienie wartoœci 4 w rejestrze rcx.
   mul rcx              ; Pomno¿enie wartoœci w rejestrze rax przez wartoœæ w rejestrze rcx, wynik w rdx:rax.
   mov rcx, rax         ; Przeniesienie wyniku mno¿enia do rejestru rcx.

   ;zerowanie startowego indeksu
   xor rax, rax         ; Wyzerowanie rejestru rax.

   ;inicjalizacja koncowego indeksu jako przedostatniego element
   mov rbx, rcx         ; Przeniesienie wartoœci rejestru rcx (rozmiar tablicy) do rejestru rbx.
   sub rbx, 4           ; Odjêcie 4 od wartoœci w rejestrze rbx (pozycja przedostatniego elementu).

   ;wywolanie funkcji rekurencyjnej
   call Recursive       ; Wywo³anie funkcji rekurencyjnej.

   ;wczytanie wczeœniej zapisanych wartoœci spowrotem do rejestrów
   pop rcx              ; Wczytanie wartoœci ze stosu do rejestru rcx.
   pop rax              ; Wczytanie wartoœci ze stosu do rejestru rax.
   pop rdi              ; Wczytanie wartoœci ze stosu do rejestru rdi.
   pop rsi              ; Wczytanie wartoœci ze stosu do rejestru rsi.
   pop rbx              ; Wczytanie wartoœci ze stosu do rejestru rbx.
   pop rbp              ; Wczytanie wartoœci ze stosu do rejestru rbp.

QuicksortAsm ENDP

Recursive:
   ;jesli startowy indeks jest wiekszy lub rowny od koncowego to zakoncz rekurencje
   cmp rax, rbx         ; Porównanie wartoœci rejestru rax (startowy indeks) z wartoœci¹ rejestru rbx (koñcowy indeks).
   ;skok do returna po wykonaniu compare, jesli cel jest wiekszy lub rowny
   jge Return           ; Skok do etykiety Return, jeœli wartoœæ rejestru rax jest wiêksza lub równa wartoœci rejestru rbx.

   ;zapisanie wartosci startowego i koncowego indeksu
   push rax             ; Zapisanie wartoœci rejestru rax (startowy indeks) na stosie.
   push rbx             ; Zapisanie wartoœci rejestru rbx (koñcowy indeks) na stosie.
   ;dodanie 4 do koncowego indeksu, poniewaz dekrementacja bedzie na poczatku petli
   add rbx, 4           ; Dodanie 4 do wartoœci rejestru rbx (koñcowy indeks).

   ;wartosc liczby pod indeksem rax (startowy indeks) przypisana do pivota
   ;przeniesiona jest do rejestru 32-bitowego, poniewaz int ma 32 bity(dlatego uzywamy edi bo jest 32 bitowym rejestrem)
   mov edi, [rsi + rax] ; Przeniesienie wartoœci pod adresem (rsi + rax) (pierwszy element tablicy) do rejestru edi (pivot).

   ;petla glowna
   MainLoop:
      iIncreaseLoop:
         ;zwiekszenie startowego indeksu o 4 bajty (wielkosc int)
         add rax, 4       ; Zwiêkszenie wartoœci rejestru rax o 4 (przesuniêcie na nastêpny element).

         ;jesli startowy indeks jest wiekszy lub rowny od koncowego to zakoncz petle
         cmp rax, rbx     ; Porównanie wartoœci rejestru rax (startowy indeks) z wartoœci¹ rejestru rbx (koñcowy indeks).
         jge EndiIncreaseLoop ; Skok do etykiety EndiIncreaseLoop, jeœli wartoœæ rejestru rax jest wiêksza lub równa wartoœci rejestru rbx.

         ;wrzucamy wartosc pod indeksem rax do rejestru tymczasowego edx i porownujemy z edi(pivot)
         ;jesli wartosc wieksza rowna pivotowi to zakoncz petle
         mov edx, [rsi + rax] ; Przeniesienie wartoœci pod adresem (rsi + rax) (aktualny element) do rejestru edx.
         cmp edx, edi     ; Porównanie wartoœci rejestru edx (aktualny element) z wartoœci¹ rejestru edi (pivot).
         jge EndiIncreaseLoop ; Skok do etykiety EndiIncreaseLoop, jeœli wartoœæ rejestru edx jest wiêksza lub równa wartoœci rejestru edi.

         jmp iIncreaseLoop ; Skok do etykiety iIncreaseLoop (powtórzenie pêtli).
      EndiIncreaseLoop:

      jDecreaseLoop:
         ;analogiczna petla do tej z i, ale tym razem zmniejszamy koncowy indeks
         sub rbx, 4       ; Zmniejszenie wartoœci rejestru rbx o 4 (przesuniêcie na poprzedni element).

         mov edx, [rsi + rbx] ; Przeniesienie wartoœci pod adresem (rsi + rbx) (aktualny element) do rejestru edx.
         cmp edx, edi     ; Porównanie wartoœci rejestru edx (aktualny element) z wartoœci¹ rejestru edi (pivot).
         jle EndjDecreaseLoop ; Skok do etykiety EndjDecreaseLoop, jeœli wartoœæ rejestru edx jest mniejsza lub równa wartoœci rejestru edi.

         jmp jDecreaseLoop ; Skok do etykiety jDecreaseLoop (powtórzenie pêtli).
      EndjDecreaseLoop:

      cmp rax, rbx       ; Porównanie wartoœci rejestru rax (startowy indeks) z wartoœci¹ rejestru rbx (koñcowy indeks).
      jge EndMainLoop   ; Skok do etykiety EndMainLoop, jeœli wartoœæ rejestru rax jest wiêksza lub równa wartoœci rejestru rbx.

      ;zamieniamy wartosci miejscami
      mov r8d, [rsi + rax] ; Przeniesienie wartoœci pod adresem (rsi + rax) (wartoœæ do zamiany) do rejestru r8d.
      mov r9d, [rsi + rbx] ; Przeniesienie wartoœci pod adresem (rsi + rbx) (wartoœæ do zamiany) do rejestru r9d.
      mov [rsi + rbx], r8d ; Przeniesienie wartoœci rejestru r8d (wartoœæ do zamiany) do adresu (rsi + rbx).
      mov [rsi + rax], r9d ; Przeniesienie wartoœci rejestru r9d (wartoœæ do zamiany) do adresu (rsi + rax).

      jmp MainLoop      ; Skok do etykiety MainLoop (powtórzenie pêtli).

   EndMainLoop:

   ;wczytujemy zapisana wczesniej wartosc do pivota i rcx (tymczasowy startowy indeks)
   pop rdi             ; Wczytanie wartoœci ze stosu do rejestru rdi (koñcowy indeks).
   pop rcx             ; Wczytanie wartoœci ze stosu do rejestru rcx (startowy indeks).
   cmp rcx, rbx        ; Porównanie wartoœci rejestru rcx (startowy indeks) z wartoœci¹ rejestru rbx (koñcowy indeks).
   je EndSwap          ; Skok do etykiety EndSwap, jeœli wartoœci s¹ równe.

   ;zamieniamy wartosci miejscami

   mov r8d, [rsi + rcx] ; Przeniesienie wartoœci pod adresem (rsi + rcx) (wartoœæ do zamiany) do rejestru r8d.
   mov r9d, [rsi + rbx] ; Przeniesienie wartoœci pod adresem (rsi + rbx) (wartoœæ do zamiany) do rejestru r9d.
   mov [rsi + rbx], r8d ; Przeniesienie wartoœci rejestru r8d (wartoœæ do zamiany) do adresu (rsi + rbx).
   mov [rsi + rcx], r9d ; Przeniesienie wartoœci rejestru r9d (wartoœæ do zamiany) do adresu (rsi + rcx).

   EndSwap:

   mov rax, rcx        ; Przeniesienie wartoœci rejestru rcx (startowy indeks) do rejestru rax.
   
   ;zapisujemy wartosc pivota i koncowego indeksu
   push rdi            ; Zapisanie wartoœci rejestru rdi (koñcowy indeks) na stosie.
   push rbx            ; Zapisanie wartoœci rejestru rbx (koñcowy indeks) na stosie.

   ;zmniejszamy koncowy indeks o 4 i wywolujemy funkcje rekurencyjna
   sub rbx, 4          ; Zmniejszenie wartoœci rejestru rbx o 4 (przesuniêcie na poprzedni element).
   call Recursive      ; Wywo³anie funkcji rekurencyjnej.

   ;wczytujemy startowy indeks do rax i zwiekszamy go o 1 
   pop rax             ; Wczytanie wartoœci ze stosu do rejestru rax (startowy indeks).
   add rax, 4          ; Zwiêkszenie wartoœci rejestru rax o 4 (przesuniêcie na nastêpny element).

   ;wczytujemy koncowy indeks do rbx i wywolujemy funkcje rekurencyjna
   pop rbx             ; Wczytanie wartoœci ze stosu do rejestru rbx (koñcowy indeks).
   call Recursive      ; Wywo³anie funkcji rekurencyjnej.

   Return:
      ret              ; Powrót z procedury.
END
