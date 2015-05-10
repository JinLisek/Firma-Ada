with Ada.Numerics.Float_Random;
with Config;
with ListaZadan;

package Sumer is
   task type sumer_task is
      entry ustawId(index : in Natural);
      --entry koniec;
      entry wykonajNaMaszynie(z : in out ListaZadan.Zadanie; sukces : out Boolean);
   end sumer_task;


   type Tablica_Taskow_Typ is array (Positive range <>) of sumer_task;
   Tablica_Taskow : Tablica_Taskow_Typ(1..Config.liczba_sumerow);
end Sumer;
