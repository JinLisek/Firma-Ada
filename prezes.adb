with Text_IO;
with ListaZadan;
with Config;
use type Config.Tryb;

package body Prezes is

   task body prezes_task is
      z : ListaZadan.Zadanie;
      sukces : Boolean;
      znak : Character;
   begin
      Losowanie_Liczba.Reset(ziarenko_liczba);
      Losowanie_dzialanie.Reset(ziarenko_dzialanie);

      PetlaTasku:
      loop
         select
            accept koniec;
            exit;
         else
            losowa_liczba := Losowanie_Liczba.Random(ziarenko_liczba);
            liczba1 := Integer(losowa_liczba);
            losowa_liczba := Losowanie_Liczba.Random(ziarenko_liczba);
            liczba2 := Integer(losowa_liczba);

            losowe_dzialanie := Losowanie_Dzialanie.Random(ziarenko_dzialanie);
            if losowe_dzialanie = 1 then
               dzialanie := Config.dodawanie;
            else
               dzialanie := Config.mnozenie;
            end if;

            z := (liczba1, liczba2, dzialanie, 0);

            if z.dzial = Config.dodawanie then
               znak := '+';
            else
               znak := '*';
            end if;

            sukces := False;

            while sukces = False loop
               ListaZadan.lista_task.dodajDoListy(z, sukces);

               if Config.tryb_symulacji = Config.gadatliwy then
                  if sukces then
                     Text_IO.Put_Line("Prezes dodal zadanie: " & Integer'Image(z.pierwArg) & " " & znak & " " & Integer'Image(z.drugiArg));
                  else
                     null;--Text_IO.Put_Line("Prezes probowal dodac zadanie do listy, ale jest ona pelna." & Integer'Image(z.pierwArg) & " " & znak & " " & Integer'Image(z.drugiArg));
                  end if;
               end if;
               delay Config.opoznienie_prezesa;
            end loop;

         end select;
      end loop PetlaTasku;
   end prezes_task;
end Prezes;

