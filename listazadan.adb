with Text_IO;

package body ListaZadan is
   Tablica_Zadan : Tablica_Zadan_Typ(1..pojemnosc);

   task body lista_task is
   begin

      PetlaTasku:
      loop
         select
            accept koniec;
            exit;
         or
            when ilosc /= pojemnosc =>
               accept dodajDoListy (z : in Zadanie; sukces : out Boolean) do

                  Tablica_Zadan(ilosc + 1) := z;
                  sukces := true;

               end dodajDoListy;

               ilosc := ilosc + 1;
         or
            when ilosc = pojemnosc =>
               accept dodajDoListy (z : in Zadanie; sukces : out Boolean) do

                  sukces := false;

               end dodajDoListy;
         or
            when ilosc /= 0 =>
               accept wezZListy (z : out Zadanie; sukces : out Boolean) do
                  z := Tablica_Zadan(ilosc);
                  sukces := True;

               end wezZListy;

               ilosc := ilosc - 1;
         or
            when ilosc = 0 =>
               accept wezZListy (z : out Zadanie; sukces : out Boolean) do
                  z:= (0, 0, Config.dodawanie, 0);
                  sukces := False;
               end wezZListy;

         end select;
      end loop PetlaTasku;
   end lista_task;
end ListaZadan;
