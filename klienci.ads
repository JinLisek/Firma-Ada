with Config;

package Klienci is
   task type klient_task is
      entry ustawId(index : Natural);
      entry koniec;
   end klient_task;

   type Tablica_Taskow_Typ is array (Positive range <>) of klient_task;
   Tablica_Taskow : Tablica_Taskow_Typ(1..Config.liczba_klientow);
end Klienci;
