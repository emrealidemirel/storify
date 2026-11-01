# Storify proje incelemesi — 1 Kasım 2026

Bu çalışma README/sunum tutarlılığı, ekran görüntüleri, mevcut testler ve yayın hazırlığı belgelerinin kontrolünü kapsar. Canlı Firebase projesi, mağaza hesapları veya gerçek kullanıcı verileri üzerinde işlem yapılmadı. Uygulama çalışma davranışı değiştirilmedi.

## Bu çalışmada tamamlananlar

- Shien ile aynı bölüm sırası: uygulama açıklaması, özellikler, ekran görüntüleri, veri/gizlilik, geliştirme ve destek.
- Birbirine bağlı İngilizce/Türkçe README'ler; ortak geliştirici adı, destek adresi ve Shien bağlantısı.
- Gerçek uygulama bileşenlerinden iki dilde ana sayfa, seçim, misafir hikâyesi ve koyu hikâye ekranları: toplam 8 PNG. Gerçek cihaz çekimi değildir; Flutter widget renderer kullanılır.
- Tek komutla yeniden üretilebilen, gerçek misafir hikâye assetlerini kullanan çekim aracı. Ekran hataları ve hikâyenin yüklenmesi kontrol edilir.
- Önceki README'deki teknik içerik ayrı geliştirme rehberinde korundu. Veri işleme açıklaması üretim gizlilik politikası gibi sunulmadan iki dilde belgelendi.
- Eksik otomatik Flutter kontrolü eklendi: main push ve PR'larda format, analiz ve test. CI boş geliştirme anahtarı şablonunu kullanır; gerçek API anahtarı gerektirmez.
- Repo bağlantıları hedef `emrealidemirel/storify` adıyla güncellendi. Dart paket adı ve Firebase ile eşleşen native uygulama kimlikleri bu repo adı değişikliğinden bağımsızdır.

## Yerelde yeniden doğrulananlar

Ortam: Flutter 3.44.0, Dart 3.12.0; kural testlerinde Node 25 ve Java 21.

| Kontrol | Sonuç |
| --- | --- |
| `flutter analyze --no-pub` | Sorun bulunmadı |
| `flutter test --no-pub` | 72 test geçti; 8 isteğe bağlı ekran çekimi atlandı |
| `flutter test --no-pub --dart-define=CAPTURE_SCREENSHOTS=true test/screenshots/capture_test.dart` | 8 ekran çekimi geçti |
| `dart format --output=none --set-exit-if-changed lib test` | Format farkı yok |
| Storage emülatörü `npm ci && npm test` | 18 kontrol geçti |
| Test araçlarının `npm ci` denetimi | 0 bilinen bağımlılık açığı raporlandı; uygulamanın tamamı için güvenlik taraması değildir |

Ekranların açık/koyu teması ve Türkçe/İngilizce yerleşimleri görsel olarak kontrol edildi. README görselleri ve yerel belge bağlantıları doğrulandı. Bu çalışma sırasında yeni Android/iOS release derlemesi alınmadı; önceki imzasız derlemelerin sonuçları [yayın hazırlığı belgesindedir](release_preparation.md).

## Kalan işler ve öncelik

| Öncelik | Durum / kanıt | Gerekli adım |
| --- | --- | --- |
| P0 | `pubspec.yaml` `.env` dosyasını asset olarak içerir; `StoryRepository` ve `ContentSafetyService` istemciden AI sağlayıcısına gider. | AI/moderasyonu kimlik doğrulayan backend'e taşı; anahtarı paketten çıkar; kullanıcı kotası ve maliyet kontrolünü sunucuda uygula. |
| P1 | `ReleaseConfig` yayıncı/destek/gizlilik/silme adreslerini dış yapılandırmadan bekler; gerçek yayın bilgileri tamamlanmamış. | Yayın bilgilerini ve herkese açık sayfaları tamamla. Teknik veri belgesi bunların yerine geçmez. |
| P1 | Storage kuralları yerelde test edildi; canlı kurallar ve sağlayıcı ayarları doğrulanmadı. | Hedef projeyi ve mevcut kuralları doğrula; yetkili dağıtım sonrası fotoğraf, bildirim ve silmeyi gerçek hesaplarla test et. |
| P1 | Native kimliklerde örnek `com.example` değerleri korunuyor; üretim imzası/Apple sağlayıcısı yapılandırması açık. | Kalıcı kimlikleri, Firebase/OAuth kayıtlarını ve imzalama ayarlarını birlikte tamamla. |
| P1 | Gerçek cihaz giriş/silme/ağ kesintisi akışları ve mağaza doğrulaması bu incelemede çalıştırılmadı. | İmzalı cihaz derlemeleriyle uçtan uca test ve mağaza kontrollerini tamamla. |
| P2 | Yayın hazırlığı belgesinde Gradle/Kotlin için yaklaşan Flutter destek uyarıları var. | Toolchain yükseltmesini ayrı değişiklikte, Android/iOS derlemeleriyle doğrula. |

Mevcut testlerde yeni bir uygulama hatası saptanmadı. Bu sonuç canlı servislerin veya yayın hazırlığının tamamlandığı anlamına gelmez. Önceki çalışmada yayın zamanına ertelenmiş backend ve yayıncı bilgileri bu değişiklikte tamamlanmış sayılmadı.

## İşlevsel sınırlar

- Son AI hikâyesi cihazda saklanır; hikâye kütüphanesi ve cihazlar arası hikâye senkronizasyonu yoktur.
- Misafir hikâyeleri yerel içeriktir, ancak ilk anonim giriş internet gerektirir; misafir ilerlemesi yeniden açılış için kaydedilmez.
- Bildirimler Storage dosyası olarak tutulur; otomatik e-posta veya geliştirici inceleme paneli yoktur.
- Apple giriş kodu ve başarılı widget testleri, canlı sağlayıcı yapılandırmasının çalıştığını kanıtlamaz.
- Premium, ödeme ve reklam entegrasyonu mevcut değildir.

Ayrıntılı sıra ve önceki düzeltmeler: [yayın hazırlığı](release_preparation.md). Geliştirme komutları: [DEVELOPMENT.md](DEVELOPMENT.md).
