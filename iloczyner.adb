with Text_IO;
with Config;
with ListaZadan;
with Serwisant;
use type Config.Dzialanie;
use type Config.Tryb;

package body Iloczyner is

   task body iloczyner_task is
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
            accept koniec;
               exit;
            or
            accept wykonajNaMaszynie (z : in out ListaZadan.Zadanie; sukces : out Boolean) do
               accept pomoz do
                  losowe_pstwo := Losowanie_Pstwo.Random(ziarenko_pstwo);
                  delay Config.opoznienie_iloczynera;
                  if Natural(losowe_pstwo) <= Config.psucie_iloczynera then
                     sukces := False;
                     zepsuta := True;
                     if Config.tryb_symulacji = Config.gadatliwy then
                        Text_IO.Put_Line("Iloczyner" & Integer'Image(id) & " sie zepsul.");
                     end if;
                  else
                     z.wynik := z.pierwArg * z.drugiArg;
                     --Text_IO.Put_Line("Iloczyner" & Integer'Image(id) & " obliczyl: " & Integer'Image(z.wynik));
                     sukces := True;
                  end if;

               end pomoz;
            end wykonajNaMaszynie;
         end select;

         if zepsuta = True then
            Serwisant.serwisant_task.napraw;
            zepsuta := False;
            if Config.tryb_symulacji = Config.gadatliwy then
               Text_IO.Put_Line("Iloczyner" & Integer'Image(id) & " zostal naprawiony przez serwisanta.");
            end if;
         end if;

      end loop PetlaTasku;
   end iloczyner_task;
end Iloczyner;
