-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2025 at 01:16 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_buku` (IN `buku_id` INT)   BEGIN
    DELETE FROM buku WHERE id_buku = buku_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_peminjaman` (IN `pinjam_id` INT)   BEGIN
    DELETE FROM peminjaman WHERE id_peminjaman = pinjam_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_siswa` (IN `siswa_id` INT)   BEGIN
    DELETE FROM siswa WHERE id_siswa = siswa_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllBuku` ()   BEGIN
    SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllBukuStatus` ()   BEGIN
    SELECT b.id_buku, b.judul_buku, b.penulis, b.kategori, b.stok, 
           CASE 
               WHEN p.id_buku IS NULL THEN 'Belum Pernah Dipinjam'
               ELSE 'Pernah Dipinjam'
           END AS status_peminjaman
    FROM buku b
    LEFT JOIN peminjaman p ON b.id_buku = p.id_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPeminjaman` ()   BEGIN
    SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllSiswa` ()   BEGIN
    SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertBuku` ()   BEGIN
    INSERT INTO Buku (Judul_Buku, Penulis, Kategori, Stok) VALUES
    ('Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
    ('Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
    ('Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 9),
    ('Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
    ('Biologi Dasar', 'Budi Rahman', 'Sains', 7),
    ('Kimia Organik', 'Siti Aminah', 'Sains', 5),
    ('Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
    ('Fisika Modern', 'Albert Einstein', 'Sains', 4),
    ('Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
    ('Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertPeminjaman` ()   BEGIN
    INSERT INTO Peminjaman (ID_Siswa, ID_Buku, Tanggal_Pinjam, Tanggal_Kembali, Status) VALUES
    (6, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
    (7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
    (8, 9, '2025-02-03', '2025-02-10', 'Dipinjam'),
    (9, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
    (10, 11, '2025-02-01', '2025-02-08', 'Dipinjam'),
    (11, 6, '2025-02-02', '2025-02-09', 'Dipinjam'),
    (12, 14, '2025-02-03', '2025-02-10', 'Dipinjam'),
    (13, 12, '2025-02-04', '2025-02-11', 'Dikembalikan'),
    (14, 15, '2025-02-05', '2025-02-12', 'Dipinjam'),
    (15, 13, '2025-02-06', '2025-02-13', 'Dipinjam');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertSiswa` ()   BEGIN
    INSERT INTO Siswa (Nama, Kelas) VALUES
    ('Farhan Maulana', 'XII-TKJ'),
    ('Gita Permata', 'X-RPL'),
    ('Hadi Sucipto', 'X-TKJ'),
    ('Intan Permadi', 'XI-RPL'),
    ('Joko Santoso', 'XI-TKJ'),
    ('Kartika Sari', 'XII-RPL'),
    ('Lintang Putri', 'XII-TKJ'),
    ('Muhammad Rizky', 'X-RPL'),
    ('Novi Andriana', 'X-TKJ'),
    ('Olivia Hernanda', 'XI-RPL');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_buku` (IN `pJudulBuku` VARCHAR(50), IN `pPenulis` VARCHAR(50), IN `pKategori` VARCHAR(30), IN `pStok` INT)   BEGIN
    INSERT INTO buku (Judul_Buku, Penulis, Kategori, Stok) 
    VALUES (pJudulBuku, pPenulis, pKategori, pStok);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_peminjaman` (IN `pIdSiswa` INT, IN `pIdBuku` INT, IN `pTanggalPinjam` DATE, IN `pTanggalKembali` DATE, IN `pStatus` VARCHAR(20))   BEGIN
    INSERT INTO peminjaman (id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status) 
    VALUES (pIdSiswa, pIdBuku, pTanggalPinjam, pTanggalKembali, pStatus);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_siswa` (IN `pNama` VARCHAR(50), IN `pKelas` VARCHAR(10))   BEGIN
    INSERT INTO siswa (Nama, Kelas) 
    VALUES (pNama, pKelas);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `KembalikanBuku` (IN `id_pinjam` INT)   BEGIN
    UPDATE peminjaman 
    SET status = 'Dikembalikan', tanggal_kembali = CURDATE() 
    WHERE id_peminjaman = id_pinjam;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SemuaSiswa` ()   BEGIN
    SELECT s.* FROM siswa s
    LEFT JOIN peminjaman p ON s.id_siswa = p.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SiswaPernahPinjam` ()   BEGIN
    SELECT DISTINCT s.* FROM siswa s
    JOIN peminjaman p ON s.id_siswa = p.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_buku` (IN `buku_id` INT, IN `new_judul` VARCHAR(50), IN `new_penulis` VARCHAR(50), IN `new_kat` VARCHAR(30), IN `new_stok` INT)   BEGIN
    UPDATE buku 
    SET 
        judul_buku = new_judul, 
        penulis = new_penulis, 
        kategori = new_kat, 
        stok = new_stok 
    WHERE id_buku = buku_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_peminjaman` (IN `pinjam_id` INT, IN `new_id_siswa` INT, IN `new_id_buku` INT, IN `new_tgl_pinjam` DATE, IN `new_tgl_kembali` DATE, IN `new_status` ENUM('Dipinjam','Dikembalikan'))   BEGIN
    UPDATE peminjaman 
    SET 
        id_siswa = new_id_siswa, 
        id_buku = new_id_buku, 
        tanggal_pinjam = new_tgl_pinjam, 
        tanggal_kembali = new_tgl_kembali, 
        status = new_status
    WHERE id_peminjaman = pinjam_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_siswa` (IN `siswa_id` INT, IN `new_nama` VARCHAR(50), IN `new_kelas` VARCHAR(20))   BEGIN
    UPDATE siswa 
    SET 
        nama = new_nama, 
        kelas = new_kelas
    WHERE id_siswa = siswa_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul_buku` varchar(50) NOT NULL,
  `penulis` varchar(50) NOT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan Pemrograman', 'Andi Wijaya', 'Teknologi', 5),
(2, 'Dasar-dasar Database', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 3),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 8),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 9),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_siswa` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `tanggal_pinjam` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`) VALUES
(6, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(8, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(9, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(10, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(11, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(12, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(13, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(14, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(15, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan');

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `kurangi_stok` BEFORE INSERT ON `peminjaman` FOR EACH ROW BEGIN
    UPDATE buku SET stok = stok - 1 WHERE id_buku = NEW.id_buku;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tambah_stok` BEFORE UPDATE ON `peminjaman` FOR EACH ROW BEGIN
    IF NEW.status = 'Dikembalikan' AND OLD.status = 'Dipinjam' THEN
        UPDATE buku SET stok = stok + 1 WHERE id_buku = NEW.id_buku;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `kelas` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Andi Saputra', 'X-RPL'),
(7, 'Budi Wijaya', 'X-TKJ'),
(8, 'Citra Lestari', 'XI-RPL'),
(9, 'Dewi Kurniawan', 'XI-TKJ'),
(10, 'Eko Prasetyo', 'XII-RPL'),
(11, 'Farhan Maulana', 'XII-TKJ'),
(12, 'Gita Purnama', 'X-RPL'),
(13, 'Hadi Pratama', 'XI-TKJ'),
(14, 'Indah Sari', 'XI-RPL'),
(15, 'Joko Susilo', 'XII-TKJ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
