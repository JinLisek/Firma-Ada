with  Text_IO;
with Config;
with ListaZadan;
with Magazyn;
use type Config.Dzialanie;
use type Config.Tryb;
use ListaZadan;

package body Sumer is

   task body sumer_task is
      id : Natural;
   begin
      accept ustawId(index : in Natural) do
         id := index;
      end ustawId;




      PetlaTasku:
      loop

         select
            accept wykonajNaMaszynie (z : in out ListaZadan.Zadanie; sukces : out Boolean) do
               delay Config.opoznienie_sumera;
               z.wynik := z.pierwArg + z.drugiArg;
               sukces := True;
               Text_IO.Put_Line("Sumer" & Integer'Image(id) & " obliczyl: " & Integer'Image(z.wynik));
            end wykonajNaMaszynie;
         end select;


      end loop PetlaTasku;
   end sumer_task;
end Sumer;
