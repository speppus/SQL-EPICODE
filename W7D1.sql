USE AdventureWorksDW;
select Productkey,ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag from dimproduct;
#Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.
select Productkey,
ProductAlternateKey,
 EnglishProductName, 
 Color, 
 StandardCost,
 FinishedGoodsFlag
 from dimproduct;
where FinishedGoodsFlag=1;


#Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello ProductAlternateKey) comincia con FR oppure BK. Il result set deve contenere il codice prodotto ProductKey), il modello, il nome del prodotto, il costo standard StandardCost) e il prezzo di listino ListPrice).


select Productkey,
ProductAlternateKey,
StandardCost,
ListPrice
 from dimproduct
 where ProductAlternateKey
 like  "FR%" or "BK%";
 
 #Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dallʼazienda ListPrice - StandardCost)
 
 select Productkey,
ProductAlternateKey,
StandardCost,
ListPrice, 
(ListPrice-StandardCost) AS guadagno
 from dimproduct
 where ProductAlternateKey like  "FR%" or "BK%";
 
 #Scrivi unʼaltra query al fine di esporre lʼelenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.
 
 select  FinishedGoodsFlag,Productkey,ListPrice
 from dimproduct
 where listprice between 1000 and 2000;
 
#Esplora la tabella degli impiegati aziendali DimEmployee)

select * 
from dimemployee;

#Esponi, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti. Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.


select FirstName,LastName
from dimemployee
where SalesPersonFlag =1;

#Interroga la tabella delle vendite FactResellerSales). 
#Esponi in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna transazione il profitto SalesAmount - TotalProductCost).
 
 
SELECT OrderDate,
ProductKey,
(SalesAmount-TotalProductCost) AS markup
FROM factresellersales
WHERE DueDate >="2020-01-01" AND Productkey IN (597, 598, 477, 214);

#Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?
# LA PRIMARY KEY E UNICA E MAI NULLA CIOE NON PUO AVERE UN VALORE NULL
#PER VERIFICARE CHE PRODUCT KEY SIA UNA PK DOBBIAMO
SELECT ProductKey
from dimproduct; # ha 606 righe ora verifichiamo difersamente

select distinct ProductKey
from dimproduct
where ProductKey is null; #verifichiamo se ci sono valori NULL
# 3 METODO CON GROUP BY
SELECT ProductKey, count(*)
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(*) > 1; # INFATTI ABBIAMO 0 RIGHE

#Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
SELECT SalesOrderNumber,SalesOrderLineNumber, count(*)
from factresellersales
group by  SalesOrderNumber,SalesOrderLineNumber
having count(*) >1;

#Conta il numero transazioni SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
select  count(SalesOrderLineNumber) as conteggio_transazioni
from factresellersales
where OrderDate >" 2020-01-01";

select  count(SalesOrderLineNumber) as conteggio_transazioni,OrderDate
from factresellersales
where OrderDate >=" 2020-01-01"
group by OrderDate;

#Calcola il fatturato totale FactResellerSales.SalesAmount), la quantità totale venduta FactResellerSales.OrderQuantity) 
#e il prezzo medio di vendita FactResellerSales.UnitPrice) per prodotto DimProduct) a partire dal 1 Gennaio 2020. 
#Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita.
# I campi in output devono essere parlanti!

select p.EnglishProductName, sum(r.SalesAmount), sum(r.OrderQuantity),avg(r.UnitPrice) as prezzo_medio
from factresellersales r
inner join  dimproduct p
on r.ProductKey = p.ProductKey
where OrderDate >= "2020-01-01"
group by p.EnglishProductName;

#Calcola il fatturato totale FactResellerSales.SalesAmount) e la quantità totale venduta FactResellerSales.OrderQuantity) per Categoria prodotto DimProductCategory).
# Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!

select pc.EnglishProductCategoryName as categoria , sum(r.OrderQuantity) as quantita_totale, sum(r.SalesAmount) as fatturato_totale, avg(UnitPrice) as PrezzoMedio
from factresellersales r
inner join dimproduct p
on r.ProductKey = p.ProductKey
inner join dimproductsubcategory sc
on p.ProductSubcategoryKey = sc.ProductSubcategoryKey
inner join dimproductcategory pc
on sc.ProductCategoryKey = pc.ProductCategoryKey
group by pc.EnglishProductCategoryName;

#Calcola il fatturato totale per area città DimGeography.City) realizzato a partire dal 1 Gennaio 2020.
# Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.

select g.City città, sum(SalesAmount) fatturatoTotale
from dimgeography g 
inner join dimreseller r
on g.GeographyKey = r.GeographyKey
inner join factresellersales fr
on fr.ResellerKey = r.ResellerKey
where fr.OrderDate >= '2020-01-01'
group by g.City
having sum(SalesAmount) >= '60000';














