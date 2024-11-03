# Final Submission: Dutch Sarcasm Headline

Nama: Daffa Maulana Haekal

Username dicoding: daffa mh

|                         | Deskripsi                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Dataset                 | [Dutch news headlines for sarcasm detection](https://www.kaggle.com/datasets/harrotuin/dutch-news-headlines)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Masalah                 | Deteksi sarcasm dalam teks berita merupakan tantangan tersendiri, karena sarcasm sering kali tidak dapat dikenali hanya dari kata-kata yang digunakan. Secara umum, dalam headline berita, sarcasm mungkin muncul dalam bentuk kontradiksi antara apa yang tampak di permukaan dengan makna yang sebenarnya. Untuk bahasa Belanda, masih relatif jarang ditemukan dataset yang secara khusus menargetkan deteksi sarcasm, sehingga dibutuhkan sistem yang dapat mengidentifikasi perbedaan halus ini.                                                                                                    |
| Solusi machine learning | Untuk memecahkan masalah deteksi sarcasm, digunakan pendekatan pipeline machine learning berbasis NLP sehingga setiap headline berbahasa belanda dapat dideteksi berupa sarcasm ataupun tidak.                                                                                                                                                                                                                                                                                                                                                                                                           |
|                         |
| Metode pengolahan       | Dataset yang digunakan pada proyek ini merupakan ekstraksi dari dataset headlines_news dimana didapatkan 2 kolom yaitu "headlines" dan "is_sarcastic". Terjadi juga proses preprocessing dengan me-non-kapitalisasi besar huruf dari atribut headlines sehingga non kapital semua. Setelah itu, dataset akan dibagi ke dalam train dan evaluation dengan rasio 8:2.                                                                                                                                                                                                                                      |
| Arsitektur model        | Model yang digunakan pada proyek adalah model jaringan syaratf tiruan yang dibangun menggunakan beberapa jenis layer, yaitu Input, TextVectorization, Embedding, dan GlobalAveragePooling1D, dan Dense. Untuk fully connected layer pada model proyek ini terdiri dari 2 dense layer dengan masing-masin unit sebanyak 64 dan 15 menggunakan fungsi aktivasi relu. Dan pada output layer model menggunakan dense layer dengan 1 unit dan fungsi aktivasi sigmoid. Untuk perhitungan loss yang digunakan pada model ini adalah binary crossentropy, model ini juga menggunakan Adam sebagai optimizernya. |
| Metrik evaluasi         | Untuk mengevaluasi performa dari model yang digunakan, proyek ini menggunakan beberapa metrik evaluasi, yaitu AUC, FalsePositives, TruePositives, FalseNegatives, TrueNegatives, dan Accuracy.                                                                                                                                                                                                                                                                                                                                                                                                           |
| Performa model          | Performa model yang saya buat memiliki capaian berupa AUC 87%, Accuracy 84%, True Positive 542, False Positive 250 , True Negative 3478 , dan False Negative 481                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Opsi Deployment          | Untuk deployment, sistem ini akan dideploy menggunakan platform railway
| Web App          | [Dutch news sarcasm detection](https://deutch-sarcastic-detection-model-production.up.railway.app/v1/models/deutch-sarcastic-detection-model)  
| Monitoring         | Monitoring pada sistem ini dilakukan menggunakan Prometheus dan Grafana. Monitoring ini bertujuan untuk menampilkan permintaan yang masuk ke sistem, serta menunjukkan status dari setiap permintaan yang diproses. Sistem ini menampilkan tiga status: jika request deteksi tidak ditemukan, jika terjadi kesalahan argumen, dan jika request deteksi berhasil yang ditandai dengan status "ok".  
