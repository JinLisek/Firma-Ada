with Ada.Numerics.Discrete_Random;
with Config;
with ListaZadan;

package Sumer is

   type Rozmiar_Losowania_Pstwa is range 1..100;
   package Losowanie_Pstwo is new Ada.Numerics.Discrete_Random(Rozmiar_Losowania_Pstwa);
   ziarenko_pstwo : Losowanie_Pstwo.Generator;
   losowe_pstwo : Rozmiar_Losowania_Pstwa;

   task type sumer_task is
      entry ustawId(index : in Natural);
      --entry koniec;
      entry wykonajNaMaszynie(z : in out ListaZadan.Zadanie; sukces : out Boolean);
   end sumer_task;


   type Tablica_Taskow_Typ is array (Positive range <>) of sumer_task;
   Tablica_Taskow : Tablica_Taskow_Typ(1..Config.liczba_sumerow);
end Sumer;
