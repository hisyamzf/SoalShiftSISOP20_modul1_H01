# SoalShiftSISOP20_modul1_H01

Soal Shift Sistem Operasi 2020\


Hisyam Zulkarnain F             05311840000019\
Bayu Trianayasa                 05311840000038
## #1 &ndash; Mengolah Data
> Source code: [soal1.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal1.sh)

---
Soal 1A\
Mencari satu *region* dengan *profit* paling minimal.

```bash

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

```bash
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

```bash
awk -F "," -v c=$c1 'NR>1{if($11~c)var[$17]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F "," 'NR<11 {printf "%s\n", $1 }'
echo ""
awk -F "," -v d=$c2 'NR>1{if($11~d)var[$17]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F " ," 'NR<11 {printf "%s\n", $1}'

```

`'NR<11 {printf "%s\n", $1 }'` Dikarenakan diperintahkan untuk mencari 10 produk yang meiliki profit terendah, maka NR<11 yang artinya adalah jika melebihi dari baris ke 10 maka perintah tersebut tidak akan dilanjutkan. 


`echo ""` untuk mencetak new line agar memisahkan produk dari masing-masing state yang telah ditentukan. 

---


## #2 &ndash; Membuat Password acak, lalu melakukan Enkripsi & Dekripsi dari password acak tersebut
> Source code: [soal2.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal2.sh), [soal2c.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal2c.sh), [soal2d.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal2d.sh)

---


Soal 2a 2b\
Membuat password acak lalu menyimpannya dengan ekstensi .txt

```bash
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1 > `echo $1 | tr -dc 'a-zA-Z'`.txt
```

`cat /dev/urandom` untuk mengambil password acak lalu dipilih sebanyak 28 karakter `fold -w 28` dan diambil baris pertama saja `head -n 1`.

`tr -dc 'a-zA-Z0-9'` untuk menyeleksi hasil output random tersebut dan hanya menghasilkan karakter alfanumerik saja dengan mendelete (`-d`) semua karakter kecuali (`-c`) a-z, A-Z, dan 0-9.

Kemudian hasil perintah di atas disimpan ke dalam file yang namanya diinputkan sebagai argumen (`$1`) sehingga hanya mengandung karakter alfabet dengan `tr -dc 'a-zA-Z'`.

---

Soal 2c\
Script Bash Enkripsi

```bash
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


```bash
#!/bin/bash

kecil='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
gede='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
amt=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
a=$(echo $1 | grep -oP '.*(?=\.txt)' | tr ${kecil:$amt:26}${gede:$amt:26} ${kecil:0:26}${gede:0:26})
mv $1 $a".txt"
```

Sama saja seperti *script* enkripsi, hanya saja set pertama dan set kedua ditukar sehingga pergeseran dibalik. Lalu, pergeseran yang dilakukan sebanyak jam file input dibuat, yang bisa diambil dengan 

`stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)'` untuk menampilkan file sistem status lalu mengambil jam file input dibuat. 

## #3 &ndash;
> Source code: [soal3a.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal3a.sh), [soal3b.sh](https://github.com/hisyamzf/SoalShiftSISOP20_modul1_H01/blob/master/soal3b.txt, [soal3c.sh]()

---

Soal3a\
Download 28 picture.

```bash
#!/bin/bash

for i in {1..28} do wget -O pdkt_kusuma_$i https://loremflickr.com/320/240/cat -a wget.log done
```

`for i in {1..28} do` Perintah looping for selama i didalam angka 1-28 maka lakukan perintah selanjutnya.


`wget -O pdkt_kusuma_$i https://loremflickr.com/320/240/cat -a wget.log done` fungsi `-wget` untuk mendownload picture dan `-o` untuk mengubah nama file dan `-a` untuk menambahkan file dari web yang udah dicantumkan.

---

Soal 3b\
Crontab

```bash
5 6-23/8 * * 0-5 cd /home/osboxes/sisop20/soal3a.sh
```

`5` artinya menit ke-5.


`6-23/8` artinya setiap 8 jam sekali dari jam 06.00-23.00.


`0-5` artinya setiap hari kecuali hari sabtu.




