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
   begin
      accept ustawId(index : in Natural) do
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

            if z.dzial = Config.dodawanie then
               Sumer.Tablica_Taskow(1).wykonajNaMaszynie(z => z, sukces => sukces);
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
