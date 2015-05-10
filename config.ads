package Config is
   type Dzialanie is (dodawanie, odejmowanie, mnozenie);
   type Tryb is (gadatliwy, spokojny);

   tryb_symulacji : constant Tryb := gadatliwy;
   pojemnosc_listy : constant Positive := 2;
   pojemnosc_magazynu : constant Positive := 3;
   liczba_pracownikow : constant Positive := 3;
   liczba_klientow : constant Natural := 1;
   liczba_sumerow : constant Positive := 2;
   opoznienie_prezesa : constant Duration := 3.0; --sekundy
   opoznienie_pracownikow : constant Duration := 3.0;
   opoznienie_klientow : constant Duration := 5.0;
   opoznienie_sumera : constant Duration := 0.5;
   psucie_sumera : constant Float := 1.0;
end Config;
