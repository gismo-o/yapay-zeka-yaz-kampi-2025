#####################################
# Python Temelleri - Ödev Scripti
#####################################

# Soru 1:
# Bir integer, bir float ve bir complex sayı tanımlayın.
# Bu sayıların türlerini yazdırın ve aralarında 1-2 işlem yapın.

num1 = 9
num2 = 8.9
num3 = 3j + 5
print (num1 , " " , type(num1) , num2 , " " , type(num2) , " " , num3, type(num3))




# Soru 2:
# İsminizi içeren bir string değişkeni oluşturun.
# Bu stringin ilk ve son karakterini yazdırın. Ayrıca tüm harfleri büyük yaparak ekrana yazdırın.

name="gizem"
print(name, name[1], name[-1], name.upper())


# Soru 3:
# Aşağıdaki string içinde "veri" kelimesi geçiyor mu kontrol edin.
# Ardından bu stringi boşluklardan bölerek liste haline getirin.

sentence = "Veri bilimi yapay zeka ile birleştiğinde güçlü sonuçlar doğurabilir."

print("veri" in sentence)

word_list=sentence.split()
print(word_list)




# Soru 4:
# İçerisinde 3 farklı türde veri bulunan bir liste oluşturun.
# Listenin uzunluğunu, ilk ve son elemanını yazdırın.
# Ardından bu listeye yeni bir eleman ekleyin ve ikinci elemanı silin.

list1 = ["selam", 5 , 6.8] #3 farklı veri türü oluşturuldu
print(list1)
list1.append(99) # eleman eklendi
print(list1)
list1.pop(1) #2.eleman silindi
print(list1)


# Soru 5:
# 2 parametre alan bir fonksiyon yazın. Bu fonksiyon, aldığı iki sayının ortalamasını dönsün.

def fun(num1, num2):
    return (num1+num2)/2

print(fun(5,8))



# Soru 6:
# Kullanıcının yaşına göre mesaj yazdıran bir fonksiyon yazın:
# 18'den küçükse "Çok gençsin!", 18-40 arasıysa "Harika bir yaştasın!", 40'tan büyükse "Deneyim önemli!" mesajını yazdırsın.

def yas(y):
    if y < 18:
        print("ÇOK GENÇSİN")
    elif y > 18 and y < 40:
        print("HARİKA BİR YAŞTASIN")
    else:
        print("DENEYİM ÖNEMLİ")

yas(5), yas(22), yas(45)




# Soru 7:
# İçerisinde sayılar olan bir liste içindeki sayıları dolaşarak 2 katını ekrana yazdırın (for döngüsü ile).

list2 = [8,8.9,11,6,5]
for l in list2:
    print(l * 2)



# Soru 8:
# 1'den başlayarak 20 dahil olacak şekilde çift sayıları yazdırın (while döngüsü ile).

i=1
while(i<20):
    if i % 2 == 0:
        print(i)
    i=i+1


# Soru 9:
# Bir çalışanın haftalık maaşını hesaplayan bir fonksiyon yazın.
# Saatlik ücreti ve haftalık toplam çalışma saati parametre olarak alınsın.
# Haftada 40 saatten fazla çalıştıysa, fazla saatler için %50 zamlı ücret ödensin (mesai).
# Örnek: 45 saat çalışan biri için 5 saatlik mesai uygulanmalı.

def maas(h,w):
    if w > 40:
        return (w - 40) * (1.5 * h) + (40 * h)
    return (h * w)

print(maas(5,45))


