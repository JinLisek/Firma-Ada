with Text_IO;
with Magazyn;
with Config;
use type Config.Tryb;

package body Klienci is

   task body klient_task is
      p : Integer;
      sukces : Boolean;
      id : Natural;
   begin
      accept ustawId (index : in Natural) do
         id := index;
      end ustawId;

      PetlaTasku:
      loop
         select
            accept koniec;
            exit;
         or
            delay 0.01;
         end select;

         Magazyn.magazyn_task.wezZMagazynu(p, sukces);

         if Config.tryb_symulacji = Config.gadatliwy then
            if sukces then
               Text_IO.Put_Line("Klient" & Integer'Image(id) & " wzial z magazynu produkt:" & Integer'Image(p));
            else
               Text_IO.Put_Line("Klient" & integer'Image(id) & " probowal wziac z magazynu produkt, ale magazyn jest pusty.");
            end if;
         end if;

         delay Config.opoznienie_klientow;
      end loop PetlaTasku;
   end klient_task;
end Klienci;
