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
            elsif losowe_dzialanie = 2 then
               dzialanie := Config.odejmowanie;
            else
               dzialanie := Config.mnozenie;
            end if;

            if liczba2 < 0 then
               if dzialanie = Config.dodawanie then
                  liczba2 := liczba2 * (-1);
                  dzialanie := Config.odejmowanie;
               elsif dzialanie = Config.odejmowanie then
                  liczba2 := liczba2 * (-1);
                  dzialanie := Config.dodawanie;
               end if;
            end if;

            z := (liczba1, liczba2, dzialanie);
            ListaZadan.lista_task.dodajDoListy(z, sukces);

            if Config.tryb_symulacji = Config.gadatliwy then
               if sukces then
                  if z.dzial = Config.dodawanie then
                     znak := '+';
                  elsif
                    z.dzial = Config.odejmowanie then
                     znak := '-';
                  else
                     znak := '*';
                  end if;

                  Text_IO.Put_Line("Prezes dodal zadanie: " & Integer'Image(z.pierwArg) & " " & znak & " " & Integer'Image(z.drugiArg));
               else
                  Text_IO.Put_Line("Prezes probowal dodac zadanie do listy, ale jest ona pelna.");
               end if;
            end if;
            delay Config.opoznienie_prezesa;

         end select;
      end loop PetlaTasku;
   end prezes_task;
end Prezes;

