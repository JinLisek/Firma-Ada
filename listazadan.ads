with Config;

package ListaZadan is
   pojemnosc : Positive := Config.pojemnosc_listy;
   ilosc : Natural := 0;

   type Zadanie is record
      pierwArg: Integer;
      drugiArg : Integer;
      dzial : Config.Dzialanie;
      wynik : Integer;
   end record;

   type Tablica_Zadan_Typ is array (Positive range <>) of Zadanie;


   task lista_task is
      entry koniec;
      entry dodajDoListy(z : in Zadanie; sukces : out Boolean);
      entry wezZListy(z : out Zadanie; sukces : out Boolean);
   end lista_task;

end ListaZadan;
