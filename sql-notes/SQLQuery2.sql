SELECT * FROM FLO


-- SORU-1: kaç farklý müþterinin alýþveriþ yaptýðýný gösterecek sorguyu yazýnýz
SELECT COUNT(DISTINCT master_id) AS Farkli_Musteri_Sayisi FROM FLO;


-- SORU-2: toplam alýþveriþ sayýsý ve ciroyu getirecek sorguyu yazýnýz
SELECT
    SUM(order_num_total_ever_offline + order_num_total_ever_online) AS TOPLAM_SIPARIS_SAYISI,
    ROUND(SUM(customer_value_total_ever_offline + customer_value_total_ever_online), 2) AS TOPLAM_CIRO
FROM FLO;

-- SORU 3: Alýþveriþ baþýna ortalama ciro
SELECT 
    ROUND(
        SUM(customer_value_total_ever_offline + customer_value_total_ever_online) /
        SUM(order_num_total_ever_offline + order_num_total_ever_online), 
    2) AS Ortalama_Ciro
FROM FLO;


-- SORU 4: En son alýþveriþ yapýlan kanal (last_order_channel) üzerinden yapýlan alýþveriþlerin toplam ciro ve alýþveriþ sayýlarýný getirecek sorgu.

SELECT 
    last_order_channel AS SON_ALISVERIS_KANALI,
    SUM(customer_value_total_ever_offline + customer_value_total_ever_online) AS TOPLAM_CIRO,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS TOPLAM_SIPARIS_SAYISI
FROM FLO
GROUP BY last_order_channel;


-- SORU 5: Store type kýrýlýmýnda elde edilen toplam ciroyu getiren sorgu.

SELECT 
    store_type AS MAGAZA_TURU,
    ROUND(SUM(customer_value_total_ever_offline + customer_value_total_ever_online), 2) AS TOPLAM_CIRO
FROM FLO
GROUP BY store_type;


-- SORU 6: Yýl kýrýlýmýnda alýþveriþ sayýlarýný getiren sorgu
-- (Müþterinin ilk alýþveriþ tarihi - first_order_date baz alýnarak)

SELECT 
    YEAR(first_order_date) AS YIL,
    SUM(order_num_total_ever_offline + order_num_total_ever_online) AS SIPARIS_SAYISI
FROM FLO
GROUP BY YEAR(first_order_date)
--ORDER BY 2 DESC;


-- SORU 7: En son alýþveriþ yapýlan kanal kýrýlýmýnda alýþveriþ baþýna ortalama ciroyu hesaplayacak sorgu

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



-- SORU 8: Son 12 ayda en çok ilgi gören kategoriyi getiren sorgu

SELECT 
    interested_in_categories_12 AS KATEGORI,
    COUNT(*) AS FREKANS_BILGISI
FROM FLO
GROUP BY interested_in_categories_12
ORDER BY FREKANS_BILGISI DESC;

-- SORU 9: En çok tercih edilen store_type bilgisini getiren sorgu

SELECT TOP 1
    store_type AS MAGAZA_TURU,
    COUNT(*) AS FREKANS_BILGISI
FROM FLO
GROUP BY store_type
ORDER BY FREKANS_BILGISI DESC;


-- SORU 10: En son alýþveriþ yapýlan kanal (last_order_channel) bazýnda,
-- en çok ilgi gören kategoriyi ve bu kategoriden ne kadar alýþveriþ yapýldýðýný getiren sorgu

SELECT DISTINCT 
    f.last_order_channel AS SON_ALISVERIS_KANALI,

    -- En çok ilgi gören kategori
    (
        SELECT TOP 1 
            interested_in_categories_12
        FROM FLO
        WHERE last_order_channel = f.last_order_channel
        GROUP BY interested_in_categories_12
        ORDER BY SUM(order_num_total_ever_online + order_num_total_ever_offline) DESC
    ) AS KATEGORI,

    -- O kategoriden yapýlan alýþveriþ sayýsý
    (
        SELECT TOP 1 
            SUM(order_num_total_ever_online + order_num_total_ever_offline)
        FROM FLO
        WHERE last_order_channel = f.last_order_channel
        GROUP BY interested_in_categories_12
        ORDER BY SUM(order_num_total_ever_online + order_num_total_ever_offline) DESC
    ) AS ALISVERIS_SAYISI

FROM FLO f;


-- SORU 11: En çok alýþveriþ yapan kiþinin ID'sini getiren sorgu

SELECT TOP 1
    master_id
FROM FLO
GROUP BY master_id
ORDER BY SUM(customer_value_total_ever_offline + customer_value_total_ever_online) DESC;


-- SORU 12: En çok alýþveriþ yapan kiþinin alýþveriþ baþýna ortalama cirosunu
-- ve alýþveriþ yapma gün ortalamasýný getiren sorgu

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



-- SORU 14: En çok alýþveriþ yapan (ciro bazýnda) ilk 100 kiþinin 
-- sipariþ baþýna ortalama cirosu ve alýþveriþ yapma gün ortalamasýný getiren sorgu

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


-- SORU 15: En son alýþveriþ yapýlan kanal (last_order_channel) kýrýlýmýnda 
-- en çok alýþveriþ yapan müþteriyi getiren sorgu

SELECT DISTINCT 
    f.last_order_channel,

    -- En çok alýþveriþ yapan müþteri
    (
        SELECT TOP 1 
            master_id
        FROM FLO
        WHERE last_order_channel = f.last_order_channel
        GROUP BY master_id
        ORDER BY SUM(customer_value_total_ever_offline + customer_value_total_ever_online) DESC
    ) AS EN_COK_ALISVERIS_YAPAN_MUSTERI,

    -- O müþterinin yaptýðý toplam ciro
    (
        SELECT TOP 1 
            SUM(customer_value_total_ever_offline + customer_value_total_ever_online)
        FROM FLO
        WHERE last_order_channel = f.last_order_channel
        GROUP BY master_id
        ORDER BY SUM(customer_value_total_ever_offline + customer_value_total_ever_online) DESC
    ) AS CIRO

FROM FLO f;



-- SORU 16: En son alýþveriþ yapan kiþinin ID'sini getiren sorgu
-- (Max son tarihte birden fazla alýþveriþ yapan ID bulunmasý durumunda hepsini getirir)

SELECT 
    master_id,
    last_order_date
FROM FLO
WHERE last_order_date = (
    SELECT MAX(last_order_date) 
    FROM FLO
);
