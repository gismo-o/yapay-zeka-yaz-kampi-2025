SELECT * FROM FLO


-- SORU-1: ka� farkl� m��terinin al��veri� yapt���n� g�sterecek sorguyu yaz�n�z
SELECT COUNT(DISTINCT master_id) AS Farkli_Musteri_Sayisi FROM FLO;


-- SORU-2: toplam al��veri� say�s� ve ciroyu getirecek sorguyu yaz�n�z
SELECT
    SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI,
    ROUND(SUM(customer_value_total_ever_offline + customer_value_total_ever_online), 2) AS TOPLAM_CIRO
FROM FLO;

-- SORU 3: Al��veri� ba��na ortalama ciro
SELECT 
    ROUND(
        SUM(customer_value_total_ever_offline + customer_value_total_ever_online) /
        SUM(order_num_total_ever_offline + order_num_total_ever_online), 
    2) AS Ortalama_Ciro
FROM FLO;


-- SORU 4: En son al��veri� yap�lan kanal (last_order_channel) �zerinden yap�lan al��veri�lerin toplam ciro ve al��veri� say�lar�n� getirecek sorgu.

SELECT 
    last_order_channel AS SON_ALISVERIS_KANALI,
    SUM(customer_value_total_ever_offline + customer_value_total_ever_online) AS TOPLAM_CIRO,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS TOPLAM_SIPARIS_SAYISI
FROM FLO
GROUP BY last_order_channel;


-- SORU 5: Store type k�r�l�m�nda elde edilen toplam ciroyu getiren sorgu.

SELECT 
    store_type AS MAGAZA_TURU,
    ROUND(SUM(customer_value_total_ever_offline + customer_value_total_ever_online), 2) AS TOPLAM_CIRO
FROM FLO
GROUP BY store_type;


-- SORU 6: Y�l k�r�l�m�nda al��veri� say�lar�n� getiren sorgu
-- (M��terinin ilk al��veri� tarihi - first_order_date baz al�narak)

SELECT 
    YEAR(first_order_date) AS YIL,
    SUM(order_num_total_ever_offline + order_num_total_ever_online) AS SIPARIS_SAYISI
FROM FLO
GROUP BY YEAR(first_order_date)
--ORDER BY 2 DESC;


-- SORU 7: En son al��veri� yap�lan kanal k�r�l�m�nda al��veri� ba��na ortalama ciroyu hesaplayacak sorgu

SELECT 
    last_order_channel AS SON_ALISVERIS_KANALI,
    ROUND(SUM(customer_value_total_ever_offline + customer_value_total_ever_online), 2) AS TOPLAM_CIRO,
    SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI,
    ROUND(
        SUM(customer_value_total_ever_offline + customer_value_total_ever_online) * 1.0 /
        NULLIF(SUM(order_num_total_ever_offline + order_num_total_ever_online), 0), 
    2) AS ORTALAMA_CIRO
FROM FLO
GROUP BY last_order_channel;



-- SORU 8: Son 12 ayda en �ok ilgi g�ren kategoriyi getiren sorgu

SELECT 
    interested_in_categories_12 AS KATEGORI,
    COUNT(*) AS FREKANS_BILGISI
FROM FLO
GROUP BY interested_in_categories_12
ORDER BY FREKANS_BILGISI DESC;

-- SORU 9: En �ok tercih edilen store_type bilgisini getiren sorgu

SELECT TOP 1
    store_type AS MAGAZA_TURU,
    COUNT(*) AS FREKANS_BILGISI
FROM FLO
GROUP BY store_type
ORDER BY FREKANS_BILGISI DESC;


-- SORU 10: En son al��veri� yap�lan kanal (last_order_channel) baz�nda,
-- en �ok ilgi g�ren kategoriyi ve bu kategoriden ne kadar al��veri� yap�ld���n� getiren sorgu

SELECT DISTINCT 
    f.last_order_channel AS SON_ALISVERIS_KANALI,

    -- En �ok ilgi g�ren kategori
    (
        SELECT TOP 1 
            interested_in_categories_12
        FROM FLO
        WHERE last_order_channel = f.last_order_channel
        GROUP BY interested_in_categories_12
        ORDER BY SUM(order_num_total_ever_online + order_num_total_ever_offline) DESC
    ) AS KATEGORI,

    -- O kategoriden yap�lan al��veri� say�s�
    (
        SELECT TOP 1 
            SUM(order_num_total_ever_online + order_num_total_ever_offline)
        FROM FLO
        WHERE last_order_channel = f.last_order_channel
        GROUP BY interested_in_categories_12
        ORDER BY SUM(order_num_total_ever_online + order_num_total_ever_offline) DESC
    ) AS ALISVERIS_SAYISI

FROM FLO f;


-- SORU 11: En �ok al��veri� yapan ki�inin ID'sini getiren sorgu

SELECT TOP 1
    master_id
FROM FLO
GROUP BY master_id
ORDER BY SUM(customer_value_total_ever_offline + customer_value_total_ever_online) DESC;


-- SORU 12: En �ok al��veri� yapan ki�inin al��veri� ba��na ortalama cirosunu
-- ve al��veri� yapma g�n ortalamas�n� getiren sorgu

SELECT 
    D.*,
    ROUND(D.TOPLAM_CIRO / D.TOPLAM_SIPARIS_SAYISI, 2) AS SIPARIS_BASINA_ORTALAMA
FROM
(
    SELECT TOP 1
        master_id,
        SUM(customer_value_total_ever_offline + customer_value_total_ever_online) AS TOPLAM_CIRO,
        SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI
    FROM FLO
    GROUP BY master_id
    ORDER BY TOPLAM_CIRO DESC
) D;



-- SORU 14: En �ok al��veri� yapan (ciro baz�nda) ilk 100 ki�inin 
-- sipari� ba��na ortalama cirosu ve al��veri� yapma g�n ortalamas�n� getiren sorgu

SELECT 
    D.master_id,
    D.TOPLAM_CIRO,
    D.TOPLAM_SIPARIS_SAYISI,
    ROUND((D.TOPLAM_CIRO / D.TOPLAM_SIPARIS_SAYISI), 2) AS SIPARIS_BASINA_ORTALAMA,
    DATEDIFF(DAY, D.first_order_date, D.last_order_date) AS ILK_SON_ALISVERIS_GUN_FRK,
    ROUND(
        (DATEDIFF(DAY, D.first_order_date, D.last_order_date) * 1.0 / D.TOPLAM_SIPARIS_SAYISI), 
    1) AS ALISVERIS_GUN_ORT
FROM
(
    SELECT TOP 100
        master_id,
        first_order_date,
        last_order_date,
        SUM(customer_value_total_ever_offline + customer_value_total_ever_online) AS TOPLAM_CIRO,
        SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI
    FROM FLO
    GROUP BY master_id, first_order_date, last_order_date
    ORDER BY SUM(customer_value_total_ever_offline + customer_value_total_ever_online) DESC
) D;


-- SORU 15: En son al��veri� yap�lan kanal (last_order_channel) k�r�l�m�nda 
-- en �ok al��veri� yapan m��teriyi getiren sorgu

SELECT DISTINCT 
    f.last_order_channel,

    -- En �ok al��veri� yapan m��teri
    (
        SELECT TOP 1 
            master_id
        FROM FLO
        WHERE last_order_channel = f.last_order_channel
        GROUP BY master_id
        ORDER BY SUM(customer_value_total_ever_offline + customer_value_total_ever_online) DESC
    ) AS EN_COK_ALISVERIS_YAPAN_MUSTERI,

    -- O m��terinin yapt��� toplam ciro
    (
        SELECT TOP 1 
            SUM(customer_value_total_ever_offline + customer_value_total_ever_online)
        FROM FLO
        WHERE last_order_channel = f.last_order_channel
        GROUP BY master_id
        ORDER BY SUM(customer_value_total_ever_offline + customer_value_total_ever_online) DESC
    ) AS CIRO

FROM FLO f;



-- SORU 16: En son al��veri� yapan ki�inin ID'sini getiren sorgu
-- (Max son tarihte birden fazla al��veri� yapan ID bulunmas� durumunda hepsini getirir)

SELECT 
    master_id,
    last_order_date
FROM FLO
WHERE last_order_date = (
    SELECT MAX(last_order_date) 
    FROM FLO
);
