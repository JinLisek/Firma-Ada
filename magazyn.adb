package body Magazyn is
   Tablica_Produktow : Tablica_Produktow_Type(1..pojemnosc);

   task body magazyn_task is
   begin
      PetlaTasku:
      loop
         select
            accept koniec;
            exit;
         or
            when ilosc /= pojemnosc =>
               accept dodajDoMagazynu (p : in Integer; sukces : out Boolean) do
                  Tablica_Produktow(ilosc + 1) := p;
                  sukces := True;
               end dodajDoMagazynu;

               ilosc := ilosc + 1;
         or
            when ilosc = pojemnosc =>
               accept dodajDoMagazynu (p : in Integer; sukces : out Boolean) do
                  sukces := False;
               end dodajDoMagazynu;
         or
            when ilosc /= 0 =>
               accept wezZMagazynu (p : out Integer; sukces : out Boolean) do
                  p:= Tablica_Produktow(ilosc);
                  sukces := True;
               end wezZMagazynu;

               ilosc := ilosc - 1;
         or
            when ilosc = 0 =>
               accept wezZMagazynu (p : out Integer; sukces : out Boolean) do
                  p := (0);
                  sukces := False;

               end wezZMagazynu;
         end select;

      end loop PetlaTasku;

   end magazyn_task;

end Magazyn;
