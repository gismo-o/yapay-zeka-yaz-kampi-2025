###############################
# Numpy & Pandas - Ödev Soruları
###############################

import numpy as np
import pandas as pd
import seaborn as sns

###############################
# Soru 1:
# 1D ve 2D array'ler oluşturun.
# Bu array’lerin boyut, eleman sayısı ve şekil bilgilerini yazdırın.
arr1 = np.array([9, 99, 8, 6, 5])
arr2 = np.array([[85,4,3], [14, 9 , 5]])

def arr_1_2 (arr):
    print(arr)
    print("Boyut: ", arr.ndim)
    print("Eleman Sayısı: ", arr.size)
    print("Şekil Bilgisi: ",arr.shape)
    print("--------------")

arr_1_2(arr1)
arr_1_2(arr2)


###############################
# Soru 2:
# 5 elemanlı rastgele sayılardan oluşan bir array oluşturun.
# Elemanların ortalamasını, standart sapmasını ve medyanını bulun.

np.random.seed(42)
arr = np.random.randint(0,100,size = 5)

def istatistik (arr):
    print(arr)
    print("Ortalama: ", np.mean(arr))
    print("Standart Sapma: ", np.std(arr))
    print("Medyan: ",np.median(arr))

istatistik(arr)

###############################
# Soru 3:
# 0 ile 1 arasında 10 eşit aralıklı sayı üretin.
# Bu sayılardan 0.5'ten büyük olanları filtreleyip yazdırın.

arr = np.linspace(0,1,10) #0-1 arası eşit aralıklı 10 sayı
print(arr)
print("----------------")
#filtreleme
print(arr[arr > 0.5])

###############################
# Soru 4:
# Pandas Series kullanarak öğrencilerin yaşlarını tutan bir seri oluşturun.
# Yaş ortalamasını ve en küçük yaşı bulun.

ages = pd.Series([18,20,25,19,21,20])
#Hem liste gibi davranır, hem de sözlük gibi etiketleme yapılabilir
print("Öğrenci Yaşları: ", ages)

print("Ortalama yaş: ",ages.mean())
print("En küçük yaş: ", ages.min())
print("----------------")
###############################
# Soru 5:
# seaborn içerisinden "diamonds" veri setini alın.
# Sadece "carat" ve "price" sütunlarını içeren ilk 5 satırı yazdırın.

diamonds = sns.load_dataset("diamonds")
print(diamonds[["carat","price"]].head())

print("----------------")
###############################
# Soru 6:
# Fiyatı 15.000’den fazla olan kaç elmas var?

print((diamonds["price"] > 15000).sum())

print("----------------")

###############################
# Soru 7:
# “cut” sütunundaki her bir kesim tipi için ortalama fiyatı(price) hesaplayın.

print(diamonds.groupby("cut", observed=True)["price"].mean())

print("----------------")
###############################
# Soru 8:
# pivot_table kullanarak her “cut” tipi için hem ortalama “carat” hem de “price” değerlerini gösterin.

tablo = pd.pivot_table(
    diamonds,
    values=["carat","price"], #hesaplanacak değerler
    index="cut", #gruplama
    aggfunc="mean" , #ortalama
    observed=True
)
print(tablo)
print("----------------")
###############################
# Soru 9:
# “color” sütununda kaç farklı renk olduğunu bulun. Her bir rengin kaç kez geçtiğini de yazdırın.

print("FARKLI RENK SAYISI: ", diamonds["color"].nunique())
print("HER RENGİN SAYISI:\n ", diamonds["color"].value_counts())
print("----------------")
###############################
# Soru 10:
# “cut” ve “clarity” kombinasyonlarına göre ortalama fiyatları hesaplayın.

#elmasın kesim kalitesi ve berraklık derecesine göre ortalama fiyatı
tablo = pd.pivot_table(
    diamonds,
    index="cut",
    values = "price",
    aggfunc="mean",
    columns="clarity",
    observed=True
)
print(tablo)