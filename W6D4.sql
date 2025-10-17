#Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria DimProduct, DimProductSubcategory).
SELECT 
    p.ProductKey,
  p.EnglishProductName,
   p.ProductSubcategoryKey,
    c.EnglishProductSubcategoryName
FROM
    dimproduct p
        INNER JOIN
    dimproductsubcategory c  ON  p.ProductSubcategoryKey= c.ProductSubcategoryKey;
    
    #Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria DimProduct, DimProductSubcategory, DimProductCategory).
    SELECT 
    sc.EnglishProductSubcategoryName,
    c.ProductCategoryKey,
     sc.ProductSubcategoryKey,
    sc.EnglishProductSubcategoryName,
    p.ProductKey,
    c.EnglishProductCategoryName
FROM
    dimproduct p
        INNER JOIN
    dimproductsubcategory sc ON   p.ProductSubCategoryKey = sc.ProductSubcategoryKey
    INNER JOIN dimproductcategory c  ON c.ProductCategoryKey=sc.ProductCategoryKey;
    
    #Esponi lʼelenco dei soli prodotti venduti DimProduct, FactResellerSales). 
    
    select p.EnglishProductName,p.ProductKey,r.OrderQuantity,r.SalesAmount,r.ProductKey
    from dimproduct p
    inner join factresellersales r on p.ProductKey=r.ProductKey;
    
    #Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1.
    select ProductKey,EnglishProductName,FinishedGoodsFlag
    from dimproduct
    where FinishedGoodsFlag=0;
    
    #Esponi lʼelenco delle transazioni di vendita FactResellerSales) indicando anche il nome del prodotto venduto DimProduct)
    select p.ProductKey,p.EnglishProductName,r.ProductKey,r.OrderQuantity,r.UnitPrice,r.SalesAmount,r.DueDate
    from dimproduct p
    inner join factresellersales r on p.ProductKey=r.ProductKey;
    
    #Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.
    select p.ProductKey,p.ProductSubcategoryKey,p.EnglishProductName,s.SalesAmount,s.OrderDate
    from factresellersales s
    inner join dimproduct p on s.ProductKey = p.ProductKey
   inner join dimproductsubcategory sc  on sc.ProductSubcategoryKey = p.ProductSubcategoryKey
   inner join dimproductcategory c on c.ProductCategoryKey = sc.ProductCategoryKey;
   
   #Esplora la tabella DimReseller.
   select * from dimreseller;
   #Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 
   select  r.ResellerKey,r.GeographyKey,r.ResellerName,g.City
   from dimreseller r
   inner join dimgeography g on g.GeographyKey = r.GeographyKey;
   
   #Esponi lʼelenco delle transazioni di vendita.
   #Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
   #Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.
   select fc.SalesOrderNumber,fc.SalesOrderLineNumber,fc.OrderDate,fc.UnitPrice,fc.OrderQuantity,fc.TotalProductCost,p.EnglishProductName,c.EnglishProductCategoryName,r.ResellerName,g.City
   from factsales fc
   inner join dimproduct p on fc.ProductKey = p.ProductKey
   inner join dimproductsubcategory sb on p.ProductSubcategoryKey= sb.ProductSubcategoryKey
   inner join dimproductcategory c on sb.ProductCategoryKey = c.ProductCategoryKey
   inner join  dimreseller r on fc.ResellerKey = r.ResellerKey
   inner join dimgeography g on g.GeographyKey = r.GeographyKey;
   
   
    
    
    
    