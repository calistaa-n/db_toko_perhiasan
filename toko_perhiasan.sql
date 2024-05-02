-- membuat table berlian
CREATE TABLE berlian (
  id_berlian INT PRIMARY KEY AUTO_INCREMENT,
  nama_berlian VARCHAR(255) NOT NULL,
  karat INT NOT NULL,
  berat DECIMAL(10,2) NOT NULL
);

-- memasukkan data ke tabel berlian
INSERT INTO berlian (nama_berlian, karat, berat)
VALUES ('The Star of India', 56.2, 563.3), ('The Hope Diamond', 45.52, 45.52), ('The Cullinan Diamond', 530.2, 3106.75);

SELECT * FROM berlian;

-- membuat table perhiasan
CREATE TABLE perhiasan (
  id_perhiasan INT PRIMARY KEY AUTO_INCREMENT,
  nama_perhiasan VARCHAR(255) NOT NULL,
  deskripsi VARCHAR(255),
  jenis_perhiasan ENUM('kalung', 'liontin', 'cincin', 'gelang') NOT NULL,
  bahan_perhiasan ENUM('emas', 'perak', 'perunggu') NOT NULL,
  berat DECIMAL(10,2) NOT NULL,
  id_berlian INT NOT NULL,
  harga DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_berlian) REFERENCES berlian(id_berlian)
);

-- memasukkan data ke tabel perhiasan
INSERT INTO perhiasan (nama_perhiasan, deskripsi, jenis_perhiasan, bahan_perhiasan, berat, id_berlian, harga)
VALUES ('The Star of India Necklace', 'A stunning necklace adorned with the Star of India diamond.', 'kalung', 'emas', 150.00, 1, 2000000.00),
('The Hope Diamond Ring', 'An elegant ring set with the Hope Diamond.', 'cincin', 'perak', 10.00, 2, 3500000.00),
('The Cullinan Diamond Tiara', 'A crown fit for a queen, featuring the Cullinan Diamond.', 'liontin', 'emas', 200.00, 3, 6000000.00);

SELECT * FROM perhiasan;

/*membuat table customer */
CREATE TABLE customer (
  id_customer INT PRIMARY KEY AUTO_INCREMENT,
  nama_customer VARCHAR(255) NOT NULL,
  alamat VARCHAR(255),
  nomor_telepon VARCHAR(255)
);

/* memasukkan data ke tabel customer */
INSERT INTO customer (nama_customer, alamat, nomor_telepon) VALUES
  ('Budi Santosa', 'Jl. Melati No. 12, Denpasar', '+628123456789'),
  ('Ani Lestari', 'Jl. Mangga No. 23, Surabaya', '+628567890123'),
  ('Dini Putri', 'Jl. Tulip No. 45, Semarang', '+628578901234'),
  ('Eko Susanto', 'Jl. Anggrek No. 56, Yogyakarta', '+628145678901');

SELECT * FROM customer;

/* membuat table penjualan */
CREATE TABLE penjualan (
  id_penjualan INT PRIMARY KEY AUTO_INCREMENT,
  id_customer INT NOT NULL,
  tanggal_penjualan DATE NOT NULL,
  id_perhiasan INT NOT NULL,
  jumlah_penjualan INT NOT NULL,
  total_harga DECIMAL(10,2) NOT NULL,
  diskon DECIMAL(10,2),
  FOREIGN KEY (id_customer) REFERENCES customer(id_customer),
  FOREIGN KEY (id_perhiasan) REFERENCES perhiasan(id_perhiasan)
);

/* masukkan data ke tabel penjualan */
INSERT INTO penjualan (id_customer, tanggal_penjualan, id_perhiasan, jumlah_penjualan, total_harga)
VALUES (1, '2024-05-02', 2, 1, 2000000.00), (2,'2024-05-02', 3, 1, 6000000.00), (2, '2024-05-23', 1, 2, 4000000.00), (4, '2024-04-30', 1, 3, 6000000.00);

SELECT * FROM penjualan;

/* membuat table pembelian */
CREATE TABLE pembelian (
  id_pembelian INT PRIMARY KEY AUTO_INCREMENT,
  tanggal_pembelian DATE NOT NULL,
  id_perhiasan INT NOT NULL,
  jumlah_pembelian INT NOT NULL,
  total_harga DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_perhiasan) REFERENCES perhiasan(id_perhiasan)
);

/* masukkan data ke pembelian */
INSERT INTO pembelian (tanggal_pembelian, id_perhiasan, jumlah_pembelian, total_harga)
VALUES ('2024-05-01', 1, 3, 3000000.00), ('2024-04-29', 2, 1, 850000.00);

SELECT * FROM pembelian;

CREATE VIEW "diskon" AS
SELECT customer.nama_customer, SUM(penjualan.total_harga) AS "total transaksi" FROM customer 
JOIN penjualan ON penjualan.id_customer = customer.id_customer
GROUP BY customer.id_customer
ORDER BY SUM(penjualan.total_harga) DESC; 

CREATE VIEW "best_sellers" AS
SELECT perhiasan.jenis_perhiasan, SUM(penjualan.jumlah_penjualan) AS terjual, SUM(penjualan.total_harga) AS "total transaksi" FROM perhiasan
JOIN penjualan ON perhiasan.id_perhiasan = penjualan.id_perhiasan
GROUP BY perhiasan.jenis_perhiasan
ORDER BY terjual DESC;

CREATE VIEW "harian_pembelian" AS
SELECT tanggal_pembelian, SUM(pembelian.total_harga) AS total_pembelian
FROM pembelian
GROUP BY tanggal_pembelian;

CREATE VIEW "harian_penjualan" AS
SELECT tanggal_penjualan, SUM(penjualan.total_harga) AS total_penjualan
FROM penjualan
GROUP BY tanggal_penjualan;



