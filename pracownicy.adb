with  Text_IO;
with Config;
with ListaZadan;
with Magazyn;
with Sumer;
with Iloczyner;
use type Config.Dzialanie;
use type Config.Tryb;

package body Pracownicy is

   task body pracownik_task is
      z : ListaZadan.Zadanie;
      sukces : Boolean;
      znak : Character;
      id : Natural;
      id_sumera : Positive;
      id_iloczynera : Positive;
   begin
      accept ustawId(index : in Natural) do
         id := index;
      end ustawId;

      Losowanie_Sumer.Reset(ziarenko_sumer);
      Losowanie_Iloczyner.Reset(ziarenko_iloczyner);

      PetlaTasku:
      loop
         select
            accept koniec;
            exit;
         or
            delay 0.01;
         end select;

         ListaZadan.lista_task.wezZListy(z, sukces);

         if sukces then
            if z.dzial = Config.dodawanie then
               znak := '+';
            else
               znak := '*';
            end if;

            if Config.tryb_symulacji = Config.gadatliwy then
               Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " pobral zadanie: "
                                & Integer'Image(z.pierwArg) & " " & znak & " " & Integer'Image(z.drugiArg));
            end if;



            sukces := False;

            if z.dzial = Config.dodawanie then
               losowy_sumer:= Losowanie_Sumer.Random(ziarenko_sumer);
               id_sumera := Positive(losowy_sumer);

               while sukces = False loop

                  select
                     Sumer.Tablica_Taskow(id_sumera).wykonajNaMaszynie(z => z, sukces => sukces);
                  or
                     delay Config.oczekiwanie_na_sumer;
                     sukces := False;
                  end select;

                  if sukces = False then
                     id_sumera := id_sumera + 1;
                     if id_sumera > Config.liczba_sumerow then
                        id_sumera := 1;
                     end if;
                  end if;

               end loop;

            else
               losowy_iloczyner:= Losowanie_Iloczyner.Random(ziarenko_iloczyner);
               id_iloczynera := Positive(losowy_iloczyner);

               while sukces = False loop


                  select
                     Iloczyner.Tablica_Taskow(id_iloczynera).pomoz;
                     if Config.tryb_symulacji = Config.gadatliwy then
                       Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " pomaga przy iloczynerze"
                                        & Integer'Image(id_iloczynera));
                     end if;
                  else
                     null;
                  end select;

                  select
                     Iloczyner.Tablica_Taskow(id_iloczynera).wykonajNaMaszynie(z => z, sukces => sukces);
                  or
                     delay Config.oczekiwanie_na_iloczyner;
                     sukces := False;
                  end select;

                  if sukces = False then
                     id_iloczynera := id_iloczynera + 1;
                     if id_iloczynera > Config.liczba_iloczynerow then
                        id_iloczynera := 1;
                     end if;
                  end if;

               end loop;
            end if;

            sukces := False;

            while sukces = False loop
               Magazyn.magazyn_task.dodajDoMagazynu(z.wynik, sukces);
               if Config.tryb_symulacji = Config.gadatliwy then
                  if sukces then
                     Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " zlozyl w magazynie: " & Integer'Image(z.pierwArg) &
                                        " " & znak & " " &Integer'Image(z.drugiArg) & " = " & Integer'Image(z.wynik));
                  else
                     null;--Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " probowal zlozyc w magazynie produkt, ale magazyn jest pelny." & Integer'Image(z.wynik));
                  end if;
               end if;
               delay Config.opoznienie_pracownikow;
            end loop;

         else
            if Config.tryb_symulacji = Config.gadatliwy then
               null;--Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " probowal wziac zadanie z listy, ale lista jest pusta.");
            end if;
         end if;

         delay Config.opoznienie_pracownikow;
      end loop PetlaTasku;
   end pracownik_task;
end Pracownicy;
