-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2024 at 02:13 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpus`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `bukuID` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `penulis` varchar(255) NOT NULL,
  `penerbit` varchar(255) NOT NULL,
  `tahunTerbit` int(11) NOT NULL,
  `stok` int(10) NOT NULL DEFAULT 1,
  `tanggal` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`bukuID`, `judul`, `penulis`, `penerbit`, `tahunTerbit`, `stok`, `tanggal`) VALUES
(10, 'buku', 'Buku', 'Buku', 2000, 1, '2024-02-29');

-- --------------------------------------------------------

--
-- Table structure for table `kategoribuku`
--

CREATE TABLE `kategoribuku` (
  `kategoriID` int(11) NOT NULL,
  `namaKategori` varchar(255) NOT NULL,
  `jumlah_buku` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategoribuku`
--

INSERT INTO `kategoribuku` (`kategoriID`, `namaKategori`, `jumlah_buku`) VALUES
(4, 'Strategy', 1);

-- --------------------------------------------------------

--
-- Table structure for table `kategoribuku_relasi`
--

CREATE TABLE `kategoribuku_relasi` (
  `kategoriBukuID` int(11) NOT NULL,
  `bukuID` int(11) NOT NULL,
  `kategoriID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategoribuku_relasi`
--

INSERT INTO `kategoribuku_relasi` (`kategoriBukuID`, `bukuID`, `kategoriID`) VALUES
(11, 9, 2),
(12, 9, 1),
(13, 10, 4);

--
-- Triggers `kategoribuku_relasi`
--
DELIMITER $$
CREATE TRIGGER `after delete` AFTER DELETE ON `kategoribuku_relasi` FOR EACH ROW BEGIN
 UPDATE kategoribuku
    SET jumlah_buku = jumlah_buku - 1
    WHERE kategoriID = OLD.kategoriID;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after insert` AFTER INSERT ON `kategoribuku_relasi` FOR EACH ROW BEGIN
 UPDATE kategoribuku
    SET jumlah_buku = jumlah_buku + 1
    WHERE kategoriID = NEW.kategoriID;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `koleksipribadi`
--

CREATE TABLE `koleksipribadi` (
  `koleksiID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `bukuID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `koleksipribadi`
--

INSERT INTO `koleksipribadi` (`koleksiID`, `userID`, `bukuID`) VALUES
(3, 11, 10),
(4, 12, 10);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `peminjamanID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `bukuID_peminjaman` int(11) NOT NULL,
  `tanggalPeminjaman` date NOT NULL DEFAULT current_timestamp(),
  `tanggalPengembalian` date NOT NULL,
  `statusPeminjaman` varchar(50) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`peminjamanID`, `userID`, `bukuID_peminjaman`, `tanggalPeminjaman`, `tanggalPengembalian`, `statusPeminjaman`) VALUES
(1, 1, 1, '2024-02-29', '2024-03-02', '2'),
(4, 6, 1, '2024-02-29', '2024-03-01', '2'),
(7, 6, 9, '2024-02-29', '2024-03-01', '1'),
(9, 11, 0, '2024-02-29', '0000-00-00', '1');

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `after delete peminjaman` AFTER DELETE ON `peminjaman` FOR EACH ROW BEGIN
    IF OLD.statusPeminjaman = 1 THEN
        UPDATE buku
        SET stok = stok + 1
        WHERE bukuID = OLD.bukuID_peminjaman;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after insert peminjaman` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
    UPDATE buku
    SET stok = stok - 1
    WHERE bukuID = NEW.bukuID_peminjaman;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after update peminjaman` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
    IF NEW.statusPeminjaman = 2 THEN
        UPDATE buku
        SET stok = stok + 1
        WHERE bukuID = NEW.bukuID_peminjaman;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ulasanbuku`
--

CREATE TABLE `ulasanbuku` (
  `ulasanID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `bukuID` int(11) NOT NULL,
  `ulasan` text DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `tanggal` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ulasanbuku`
--

INSERT INTO `ulasanbuku` (`ulasanID`, `userID`, `bukuID`, `ulasan`, `rating`, `tanggal`) VALUES
(1, 1, 1, 'tes2', 3, '2024-02-29'),
(2, 11, 10, 'p', 1, '2024-03-01');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` enum('admin','petugas','peminjam') NOT NULL,
  `email` varchar(255) NOT NULL,
  `namaLengkap` text NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `level`, `email`, `namaLengkap`, `alamat`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 'admin@gmail.com', 'admin', 'batam'),
(10, 'petugas', 'afb91ef692fd08c445e8cb1bab2ccf9c', 'petugas', 'petugas@gmail.com', 'petugas', 'bata,'),
(11, 'zaesen', '30ebbe65c4f2673861539f117aed2062', 'peminjam', 'zaesen@gmail.com', 'zaesenn', 'batam'),
(12, '1', 'c4ca4238a0b923820dcc509a6f75849b', 'peminjam', '12121@gmail.com', '1', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`bukuID`);

--
-- Indexes for table `kategoribuku`
--
ALTER TABLE `kategoribuku`
  ADD PRIMARY KEY (`kategoriID`);

--
-- Indexes for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  ADD PRIMARY KEY (`kategoriBukuID`);

--
-- Indexes for table `koleksipribadi`
--
ALTER TABLE `koleksipribadi`
  ADD PRIMARY KEY (`koleksiID`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`peminjamanID`);

--
-- Indexes for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  ADD PRIMARY KEY (`ulasanID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `nama unik` (`namaLengkap`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `bukuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `kategoribuku`
--
ALTER TABLE `kategoribuku`
  MODIFY `kategoriID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  MODIFY `kategoriBukuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `koleksipribadi`
--
ALTER TABLE `koleksipribadi`
  MODIFY `koleksiID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `peminjamanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  MODIFY `ulasanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
