with Config;

package Magazyn is
   pojemnosc : Positive := Config.pojemnosc_magazynu;
   ilosc : Natural := 0;
   produkt : Integer;

   type Tablica_Produktow_Type is array (Positive range <>) of Integer;

   task magazyn_task is
      entry koniec;
      entry dodajDoMagazynu(p : in Integer; sukces : out Boolean);
      entry wezZMagazynu(p : out Integer; sukces : out Boolean);
   end magazyn_task;

end Magazyn;
