with Config;

package Sumer is
   task type sumer_task is
      entry ustawId(index : in Natural);
      entry koniec;
   end sumer_task;


   type Tablica_Taskow_Typ is array (Positive range <>) of sumer_task;
   Tablica_Taskow : Tablica_Taskow_Typ(1..Config.liczba_sumerow);
end Sumer;
