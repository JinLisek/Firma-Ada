package Config is
   type Dzialanie is (dodawanie, odejmowanie, mnozenie);
   type Tryb is (gadatliwy, spokojny);
   tryb_symulacji : constant Tryb := gadatliwy;
   pojemnosc_listy : constant Positive := 10;
   pojemnosc_magazynu : constant Positive := 10;
   liczba_pracownikow : constant Positive := 3;
   liczba_klientow : constant Natural := 3;
   opoznienie_prezesa : constant Duration := 0.5; --sekundy
   opoznienie_pracownikow : constant Duration := 3.0;
   opoznienie_klientow : constant Duration := 5.0;
end Config;
