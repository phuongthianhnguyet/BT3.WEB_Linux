-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Máy chủ: mariadb:3306
-- Thời gian đã tạo: Th10 06, 2025 lúc 10:30 AM
-- Phiên bản máy phục vụ: 10.11.14-MariaDB-ubu2204
-- Phiên bản PHP: 8.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `BanMyPham`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `LoaiSanPham`
--

CREATE TABLE `LoaiSanPham` (
  `ID` int(10) UNSIGNED NOT NULL,
  `TenLoai` varchar(120) NOT NULL,
  `MoTa` text DEFAULT NULL,
  `IDCha` int(10) UNSIGNED DEFAULT NULL,
  `NgayTao` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `LoaiSanPham`
--

INSERT INTO `LoaiSanPham` (`ID`, `TenLoai`, `MoTa`, `IDCha`, `NgayTao`) VALUES
(1, 'Chăm sóc da', 'Các sản phẩm giúp dưỡng và bảo vệ làn da.', NULL, '2025-11-05 13:22:24'),
(2, 'Trang điểm', 'Sản phẩm dùng để trang điểm mặt.', NULL, '2025-11-05 13:22:24'),
(3, 'Nước hoa', 'Các loại nước hoa cho nam và nữ.', NULL, '2025-11-05 13:22:24'),
(4, 'Chăm sóc tóc', 'Dầu gội, dầu xả và sản phẩm dưỡng tóc.', NULL, '2025-11-05 13:22:24');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `NguoiDung`
--

CREATE TABLE `NguoiDung` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `Ten_dang_nhap` varchar(255) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `HoTen` varchar(150) DEFAULT NULL,
  `SoDienThoai` varchar(30) DEFAULT NULL,
  `LaAdmin` tinyint(1) NOT NULL DEFAULT 0,
  `NgayTao` timestamp NULL DEFAULT current_timestamp(),
  `NgayCapNhat` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `NguoiDung`
--

INSERT INTO `NguoiDung` (`ID`, `Ten_dang_nhap`, `MatKhau`, `HoTen`, `SoDienThoai`, `LaAdmin`, `NgayTao`, `NgayCapNhat`) VALUES
(1, 'admin', '82d03738d760b086e91c7c7b34e9b1db38553d0cb6dc2869dfba4664e369a6c1', 'Quản trị viên', '0901234567', 1, '2025-11-05 13:22:24', '2025-11-06 07:36:52'),
(2, 'nguyet', '82d03738d760b086e91c7c7b34e9b1db38553d0cb6dc2869dfba4664e369a6c1', 'Phương Thị Ánh Nguyệt', '0912345678', 0, '2025-11-05 13:22:24', '2025-11-06 07:36:47');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `SanPham`
--

CREATE TABLE `SanPham` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `MaSP` varchar(100) DEFAULT NULL,
  `TenSP` varchar(255) NOT NULL,
  `MoTaNgan` varchar(512) DEFAULT NULL,
  `Gia` decimal(12,2) NOT NULL DEFAULT 0.00,
  `GiaGoc` decimal(12,2) DEFAULT NULL,
  `TonKho` int(11) NOT NULL DEFAULT 0,
  `DangBan` tinyint(1) DEFAULT 1,
  `NoiBat` tinyint(1) DEFAULT 0,
  `SoLuongBan` int(255) NOT NULL,
  `Anh` varchar(64) DEFAULT NULL,
  `NgayTao` timestamp NULL DEFAULT current_timestamp(),
  `NgayCapNhat` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `SanPham`
--

INSERT INTO `SanPham` (`ID`, `MaSP`, `TenSP`, `MoTaNgan`, `Gia`, `GiaGoc`, `TonKho`, `DangBan`, `NoiBat`, `SoLuongBan`, `Anh`, `NgayTao`, `NgayCapNhat`) VALUES
(1, 'SP001', 'Kem dưỡng ẩm ban đêm', 'Giúp da mềm mịn và giữ ẩm suốt đêm.', 250000.00, 300000.00, 50, 1, 1, 0, 'kemduongam.jpg', '2025-11-05 13:22:24', NULL),
(2, 'SP002', 'Sữa rửa mặt than hoạt tính', 'Làm sạch sâu, giảm bã nhờn và bụi bẩn.', 180000.00, 220000.00, 80, 1, 0, 0, 'suaruamat.jpg', '2025-11-05 13:22:24', NULL),
(3, 'SP003', 'Son lì cao cấp', 'Màu sắc tự nhiên, lâu trôi.', 320000.00, 390000.00, 60, 1, 1, 0, 'sonli.jpg', '2025-11-05 13:22:24', NULL),
(4, 'SP004', 'Nước hoa hồng dưỡng ẩm', 'Cân bằng độ pH và làm mềm da.', 200000.00, 250000.00, 70, 1, 0, 0, 'nuochoahong.jpg', '2025-11-05 13:22:24', NULL),
(5, 'SP005', 'Dầu gội phục hồi tóc hư tổn', 'Giúp tóc mềm mượt, chắc khỏe.', 210000.00, 260000.00, 40, 1, 0, 0, 'daugoi.jpg', '2025-11-05 13:22:24', NULL),
(6, 'SP006', 'Nước hoa nữ hương hoa hồng', 'Hương thơm dịu nhẹ, quyến rũ.', 550000.00, 650000.00, 25, 1, 1, 0, 'nuochoanu.jpg', '2025-11-05 13:22:24', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `SanPham_Loai`
--

CREATE TABLE `SanPham_Loai` (
  `IDSanPham` bigint(20) UNSIGNED NOT NULL,
  `IDLoai` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `SanPham_Loai`
--

INSERT INTO `SanPham_Loai` (`IDSanPham`, `IDLoai`) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 1),
(5, 4),
(6, 3);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `LoaiSanPham`
--
ALTER TABLE `LoaiSanPham`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDCha` (`IDCha`);

--
-- Chỉ mục cho bảng `NguoiDung`
--
ALTER TABLE `NguoiDung`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Ten_dang_nhap`);

--
-- Chỉ mục cho bảng `SanPham`
--
ALTER TABLE `SanPham`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `MaSP` (`MaSP`);

--
-- Chỉ mục cho bảng `SanPham_Loai`
--
ALTER TABLE `SanPham_Loai`
  ADD PRIMARY KEY (`IDSanPham`,`IDLoai`),
  ADD KEY `IDLoai` (`IDLoai`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `LoaiSanPham`
--
ALTER TABLE `LoaiSanPham`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `NguoiDung`
--
ALTER TABLE `NguoiDung`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `SanPham`
--
ALTER TABLE `SanPham`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ràng buộc đối với các bảng kết xuất
--

--
-- Ràng buộc cho bảng `LoaiSanPham`
--
ALTER TABLE `LoaiSanPham`
  ADD CONSTRAINT `loaisanpham_ibfk_1` FOREIGN KEY (`IDCha`) REFERENCES `LoaiSanPham` (`ID`) ON DELETE SET NULL;

--
-- Ràng buộc cho bảng `SanPham_Loai`
--
ALTER TABLE `SanPham_Loai`
  ADD CONSTRAINT `sanpham_loai_ibfk_1` FOREIGN KEY (`IDSanPham`) REFERENCES `SanPham` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `sanpham_loai_ibfk_2` FOREIGN KEY (`IDLoai`) REFERENCES `LoaiSanPham` (`ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
