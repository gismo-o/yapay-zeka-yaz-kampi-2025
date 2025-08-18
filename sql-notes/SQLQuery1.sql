select * from Customers
--tüm tabloyu getir
select companyname from Customers
--tablodan companyname sütununu getir
select CustomerID,country from customers
--CustomerID ve country sütunlarýný getir


--soru 1: tüm müþterilerin listesini al
select * from Customers

--soru 2: almanyadaki müþterileri listeleyin
select * from Customers where Country='Germany'

--soru 3: mecvut ürünlerin adlarýný ve fiyatlarýný listele
select ProductName,UnitPrice from Products

--soru 4: sadece þirket isimlerini listele
select CompanyName from Customers

--soru 5: ürünleri fiyata göre azalan sýrayla listele
--desc: büyükten küçüðe sýralar
--asc : küçükten büyüðe sýralar. #default
select * from Products ORDER BY UnitPrice desc

--soru 6: sipariþ tablosunda customer ID'leri benzersiz olarak getir
select * from Orders
select distinct CustomerID from orders

--soru 7: telefon no ve fax belirtilmiþ müþterileri listeleyin
select CustomerID, Phone, Fax from Customers
where Fax is not null --null olanlarý getirmez

select CustomerID, Phone, Fax from Customers
where Fax is null --Fax deðerleri eksik olanlarý getir

--soru 8: ilk 10 ürünü isme göre listele
select * from Products
order by ProductName --isimleri A-Z sýralar

select top 10 ProductName from Products order by ProductName
--ProductName sütununun ilk 10ununu getirir (ProductName sütununa göre A-Z sýralý)

--soru 9: stokta olmayan ürünleri bul
select * from Products where UnitsInStock = 0
--stokta olan ürünleri bul
select * from Products where UnitPrice <> 0

--soru 10: ürün fiyatlarýnýn ortalama fiyattan yüksek olanlarý bul
select * from Products

select ProductName, UnitPrice FROM Products
where UnitPrice > (select avg(unitPrice) FROM Products)
--ortalama üzerine çýkan ürünleri bulduk

--soru 11: 20 adetten fazla stokta olan ürünleri göster
SELECT * from Products where UnitsInStock > 20

--soru 12: gönderici firmalarý alfabetik sýrayla listele 
select * from Suppliers

select * from Suppliers order by ContactName asc

--soru 13: her bir sipariþin ürün adedini listeleyin
select OrderID,Count(Quantity) from [Order Details]
group by OrderID
--herhangi bir matematiksel iþlemin yanýnda bir kriter varsa group by yapmak zorunludur

select OrderID,sum(Quantity) as SalesCount from [Order Details]
group by OrderID --her sipariþin ürün satýþ adedini listeleyiniz
--Aggregate Functions (toplama fonk.)olduðu ve yanýnda kriter olduðu için group by kullanmalýyýz


select OrderID,sum(Quantity) as SalesCount from [Order Details]
group by OrderID having sum(Quantity) > 20 --satýþ adedi 20'den büyük olanlarý getir
--having filtreleme görevi yapar ancak group by'dan sonra

select OrderID,sum(Quantity) as SalesCount from [Order Details]
where OrderID=10748
group by OrderID having sum(Quantity) > 20 --where ve having birlikte kullanýmý


select OrderID,sum(Quantity) as SalesCount from [Order Details]
group by OrderID 
having OrderID = 10748 --having where'in rolünü çalabilir
--sýralama her zaman þöyle olmalýdýr:
-- where - group by- having


--soru 14: her çalýþanýn aldýðý sipariþ sayýsýný bulun
select E.FirstName, E.LastName,
count(O.OrderID) as SiparisAdedi from Employees E
inner join Orders O on E.EmployeeID = O.EmployeeID
group by E.FirstName, E.LastName
--matematiksel iþlem + kriter var group by kullan
--burda iki kümedeki eþleþen verilerle ilgileniyoruz, kesiþimlerini alýyoruz


--soru 15: ürünleri kategoriye göre gruplayýn ve ortalama fiyatlarýný hesapla
select C.CategoryName, P.ProductName,
AVG (P.UnitPrice) as OrtalamaFiyat from Categories C
left join Products P on C.CategoryID=P.CategoryID
GROUP BY C.CategoryName, P.ProductName


--soru 16: her sipariþ için, sipariþ sýrasýný tarihe göre belirleyin
-- her sipariþi sýralayýp 3 farklý sýralama metodu ile sýra numarasý verir.
select CustomerID, OrderID, OrderDate,
ROW_NUMBER() over (order by OrderDate) as OrderSeq_ROW,
RANK() OVER (order by OrderDate) as OrderSeq_RANK,
DENSE_RANK() over (ORDER BY OrderDate) as OrderSeq_DENSE_RANK
FROM Orders
--ROW_NUMBER() -> Her satýra benzersiz bir sýra numarasý verir. Ayný OrderDate olsa bile farklý numara alýr.
--RANK() -> Ayný OrderDate olanlara ayný sýra numarasýný verir ama sonraki sýra atlanýr.
--DENSE_RANK() -> Ayný OrderDate olanlara yine ayný sýra verilir ama atlama olmaz

/*
OVER, SQL'de gruplamadan satýr bazlý analiz yapmayý saðlar. 
Özellikle sýralý iþlem, kümülatif hesaplama gibi senaryolarda çok güçlüdür.

OVER Neden Kullanýlýr?
- TOPLU iþlemler yapar ama satýrlarý kaybetmez.

-Satýr bazlý hesaplamalar yaparken gruplama (GROUP BY) gibi satýrlarý birleþtirmez.

-Analitik fonksiyonlarla birlikte sýralama, sýralý numaralandýrma, kümülatif toplam gibi iþlemleri satýr düzeyinde yapmaný saðlar.

*/


/*
date                   row_number  rank   dense_rank
1996-07-04 00:00:00.000		1		1		1
1996-07-05 00:00:00.000		2		2		2
1996-07-08 00:00:00.000	*	3		3		3
1996-07-08 00:00:00.000	*	4		3		3
1996-07-09 00:00:00.000		5		5		4
1996-07-10 00:00:00.000		6		6		5
*/



--soru 17: CASE WHEN ile ürün stok durumunu metinsel olarak göster
-- case when: koþullu gruplama
select ProductName, UnitsInStock,
CASE 
when UnitsInStock = 0 then 'stokta yok'
when UnitsInStock < 20 then 'az stok'
else 'yeterli stok'
end as StokDurumu
from Products;



-- soru 18: her bir müþterinin en güncel yaptýðý alýþveriþ
select
CustomerID, OrderID, OrderDate, 
ROW_NUMBER() over (partition by CustomerID order by OrderDate desc) 
as OrderRank
from Orders
order by CustomerID, OrderRank

--müþteri no'larýný gruplayarak bölüyo, no atamasý yapýyo ve tekilleþtiriyo
--PARTITION BY CustomerID: Her müþteriyi ayrý bir grup olarak ele alýyor.
/*
order date			     OrderRank
1998-04-09 00:00:00.000		1
1998-03-16 00:00:00.000		2
1998-01-15 00:00:00.000		3
1997-10-13 00:00:00.000		4
1997-10-03 00:00:00.000		5
1997-08-25 00:00:00.000		6
1998-03-04 00:00:00.000		1
1997-11-28 00:00:00.000		2
1997-08-08 00:00:00.000		3
1996-09-18 00:00:00.000		4
1998-01-28 00:00:00.000		1
1997-09-25 00:00:00.000		2
*/

