with Ada.Numerics.Discrete_Random;
with Config;
use type Config.Dzialanie;

package Prezes is
   liczba1 : Integer;
   liczba2 : Integer;
   dzialanie : Config.Dzialanie;
   type Rozmiar_Losowania_Liczby is range -100..100;
   type Rozmiar_Losowania_Dzialania is range 1..3;
   package Losowanie_Liczba is new Ada.Numerics.Discrete_Random(Rozmiar_Losowania_Liczby);
   package Losowanie_Dzialanie is new Ada.Numerics.Discrete_Random(Rozmiar_Losowania_Dzialania);
   ziarenko_liczba : Losowanie_Liczba.Generator;
   ziarenko_dzialanie : Losowanie_Dzialanie.Generator;
   losowa_liczba : Rozmiar_Losowania_Liczby;
   losowe_dzialanie : Rozmiar_Losowania_Dzialania;

   task prezes_task is
      entry koniec;
   end prezes_task;

end Prezes;
