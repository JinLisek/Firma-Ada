with Text_IO;
with Config;
with ListaZadan;
with Magazyn;
with Serwisant;
use type Config.Dzialanie;
use type Config.Tryb;
use ListaZadan;

package body Sumer is

   task body sumer_task is
      id : Natural;
      zepsuta : Boolean;
   begin
      accept ustawId(index : in Natural) do
         id := index;
      end ustawId;

      zepsuta := False;

      Losowanie_Pstwo.Reset(ziarenko_pstwo);

      PetlaTasku:
      loop

         select
            accept wykonajNaMaszynie (z : in out ListaZadan.Zadanie; sukces : out Boolean) do
               losowe_pstwo := Losowanie_Pstwo.Random(ziarenko_pstwo);

               delay Config.opoznienie_sumera;

               if Natural(losowe_pstwo) <= Config.psucie_sumera then
                  sukces := False;
                  zepsuta := True;
                  Text_IO.Put_Line("Sumer" & Integer'Image(id) & " sie zepsul.");
               else
                  z.wynik := z.pierwArg + z.drugiArg;
                  Text_IO.Put_Line("Sumer" & Integer'Image(id) & " obliczyl: " & Integer'Image(z.wynik));
                  sukces := True;
               end if;

            end wykonajNaMaszynie;
         end select;

         if zepsuta = True then
            Serwisant.serwisant_task.napraw;
            zepsuta := False;
            Text_IO.Put_Line("Sumer" & Integer'Image(id) & " zostal naprawiony przez serwisanta.");
         end if;

      end loop PetlaTasku;
   end sumer_task;
end Sumer;
