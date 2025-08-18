# DEEP LEARNING

Neden Kullanırız ?

- karmaşık problemleri çözebilmek
- yapısal olmayan verileri analiz edebilmek
- geliştirilen modelin performansını arttırabilmek
- kurumsal dönüşüm ve teknolojiye ayak uydurabilmek

NEDİR ?

![](resim1.png)

YAPAY ZEKA: İnsan zekasının bilgisayarlar, yazılımlar veya makineler aracılığıyla taklit edilmesi sürecidir.

MAKİNE ÖĞRENMESİ: Bilgisayarların geçmiş verilerden öğrenerek tahmin veya karar verebilmesini sağlayan yöntemler bütünüdür.

DERİN ÖĞRENME: Yapay sinir ağ yapısını kullanrak büyük ve karmaşık veri kümelerinden öğrenme yapabilen makine öğrenmesi yöntemi

### GEN AI - LLM

Derin öğrenme modellerini kullanarak yeni veri üreten modellere (LLM) GenAI denir.

# Machine Learning vs Deep Learning

| Özellik                       | Machine Learning                                    | Deep Learning                                      |
| ----------------------------- | --------------------------------------------------- | -------------------------------------------------- |
| **Yöntemler**                 | Geleneksel algoritma ve istatistiksel yöntemler     | Yapay sinir ağları ve çok katmanlı yapılar         |
| **Hesaplama Maliyeti**        | Daha düşük                                          | Yüksek                                             |
| **Veri Türü**                 | Tabular veriler                                     | Görüntü, ses, video                                |
| **Büyük Veri ile Geliştirme** | Zor                                                 | Daha esnek                                         |
| **Özellik Mühendisliği**      | Başarı oranında etkisi yüksek, özellik çıkarımı zor | Özellik çıkarımı daha standart, verimliliği yüksek |
| **Açıklanabilirlik**          | Daha yüksek                                         | Daha düşük                                         |

### Deep Learning Terminoloji

Bir yapay sinir ağı,

- birbiri ile bağlantılı düğümler (nodes)
- nöronlar
- katman yapılarından oluşur.

Derin Öğrenme; Yapay sinir ağlarının fazla sayıda katmana sahip olması durumudur.

![](resim2.png)

### Deep Learning Algoritmalarında Kullanılan Kütüphaneler

- TensorFlow
- PyTorch
- Keras
- mxnet

### Derin Öğrenme Uygulamaları

- görüntü tanıma, görüntü işleme
- doğal dil işleme (NLP)
- ses tanıma
- otonom araçlar

### Deep Learning nasıl çalışıyor?

- Önce girdi verilerini (mesela bir resim) alıyoruz ve içinden çıktı tahmini üretiyoruz.

- Sonra bu tahmini, elimizdeki gerçek cevapla karşılaştırıyoruz.

- Aradaki farkı ölçmek için loss function denen bir değer hesaplıyoruz. (Bu aslında “ne kadar hata yaptık” demek.)

- Bu hata yüksekse, ağırlıkları ve bias değerlerini küçük küçük değiştirerek hatayı azaltmaya çalışıyoruz. (Buna optimizasyon deniyor.)

- Amaç: hata (loss) değerini mümkün olduğunca küçültmek.

-Eğer model sadece eğitim verisini ezberlerse (train çok iyi ama test kötü), bu durumda model aşırı öğrenmiş olur → overfitting.

- O yüzden öğrenmeyi fazla uzatmamalı, tam kararında bırakmalıyız.

## ![](resim3.png)

## **NOT: BİAS değeri** sayesinde çıktıları daha başarılı şekilde güncelleyip daha iyi sonuçlar elde edebiliriz. Örneğin sadece weight (w) değerlerini güncelleyerek ilerleseydik tek bir noktadan güncelleme yaptığımız için modelin başarı performansını istediğimiz gibi yükseltemeyebilirdik. Bu nedenle bias ekliyoruz.

Modelin neden genellenebilir olmasını istiyoruz ?

- Eğer sürekli katsayıları (w)geliştiriyorsak ama loss artık düşmüyorsa, model zaten benzer hataları öğrenmiş ve onları düzeltecek şekilde ayarlanmıştır. Bu noktadan sonra güncellemeler aynı veya çok benzer sonuçları verir.

---

Aktivasyon Fonksiyonunun Önemi

- Aktivasyon fonksiyonları, yapay sinir ağlarında gizli katmanlarda ağırlık (𝑤) ve bias (𝑏) ile hesaplanan değerden sonra uygulanır ve modele **karmaşık şeyleri öğrenme yeteneği** kazandırır; giriş katmanında aktivasyon kullanılmaz çünkü orası sadece veriyi içeri alır, çıkış katmanında ise **probleme göre özel bir aktivasyon** seçilir (örneğin ikili sınıflandırmada Sigmoid, çok sınıfta Softmax, sayısal tahminde aktivasyon yoktur).

Neden probleme özel aktivasyon seçilir ?

- Aktivasyon fonksiyonunu probleme göre seçmek önemlidir çünkü her problem farklı bir çıktı ister: mesela ikili sınıflandırmada Sigmoid kullanılır ve sonucu 0–1 arasında olasılık gibi verir, çok sınıflı problemlerde Softmax seçilir ve her sınıfa olasılık dağıtır, sayısal tahminlerde ise genelde aktivasyon kullanılmaz ki model her türlü gerçek sayıyı tahmin edebilsin; yani doğru aktivasyon seçmek, modelin çıktısını probleme uygun ve anlamlı hale getirir.

---

**SOFTMAX Aktivasyonu Örneği:**

```
import tensorflow as tf
from tensorflow.keras import Sequential
from tensorflow.keras.layers import Dense
import numpy as np

# 1️⃣ Sınıf isimlerini tanımlıyoruz
class_names = ["Kedi", "Köpek", "Kuş"]

# 2️⃣ Modelimizi oluşturuyoruz
model = Sequential([
    Dense(8, activation='relu', input_shape=(4,)),   # gizli katman: 8 nöron, girişte 4 özellik var
    Dense(3, activation='softmax')                   # çıkış katmanı: 3 sınıf için softmax
])

# 3️⃣ Modeli derliyoruz (optimizer, loss, metric)
model.compile(optimizer='adam',
              loss='categorical_crossentropy',
              metrics=['accuracy'])

# 4️⃣ Örnek giriş verisi (4 özellikli bir veri)
# Diyelim ki elimizde "bir hayvan" var, 4 sayıyla temsil edilmiş
sample_data = np.array([[0.5, 0.8, 0.2, 0.9]])  # [özellik1, özellik2, özellik3, özellik4]

# 5️⃣ Model tahmini (rastgele ağırlıklarla eğitimsiz örnek)
prediction = model.predict(sample_data)

# 6️⃣ Sonucu yazdırıyoruz
print("Olasılıklar:", prediction)  # her sınıf için olasılık
predicted_class = np.argmax(prediction)  # en yüksek olasılığın indexi
print("Tahmin edilen sınıf:", class_names[predicted_class])
```

---

#### Sigmoid Fonksiyonu

Formül:
Sigmoid(x) = 1 / (1 + e^(-x))

- Çıktı daima **0 ile 1** arasındadır.

---

### Aktivasyon Fonksiyonu Türleri

1. Linear : Regresyon modelleri
2. Sigmoid : İkili sınıflandırma
3. TANH (Hyperbolic Tangent): Zaman serisi modelleri (ÖR: Satışları zaman periyoduna göre ölçme) -gizli katmanlarda
4. ReLU (Rectified Linear Unit): Görüntü işleme -gizli katmanlarda
5. Softmax : çoklu sınıflandırma

---

#### Cost Fonksiyonu

Regresyon Problemleri için kullanılır

Modelin tahminlerinin gerçek değerden ne kadar farklı olduğunu ölçer.- performans değerlendirmesi

- MSE: (Gerçek değer − Tahmin edilen değer)² alınır, tüm örneklerin ortalaması hesaplanır.

---

### Log-Loss Fonksiyonu

Sınıflandırma problemleri için kullanılır.

---

#### Forward Propagation (İleri Yayılım) adımları:

- girdiyi al
- ağırlıkları çarp ve bias ekle
- aktivasyon fonksiyonu uygula
- sonraki katmana ilet
- çıkış hesaplanana kadar tekrarla

---

#### Backpropagation adımları:

- loss fonksiyonu hesaplamak
- zincir kuralı ile gradyanları hesapla
- ağırlıkları güncelle
- epoch boyunca tekrar et

Modelin her katmandaki ağırlıkların ve biasların kaybı minimize edecek şekilde nasıl ayarlanması gerektiğini belirler.

- paramatrelerin güncellenmesi _update kuralı_ ile belirlenir.

---

## CNN (Convolutional Neural Network) MİMARİSİ

![](resim4.jpg)

Convolution Layers

- İlgili resmin özelliklerini algılamaktan sorumlu.
- Bu katmanda, görüntüdeki düşük ve yüksek seviyeli özellikleri çıkarmak için resme bazı filtreler ya da kerneller uygularız
- CNN'de görüntüler matrislerle ifade edilir.

Pooling Layers

- Çıkarılan özelliklerin (feature map) boyutunu küçültür.
- Amaç:giriş matrisinin kanal sayısını sabit tutarak genişlik ve yükseklik bazında boyut indirgemesi yapmak. Bu sayede hesaplama karmaşıklığını azaltır. **Evrişim katmanından sonra** kullanılır.
  - Max Pooling
  - Avarage Pooling

Flatten & Dense Layers

- Flatten layer, çok boyutlu veriyi (örneğin 28x28 piksellik bir resim) tek boyutlu vektöre dönüştürür ki tam bağlı (Dense) katmanlara girdi olarak verilebilsin.

- Dense layer ise her nöronun önceki katmandaki tüm nöronlarla bağlantılı olduğu, ağırlık (𝑤) ve bias (𝑏) kullanarak hesap yapıp aktivasyon fonksiyonu ile çıktı üreten katmandır.

```
from tensorflow.keras import layers, Sequential

model = Sequential([
    # 1️⃣ Giriş katmanı: 224x224 boyutunda, 3 kanallı (RGB) resimler
    layers.Input(shape=(224, 224, 3)),

    # 2️⃣ İlk Convolutional katman: 32 filtre, 3x3 kernel, ReLU aktivasyon
    layers.Conv2D(32, (3, 3), activation='relu'),
    # 3️⃣ MaxPooling: 2x2 havuzlama ile boyutu küçültme
    layers.MaxPooling2D((2, 2)),

    # 4️⃣ İkinci Convolutional katman: 64 filtre, 3x3 kernel
    layers.Conv2D(64, (3, 3), activation='relu'),
    layers.MaxPooling2D((2, 2)),

    # 5️⃣ Üçüncü Convolutional katman: 128 filtre, 5x5 kernel
    layers.Conv2D(128, (5, 5), activation='relu'),

    # 6️⃣ Çok boyutlu veriyi düzleştirme (Flatten)
    layers.Flatten(),

    # 7️⃣ Tam bağlı (Dense) katman: 128 nöron, ReLU aktivasyonu
    layers.Dense(128, activation='relu'),

    # 8️⃣ Çıkış katmanı: 3 sınıf için 3 nöron, Softmax aktivasyonu
    layers.Dense(3, activation='softmax')
])
```

_Özet:_ Bu model bir resmi alıyor → Conv ve Pooling katmanlarıyla özelliklerini çıkarıyor → Flatten ile düzleştiriyor → Dense katmanlarda işliyor → en sonunda Softmax ile “bu resim hangi sınıfa ait” kararını veriyor.

---

| Avantajlar                | Dezavantajlar               |
| ------------------------- | --------------------------- |
| Özellik çıkarımı          | Hesaplama maliyeti          |
| Spatial invariance        | Overfitting                 |
| Gürültüye karşı dayanıklı | Yorumlanabilirlik eksikliği |
| Transfer Learning         |                             |
| Performans                |                             |

---

### Pretrained CNN Model

Pretrained CNN model, büyük veri kümeleri (ör. ImageNet) üzerinde önceden eğitilmiş, temel görsel özellikleri (kenar, şekil, doku) zaten öğrenmiş ve bu bilgileri transfer learning ile yeni görevlerde kullanılabilen derin sinir ağı modelidir.

- kaynak ve zaman maliyeti
- performans
- özelleştirme ve adaptasyon

---

#### Pretrained CNN Model - VGG

VGG, her yerde aynı 3x3 filtrelerden oluşan standart konvolüsyon bloklarıyla homojen bir yapı kurar ve eğitimde ağırlıkları **Xavier yöntemiyle** başlatarak derin ağlarda öğrenmenin dengeli ve kararlı ilerlemesini sağlar.

---

#### Pretrained CNN Model - ResNet

ResNet, pretrained CNN modelleri arasında öne çıkan; “residual connection” (skip connection) denilen atlama bağlantıları sayesinde çok derin katmanlarda bile kaybolan gradyan sorununu çözerek daha derin, daha doğru ve kararlı öğrenme sağlayan, büyük veri kümelerinde önceden eğitilip transfer learning için yaygın kullanılan güçlü bir modeldir.

---

#### Pretrained CNN Model - GoogleNet(Inception)

GoogleNet (Inception), pretrained CNN modellerinden biri olup, her katmanda farklı boyutlarda filtreleri (1x1, 3x3, 5x5) aynı anda kullanarak hem geniş hem derin özellik çıkarımı yapabilen, parametre sayısını azaltmak için Inception bloklarıyla optimize edilmiş ve ImageNet üzerinde eğitilip transfer learning’de sıkça kullanılan bir mimaridir.

-Büyük katmanlı yapılardan iyi seviye özellik çıkartmak için tercih edilir.

---

### TRANSFER LEARNING - FINE TUNING

**Transfer learning,** önceden eğitilmiş bir modeli yeni bir göreve uyarlamayı sağlar; **fine-tuning** ise bu modeli özelleştirerek en iyi sonucu vermesi için ayarlama yapar.

---

### Fine Tuning Teknikleri

- Feature Extractor (Özellik Çıkarmak) : Modelin önceden öğrendiği özellikler (kenar, şekil, desen vb.) kullanılır, sadece son katman yeniden eğitilir.
- Full Network Fine Tuning: Hiçbir katman dondurulamaz. Tüm model, yeni veri setine göre baştan sona yeniden eğitilerek özelleştirilir.
- Katmanların dondurulması (Frozen layers): Modelin bazı katmanları sabitlenir (ağırlıkları değiştirilmez). Sadece seçilen katmanlar yeniden eğitilir.
- Gradual Unfreezing: Katmanlar yavaş yavaş “dondurulmuş” durumdan çıkarılır. Önce üst katmanlar, sonra alt katmanlar açılarak model daha verimli şekilde adapte edilir.

ÖZET TABLO:

### Fine Tuning Teknikleri

| Teknik                       | Açıklama                                                                                                |
| ---------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Feature Extractor**        | Önceden öğrenilmiş özellikler kullanılır, sadece son katman yeniden eğitilir.                           |
| **Full Network Fine Tuning** | Hiçbir katman dondurulmaz, tüm model yeni veri setine göre baştan sona yeniden eğitilir.                |
| **Frozen Layers**            | Bazı katmanlar sabitlenir (ağırlıkları değişmez), sadece belirli katmanlar yeniden eğitilir.            |
| **Gradual Unfreezing**       | Katmanlar aşamalı olarak dondurulmuş durumdan çıkarılır, önce üst katmanlar sonra alt katmanlar açılır. |

---
