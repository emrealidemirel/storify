# Storify

[English](README.md) · **Türkçe**

Storify, Android ve iOS için geliştirilmiş etkileşimli bir hikâye uygulamasıdır. Hikâyenin türünü ve kahramanını seç, bir bölümü oku ve sırada ne olacağına karar ver. Türkçe veya İngilizce hazır misafir hikâyelerini keşfedebilir ya da giriş yaparak yapay zekâyla kendi hikâyeni oluşturabilirsin.

## Özellikler

- **Seçimlerinle şekillenen hikâyeler:** Her bölümde sunulan üç seçenek, hikâyenin devamına yön verir. Yapay zekâ önceki olayları devam bölümlerinin bağlamında kullanır.
- **Sekiz tür:** Macera, fantastik, gizem, bilim kurgu, korku, romantik, tarihî ve komedi. Kahramanını seçebilir veya seçimi uygulamaya bırakabilirsin.
- **Misafir hikâyeleri:** İki dilde, farklı sonlara ulaşan hazır hikâyeleri yapay zekâ isteği yapmadan keşfet. İlk misafir girişi internet bağlantısı gerektirir.
- **Yapay zekâyla hikâye:** Kayıtlı kullanıcılar hikâye oluşturabilir, aynı cihazda son kaydedilen yapay zekâ hikâyesine devam edebilir ve en fazla 30 bölümde sona ulaşabilir.
- **Hesap yönetimi:** E-posta/şifre ve Google ile giriş, şifre sıfırlama, profil düzenleme ve hesap silme. iOS için Apple ile giriş kodu mevcut; sağlayıcı yapılandırması gerektirir.
- **İçerik kontrolleri:** Yapay zekâyla paylaşım öncesinde izin, üretilen metin ve seçeneklerde moderasyon ve uygulama içinden hikâye bildirme.
- **Kişiselleştirme:** Türkçe ve İngilizce dil desteği, açık ve koyu tema; Storify'nin kahverengi ve altın paletinde farklı ekran boyutlarına uyumlu arayüz.

## Ekran görüntüleri

Örnek hikâyelerle uygulama ekranları:

<img src="docs/store/screenshots/tr-home.png" width="250" alt="Storify Türkçe ana sayfa"> <img src="docs/store/screenshots/tr-selection.png" width="250" alt="Storify Türkçe hikâye türü ve kahraman seçimi"> <img src="docs/store/screenshots/tr-story.png" width="250" alt="Storify Türkçe misafir hikâyesi ve seçenekleri">

<details>
<summary>Koyu tema</summary>

<img src="docs/store/screenshots/tr-story-dark.png" width="250" alt="Storify koyu temada Türkçe misafir hikâyesi">

</details>

## Veriler ve gizlilik

Son yapay zekâ hikâyesi ve tercihler cihazda saklanır; hikâyeler cihazlar arasında senkronize edilmez. Kimlik doğrulama, profil fotoğrafları ve gönderilen içerik bildirimleri için Firebase kullanılır. İzin verildikten sonra yapay zekâ üretimi için hikâye bağlamı ve seçimler OpenAI'a gönderilir. Bu izin uygulama içinden geri alınabilir. Storify reklam, satın alma veya kullanım analitiği entegrasyonu içermez.

Hesap silme işlemi yeniden kimlik doğrulaması gerektirir; ilişkili dosyaları, yerel hikâye verilerini ve hesabı kaldırır.

[Veri işleme açıklaması](docs/DATA_AND_PRIVACY.md#türkçe) · [Yayın kontrol listesi](docs/release_preparation.md)

## Geliştirme

Uygulama geliştirme aşamasındadır. Dağıtım öncesinde yapay zekâ istekleri, uygulamadaki geliştirme anahtarı yerine kimlik doğrulamalı bir sunucu üzerinden çalışmalıdır. İmzalama, herkese açık gizlilik ve hesap silme sayfaları ile fiziksel cihaz testleri de tamamlanmalıdır.

Storify, Flutter ile geliştirilmiştir. Durum yönetiminde Bloc/Cubit, yerel hikâye ilerlemesi ve tercihler için SharedPreferences, kimlik doğrulama ve dosya depolama için Firebase kullanılır. Çeviriler `easy_localization` ile yönetilir.

```sh
git clone https://github.com/emrealidemirel/storify.git
cd storify
flutter pub get
cp .env.example .env
flutter run
```

İlgili özellikleri test etmeden önce Firebase sağlayıcılarını ve yerel geliştirme anahtarını yapılandır. Yapay zekâ sağlayıcı anahtarı içeren derlemeleri dağıtma.

Kod ve test kontrolleri:

```sh
flutter analyze --no-pub
flutter test --no-pub
```

Yapılandırma, mimari, Storage kuralı testleri ve derleme komutları [geliştirme rehberinde](docs/DEVELOPMENT.md) açıklanır.

## Destek

Geliştirici: [Emre Ali Demirel](https://github.com/emrealidemirel)

Diğer projeler: [Shien](https://github.com/emrealidemirel/shien) · [BugPilot AI](https://github.com/emrealidemirel/bugpilot-ai)

Sorular ve geri bildirimler için: [emrealidemirel@gmail.com](mailto:emrealidemirel@gmail.com)
