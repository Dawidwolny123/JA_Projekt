;Wersja 0.6 Dawid Wolny
; Funkcja bedzie zwracala operacje sortowania dla tablicy liczb. Bedzie ona sortowana algorytmem Quick Sort.
; Polegac on bedzie na rekurencyjnym podziale tablicy na dwie podtablice, na ktorych nastepnie wykonywane bedzie sortowanie.
.DATA
.CODE

QuicksortAsm PROC EXPORT
   ;zapisanie warto�ci na stosie(bez tego wyskakiwal mi blad zwiazany z pamiecia)
   push rbp             ; Zapisanie warto�ci rejestru rbp na stosie.
   push rbx             ; Zapisanie warto�ci rejestru rbx na stosie.
   push rsi             ; Zapisanie warto�ci rejestru rsi na stosie.
   push rdi             ; Zapisanie warto�ci rejestru rdi na stosie.
   push rax             ; Zapisanie warto�ci rejestru rax na stosie.
   push rcx             ; Zapisanie warto�ci rejestru rcx na stosie.

   ;wska�nik na pierwszy element tablicy do rsi
   mov rsi, rcx         ; Przeniesienie warto�ci rejestru rcx (pierwszy argument) do rejestru rsi (wska�nik na tablic�).
   ;wielko�� tablicy do rejestru rax
   mov rax, rdx         ; Przeniesienie warto�ci rejestru rdx (drugi argument) do rejestru rax (rozmiar tablicy).

   ;mno�ymy wielko�� tablicy razy 4 aby wielko�� podana by�a w bajtach
   mov rcx, 4           ; Ustawienie warto�ci 4 w rejestrze rcx.
   mul rcx              ; Pomno�enie warto�ci w rejestrze rax przez warto�� w rejestrze rcx, wynik w rdx:rax.
   mov rcx, rax         ; Przeniesienie wyniku mno�enia do rejestru rcx.

   ;zerowanie startowego indeksu
   xor rax, rax         ; Wyzerowanie rejestru rax.

   ;inicjalizacja koncowego indeksu jako przedostatniego element
   mov rbx, rcx         ; Przeniesienie warto�ci rejestru rcx (rozmiar tablicy) do rejestru rbx.
   sub rbx, 4           ; Odj�cie 4 od warto�ci w rejestrze rbx (pozycja przedostatniego elementu).

   ;wywolanie funkcji rekurencyjnej
   call Recursive       ; Wywo�anie funkcji rekurencyjnej.

   ;wczytanie wcze�niej zapisanych warto�ci spowrotem do rejestr�w
   pop rcx              ; Wczytanie warto�ci ze stosu do rejestru rcx.
   pop rax              ; Wczytanie warto�ci ze stosu do rejestru rax.
   pop rdi              ; Wczytanie warto�ci ze stosu do rejestru rdi.
   pop rsi              ; Wczytanie warto�ci ze stosu do rejestru rsi.
   pop rbx              ; Wczytanie warto�ci ze stosu do rejestru rbx.
   pop rbp              ; Wczytanie warto�ci ze stosu do rejestru rbp.

QuicksortAsm ENDP

Recursive:
   ;jesli startowy indeks jest wiekszy lub rowny od koncowego to zakoncz rekurencje
   cmp rax, rbx         ; Por�wnanie warto�ci rejestru rax (startowy indeks) z warto�ci� rejestru rbx (ko�cowy indeks).
   ;skok do returna po wykonaniu compare, jesli cel jest wiekszy lub rowny
   jge Return           ; Skok do etykiety Return, je�li warto�� rejestru rax jest wi�ksza lub r�wna warto�ci rejestru rbx.

   ;zapisanie wartosci startowego i koncowego indeksu
   push rax             ; Zapisanie warto�ci rejestru rax (startowy indeks) na stosie.
   push rbx             ; Zapisanie warto�ci rejestru rbx (ko�cowy indeks) na stosie.
   ;dodanie 4 do koncowego indeksu, poniewaz dekrementacja bedzie na poczatku petli
   add rbx, 4           ; Dodanie 4 do warto�ci rejestru rbx (ko�cowy indeks).

   ;wartosc liczby pod indeksem rax (startowy indeks) przypisana do pivota
   ;przeniesiona jest do rejestru 32-bitowego, poniewaz int ma 32 bity(dlatego uzywamy edi bo jest 32 bitowym rejestrem)
   mov edi, [rsi + rax] ; Przeniesienie warto�ci pod adresem (rsi + rax) (pierwszy element tablicy) do rejestru edi (pivot).

   ;petla glowna
   MainLoop:
      iIncreaseLoop:
         ;zwiekszenie startowego indeksu o 4 bajty (wielkosc int)
         add rax, 4       ; Zwi�kszenie warto�ci rejestru rax o 4 (przesuni�cie na nast�pny element).

         ;jesli startowy indeks jest wiekszy lub rowny od koncowego to zakoncz petle
         cmp rax, rbx     ; Por�wnanie warto�ci rejestru rax (startowy indeks) z warto�ci� rejestru rbx (ko�cowy indeks).
         jge EndiIncreaseLoop ; Skok do etykiety EndiIncreaseLoop, je�li warto�� rejestru rax jest wi�ksza lub r�wna warto�ci rejestru rbx.

         ;wrzucamy wartosc pod indeksem rax do rejestru tymczasowego edx i porownujemy z edi(pivot)
         ;jesli wartosc wieksza rowna pivotowi to zakoncz petle
         mov edx, [rsi + rax] ; Przeniesienie warto�ci pod adresem (rsi + rax) (aktualny element) do rejestru edx.
         cmp edx, edi     ; Por�wnanie warto�ci rejestru edx (aktualny element) z warto�ci� rejestru edi (pivot).
         jge EndiIncreaseLoop ; Skok do etykiety EndiIncreaseLoop, je�li warto�� rejestru edx jest wi�ksza lub r�wna warto�ci rejestru edi.

         jmp iIncreaseLoop ; Skok do etykiety iIncreaseLoop (powt�rzenie p�tli).
      EndiIncreaseLoop:

      jDecreaseLoop:
         ;analogiczna petla do tej z i, ale tym razem zmniejszamy koncowy indeks
         sub rbx, 4       ; Zmniejszenie warto�ci rejestru rbx o 4 (przesuni�cie na poprzedni element).

         mov edx, [rsi + rbx] ; Przeniesienie warto�ci pod adresem (rsi + rbx) (aktualny element) do rejestru edx.
         cmp edx, edi     ; Por�wnanie warto�ci rejestru edx (aktualny element) z warto�ci� rejestru edi (pivot).
         jle EndjDecreaseLoop ; Skok do etykiety EndjDecreaseLoop, je�li warto�� rejestru edx jest mniejsza lub r�wna warto�ci rejestru edi.

         jmp jDecreaseLoop ; Skok do etykiety jDecreaseLoop (powt�rzenie p�tli).
      EndjDecreaseLoop:

      cmp rax, rbx       ; Por�wnanie warto�ci rejestru rax (startowy indeks) z warto�ci� rejestru rbx (ko�cowy indeks).
      jge EndMainLoop   ; Skok do etykiety EndMainLoop, je�li warto�� rejestru rax jest wi�ksza lub r�wna warto�ci rejestru rbx.

      ;zamieniamy wartosci miejscami
      mov r8d, [rsi + rax] ; Przeniesienie warto�ci pod adresem (rsi + rax) (warto�� do zamiany) do rejestru r8d.
      mov r9d, [rsi + rbx] ; Przeniesienie warto�ci pod adresem (rsi + rbx) (warto�� do zamiany) do rejestru r9d.
      mov [rsi + rbx], r8d ; Przeniesienie warto�ci rejestru r8d (warto�� do zamiany) do adresu (rsi + rbx).
      mov [rsi + rax], r9d ; Przeniesienie warto�ci rejestru r9d (warto�� do zamiany) do adresu (rsi + rax).

      jmp MainLoop      ; Skok do etykiety MainLoop (powt�rzenie p�tli).

   EndMainLoop:

   ;wczytujemy zapisana wczesniej wartosc do pivota i rcx (tymczasowy startowy indeks)
   pop rdi             ; Wczytanie warto�ci ze stosu do rejestru rdi (ko�cowy indeks).
   pop rcx             ; Wczytanie warto�ci ze stosu do rejestru rcx (startowy indeks).
   cmp rcx, rbx        ; Por�wnanie warto�ci rejestru rcx (startowy indeks) z warto�ci� rejestru rbx (ko�cowy indeks).
   je EndSwap          ; Skok do etykiety EndSwap, je�li warto�ci s� r�wne.

   ;zamieniamy wartosci miejscami

   mov r8d, [rsi + rcx] ; Przeniesienie warto�ci pod adresem (rsi + rcx) (warto�� do zamiany) do rejestru r8d.
   mov r9d, [rsi + rbx] ; Przeniesienie warto�ci pod adresem (rsi + rbx) (warto�� do zamiany) do rejestru r9d.
   mov [rsi + rbx], r8d ; Przeniesienie warto�ci rejestru r8d (warto�� do zamiany) do adresu (rsi + rbx).
   mov [rsi + rcx], r9d ; Przeniesienie warto�ci rejestru r9d (warto�� do zamiany) do adresu (rsi + rcx).

   EndSwap:

   mov rax, rcx        ; Przeniesienie warto�ci rejestru rcx (startowy indeks) do rejestru rax.
   
   ;zapisujemy wartosc pivota i koncowego indeksu
   push rdi            ; Zapisanie warto�ci rejestru rdi (ko�cowy indeks) na stosie.
   push rbx            ; Zapisanie warto�ci rejestru rbx (ko�cowy indeks) na stosie.

   ;zmniejszamy koncowy indeks o 4 i wywolujemy funkcje rekurencyjna
   sub rbx, 4          ; Zmniejszenie warto�ci rejestru rbx o 4 (przesuni�cie na poprzedni element).
   call Recursive      ; Wywo�anie funkcji rekurencyjnej.

   ;wczytujemy startowy indeks do rax i zwiekszamy go o 1 
   pop rax             ; Wczytanie warto�ci ze stosu do rejestru rax (startowy indeks).
   add rax, 4          ; Zwi�kszenie warto�ci rejestru rax o 4 (przesuni�cie na nast�pny element).

   ;wczytujemy koncowy indeks do rbx i wywolujemy funkcje rekurencyjna
   pop rbx             ; Wczytanie warto�ci ze stosu do rejestru rbx (ko�cowy indeks).
   call Recursive      ; Wywo�anie funkcji rekurencyjnej.

   Return:
      ret              ; Powr�t z procedury.
END
