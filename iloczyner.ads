with Ada.Numerics.Discrete_Random;
with Config;
with ListaZadan;

package Iloczyner is

   type Rozmiar_Losowania_Pstwa is range 1..100;
   package Losowanie_Pstwo is new Ada.Numerics.Discrete_Random(Rozmiar_Losowania_Pstwa);
   ziarenko_pstwo : Losowanie_Pstwo.Generator;
   losowe_pstwo : Rozmiar_Losowania_Pstwa;

   task type iloczyner_task is
      entry ustawId(index : in Natural);
      entry koniec;
      entry wykonajNaMaszynie(z : in out ListaZadan.Zadanie; sukces : out Boolean);
      entry pomoz;
   end iloczyner_task;


   type Tablica_Taskow_Typ is array (Positive range <>) of iloczyner_task;
   Tablica_Taskow : Tablica_Taskow_Typ(1..Config.liczba_iloczynerow);
end Iloczyner;
