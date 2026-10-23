# 📊 Penerapan Analisis Cluster untuk Segmentasi Kabupaten/Kota di Jawa Timur Berdasarkan Pendapatan Pekerja Informal dan Pendidikan Terakhir

![R](https://img.shields.io/badge/Language-R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Statistics](https://img.shields.io/badge/Domain-Applied%20Statistics-00b4d8?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

---

## 📌 1. Project Overview

Proyek ini merupakan bagian dari laporan Praktik Kerja Lapangan (PKL) di **Badan Pusat Statistik (BPS) Kota Malang**[cite: 11]. Penelitian ini bertujuan untuk melakukan segmentasi wilayah terhadap 38 Kabupaten/Kota di Provinsi Jawa Timur berdasarkan karakteristik rata-rata pendapatan pekerja informal menurut tingkat pendidikan yang ditamatkan[cite: 2, 9]. 

Data sekunder yang digunakan bersumber dari publikasi BPS **"Jawa Timur dalam Angka 2025"**[cite: 36], dengan empat variabel utama:
* $X_1$: Rata-rata pendapatan pekerja informal yang tidak pernah sekolah[cite: 36].
* $X_2$: Rata-rata pendapatan pekerja informal tamatan SD/MI[cite: 36].
* $X_3$: Rata-rata pendapatan pekerja informal tamatan SMP/MTs[cite: 36].
* $X_4$: Rata-rata pendapatan pekerja informal tamatan SMA ke atas[cite: 36].

---

## 📐 2. Metodologi dan Rumus Matematis

Sebelum menerapkan algoritma pengelompokan (*clustering*), dilakukan serangkaian pengujian asumsi statistik guna memastikan kualitas dan validitas data[cite: 18].

### A. Uji Kecukupan Sampel (Kaiser-Meyer-Olkin / KMO)
Digunakan untuk mengukur apakah sampel yang digunakan telah cukup mewakili populasi[cite: 30]. Nilai KMO dihitung menggunakan rumus[cite: 30]:

$$KMO = \frac{\sum_{i=1}^{n}\sum_{j}^{n}r_{ij}^{2}}{\sum_{i=1}^{n}\sum_{j}^{n}r_{ij}^{2}+\sum_{i=1}^{n}\sum_{j}^{n}a_{ij}^{2}}$$

* **Keterangan:**
  * $r_{ij}^2$ = Koefisien korelasi sederhana antara variabel ke-$i$ dan ke-$j$[cite: 30, 31].
  * $a_{ij}^2$ = Koefisien korelasi parsial antara variabel ke-$i$ dan ke-$j$[cite: 31, 32].
* **Kriteria Pengujian:** Jika $\text{KMO} \ge 0,5$, maka sampel memenuhi syarat kecukupan[cite: 31, 39].

### B. Uji Asumsi Non-Multikolinieritas
Pemeriksaan korelasi Pearson antar variabel dilakukan untuk menghindari hubungan linier yang terlalu kuat di antara variabel penjelas[cite: 31]. Koefisien korelasi ($r$) dirumuskan sebagai berikut[cite: 31]:

$$r = \frac{n \sum_{i=1}^{n}x_{i1}x_{i2}-(\sum_{i=1}^{n}x_{i1})(\sum_{i=1}^{n}x_{i2})}{\sqrt{\left[n\sum_{i=1}^{n}x_{i1}^2-\left(\sum_{i=1}^{n}x_{i1}\right)^2\right] \left[n\sum_{i=1}^{n}x_{i2}^2-\left(\sum_{i=1}^{n}x_{i2}\right)^2\right]}}$$

* **Kriteria Pengujian:** Jika nilai korelasi $r \ge 0,8$, maka terjadi multikolinieritas ($H_0$ ditolak); jika $r < 0,8$, asumsi terpenuhi[cite: 32, 39].

### C. Algoritma K-Means Clustering
Metode non-hierarki (*unsupervised learning*) yang mempartisi data ke dalam $k$ klaster[cite: 31, 32]. Tahapannya meliputi:
1. **Jarak Euclidean** untuk menghitung jarak antar objek ($X_i$) dan pusat klaster/centroid ($X_g$)[cite: 32]:
   $$d(X_i, X_g) = \sqrt{\sum_{j=1}^{p}(X_{ij} - X_{gj})^2}$$
2. **Fungsi Objektif ($J$)** untuk meminimalkan variasi di dalam klaster[cite: 32]:
   $$J = \sum_{i=1}^{n}\sum_{j=1}^{k}a_{ij}d(X_i, C_{kj})^2$$

### D. Evaluasi Silhouette Index
Digunakan untuk mengukur kualitas pengelompokan secara internal[cite: 32, 33]. Nilai indeks silhouette $s(i)$ dihitung dengan rumus[cite: 34]:

$$s(i) = \frac{b(i) - a(i)}{\max(a(i), b(i))}$$

* **Keterangan:**
  * $a(i)$ = Rata-rata jarak objek $i$ dengan semua objek lain dalam satu klaster yang sama[cite: 34].
  * $b(i)$ = Nilai minimum jarak rata-rata objek $i$ dengan semua objek pada klaster lain[cite: 34].
  * Nilai rata-rata keseluruhan (*Average Silhouette Width*) digunakan untuk menentukan jumlah klaster $k$ yang paling optimal[cite: 33, 40].

---

## 📈 3. Hasil Analisis & Temuan Utama

1. **Uji Asumsi:**
   * **KMO Test:** Menghasilkan nilai Overall MSA sebesar **0.80**, yang berarti sampel sangat mencukupi[cite: 39, 40].
   * **Multikolinieritas:** Seluruh koefisien korelasi antar variabel bernilai $< 0.8$, menunjukkan tidak adanya pelanggaran asumsi multikolinieritas[cite: 38, 39].
2. **Jumlah Klaster Optimal ($k$):** Berdasarkan pendekatan *Silhouette Index*, titik puncak tertinggi berada pada **$k = 2$** dengan *average silhouette width* $\approx 0.42$[cite: 40].
3. **Karakteristik Klaster:**
   * **Klaster 1 (23 Kabupaten/Kota):** Wilayah dengan rata-rata pendapatan pekerja informal di seluruh jenjang pendidikan yang cenderung **lebih rendah**[cite: 21, 22].
   * **Klaster 2 (15 Kabupaten/Kota):** Wilayah dengan rata-rata pendapatan pekerja informal yang **lebih tinggi** (didominasi kota besar/wilayah industri seperti Surabaya, Malang, Sidoarjo, Gresik, dll.)[cite: 21, 22, 42].

---

## 📁 4. Repository Structure

```text
.
├── Batas Kabupaten/                            # Folder shapefile (.shp) batas administratif wilayah Jatim
├── Data Indikator Kemiskinan Jawa Timur 2024.xlsx # Dataset utama penelitian
├── Draft Laporan Skripsi.pdf                   # Dokumen lengkap laporan PKL
├── Peta Sebaran.mxd                            # Project file ArcMap untuk pemetaan spasial
├── Syntax Code.R                               # Script R untuk analisis data & SKATER/K-Means
├── Tugas-Akhir-Skripsi.Rproj                   # RStudio Project File
└── README.md                                   # Dokumentasi repositori
