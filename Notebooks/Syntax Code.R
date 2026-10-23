library(tidyverse)
library(cluster)
library(factoextra)
library(readxl)
library(psych)

#Input Data
dataPKL <- read_excel("D:/KULIII AH/Road to Sarjana/datapkl.xlsx")
data <- data.frame(dataPKL)
dataclus <- data[,-1]
head(dataclus)

## Ubah ke numerik
# Daftar nama kolom yang akan diubah
kolom_untuk_diubah <- c("Tidak.Pernah.Sekolah", "SD.MI", "SMP.MTs", "SMA.ke.Atas")

# Loop melalui setiap kolom dan ubah tipenya
for (kolom in kolom_untuk_diubah) {
  dataclus[[kolom]] <- as.numeric(gsub("\\.", "", dataclus[[kolom]]))
}
# Periksa struktur data setelah perubahan (opsional)
str(dataclus)
# Tampilkan beberapa baris pertama untuk memastikan (opsional)
head(dataclus)
summary(dataclus)
datafix <- scale(dataclus)

#Uji KMO
kmo_result <- KMO(dataclus)
print(kmo_result)

#Asumsi Non Multiko
korelasi <- cor(dataclus[,1:4], method = 'pearson'
  ) 
korelasi 

#Metode Silhouette
fviz_nbclust(datafix, kmeans, method = "silhouette")

#K-Means
km <- kmeans(datafix, 2, nstart = 25)
print(km)
data$cluster <- as.factor(km$cluster)
view(data) 

#Visualisasi
fviz_cluster(km, data = datafix)

#Profiling Cluster
dataclus %>%
  mutate(Cluster = data$cluster) %>%
  group_by(Cluster) %>%
  summarise_all("mean")
