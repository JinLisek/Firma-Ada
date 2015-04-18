with Text_IO;
with Config;
use type Config.Tryb;

with ListaZadan;
with Magazyn;
with Prezes;
with Pracownicy;
with Klienci;

package body Interfejs is
   znak : Character;

   procedure Wypisz_Polecenia is
   begin
      Text_IO.Put_Line("l - lista zadan");
      Text_IO.Put_Line("m - magazyn");
      Text_IO.Put_Line("k - koniec");
   end Wypisz_Polecenia;


   task body interfejs_task is
      index : Natural := 1;
   begin
      for t of Pracownicy.Tablica_Taskow loop
         t.ustawId(index);
         index := index + 1;
      end loop;

      index := 1;

      for t of Klienci.Tablica_Taskow loop
         t.ustawId(index);
         index := index + 1;
      end loop;

      if Config.tryb_symulacji = Config.spokojny then
         Text_IO.Put_Line("--TRYB SPOKOJNY--");
         PetlaTasku:
         loop
            Wypisz_Polecenia;
            Text_IO.get(znak);

            if znak = 'l' then
               Text_IO.Put_Line("Ilosc zadan na liscie to" & Positive'Image(ListaZadan.ilosc));
            elsif znak = 'm' then
               Text_IO.Put_Line("Ilosc produktow w magazynie to" & Positive'Image(Magazyn.ilosc));
            elsif znak = 'k' then

               for t of Pracownicy.Tablica_Taskow loop
                  t.koniec;
               end loop;

               for t of Klienci.Tablica_Taskow loop
                  t.koniec;
               end loop;

               Prezes.prezes_task.koniec;
               ListaZadan.lista_task.koniec;
               Magazyn.magazyn_task.koniec;

               exit;
            end if;
         end loop PetlaTasku;
      end if;
   end interfejs_task;
end Interfejs;
