with Config;

package Pracownicy is
   task type pracownik_task is
      entry ustawId(index : in Natural);
      entry koniec;
   end pracownik_task;


   type Tablica_Taskow_Typ is array (Positive range <>) of pracownik_task;
   Tablica_Taskow : Tablica_Taskow_Typ(1..Config.liczba_pracownikow);
end Pracownicy;
