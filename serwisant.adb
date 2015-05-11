package body Serwisant is

   task body serwisant_task is
   begin
      PetlaTasku:
      loop
         select
            accept koniec;
            exit;
         or
            accept napraw do
               Delay Config.opoznienie_serwisanta;
            end napraw;

         end select;

      end loop PetlaTasku;

   end serwisant_task;

end Serwisant;
