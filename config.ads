package Config is
   type Dzialanie is (dodawanie, mnozenie);
   type Tryb is (gadatliwy, spokojny);

   tryb_symulacji : constant Tryb := gadatliwy;
   pojemnosc_listy : constant Positive := 2;
   pojemnosc_magazynu : constant Positive := 3;
   liczba_pracownikow : constant Positive := 3;
   liczba_klientow : constant Natural := 1;
   liczba_sumerow : constant Positive := 2;
   liczba_iloczynerow : constant Positive := 1;
   opoznienie_prezesa : constant Duration := 3.0; --sekundy
   opoznienie_pracownikow : constant Duration := 1.0;
   opoznienie_klientow : constant Duration := 5.0;
   opoznienie_sumera : constant Duration := 0.5;
   opoznienie_iloczynera : constant Duration := 0.5;
   opoznienie_serwisanta : constant Duration := 2.0;
   psucie_sumera : constant Natural := 50;
   psucie_iloczynera : constant Natural := 50;
end Config;
