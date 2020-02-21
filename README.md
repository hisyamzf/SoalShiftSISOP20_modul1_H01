# SoalShiftSISOP20_modul1_B09

Soal shift Sistem Operasi 2020\
Hisyam Zulkarnain F             05311840000019\
Bayu Trianayasa                 05311840000038
## #1 &ndash; Mengolah Data
> Source code: [soal1.sh](https://github.com/1Maximuse/SoalShiftSISOP20_modul1_B09/blob/master/soal1/soal1.sh)

---

Untuk bagian soal (a), diminta mencari satu *region* dengan *profit* paling minimal.

Soal (a) dapat diselesaikan dengan program AWK menggunakan *field separator* karakter tab sebagai berikut.

```awk
awk -F '	' '
{
	if ($13 != "Region")
		data[$13] += $21
}
END {
	for (i in data) {
		print data[i] " " i
	}
}' Sample-Superstore.tsv
```

Untuk setiap baris, perlu dicek apakah baris tersebut merupakan baris pertama (yang bukan merupakan data) dengan `if ($13 != "Region")`.

Apabila baris merupakan baris data, *field* ke-21 (*profit*) ditambahkan ke dalam *associative array* dengan *key* *field* ke-13 (*region*).

Setelah melakukan iterasi terhadap seluruh baris file, maka *array* data berisi *profit* total dari setiap *region*. Kita melakukan print untuk setiap *region* yang ada beserta dengan *profit*nya, dengan format berikut.

```
<profit1> <region1>
<profit2> <region2>
...
```

Output dari perintah AWK tersebut di-*pipe* ke dalam urutan perintah berikut.

`sort -g -k 1` untuk melakukan pengurutan sesuai dengan bilangan pecahan (`-g`) pada kolom pertama (`-k 1`) terpisah oleh spasi.

`grep -oP '(?<=[0-9.] ).*'` untuk mengambil nama *region*nya saja, dengan menggunakan POSIX (`-P`) *regex lookbehind* dengan format `(?<=...)` untuk membuang angka di depan sehingga yang terambil hanya karakter sisanya  dengan `.*`.

`head -n 1` untuk hanya mengambil 1 baris teratas.

---

Soal (b) dapat diselesaikan dengan perintah AWK berikut.

```awk
awk -F '	' -v a="$a" '
$13 == a {
	data[$11] += $21
}
END {
	print a
	for (i in data) {
		print data[i] " " i
	}
}' Sample-Superstore.tsv
```

Terdapat argumen `-v a="$a"` yang gunanya untuk memasukkan variabel *shell* ke dalam program AWK dengan nama "a".

Perintah AWK tersebut sama persis dengan solusi soal (a), dengan dua perbedaan:
1. Untuk setiap baris, dilakukan pengecekan apakah *region* record tersebut sesuai dengan hasil soal (a).
2. *Profit* ditambahkan berdasarkan *state* (*field* ke-11).

Hasil perintah AWK tersebut di-*pipe* ke serangkaian perintah yang sama dengan soal (a), kecuali perintah terakhir `head -n 2`, yang mengambil dua baris teratas.

---

Soal (c) dapat diselesaikan dengan perintah AWK berikut.

```awk
awk -F '	' -v b="$b" '
BEGIN {
	split(b, check, "\n")
}
$11 == check[1] || $11 == check[2] {
	data[$17] += $21
}
END {
	for (i in data) {
		print data[i] " " i
	}
}' Sample-Superstore.tsv
```

Sekali lagi, perintah AWK sama persis dengan soal (b), hanya saja untuk setiap baris dilakukan pengecekan bahwa *state* sesuai dengan keluaran soal (b), dan *profit* dijumlahkan berdasarkan *product name*.

---

Untuk soal (a), (b), dan (c), hasil keluaran perintah disimpan dalam sebuah variabel, sehingga dapat dicetak dengan `echo`, dan dapat digunakan untuk soal berikutnya.

## #2 &ndash; Caesar Cipher
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
