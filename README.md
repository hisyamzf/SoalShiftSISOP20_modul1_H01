# SoalShiftSISOP20_modul1_H01

Soal shift Sistem Operasi 2020\
Hisyam Zulkarnain F             05311840000019\
Bayu Trianayasa                 05311840000038
## #1 &ndash; Mengolah Data
> Source code: [soal1.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal1.sh)

---
Soal 1A mencari satu *region* dengan *profit* paling minimal.

```

`a=`awk -F "," 'NR>1{var[$13]+=$21} END{for( c in var) printf "%s,%f\n",c , var[c]}' Sample-Superstore.csv | sort -g -t"," -k 2  | awk -F "," 'NR<2 {printf "%s\n", $1 }'`
echo $a
echo ""

```
`awk -F ","` Option -F untuk memisah bidang/kolom yang terdapat di .csv


`'NR>1{var[$13]+=$21} END{for( c in var) printf "%s,%f\n",c , var[c]}` untuk mengelompokan masing2 region(kolom13) beserta profitnya(kolom21) lalu dijumlahkan profitnya terhadap region yang sama. lalu cetak hasil pengelompokan serta penjumlahan tersebut.


`Sample-Superstore.csv` Nama file yang ingin diolah datanya.


`sort -g -t"," -k 2` untuk mensortir hasil dari pengelompokkan sebelumnya. `-g` untuk mensortir general number `-t","` untuk mengatur field separatornya dan `-k 2` untuk set key terhadap kolom profit(kolom 2).


``awk -F "," 'NR<2 {printf "%s\n", $1 }'`` untuk mencetak hasil dari sortiran dan mencetak hasil kolom 1 aja.
`echo $a` untuk mencetak hasil dari variabel a

---

Soal 1B mencari state yang memimiliki profit paling rendah berdasarkan hasil dari poin 1A

```
b=`awk -F "," -v a=$a 'NR>1{if($13~a)var[$11]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F "," 'NR<3 {printf "%s\n", $1 }'`
c1=`echo $b | awk -F " " '{print $1}'`
c2=`echo $b | awk -F " " '{print $2}'`
echo $c1 $c2 
echo ""

```

Option`-v a="$a"`untuk memasukkan variabel *shell* ke dalam program AWK dengan nama "a".


`'NR>1{if($13~a)var[$11]+=$21}` Fungsi if berfungsi untuk pengecualian jika kolom 13 sama dengan variable a, maka akan dilanjutkan  dengan mengelompokan masing2 state(kolom11) beserta profitnya(kolom21) lalu dijumlahkan profitnya terhadap state yang sama. 


``c1=`echo $b` | `awk -F " " '{print $1}'`` berfungsi untuk mencetak kolom 1 dari hasil state yang telah dikelompokkan berdasarkan profitnya. karena output dari perintah sebelumnya menghasilkan 2 hasil (state) 

---
Soal 1C mencari 10 nama produk yang memiliki profit paling sedikit berdasarkan state yang telah ditentukan dari point 1B. 

```
awk -F "," -v c=$c1 'NR>1{if($11~c)var[$17]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F "," 'NR<11 {printf "%s\n", $1 }'
echo ""
awk -F "," -v d=$c2 'NR>1{if($11~d)var[$17]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F " ," 'NR<11 {printf "%s\n", $1}'

```

`'NR<11 {printf "%s\n", $1 }'` Dikarenakan diperintahkan untuk mencari 10 produk yang meiliki profit terendah, maka NR<11 yang artinya adalah jika melebihi dari baris ke 10 maka perintah tersebut tidak akan dilanjutkan. 


`echo ""` untuk mencetak new line agar memisahkan produk dari masing-masing state yang telah ditentukan. 

---


## #2 &ndash; Membuat Password acak, lalu melakukan Enkripsi & Dekripsi dari password acak tersebut
> Source code: [soal2.sh](https://github.com/1Maximuse/SoalShiftSISOP20_modul1_B09/blob/master/soal2/soal2.sh), [soal2_enkripsi.sh](https://github.com/1Maximuse/SoalShiftSISOP20_modul1_B09/blob/master/soal2/soal2_enkripsi.sh), [soal2_dekripsi.sh](https://github.com/1Maximuse/SoalShiftSISOP20_modul1_B09/blob/master/soal2/soal2_dekripsi.sh)

---

Pertama, untuk men-*generate* password sepanjang 28 karakter alfanumerik, digunakan perintah berikut.

```shell
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1 > `echo $1 | tr -dc 'a-zA-Z'`.txt
```

`cat /dev/urandom` membaca lokasi `/dev/urandom`, yaitu file spesial dalam UNIX yang berfungsi sebagai *pseudo-RNG*.

`tr -dc 'a-zA-Z0-9'` menseleksi hasil output random tersebut dan hanya mengoutputkan karakter alfanumerik saja dengan mendelete (`-d`) semua karakter kecuali (`-c`) a-z, A-Z, dan 0-9.

`fold -w 28` memecah output menjadi baris-baris dengan panjang baris 28 karakter.

`head -n 1` mengambil baris teratas saja untuk mendapatkan satu hasil.

Hasil perintah-perintah di atas disimpan ke dalam file yang namanya diinputkan sebagai argumen (`$1`) dan diproses sehingga hanya mengandung karakter alfabet dengan `tr -dc 'a-zA-Z'`.

---

Kemudian, *script* enkripsi dibuat dengan perintah berikut.

```shell
strip='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
strip2='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
a=$(echo $1 | grep -oP '.*(?=\.txt)' | tr ${strip:0:26}${strip2:0:26} ${strip:`date +%-H`:26}${strip2:`date +%-H`:26})
cp $1 $a".txt"
```

Dibuat dua variabel yang berisi urutan alfabet kecil dan kapital sebanyak dua perulangan.

`echo $1 | grep -oP '.*(?=\.txt)'` membaca argumen pertama untuk nama file, dan mengambil namanya saja tanpa ekstensi.

`tr ${strip:0:26}${strip2:0:26} ${strip:``date +%-H``:26}${strip2:``date +%-H``:26}` melakukan *caesar cipher* dengan membuat dua set urutan karakter. `${strip:0:26}` untuk mengambil substring dari variable `strip` yaitu 26 karakter pertama (a-z). Sama untuk karakter kapital, dengan `${strip2:0:26}`. Set kedua dibuat dengan cara yang sama, namun dengan `${strip:``date +%-H``:26}${strip2:``date +%-H``:26}` menggeser bagian yang diambil sesuai dengan jam sekarang dengan `date +%-H`.

Contoh, pada jam 3 pagi maka perintah `tr` akan menjadi `tr abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ defghijklmnopqrstuvwxyzabcDEFGHIJKLMNOPQRSTUVWXYZABC`.

Hasilnya digunakan untuk memberi nama salinan file yang diinputkan dengan perintah `cp $1 $a".txt`.

---

*Script* dekripsi dibuat dengan perintah berikut.

```shell
strip='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
strip2='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
amt=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
a=$(echo $1 | grep -oP '.*(?=\.txt)' | tr ${strip:$amt:26}${strip2:$amt:26} ${strip:0:26}${strip2:0:26})
cp $1 $a".txt"
```

Sama saja seperti *script* enkripsi, hanya saja set pertama dan set kedua ditukar sehingga pergeseran dibalik. Lalu, pergeseran yang dilakukan sebanyak jam file input dibuat, yang bisa diambil dengan `stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)'`

`stat -c %y $1` untuk mengakses waktu file dimodifikasi (dan dibuat).

`grep -oP '(?<=[^ ] ).*(?=:.*:)'` untuk mengambil jamnya saja.

## #3 &ndash; Cat
> Source code: [soal3.sh](https://github.com/1Maximuse/SoalShiftSISOP20_modul1_B09/blob/master/soal3/soal3.sh), [soal3_cron.txt](https://github.com/1Maximuse/SoalShiftSISOP20_modul1_B09/blob/master/soal3/soal3_cron.txt), [soal3_identify.sh](https://github.com/1Maximuse/SoalShiftSISOP20_modul1_B09/blob/master/soal3/soal3_identify.sh)

---

Untuk mendownload gambar, digunakan script `soal3.sh` berisi kode berikut.

```shell
i=$(ls pdkt_kusuma_* | grep -o '[0-9]*' | sort -rn | head -n 1)
for ((x = 0; x < 28; x++))
do
	i=$(($i+1))
	wget -O pdkt_kusuma_$i https://loremflickr.com/320/240/cat -a wget.log
done
```

Pertama, perintah `ls pdkt_kusuma_* | grep -o '[0-9]*' | sort -rn | head -n 1` mengambil indeks terakhir dari gambar-gambar yang sudah terdownload sebelumnya.

`ls pdkt_kusuma_*` menampilkan semua file dengan awalan "pdkt_kusuma_".

`grep -o '[0-9]*'` hanya mengoutputkan bagian angkanya saja.

`sort -rn` mengurutkan hasil output sebelumnya berdasar angka (`-n`) sehingga yang paling besar di atas (`-r`).

`head -n 1` mengambil yang paling besar saja (paling atas).

Kemudian, nilai `i` ditambah 1.

Kemudian gambar bisa didownload dan disimpan menyesuaikan dengan nilai `i`, dan output di-*append* ke file `wget.log`.

Ini dilakukan sebanyak 28 kali untuk mendownload 28 gambar dari URL tersebut.

---

Untuk menjalankan script `soal3.sh` setiap 8 jam dimulai dari jam 6.05 kecuali hari Sabtu, dibuat cron job berikut.

```
5 6-23/8 * * 0-5 /home/noel/Desktop/modul1/soal3.sh
```

`5 6-23/8 * * 0-5` berarti menit 5, jam 6 sampai 23 (dilakukan setiap 8 jam), tanggal berapapun, bulan apapun, hari Minggu - Jumat.

`/home/noel/Desktop/modul1/soal3.sh` menandakan lokasi file, dalam kasus ini terletak pada Desktop user noel, dalam folder modul1.

---

Untuk mencari duplikat, script `soal3_identify.sh` berisi kode berikut.

```awk
cat wget.log | grep Location: > location.log

mkdir kenangan
mkdir duplicate
awk '{
	i++
	print i ";" $2
}' location.log | awk -F ';' '{
	cnt[$2]++
	if (cnt[$2] > 1) {
		cmd = "mv pdkt_kusuma_" $1 " duplicate/duplicate_" $1
	} else {
		cmd = "mv pdkt_kusuma_" $1 " kenangan/kenangan_" $1
	}
	system(cmd)
}'
ls *.log | awk '{
	cmd = "cp " $0 " " $0 ".bak"
	system(cmd)
}'
```

Pertama, baris-baris pada *logfile* `wget.log` yang mengandung karakter "Location:" disimpan pada file "location.log".

Sebelum dimulai, dibuat folder "kenangan" dan "duplicate" untuk memastikan kedua folder itu sudah ada.

Lalu, dengan perintah AWK setiap baris diberi nomor sesuai dengan nomor download gambarnya, dan dari file "location.log" diambil *path*nya saja untuk membantu mengidentifikasi file identik, dipisahkan dengan `;`.

Hasil dari perintah AWK tersebut dijalankan AWK lagi dengan *field separator* `;`.

Dibuat *associative array* dengan key yaitu *path* yang didapat dari file "location.log". Untuk setiap file dengan *path* sama, nilai array ditambah satu.

Untuk setiap baris, dicek apabila sudah ada lebih dari satu *path* yang sama, maka file dipindah ke folder "duplicate" dan diberi nama "duplicate_xx" sesuai dengan nomornya, sedangkan apabila file belum ada yang menyamai maka dipindah ke folder "kenangan" dan diberi nama "kenangan_xx".

Setelah semua pemindahan selesai, dilakukan *backup* seluruh *logfile*.

`ls *.log` untuk menampilkan seluruh *logfile* yang ada, kemudian perintah AWK digunakan untuk menyalin file tersebut dengan ekstensi tambahan ".bak".
