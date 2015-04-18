with  Text_IO;
with Config;
with ListaZadan;
with Magazyn;
use type Config.Dzialanie;
use type Config.Tryb;

package body Pracownicy is

   task body pracownik_task is
      z : ListaZadan.Zadanie;
      p : Integer;
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
            if z.dzial = Config.dodawanie then
               p := z.pierwArg + z.drugiArg;
               znak := '+';
            elsif z.dzial = Config.odejmowanie then
               p := z.pierwArg - z.drugiArg;
               znak := '-';
            else
               p := z.pierwArg * z.drugiArg;
               znak := '*';
            end if;

            if Config.tryb_symulacji = Config.gadatliwy then
               Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " pobral zadanie: "
                                & Integer'Image(z.pierwArg) & " " & znak & " " & Integer'Image(z.drugiArg));
            end if;

            Magazyn.magazyn_task.dodajDoMagazynu(p, sukces);
            if Config.tryb_symulacji = Config.gadatliwy then
               if sukces then
                  Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " zlozyl w magazynie: " & Integer'Image(z.pierwArg) &
                                     " " & znak & " " &Integer'Image(z.drugiArg) & " = " & Integer'Image(p));
               else
                  Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " probowal zlozyc w magazynie produkt, ale magazyn jest pelny.");
               end if;

            else
               if Config.tryb_symulacji = Config.gadatliwy then
                  Text_IO.Put_Line("Pracownik" & Integer'Image(id) & " probowal wziac zadanie z listy, ale lista jest pusta.");
               end if;
            end if;
         end if;

         delay Config.opoznienie_pracownikow;
      end loop PetlaTasku;
   end pracownik_task;
end Pracownicy;
