# SoalShiftSISOP20_modul1_H01

Soal Shift Sistem Operasi 2020\
Hisyam Zulkarnain F             05311840000019\
Bayu Trianayasa                 05311840000038
## #1 &ndash; Mengolah Data
> Source code: [soal1.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal1.sh)

---
Soal 1A\
Mencari satu *region* dengan *profit* paling minimal.

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

Soal 1B\
Mencari state yang memiliki profit paling rendah berdasarkan hasil dari poin 1A

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
Soal 1C\
Mencari 10 nama produk yang memiliki profit paling sedikit berdasarkan state yang telah ditentukan dari point 1B. 

```
awk -F "," -v c=$c1 'NR>1{if($11~c)var[$17]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F "," 'NR<11 {printf "%s\n", $1 }'
echo ""
awk -F "," -v d=$c2 'NR>1{if($11~d)var[$17]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F " ," 'NR<11 {printf "%s\n", $1}'

```

`'NR<11 {printf "%s\n", $1 }'` Dikarenakan diperintahkan untuk mencari 10 produk yang meiliki profit terendah, maka NR<11 yang artinya adalah jika melebihi dari baris ke 10 maka perintah tersebut tidak akan dilanjutkan. 


`echo ""` untuk mencetak new line agar memisahkan produk dari masing-masing state yang telah ditentukan. 

---


## #2 &ndash; Membuat Password acak, lalu melakukan Enkripsi & Dekripsi dari password acak tersebut
> Source code: [soal2.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal2.sh), [soal2_enkripsi.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal2c.sh), [soal2_dekripsi.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal2d.sh)

---


Soal 2a 2b\
Membuat password acak lalu menyimpannya dengan ekstensi .txt

```shell
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1 > `echo $1 | tr -dc 'a-zA-Z'`.txt
```

`cat /dev/urandom` untuk mengambil password acak lalu dipilih sebanyak 28 karakter `fold -w 28` dan diambil baris pertama saja `head -n 1`.

`tr -dc 'a-zA-Z0-9'` untuk menyeleksi hasil output random tersebut dan hanya menghasilkan karakter alfanumerik saja dengan mendelete (`-d`) semua karakter kecuali (`-c`) a-z, A-Z, dan 0-9.

Kemudian hasil perintah di atas disimpan ke dalam file yang namanya diinputkan sebagai argumen (`$1`) sehingga hanya mengandung karakter alfabet dengan `tr -dc 'a-zA-Z'`.

---

Soal 2c\
Script Bash Enkripsi

```shell
#!/bin/bash
kecil='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
gede='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
a=$(echo $1 | grep -oP '.*(?=\.txt)' | tr ${kecil:0:26}${gede:0:26} ${kecil:`date +%-H`:26}${gede:`date +%-H`:26})
mv $1 $a".txt"
```

urutan alfabet huruf kecil lalu dimasukkan ke variabel *kecil*

urutan alfabet huruf besar lalu dimasukkan ke variabel *gede*

dibuat secara 2x perulangan karena memiliki patokan dengan range *jam* yaitu 2 digit. 

`echo $1 | grep -oP '.*(?=\.txt)'` membaca argumen pertama  lalu mengambil nama file saja tanpa ekstensi.

`tr ${kecil:0:26}${gede:0:26} ${kecil:``date +%-H``:26}${gede:``date +%-H``:26}` melakukan caesar cipher dengan membuat dua set karakter. 

`${kecil:0:26}` untuk mengambil alfabet dari variable `kecil` yaitu 26 karakter pertama (a-z). Begitu juga untuk huruf kapital, dengan `${gede:0:26}`. 

`${kecil:``date +%-H``:26}${gede:``date +%-H``:26}` Sama seperti sebelumnya untuk men set 2 karakter, namun dengan menggeser bagian yang diambil sesuai dengan jam sekarang dengan `date +%-H`.

Lalu hasilnya digunakan untuk men cut nama  file yang diinputkan dengan perintah `mv $1 $a".txt`.

---
Soal 2d\
Script Bash Dekripsi 


```shell
#!/bin/bash

kecil='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
gede='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
amt=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
a=$(echo $1 | grep -oP '.*(?=\.txt)' | tr ${kecil:$amt:26}${gede:$amt:26} ${kecil:0:26}${gede:0:26})
mv $1 $a".txt"
```

Sama saja seperti *script* enkripsi, hanya saja set pertama dan set kedua ditukar sehingga pergeseran dibalik. Lalu, pergeseran yang dilakukan sebanyak jam file input dibuat, yang bisa diambil dengan 

`stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)'` untuk menampilkan file sistem status lalu mengambil jam file input dibuat. 

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
