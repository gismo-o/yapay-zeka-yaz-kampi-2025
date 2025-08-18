select * from Customers
--t�m tabloyu getir
select companyname from Customers
--tablodan companyname s�tununu getir
select CustomerID,country from customers
--CustomerID ve country s�tunlar�n� getir


--soru 1: t�m m��terilerin listesini al
select * from Customers

--soru 2: almanyadaki m��terileri listeleyin
select * from Customers where Country='Germany'

--soru 3: mecvut �r�nlerin adlar�n� ve fiyatlar�n� listele
select ProductName,UnitPrice from Products

--soru 4: sadece �irket isimlerini listele
select CompanyName from Customers

--soru 5: �r�nleri fiyata g�re azalan s�rayla listele
--desc: b�y�kten k����e s�ralar
--asc : k���kten b�y��e s�ralar. #default
select * from Products ORDER BY UnitPrice desc

--soru 6: sipari� tablosunda customer ID'leri benzersiz olarak getir
select * from Orders
select distinct CustomerID from orders

--soru 7: telefon no ve fax belirtilmi� m��terileri listeleyin
select CustomerID, Phone, Fax from Customers
where Fax is not null --null olanlar� getirmez

select CustomerID, Phone, Fax from Customers
where Fax is null --Fax de�erleri eksik olanlar� getir

--soru 8: ilk 10 �r�n� isme g�re listele
select * from Products
order by ProductName --isimleri A-Z s�ralar

select top 10 ProductName from Products order by ProductName
--ProductName s�tununun ilk 10ununu getirir (ProductName s�tununa g�re A-Z s�ral�)

--soru 9: stokta olmayan �r�nleri bul
select * from Products where UnitsInStock = 0
--stokta olan �r�nleri bul
select * from Products where UnitPrice <> 0

--soru 10: �r�n fiyatlar�n�n ortalama fiyattan y�ksek olanlar� bul
select * from Products

select ProductName, UnitPrice FROM Products
where UnitPrice > (select avg(unitPrice) FROM Products)
--ortalama �zerine ��kan �r�nleri bulduk

--soru 11: 20 adetten fazla stokta olan �r�nleri g�ster
SELECT * from Products where UnitsInStock > 20

--soru 12: g�nderici firmalar� alfabetik s�rayla listele 
select * from Suppliers

select * from Suppliers order by ContactName asc

--soru 13: her bir sipari�in �r�n adedini listeleyin
select OrderID,Count(Quantity) from [Order Details]
group by OrderID
--herhangi bir matematiksel i�lemin yan�nda bir kriter varsa group by yapmak zorunludur

select OrderID,sum(Quantity) as SalesCount from [Order Details]
group by OrderID --her sipari�in �r�n sat�� adedini listeleyiniz
--Aggregate Functions (toplama fonk.)oldu�u ve yan�nda kriter oldu�u i�in group by kullanmal�y�z


select OrderID,sum(Quantity) as SalesCount from [Order Details]
group by OrderID having sum(Quantity) > 20 --sat�� adedi 20'den b�y�k olanlar� getir
--having filtreleme g�revi yapar ancak group by'dan sonra

select OrderID,sum(Quantity) as SalesCount from [Order Details]
where OrderID=10748
group by OrderID having sum(Quantity) > 20 --where ve having birlikte kullan�m�


select OrderID,sum(Quantity) as SalesCount from [Order Details]
group by OrderID 
having OrderID = 10748 --having where'in rol�n� �alabilir
--s�ralama her zaman ��yle olmal�d�r:
-- where - group by- having


--soru 14: her �al��an�n ald��� sipari� say�s�n� bulun
select E.FirstName, E.LastName,
count(O.OrderID) as SiparisAdedi from Employees E
inner join Orders O on E.EmployeeID = O.EmployeeID
group by E.FirstName, E.LastName
--matematiksel i�lem + kriter var group by kullan
--burda iki k�medeki e�le�en verilerle ilgileniyoruz, kesi�imlerini al�yoruz


--soru 15: �r�nleri kategoriye g�re gruplay�n ve ortalama fiyatlar�n� hesapla
select C.CategoryName, P.ProductName,
AVG (P.UnitPrice) as OrtalamaFiyat from Categories C
left join Products P on C.CategoryID=P.CategoryID
GROUP BY C.CategoryName, P.ProductName


--soru 16: her sipari� i�in, sipari� s�ras�n� tarihe g�re belirleyin
-- her sipari�i s�ralay�p 3 farkl� s�ralama metodu ile s�ra numaras� verir.
select CustomerID, OrderID, OrderDate,
ROW_NUMBER() over (order by OrderDate) as OrderSeq_ROW,
RANK() OVER (order by OrderDate) as OrderSeq_RANK,
DENSE_RANK() over (ORDER BY OrderDate) as OrderSeq_DENSE_RANK
FROM Orders
--ROW_NUMBER() -> Her sat�ra benzersiz bir s�ra numaras� verir. Ayn� OrderDate olsa bile farkl� numara al�r.
--RANK() -> Ayn� OrderDate olanlara ayn� s�ra numaras�n� verir ama sonraki s�ra atlan�r.
--DENSE_RANK() -> Ayn� OrderDate olanlara yine ayn� s�ra verilir ama atlama olmaz

/*
OVER, SQL'de gruplamadan sat�r bazl� analiz yapmay� sa�lar. 
�zellikle s�ral� i�lem, k�m�latif hesaplama gibi senaryolarda �ok g��l�d�r.

OVER Neden Kullan�l�r?
- TOPLU i�lemler yapar ama sat�rlar� kaybetmez.

-Sat�r bazl� hesaplamalar yaparken gruplama (GROUP BY) gibi sat�rlar� birle�tirmez.

-Analitik fonksiyonlarla birlikte s�ralama, s�ral� numaraland�rma, k�m�latif toplam gibi i�lemleri sat�r d�zeyinde yapman� sa�lar.

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



--soru 17: CASE WHEN ile �r�n stok durumunu metinsel olarak g�ster
-- case when: ko�ullu gruplama
select ProductName, UnitsInStock,
CASE 
when UnitsInStock = 0 then 'stokta yok'
when UnitsInStock < 20 then 'az stok'
else 'yeterli stok'
end as StokDurumu
from Products;



-- soru 18: her bir m��terinin en g�ncel yapt��� al��veri�
select
CustomerID, OrderID, OrderDate, 
ROW_NUMBER() over (partition by CustomerID order by OrderDate desc) 
as OrderRank
from Orders
order by CustomerID, OrderRank

--m��teri no'lar�n� gruplayarak b�l�yo, no atamas� yap�yo ve tekille�tiriyo
--PARTITION BY CustomerID: Her m��teriyi ayr� bir grup olarak ele al�yor.
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

