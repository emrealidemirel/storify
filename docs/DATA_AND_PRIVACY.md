# Storify data handling

[English](#english) · [Türkçe](#türkçe)

## English

This is a technical description of the current development build, not a published production privacy policy. Publisher details, retention terms, and public privacy/account-deletion URLs remain release tasks.

| Data | Current handling |
| --- | --- |
| Account | Firebase Authentication handles email/password, Google, anonymous sessions, and the implemented Apple provider flow. |
| Profile | Optional name/photo; photos are stored under the account's Firebase Storage path. |
| Story progress | The latest AI story, its choices, and an owner identifier are stored locally with SharedPreferences. There is no cloud story sync or story library. |
| Guest stories | Bundled Turkish/English story graphs run locally after guest authentication; the initial anonymous sign-in needs a connection. Guest story progress is not persisted across sessions. |
| AI requests | Story theme, protagonist selection, passages, and choices are sent to OpenAI for generation and moderation after account-specific permission. The app does not intentionally include the profile name, email, or photo in these payloads. |
| Content reports | The reported passages, choices, and reason are uploaded to the user's Storage path for developer review. No automated email notification or review dashboard is implemented. |
| Preferences | Language, theme, and account-specific AI permission are stored locally. Permission can be withdrawn in the app. |

There are no advertising, purchase, or usage analytics integrations. Firebase and AI providers still process data required by their services; absence of an analytics integration is not a claim that no service data is collected.

Account deletion is available in Settings for registered accounts. It reauthenticates the user, deletes associated Storage files, clears local story/consent data, and then deletes the Firebase Auth account. Failed file cleanup prevents Auth deletion so the operation can be retried. The sequence is not an atomic transaction and does not promise deletion of provider-side logs or backups. A public external deletion-request page is pending.

AI credentials are currently bundled for local development. Move generation/moderation to an authenticated backend and remove the bundled secret before distribution. Review and deploy Storage rules to the intended Firebase project; local emulator tests do not establish the live configuration.

## Türkçe

Bu belge mevcut geliştirme sürümünün teknik veri akışını açıklar; yayımlanmış bir üretim gizlilik politikası değildir. Yayıncı bilgileri, saklama süreleri ve herkese açık gizlilik/hesap silme adresleri yayın öncesinde tamamlanmalıdır.

| Veri | Mevcut işleyiş |
| --- | --- |
| Hesap | E-posta/şifre, Google, anonim oturum ve kodu eklenmiş Apple sağlayıcısı akışı Firebase Authentication üzerinden yürütülür. |
| Profil | İsteğe bağlı ad/fotoğraf; fotoğraf hesabın Firebase Storage yolunda tutulur. |
| Hikâye ilerlemesi | Son AI hikâyesi, seçenekleri ve sahip kimliği SharedPreferences ile cihazda saklanır. Bulut hikâye senkronizasyonu veya hikâye kütüphanesi yoktur. |
| Misafir hikâyeleri | Türkçe/İngilizce hazır hikâye grafikleri misafir girişi sonrasında yerelde çalışır. İlk anonim giriş internet gerektirir. Misafir ilerlemesi oturumlar arasında kaydedilmez. |
| AI istekleri | Hesaba özel izin sonrasında hikâye türü, kahraman seçimi, bölümler ve seçenekler üretim/moderasyon için OpenAI'a gönderilir. Uygulama profil adını, e-postayı veya fotoğrafı bu isteklere bilerek eklemez. |
| İçerik bildirimleri | Bildirilen bölümler, seçenekler ve gerekçe geliştirici incelemesi için kullanıcının Storage yoluna yüklenir. Otomatik e-posta veya inceleme paneli yoktur. |
| Tercihler | Dil, tema ve hesaba özel AI izni yerelde saklanır. İzin uygulamadan geri alınabilir. |

Reklam, satın alma veya kullanım analitiği entegrasyonu yoktur. Firebase ve AI sağlayıcıları hizmetleri için gerekli verileri işlemeye devam eder; analitik entegrasyonu olmaması hiçbir hizmet verisinin toplanmadığı anlamına gelmez.

Kayıtlı hesaplar Ayarlar üzerinden silinebilir. İşlem yeniden kimlik doğrulaması yapar, ilişkili Storage dosyalarını siler, yerel hikâye/izin verilerini temizler ve ardından Firebase Auth hesabını siler. Dosya temizliği başarısızsa Auth hesabı silinmez ve işlem yeniden denenebilir. Adımlar tek bir transaction değildir; sağlayıcı günlüklerinin veya yedeklerinin silindiği taahhüt edilmez. Uygulama dışından silme talebi için herkese açık sayfa henüz hazırlanmamıştır.

AI anahtarı şu anda yerel geliştirme için pakete eklenir. Dağıtım öncesinde üretim/moderasyon kimlik doğrulayan bir sunucuya taşınmalı ve paket içindeki gizli anahtar kaldırılmalıdır. Storage kuralları hedef Firebase projesine incelenerek uygulanmalıdır; yerel emülatör testleri canlı yapılandırmayı doğrulamaz.
