with Config;
with Ada.Numerics.Discrete_Random;

package Pracownicy is
   type Rozmiar_Losowania_Sumerow is range 1..Config.liczba_sumerow;
   type Rozmiar_Losowania_Iloczynerow is range 1..Config.liczba_iloczynerow;
   package Losowanie_Sumer is new Ada.Numerics.Discrete_Random(Rozmiar_Losowania_Sumerow);
   package Losowanie_Iloczyner is new Ada.Numerics.Discrete_Random(Rozmiar_Losowania_Iloczynerow);
   ziarenko_sumer : Losowanie_Sumer.Generator;
   ziarenko_iloczyner : Losowanie_Iloczyner.Generator;
   losowy_sumer : Rozmiar_Losowania_Sumerow;
   losowy_iloczyner : Rozmiar_Losowania_Iloczynerow;

   task type pracownik_task is
      entry ustawId(index : in Natural);
      entry koniec;
   end pracownik_task;


   type Tablica_Taskow_Typ is array (Positive range <>) of pracownik_task;
   Tablica_Taskow : Tablica_Taskow_Typ(1..Config.liczba_pracownikow);
end Pracownicy;
