# PYTHON FOR DATA SCIENCE
from statistics import quantiles

gik = "Hello Gizem ilayda"
gik = 'Hello Gizem ilayda'
print(gik)
print(gik[-1])
print(gik[0:5]) # 0-5 arası olanları al
print("Gizem" in gik) #boolean döndürür


#int
a = 99
print(a)
c = 10
print(type(a + c))

#float
y = 33.10
print(type(y))

#strings
a= "hello world"
print(type(a))

#boolean
b= True
print(type(b))

#lists : sıralı, kapsayıcı, değiştirilebilir
l = [1,2,3,4, "str", 3.2, False]
print(l , type(l))

#dictionary(sözlük) : sırasız, kapsayıcı, değiştirilebilir, key değerleri farklı olmalı
#{"key" : "value"}
d= {"name" : "jake",
    "age" : "20",
    "Adress" : "istanbul"}
print(d , type(d))


#tuple : sıralı, kapsayıcı, değiştirelemez
#önemli olan, değişmeyecek verilerde kullanırız
t= ("Machine Learning", "Data Science")
print(t, type(t))


# set : sırasız, eşsiz, kapsayıcı, değiştirilebilir
s = {"Python", "Machine Learning", "Data Science", "Python"}
print(s , type(s)) #python'dan iki tane olmasına rağmen 1 tane yazdırır. ve hepsinin sırasını değiştirir


# TİPLERİ DEĞİŞTİRMEK
x = 8 #int
y = 3.2 #float
z = 8j + 18 #complex

print(int(x*y))
print(float(x*y))

print(float(x))
print(int(y))
print(int(3.9))
# int(z) #error


#STRING METOTLARI
print(dir(str)) #içine hangi metotları yazacağımızı gösterir

text = "hello, AI Era!"
text.upper()
text.lower()
text.replace("l", "k")

#arka arakaya uygulamak istersek:
text.upper().replace("O", "E")
type(text.split())
#text.split().upper() error verir çünkü listelerde upper fonk. yok
len(text)


#LİSTE METOTLARI
lst = [1,2,3,4, "str", 3.2, False]
lst.append(33.34) #eleman ekler
lst
lst.pop(7) #indexe göre eleman siler
lst.insert(0,"AI") #index'e ekleme yapar
lst.upper() #error verir. her fonk her veri tipinde kullanılmaz


#FUNCTION (FONKSİYONLAR)

#ön tanımlı argümanlar.
def hi(word = "Selam"):
    print(word, "Miuul")

hi()
hi(word = "Merhaba")

# öğrencilerin vize notlarının %40'ını, final notlarının %60'ını ağırlık olarak alan bir fonk yaz

ogr1 = (40 * 0.4) + (70 * 0.6)
ogr2 = (80 * 0.4) + (20 * 0.6)
print(ogr1, ogr2)

def note_calculator(vize_notu, final_notu):
    return (vize_notu * 0.4) * (final_notu * 0.6)

ogr1 = note_calculator(40,70)
ogr2 = note_calculator(80,20)
print(ogr1, ogr2)


# LOOPS (DÖNGÜLER)

#for loop
bootcamps =  ["Data Science", "Data Analytics", "AWS Cloud Engineering"]
bootcamps[0]
bootcamps[1]

for bc in bootcamps: #her döndüğün elemanı geçici olarak bc'ye kaydet
    print(bc)

#while loops
num = 5
while num < 10:
    print(num)
    num = num + 1
    #bu döngü true olduğu sürece devam eder

###############################
#           NUMPY
###############################
import numpy as np

# matris işlemleri gibi matematiksel işlemleri yapmamızı sağlar
l1 = [1, 3 ,5 ,7]
l2 = [2, 4 ,6 ,8]
# 1. numpy kütüphanesine git ve array fonkiyonunu çağır
arr1 = np.array([1, 3 ,5 ,7])
arr2 = np.array([2, 4 ,6 ,8])

# 2. numpy kütüphanesi kullanarak listeleri çarp. Normalde listelerde çarpma işlemi yok!
arr1 * arr2
type(arr1)

np.zeros(5) # 0lardan oluşan numpy arrayi
np.ones(5) # 0lardan oluşan numpy arrayi

np.arange(0,10,2) #0-10 arası 2şer artan
np.linspace(0,1,5) #0-1 arası 5 sayı
np.random.randint(0,100,5) #0-99 arası rastgele 5 sayı
np.random.normal(0,1,(2,3)) #normal dağılıma göre 2*3 matris

arr1.shape # tek boyutlu array
arr1.ndim #kaç boyutlu bilgisi
arr1.size #toplam eleman sayısı

arr1[:3]

# NUMPY İLE MATEMATİKSEL İŞLEMLER

arr = np.array([1,2,3,4,5])
arr * 2
np.sum(arr)
np.mean(arr)
np.median(arr)
np.std(arr)

#filtreleme:
arr[arr>4]

######################
#           PANDAS
######################
# numpy temellidir. veriyi okuyup işlemek için kullanılan kütüphane

#series
import pandas as pd
arr = np.array([1,2,3,4,5,6,7])
ser = pd.Series(arr)
ser
ser.shape # boyutunu gösterir
ser.ndim # kaç boyutlu olduğunu yazar
ser.size # kaç veri olduğunu görürüz
ser.head() # ilk 5 satır
ser.tail() #son 5 satır

# pandas dataframe
import seaborn as sns
df = sns.load_dataset("tips")
type(df)
df.head()
df.tail()
df.columns
df.values #her satırı array gibi alır
df.size
type(df.values)
df.dtypes

df.info() #sütunların içinde kaç dolu değer olduğunu ve tipini gösterir
df.describe().T
df.isnull().sum()

df["total_bill"].head() #belirtilen sütunun ilk 5 satırı
df["day"].value_counts() # günlerden kaçar tane var
df["day"].unique() #eşsiz satırları görürüm
df["day"].nunique() # toplam unique sayısı

# seçim ve filtreleme
df[df["total_bill"] > 10].head()

#loc -> satır,sütun
df.loc[0:3, "total_bill"] # ilk 3 satırı al, sonra total bill olan sütunu al
df.loc[df["total_bill"] > 10 , ["smoker","size"]].head()
# total bill > 10 olan satırlara bak. smoker ve size sütunlarını al. ilk 5 satırı


#iloc -> verinin veya sütunun nerde olduğuna göre ilerleyerek seçim yapmamızı sağlar
df.iloc[0]
df.iloc[0, 2:4] # 0. satırdaki 2-4 arası sütunu getir


# gruplama işlemleri (aggregation)

# groupby
#gün bazında ortalama hesaplama
df.groupby("day")["total_bill"].mean()
#2.yöntem- birden fazla sütun kullanırken tercih edilir
df.groupby("day").agg({"total_bill":"mean"})

df.groupby("day").agg({
    "total_bill" : ["mean", "sum"],
    "tip" : "mean"
})


# pivot table
df.pivot_table(
    index="day",
    values="total_bill",
    aggfunc="mean"
)


df.pivot_table(
    index="day",
    values=["total_bill","tip"],
    aggfunc={
        "total_bill" : ["mean","sum"],
        "tip" : ["mean"]
    }
)


###########################################
#        KEŞİFÇİ VERİ ANALİZİ (EDA)
###########################################

def check_df(dataframe, head=5):
    print("##################### shape ###################")
    print(dataframe.shape)
    print("##################### types ###################")
    print(dataframe.dtypes)
    print("##################### tail ###################")
    print(dataframe.head(head))
    print("##################### NA ###################")
    print(dataframe.isnull().sum())
    print("##################### quantiles ###################")
    print(dataframe.describe([0, 0.05, 0.50, 0.95, 0.99, 1]).T) #sayısal değişkenlerin değişim bilgisi

check_df(df)


###############################################
#       KATEGORİK DEĞİŞİM ANALİZİ
###############################################

cat_cols = ['sex', 'smoker', 'day', 'time']
def cat_summary(dataframe, col_name):
    print(pd.DataFrame({col_name: dataframe[col_name].value_counts(),
                        "Ratio" : 100 * dataframe[col_name].value_counts() / len(dataframe)}))
    print("##########################################")

cat_summary(df, 'day')

#tüm kategorik sütunlarda döngü
for col in cat_cols:
    cat_summary(df, col)


###############################################
#       NUMERİK DEĞİŞİM ANALİZİ
###############################################

num_cols = ["total_bill", "tip", "size"]

def num_summary(dataframe, numerical_col):
    quantiles = [0.05, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 0.95, 0.99]
    print(dataframe[numerical_col]. describe(quantiles).T)

num_summary(dataframe=df, numerical_col="tip") # 1 değişkene bakmak için

#tüm sayısal sütunlarda döngü
for col in num_cols:
    num_summary(df,col)
    print("-----------------------------------------------")


###############################################
#       HEDEF DEĞİŞİM ANALİZİ
###############################################

TARGET = "tip"

#kategorik değişken - hedef değişken ilişkisi
def target_summary_with_cat(dataframe, target, categorical_col):
    print(pd.DataFrame({
        "TARGET_MEAN" : dataframe.groupby(categorical_col)[target].mean()}), end="\n\n\n")

for col in cat_cols:
    target_summary_with_cat(
        dataframe=df,
        target=TARGET,
        categorical_col=col
    )



''''
NOTLAR:
Nominal değişkenler, sıralama yapılamayan kategorik değişkenlerdir
Ordinal değişken, sıralama yapılabilen kategorik değişkenlerdir
Bağımlı değişken -> tahmin edilmek istenen hedef değişken
'''