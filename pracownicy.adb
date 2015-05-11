with  Text_IO;
with Config;
with ListaZadan;
with Magazyn;
with Sumer;
use type Config.Dzialanie;
use type Config.Tryb;

package body Pracownicy is

   task body pracownik_task is
      z : ListaZadan.Zadanie;
      sukces : Boolean;
      znak : Character;
      id : Natural;
      id_sumera : Positive;
   begin
      accept ustawId(index : in Natural) do
         id := index;
      end ustawId;

      Losowanie_Sumer.Reset(ziarenko_sumer);


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

            if z.dzial = Config.odejmowanie then
               z.drugiArg := z.drugiArg * (-1);
               z.dzial := Config.dodawanie;
            end if;

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
                  Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " idzie do sumera" & Positive'Image(Positive(losowy_sumer)));
                  Sumer.Tablica_Taskow(Integer(losowy_sumer)).wykonajNaMaszynie(z => z, sukces => sukces);
                  if sukces = False then
                     id_sumera := id_sumera + 1;
                     Text_IO.Put_Line(Positive'Image(id_sumera) & " " & Positive'Image(Config.liczba_sumerow));
                     if id_sumera > Config.liczba_sumerow then
                        Text_IO.Put_Line("r");
                        losowy_sumer := 1;
                        id_sumera := 1;
                     else
                        losowy_sumer := losowy_sumer + 1;
                     end if;
                     Text_IO.Put_Line(Positive'Image(Integer(losowy_sumer)));
                  end if;

               end loop;

            else
               z.wynik := z.pierwArg * z.drugiArg;
            end if;

            sukces := False;

            while sukces = False loop
               Magazyn.magazyn_task.dodajDoMagazynu(z.wynik, sukces);
               if Config.tryb_symulacji = Config.gadatliwy then
                  if sukces then
                     Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " zlozyl w magazynie: " & Integer'Image(z.pierwArg) &
                                        " " & znak & " " &Integer'Image(z.drugiArg) & " = " & Integer'Image(z.wynik));
                  else
                     Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " probowal zlozyc w magazynie produkt, ale magazyn jest pelny." & Integer'Image(z.wynik));
                  end if;
               end if;
               delay Config.opoznienie_pracownikow;
            end loop;

         else
            if Config.tryb_symulacji = Config.gadatliwy then
               Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " probowal wziac zadanie z listy, ale lista jest pusta.");
            end if;
         end if;

         delay Config.opoznienie_pracownikow;
      end loop PetlaTasku;
   end pracownik_task;
end Pracownicy;
