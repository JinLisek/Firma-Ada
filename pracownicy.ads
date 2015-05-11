with Config;
with Ada.Numerics.Discrete_Random;

package Pracownicy is
   type Rozmiar_Losowania_Sumerow is range 1..Config.liczba_sumerow;
   package Losowanie_Sumer is new Ada.Numerics.Discrete_Random(Rozmiar_Losowania_Sumerow);
   ziarenko_sumer : Losowanie_Sumer.Generator;
   losowy_sumer : Rozmiar_Losowania_Sumerow;

   task type pracownik_task is
      entry ustawId(index : in Natural);
      entry koniec;
   end pracownik_task;


   type Tablica_Taskow_Typ is array (Positive range <>) of pracownik_task;
   Tablica_Taskow : Tablica_Taskow_Typ(1..Config.liczba_pracownikow);
end Pracownicy;
