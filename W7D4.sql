#Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa. 
#La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome prodotto, il nome della sottocategoria associata e il nome della categoria associata.
CREATE VIEW Product AS(
    SELECT 
        p.EnglishProductName nome_prodotto,
        sb.EnglishProductSubcategoryName name_sottocategoria,
        pc.EnglishProductCategoryName name_categoria
    FROM
        dimproduct p
            INNER JOIN
        dimproductsubcategory sb ON p.ProductSubcategoryKey = sb.ProductSubcategoryKey
            INNER JOIN
        dimproductcategory pc ON sb.ProductCategoryKey = pc.ProductCategoryKey);
          
        
        #Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa. 
        #La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome del reseller, il nome della città e il nome della regione.
        create view Relesser as ( 
        select r.ResellerName, g.City citta,g.EnglishCountryRegionName regione
        from dimreseller r
        join dimgeography g
        on r.GeographyKey = g.GeographyKey
        group by g.EnglishCountryRegionName,g.City);
        
        #Crea una vista denominata Sales che deve restituire la data dellʼordine, il codice documento, la riga di corpo del documento, la quantità venduta, lʼimporto totale e il profitto.
        
        CREATE VIEW sales AS(
 SELECT 
        fc.OrderDate data_ordine,
        fc.SalesOrderNumber codice_documento,
        fc.SalesOrderLineNumber riga_documento,
        fc.OrderQuantity quantita,
        fc.SalesAmount importo_totale,
        (fc.SalesAmount - fc.TotalProductCost) profitto
    FROM
      factsales fc);
      
      
        
