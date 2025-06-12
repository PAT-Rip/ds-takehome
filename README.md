# 📦 Tech Test Project Overview
Proyek ini terdiri dari tiga bagian utama yang mencakup analisis data, pemodelan machine learning, dan validasi model. Setiap bagian menggunakan dataset dan pendekatan berbeda sesuai dengan tujuan analisisnya.

1. analysis.sql
Berisi query SQL yang digunakan untuk:

* Menghitung nilai RFM (Recency, Frequency, Monetary) dari pelanggan.
* Melakukan segmentasi pelanggan ke dalam ≥6 kategori berdasarkan skor RFM.
* Mengidentifikasi repeat purchase bulanan dari dataset e_commerce_transactions.csv.
* Deteksi anomali menggunakan kolom decoy_flag dan decoy_noise.

2. B_modelling.ipynb
Berisi proses end-to-end pembuatan model machine learning menggunakan data credit_scoring.csv, termasuk:

* Eksplorasi Data Awal (EDA) dan pembersihan data (drop fitur leakage).
* Pembangunan model baseline (Logistic Regression) hingga Gradient Boosting.
* Kalibrasi skor probabilitas dan pembuatan scorecard skala industri (300–850).
* Analisis interpretabilitas model menggunakan SHAP values dan pembuatan slide keputusan pinjaman sebesar IDR 5 juta.

3. validations_R.ipynb
Notebook berbasis R yang digunakan untuk:

* Melakukan evaluasi model menggunakan Hosmer-Lemeshow goodness-of-fit test.
* Menampilkan calibration curve sebagai validasi probabilitas.
* Menentukan cut-off score untuk meminimalkan risiko (expected default ≤ 5%).

# ✍️ Catatan
1. Semua file bersifat modular dan dapat dijalankan secara terpisah.
2. Gunakan kernel R untuk notebook validations_R.ipynb.
3. Kalibrasi model dan evaluasi dilakukan secara hati-hati untuk memastikan keputusan berbasis data dapat diandalkan.
