-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 30, 2022 lúc 11:59 AM
-- Phiên bản máy phục vụ: 10.4.22-MariaDB
-- Phiên bản PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `cosmeticdb`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bills`
--

CREATE TABLE `bills` (
  `id` int(4) NOT NULL,
  `receiverName` varchar(30) DEFAULT NULL,
  `phone` int(20) DEFAULT NULL,
  `deliveryDate` char(20) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `total` float DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `deliveryAddress` varchar(50) DEFAULT NULL,
  `paymentMethod` varchar(100) DEFAULT NULL,
  `user_Id` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `bills`
--

INSERT INTO `bills` (`id`, `receiverName`, `phone`, `deliveryDate`, `notes`, `total`, `status`, `deliveryAddress`, `paymentMethod`, `user_Id`) VALUES
(21, '1 thằng nào đó', 99874343, '28-05-2022', 'đóng hàng cho cẩn thận', 14.11, 'Success', 'bắc ninh', 'Payment by card', 7),
(22, 'test2', 1234567890, '28-05-2022', 'k gì cả', 18.73, 'Success', 'bắc ninh 2', 'Payment on delivery', 7),
(23, 'sds', 3434343, '28-05-2022', '434343', 14.11, 'Success', '3434343', 'Payment on delivery', 7),
(24, 'Nguyen minh quan', 2147483647, '29-05-2022', 'giao hang can than', 14.11, 'Success', 'bac ninh', 'Payment by card', 7),
(25, '323232', 323232, '15-06-2022', '323232', 14.11, 'Success', '3232', 'Payment on delivery', 10),
(26, 'Nguyen Hai Quan', 34593834, '26-06-2022', 'dsadsav', 24.31, 'Success', 'Ha Noi', 'Payment by card', 7),
(27, 'Hoang Ngoc Nhat', 342342423, '26-06-2022', 'dấdsadsa', 12.78, 'Success', 'Ha Tinh', 'Payment by card', 7),
(28, 'Nguyễn Minh Quang', 34282342, '27-06-2022', '', 85.51, 'Pending', 'Lam Dong', 'Payment on delivery', 7),
(29, 'Hoang Ngoc Nhat', 344953747, '27-06-2022', 'ghi chu', 16, 'Success', 'Ha Noi', 'Payment on delivery', 7);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bill_details`
--

CREATE TABLE `bill_details` (
  `id` int(4) NOT NULL,
  `amount` int(20) DEFAULT NULL,
  `pro_Id` int(4) NOT NULL,
  `bill_Id` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `bill_details`
--

INSERT INTO `bill_details` (`id`, `amount`, `pro_Id`, `bill_Id`) VALUES
(22, 1, 16, 22),
(27, 2, 3, 26),
(28, 1, 17, 27),
(29, 1, 18, 27),
(31, 3, 6, 28),
(32, 4, 19, 29);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `id` int(4) NOT NULL,
  `user_Id` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart_details`
--

CREATE TABLE `cart_details` (
  `id` int(4) NOT NULL,
  `pro_Id` int(4) NOT NULL,
  `quantity` int(11) NOT NULL,
  `cart_Id` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(4) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `fatherCateId` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `fatherCateId`) VALUES
(1, 'Chăm sóc môi', NULL),
(2, 'Kem dưỡng da', NULL),
(3, 'Chăm sóc toàn thân', NULL),
(4, 'Chăm sóc mắt', NULL),
(5, 'Chăm sóc mặt', NULL),
(6, 'Chăm sóc tóc', NULL),
(7, 'Son Mỹ', 1),
(8, 'Son Canada', 1),
(10, 'Son Việt Nam', 1),
(11, 'Son Trung Quốc', 1),
(12, 'Son Lào', 1),
(13, 'Son Anh', 1),
(14, 'Son Nhật', 1),
(15, 'Son Bóng', 1),
(16, 'Son dưỡng', 1),
(17, 'Son môi lỏng', 1),
(18, 'Vết môi', 1),
(19, 'Chì kẻ môi', 1),
(20, 'Môi đầy đặn', 1),
(21, 'Bộ chăm sóc môi', 1),
(22, 'Chăm sóc môi', 1),
(23, 'Kem Mỹ', 2),
(24, 'Kem Hàn Quốc', 2),
(25, 'Kem Lào', 2),
(26, 'Kem Trung Quốc', 2),
(27, 'Kem Nhật', 2),
(28, 'Kem Việt Nam', 2),
(29, 'Kem Campuchia', 2),
(30, 'Kem Nga', 2),
(31, 'Kem Ukraine', 2),
(32, 'Kem Úc', 2),
(33, 'Kem Đức', 2),
(34, 'Kem cho da khô', 2),
(35, 'Da hỗn hợp', 2),
(36, 'Da nhạy cảm', 2),
(37, 'Cho người trưởng thành', 2),
(38, 'Da nhiều dầu', 2),
(39, 'Kem chống nắng', 2),
(40, 'Kem Pháp', 2),
(41, 'Kem Tây Ban Nha', 2),
(42, 'Serum', 2),
(43, 'Da nhăn', 3),
(44, 'Sữa tắm', 3),
(45, 'Da em bé', 3),
(46, 'Kem dưỡng da', 3),
(47, 'Sản phẩm da Mỹ', 3),
(48, 'Sản phẩm da Anh', 3),
(49, 'Sản phẩm da Việt', 3),
(50, 'Sản phẩm da Trung Quốc', 3),
(51, 'Sản phẩm da Nhật', 3),
(52, 'Sản phẩm da Nga', 3),
(53, 'Sản phẩm da Tây Ban Nha', 3),
(54, 'Sản phẩm da Lào', 3),
(55, 'Sản phẩm da CamPuchia', 3),
(56, 'Sản phẩm da Đức', 3),
(57, 'Kem chống nắng', 3),
(59, 'Chăm sóc da theo chu kỳ', 3),
(60, 'Tái tạo da', 3),
(61, 'Bảng mắt', 4),
(62, 'Mascara Mỹ', 4),
(63, 'Mascara Nga', 4),
(64, 'Mascara Việt Nam', 4),
(65, 'Mascara Trung Quốc', 4),
(66, 'Mascara Hàn Quốc', 4),
(67, 'Mascara Nhật', 4),
(68, 'Kẻ mắt Lào', 4),
(69, 'Kẻ mắt Campuchia', 4),
(70, 'Kẻ mắt Đức', 4),
(71, 'Kẻ mắt Mỹ', 4),
(72, 'Lông mày', 4),
(73, 'Lông mi', 4),
(74, 'Phấn mắt', 4),
(75, 'Serum dưỡng mi', 4),
(76, 'Serum lông mày', 4),
(77, 'Mồi mắt', 4),
(78, 'Bộ dưỡng mắt', 4),
(79, 'Bộ sưu tập cho mắt', 4),
(80, 'Phấn Mỹ', 5),
(82, 'Phấn Trung Quốc', 5),
(83, 'Phấn Việt Nam', 5),
(84, 'Phấn Hàn', 5),
(85, 'Phấn Nga', 5),
(86, 'Phấn Lào', 5),
(87, 'Phấn Nhật', 5),
(90, 'Phấn Thái Lan', 5),
(91, 'Phấn Tây Ban Nha', 5),
(92, 'Phấn Lào', 5),
(93, 'Nền mặt', 5),
(94, 'Kem dưỡng ẩm có màu', 5),
(95, 'Kem che khuyết điểm', 5),
(96, 'Kem lót mặt', 5),
(98, 'Làm nổi', 5),
(99, 'Viền mặt', 5),
(101, 'Bộ sưu tập cho mặt', 5),
(104, 'Kem tạo kiểu', 6),
(105, 'Dầu gội khô', 6),
(106, 'Kem lót tóc', 6),
(107, 'Xịt dưỡng tóc', 6),
(108, 'Mặt nạ tóc', 6),
(109, 'Dầu xả', 6),
(110, 'Tóc có dầu', 6),
(111, 'Serum tóc', 6),
(112, 'Điều trị da đầu', 6),
(113, 'Thuốc bổ tóc', 6),
(114, 'Tóc mảnh', 6),
(115, 'Tóc hư tổn', 6),
(116, 'Tóc khô', 6),
(117, 'Tóc xoăn', 6),
(118, 'Chăm sóc da đầu', 6),
(119, 'Tóc dày', 6),
(120, 'Chăm sóc màu tóc', 6),
(121, 'Tóc rụng', 6),
(122, 'Chất bảo vệ tóc', 6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
--

CREATE TABLE `comments` (
  `id` int(4) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `cmtDate` char(30) DEFAULT NULL,
  `updateAt` char(30) DEFAULT NULL,
  `user_Id` int(4) NOT NULL,
  `pro_Id` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `comments`
--

INSERT INTO `comments` (`id`, `content`, `cmtDate`, `updateAt`, `user_Id`, `pro_Id`) VALUES
(18, 'fgfgf', '22-05-2022', NULL, 7, 18),
(22, 'cgdfgfgf', '24-05-2022 02:02:42', NULL, 7, 8);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `manufacturers`
--

CREATE TABLE `manufacturers` (
  `id` int(4) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `manufacturers`
--

INSERT INTO `manufacturers` (`id`, `name`, `address`) VALUES
(1, 'PCI ST QUENTIN', 'ZAC CHAUSSEE ROMAINE RUE MARCEL PUAUL ST QUENTIN 02100 France'),
(2, 'SCHWAN STABILO COSMETICS GMBH & CO.', 'SCHWANWEG 1 HEROLDSBERG GERMANY'),
(3, 'JIA HSING ENTERPRISE CO., LTD.', 'NO.17 FU-GON RD., FU SHIN SHUEN CHANGHUA TAIWAN'),
(4, 'THE BODY SHOP INTERNATIONAL PLC', 'WATERSMEAD BUSINESS PARK LITTLEHAMPTON, WS BN176LS GB Northern Europe'),
(5, 'ANISA COSMETIC APPLICATORS', '18 STREET YANGLIUQING XIQING DISTRICT TIANJIN ,300380,CN Eastern Asia'),
(6, 'CLARINS', 'AVENUE DE LA VILLE IDEALE POLE JULES VERNE GLISY, 80440 FRANCE'),
(7, 'LOREAL LUXE ENL', '106 RUE DANTON LEVALLOIS PERRET 92691 FR Western Europe'),
(8, 'KAO GERMANY GMBH', 'PFUNGSTAEDTER STR. 92-100 DARMSTADT GERMANY Western Europe'),
(9, 'COTY GENEVA SA VERSOIX', 'CHEMIN DE LA PAPTERIE 1 VERSOIX 1290 CH Western Europe'),
(10, 'CHROMAVIS SPA', 'VIA FRANCESCO SFORZA 19 MILANO 20122 IT Southern Europe Italy'),
(11, 'A PACK PERSONAL CARE SDN.BHD', 'NO.1, JALAN SC 6 PUSAT PERINDUSTRIAN SUNGAI CHUA KAJANG 43000'),
(12, 'A TASK SDN. BHD.', 'NO. 17, LORONG NAGASARI 22, TAMAN NAGASARI, 13600 PERAI'),
(13, 'ACHIMA SKINCARE SDN. BHD.', 'NO. 73, JALAN TAMING 6, TAMAN TAMING JAYA, SERI KEMBANGAN 43300'),
(14, 'ADA COSMETICS INTERNATIONAL SDN. BHD.', 'NO. 12A, JALAN VILLA 3, ANGGERIK VILLA KAJANG 43000'),
(15, 'ATIKA BEAUTY MANUFACTURING SDN. BHD.', 'LOT 152, JALAN PERMATA 1, ARAB MALAYSIAN INDUSTRIAL PARK NILAI 71800');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(4) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `promotion` float DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `size` char(5) DEFAULT NULL,
  `amount` int(20) DEFAULT NULL,
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createAt` char(30) DEFAULT NULL,
  `updateAt` char(30) DEFAULT NULL,
  `manu_Id` int(4) NOT NULL,
  `cate_Id` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `promotion`, `description`, `size`, `amount`, `image`, `createAt`, `updateAt`, `manu_Id`, `cate_Id`) VALUES
(1, 'Fenty Icon The Fill Semi-Matte Refillable Lipstick', 20, 0.15, '<div>\n      <p>\n        <span><strong style=\"font-weight:600\">Đây là gì</strong>:&nbsp;</span>Son môi dưỡng ẩm, có độ che phủ trung bình với kết cấu dưỡng ẩm cao, tạo điều kiện và dưỡng ẩm cho môi.\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Loại da</strong>:&nbsp;</span>Da thường, da khô, da hỗn hợp và da nhiều dầu.\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Mối quan tâm về chăm sóc da</strong>:&nbsp;</span>Đường nhăn / Nếp nhăn, Khô và Mờ.\n      </p>\n        <span><strong style=\"font-weight:600\">Công thức</strong>:&nbsp;</span>Gel\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Thành phần nổi bật</strong>:&nbsp;</span>- Berry Mix Complex ™: Giàu vitamin C và chất chống oxy hóa.\n- Công nghệ Moisture Wrap ™: Khóa độ ẩm để dưỡng ẩm lâu dài.\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Chú thích thành phần</strong>:&nbsp;</span>Không chứa paraben và phthalate.\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Những gì khác bạn cần biết</strong>:&nbsp;</span>Fenty Icon Fill Semi-Matte Refillable Lipstick là mặt nạ dưỡng chuyên sâu dành cho môi. Với Công nghệ Moisture Wrap ™ độc quyền và Berry Mix Complex ™ nuôi dưỡng, mặt nạ môi dưỡng ẩm này cung cấp độ ẩm và chất chống oxy hóa mạnh trong khi bạn ngủ.<br/>\n        <span>- Nhẹ nhàng lau sạch lượng dư thừa vào buổi sáng khi cần thiết.</span>\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Cách sử dụng được đề xuất</strong>:&nbsp;</span>- Thoa đều lên môi vào buổi tối và để qua đêm.\n      </p>\n    </div>', 'Nhỏ', 312422, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1656581360/cosmetic/products/Product1_1.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1656581363/cosmetic/products/Product1_2.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1656581364/cosmetic/products/Product1_3.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1656581366/cosmetic/products/Product1_4.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1656581368/cosmetic/products/Product1_5.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1656581370/cosmetic/products/Product1_6.jpg.webp\"]', '30-06-2022 16:29:32', NULL, 1, 7),
(2, 'Cream Lip Stain Liquid Lipstick', 2, 0, '{}', 'To', 342122, '[]', '2-05-2022 10:51:37', '27-06-2022 09:53:00', 2, 7),
(3, 'Matte & Satin Velvet Lipstick', 6, 0.15, '{}', 'Nhỏ', 123312, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237461/cosmetic/products/Product3_1.webp\"]', '2-05-2022 10:51:37', NULL, 3, 7),
(4, 'HHK700 Lipstick', 15, 0.19, '{}', 'To', 142310, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237461/cosmetic/products/Product4_1.webp\"]', '2-05-2022 10:51:37', NULL, 4, 7),
(5, 'AV450 Lipstick', 14, 0.1, '{}', 'Nhỏ', 635311, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237461/cosmetic/products/Product5_1.webp\"]', '2-05-2022 10:51:37', NULL, 5, 7),
(6, 'Dior Addict Refillable Shine Lipstick', 34, 0.3, '{}', 'Nhỏ', 312350, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237462/cosmetic/products/Product6_1.webp\"]', '2-05-2022 10:51:37', NULL, 6, 7),
(7, 'Stunna Lip Paint Longwear Fluid Lip Color', 15, 0.2, '{}', 'Nhỏ', 541219, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237462/cosmetic/products/Product7_1.webp\"]', '2-05-2022 10:51:37', NULL, 7, 7),
(8, 'The Slim Velvet Radical Matte Lipstick', 50, 0.15, '{}', 'Nhỏ', 432461, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237463/cosmetic/products/Product8_1.webp\"]', '2-05-2022 10:51:37', NULL, 8, 7),
(9, 'Power Bullet Matte Lipstick', 21, 0.15, '{}', 'To', 124431, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237463/cosmetic/products/Product9_1.webp\"]', '2-05-2022 10:51:37', NULL, 9, 7),
(10, 'K.I.S.S.I.N.G Lipstick', 5, 0.16, '{}', 'To', 98456, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237463/cosmetic/products/Product9_1.webp\"]', '2-05-2022 10:51:37', NULL, 10, 7),
(11, 'MatteTrance™ Lipstick', 6, 0.13, '{}', 'Nhỏ', 35252, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237464/cosmetic/products/Product11_1.webp\"]', '2-05-2022 10:51:37', NULL, 11, 7),
(12, 'Le Rouge Sheer Velvet Matte Lipstick', 34, 0.16, '{}', 'To', 51342, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237465/cosmetic/products/Product12_1.webp\"]', '2-05-2022 10:51:37', NULL, 12, 7),
(13, 'Lip Power Long Lasting Satin Lipstick', 15, 0.21, '{}', 'Nhỏ', 542432, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237465/cosmetic/products/Product13_1.webp\"]', '2-05-2022 10:51:37', NULL, 13, 7),
(14, 'Fenty Icon The Fill Semi-Matte Refillable Lipstick', 5, 0.2, '{}', 'Nhỏ', 514314, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237465/cosmetic/products/Product14_1.webp\"]', '2-05-2022 10:51:37', NULL, 14, 7),
(15, 'Lip Color Matte Lipstick', 14, 0.12, '{}', 'To', 61231, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237466/cosmetic/products/Product15_1.webp\"]', '2-05-2022 10:51:37', NULL, 15, 7),
(16, 'Slip Shine Sheer Shiny Lipstick', 7, 0.34, '{}', 'To', 122122, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237466/cosmetic/products/Product16_1.webp\"]', '2-05-2022 10:51:37', NULL, 1, 7),
(17, 'Too Femme Heart Core Lipstick', 6, 0.12, '{}', 'To', 532431, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237466/cosmetic/products/Product17_1.webp\"]', '2-05-2022 10:51:37', NULL, 2, 7),
(18, 'Rosso Valentino Refillable Lipstick', 15, 0.5, '{}', 'Nhỏ', 32420, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237467/cosmetic/products/Product18_1.webp\"]', '2-05-2022 10:51:37', NULL, 3, 7),
(19, 'Studded Kiss Crème Lipstick', 5, 0.2, '{}', 'To', 43127, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237467/cosmetic/products/Product19_1.webp\"]', '2-05-2022 10:51:37', NULL, 4, 7),
(20, 'Ultra Suede™️ Cozy Lip Creme', 5, 0.15, '{}', 'To', 543342, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653237467/cosmetic/products/Product20_1.webp\"]', '2-05-2022 10:51:37', NULL, 5, 7),
(21, 'Color Block High Impact Lipstick', 15, 0.16, '{}', 'To', 13141, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353764/cosmetic/productsFake/all_2.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353766/cosmetic/productsFake/all_3.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353930/cosmetic/productsFake/product23_1.jpg.webp\"]', '2-05-2022 10:51:37', '24-05-2022 07:58:51', 6, 7),
(22, 'Rouge Pur Couture Satin Lipstick Collection', 13, 0.5, '{}', 'To', 54233, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353764/cosmetic/productsFake/all_2.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353766/cosmetic/productsFake/all_3.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353898/cosmetic/productsFake/product22_1.jpg.webp\"]', '2-05-2022 10:51:37', '24-05-2022 07:58:19', 7, 7),
(23, 'Lip Power Long Lasting Satin Lipstick', 34, 0.12, '<div>\r\n      <p>\r\n        <span><strong style=\"font-weight:600\">What it is</strong>:&nbsp;</span>A medium-coverage,\r\n            hydrating lipstick with a high-shine, balm-like texture that\r\n            conditions and moisturizes the lips.\r\n      </p>\r\n      <p>\r\n        <span><strong style=\"font-weight:600\">Skin Types</strong>:&nbsp;</span>Normal, Dry,\r\n        Combination, and Oily\r\n      </p>\r\n      <p>\r\n        <span><strong style=\"font-weight:600\">Skincare Concerns</strong>:&nbsp;</span>Fine\r\n        Lines/Wrinkles, Dryness, and Dullness\r\n      </p>\r\n        <span><strong style=\"font-weight:600\">Formulation</strong>:&nbsp;</span>Gel\r\n      </p>\r\n      <p>\r\n        <span><strong style=\"font-weight:600\">Highlighted Ingredients</strong>:&nbsp;</span>Berry Mix Complex™: Rich in vitamin C and antioxidants.\r\n        - Moisture Wrap™ technology: Locks in moisture for long-lasting\r\n        hydration.\r\n        Lines/Wrinkles, Dryness, and Dullness\r\n      </p>\r\n      <p>\r\n        <span><strong style=\"font-weight:600\">Ingredient Callouts</strong>:&nbsp;</span>Free of\r\n        parabens and phthalates.\r\n      </p>\r\n      <p>\r\n        <span><strong style=\"font-weight:600\">What Else You Need to Know</strong>:&nbsp;</span>LANEIGE Lip Sleeping Mask is a special intensive-care mask for lips.\r\n        With exclusive Moisture Wrap™ Technology and nourishing Berry Mix\r\n        Complex™, this hydrating lip mask delivers intense moisture and\r\n        antioxidants while you sleep.<br/>\r\n        <span>-Gently wipe off excess in the morning as needed.</span>\r\n      </p>\r\n      <p>\r\n        <span><strong style=\"font-weight:600\">Suggested Usage</strong>:&nbsp;</span>-Apply generously to the lips in the evening and leave on\r\n        overnight.\r\n      </p>\r\n    </div>', 'To', 23131, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353764/cosmetic/productsFake/all_2.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353766/cosmetic/productsFake/all_3.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353768/cosmetic/productsFake/product21_1.jpg.webp\"]', '2-05-2022 10:51:37', '24-05-2022 07:56:09', 8, 7),
(24, 'Velvet Matte Lipstick Pencil', 15, 0.5, '{}', 'Nhỏ', 23424, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353764/cosmetic/productsFake/all_2.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353766/cosmetic/productsFake/all_3.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353954/cosmetic/productsFake/product24_1.jpg.webp\"]', '2-05-2022 10:51:37', '24-05-2022 07:59:15', 9, 7),
(25, 'Color Block High Impact Lipstick', 14, 0.25, '<div>\n      <p>\n        <span><strong style=\"font-weight:600\">What it is</strong>:&nbsp;</span>A medium-coverage,\n            hydrating lipstick with a high-shine, balm-like texture that\n            conditions and moisturizes the lips.\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Skin Types</strong>:&nbsp;</span>Normal, Dry,\n        Combination, and Oily\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Skincare Concerns</strong>:&nbsp;</span>Fine\n        Lines/Wrinkles, Dryness, and Dullness\n      </p>\n        <span><strong style=\"font-weight:600\">Formulation</strong>:&nbsp;</span>Gel\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Highlighted Ingredients</strong>:&nbsp;</span>Berry Mix Complex™: Rich in vitamin C and antioxidants.\n        - Moisture Wrap™ technology: Locks in moisture for long-lasting\n        hydration.\n        Lines/Wrinkles, Dryness, and Dullness\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Ingredient Callouts</strong>:&nbsp;</span>Free of\n        parabens and phthalates.\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">What Else You Need to Know</strong>:&nbsp;</span>LANEIGE Lip Sleeping Mask is a special intensive-care mask for lips.\n        With exclusive Moisture Wrap™ Technology and nourishing Berry Mix\n        Complex™, this hydrating lip mask delivers intense moisture and\n        antioxidants while you sleep.<br/>\n        <span>-Gently wipe off excess in the morning as needed.</span>\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Suggested Usage</strong>:&nbsp;</span>-Apply generously to the lips in the evening and leave on\n        overnight.\n      </p>\n    </div>', 'Nhỏ', 524312, '[]', '2-05-2022 10:51:37', '25-05-2022 15:17:18', 10, 7),
(26, 'Le Marc Lip Crème Lipstick', 6, 0.3, '{}', 'To', 41234, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353764/cosmetic/productsFake/all_2.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353766/cosmetic/productsFake/all_3.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653354302/cosmetic/productsFake/product26_1.jpg.webp\"]', '2-05-2022 10:51:37', '24-05-2022 08:05:04', 11, 7),
(27, 'Matte & Satin Velvet Lipstick', 6, 0.15, '{}', 'To', 154323, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353764/cosmetic/productsFake/all_2.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653353766/cosmetic/productsFake/all_3.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653354321/cosmetic/productsFake/product27_1.jpg.webp\"]', '2-05-2022 10:51:37', '24-05-2022 08:05:22', 3, 7),
(28, 'HHK700 Lipstick', 15, 0.19, '{}', 'To', 142313, '', '2-05-2022 10:51:37', NULL, 4, 7),
(29, 'AV450 Lipstick', 14, 0.1, '{}', 'To', 635312, '', '2-05-2022 10:51:37', NULL, 5, 7),
(30, 'Dior Addict Refillable Shine Lipstick', 34, 0.3, '{}', 'Nhỏ', 312353, '', '2-05-2022 10:51:37', NULL, 6, 7),
(31, 'Stunna Lip Paint Longwear Fluid Lip Color', 15, 0.2, '{}', 'Nhỏ', 541221, '', '2-05-2022 10:51:37', NULL, 7, 7),
(32, 'The Slim Velvet Radical Matte Lipstick', 50, 0.15, '{}', 'To', 432461, '', '2-05-2022 10:51:37', NULL, 8, 7),
(33, 'Power Bullet Matte Lipstick', 21, 0.15, '{}', 'Nhỏ', 124431, '', '2-05-2022 10:51:37', NULL, 9, 7),
(34, 'K.I.S.S.I.N.G Lipstick', 5, 0.16, '{}', 'To', 98456, '', '2-05-2022 10:51:37', NULL, 10, 7),
(35, 'MatteTrance™ Lipstick', 6, 0.13, '{}', 'Nhỏ', 35252, '', '2-05-2022 10:51:37', NULL, 11, 7),
(36, 'Le Rouge Sheer Velvet Matte Lipstick', 34, 0.16, '{}', 'Nhỏ', 51342, '', '2-05-2022 10:51:37', NULL, 12, 7),
(37, 'Lip Power Long Lasting Satin Lipstick', 15, 0.21, '{}', 'To', 542432, '', '2-05-2022 10:51:37', NULL, 13, 7),
(38, 'Fenty Icon The Fill Semi-Matte Refillable Lipstick', 5, 0.2, '{}', 'To', 514314, '', '2-05-2022 10:51:37', NULL, 14, 7),
(39, 'Lip Color Matte Lipstick', 14, 0.12, '{}', 'To', 61231, '', '2-05-2022 10:51:37', NULL, 15, 7),
(40, 'Slip Shine Sheer Shiny Lipstick', 7, 0.34, '{}', 'To', 122124, '', '2-05-2022 10:51:37', NULL, 1, 7),
(41, 'Too Femme Heart Core Lipstick', 6, 0.12, '{}', 'To', 532432, '', '2-05-2022 10:51:37', NULL, 2, 7),
(42, 'Rosso Valentino Refillable Lipstick', 15, 0.5, '{}', 'Nhỏ', 32421, '', '2-05-2022 10:51:37', NULL, 3, 7),
(43, 'Studded Kiss Crème Lipstick', 5, 0.2, '{}', 'Nhỏ', 43131, '', '2-05-2022 10:51:37', NULL, 4, 7),
(44, 'Ultra Suede™️ Cozy Lip Creme', 5, 0.15, '{}', 'To', 543342, '', '2-05-2022 10:51:37', NULL, 5, 7),
(45, 'Color Block High Impact Lipstick', 15, 0.16, '{}', 'Nhỏ', 13141, '', '2-05-2022 10:51:37', NULL, 6, 7),
(46, 'Rouge Pur Couture Satin Lipstick Collection', 13, 0.5, '{}', 'To', 54233, '', '2-05-2022 10:51:37', NULL, 7, 7),
(47, 'Lip Power Long Lasting Satin Lipstick', 34, 0.12, '{}', 'Nhỏ', 23131, '', '2-05-2022 10:51:37', NULL, 8, 7),
(48, 'Velvet Matte Lipstick Pencil', 15, 0.5, '{}', 'To', 23424, '', '2-05-2022 10:51:37', NULL, 9, 7),
(49, 'Color Block High Impact Lipstick', 14, 0.25, '{}', 'To', 524312, '', '2-05-2022 10:51:37', NULL, 10, 7),
(50, 'Le Marc Lip Crème Lipstick', 6, 0.3, '{}', 'To', 41234, '', '2-05-2022 10:51:37', NULL, 11, 7),
(51, 'Superfood Air-Whip Moisturizer with Hyaluronic Aci', 20.5, 0.2, '<div>\r\n      <p>\r\n        <span style=\"font-weight: bold\">What it is:</span>A limited-edition,\r\n        lavender-scented version of the cult-favorite water sleeping mask that\r\n        delivers intense hydration while you sleep.\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Skin Types:</span>Normal, Dry,\r\n        Combination, and Oily\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Skincare Concerns:</span>Dryness, Fine\r\n        Lines and Wrinkles, Dullness and Uneven Texture\r\n      </p>\r\n      <p><span style=\"font-weight: bold\">Formulation:</span>Gel</p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Highlighted Ingredients:</span>\r\n        Hyaluronic Acid: Imparts hydration for a softer, more plumped look.\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Ingredient Callouts:</span>Free of\r\n        parabens, phthalates, and mineral oil.\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">What Else You Need to Know:</span>Become\r\n        an overnight sensation with this famous sleeping mask. The unique\r\n        formula features Hydro Ionized Mineral Water™, which floods skin with\r\n        moisture, while hunza apricot and evening primrose extracts help\r\n        brighten and purify. While it’s working, enjoying LANEIGE\'s exclusive\r\n        Sleepscent™ to help impart a restful sleep so you can wake up looking\r\n        refreshed.\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Suggested Usage:</span><br /><span\r\n          >-Warm up in between hands and breathe in soothing lavender\r\n          scent.</span\r\n        ><br /><span\r\n          >-Apply evenly across face as the last step of your PM routine,\r\n          following your moisturizer.</span\r\n        ><br /><span>-Leave on overnight and rinse off in the morning.</span>\r\n        <br /><span>-Use once or twice a week.</span>\r\n      </p>\r\n    </div>', 'Nhỏ', 123413, '[\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653351732/cosmetic/creamProducts/CreamPro1_1.jpg.webp\",\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653351734/cosmetic/creamProducts/CreamPro1_2.jpg.webp\",\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653351736/cosmetic/creamProducts/CreamPro1_3.jpg.webp\",\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653351738/cosmetic/creamProducts/CreamPro1_4.jpg.webp\",\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653351740/cosmetic/creamProducts/CreamPro1_5.jpg.webp\",\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653351742/cosmetic/creamProducts/CreamPro1_6.jpg.webp\"]', '24-05-2022 07:33:32', NULL, 2, 23),
(52, 'Lip Sleeping Mask with Hyaluronic Acid and Vitamin', 25.6, 0.3, '<div>\r\n      <p>\r\n        <span style=\"font-weight: bold\">What it is:</span>A leave-on lip mask\r\n        that delivers intense moisture and antioxidants while you sleep with its\r\n        Moisture Wrap™ technology and Berry Mix Complex™ formula.\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Skin Types:</span>Normal, Dry,\r\n        Combination, and Oily\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Skincare Concerns:</span>Fine\r\n        Lines/Wrinkles, Dryness, and Dullness\r\n      </p>\r\n      <p><span style=\"font-weight: bold\">Formulation:</span>Gel</p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Highlighted Ingredients:</span><br />\r\n        Berry Mix Complex™: Rich in vitamin C and antioxidants.<br />\r\n        - Moisture Wrap™ technology: Locks in moisture for long-lasting\r\n        hydration.\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Ingredient Callouts:</span>Free of\r\n        parabens and phthalates.\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">What Else You Need to Know:</span>\r\n        LANEIGE Lip Sleeping Mask is a special intensive-care mask for lips.\r\n        With exclusive Moisture Wrap™ Technology and nourishing Berry Mix\r\n        Complex™, this hydrating lip mask delivers intense moisture and\r\n        antioxidants while you sleep.\r\n      </p>\r\n      <p>\r\n        <span style=\"font-weight: bold\">Suggested Usage:</span><br /><span\r\n          >-Apply generously to the lips in the evening and leave on\r\n          overnight.</span\r\n        ><br /><span>-Gently wipe off excess in the morning as needed.</span>\r\n      </p>\r\n    </div>', 'Nhỏ', 153264, '[\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653352737/cosmetic/creamProducts/CreamPro2_1.jpg.webp\",\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653352738/cosmetic/creamProducts/CreamPro2_2.jpg.webp\",\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653352740/cosmetic/creamProducts/CreamPro2_3.jpg.webp\"]', '24-05-2022 07:39:01', NULL, 4, 23),
(53, 'Watermelon + AHA Glow Sleeping Cream', 15.3, 0.25, '', 'To', 25112, '[\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653353292/cosmetic/creamProducts/CreamPro3_1.jpg.webp\",\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653353294/cosmetic/creamProducts/CreamPro3_2.jpg.webp\",\"https://res.cloudinary.com/nhat-clouds/image/upload/v1653353296/cosmetic/creamProducts/CreamPro3_3.jpg.webp\"]', '24-05-2022 07:48:18', NULL, 7, 23),
(54, 'HC5001', 16.5, 0.15, '<div>\n      <p>\n        <span><strong style=\"font-weight:600\">What it is</strong>:&nbsp;</span>A medium-coverage,\n            hydrating lipstick with a high-shine, balm-like texture that\n            conditions and moisturizes the lips.\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Skin Types</strong>:&nbsp;</span>Normal, Dry,\n        Combination, and Oily\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Skincare Concerns</strong>:&nbsp;</span>Fine\n        Lines/Wrinkles, Dryness, and Dullness\n      </p>\n        <span><strong style=\"font-weight:600\">Formulation</strong>:&nbsp;</span>Gel\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Highlighted Ingredients</strong>:&nbsp;</span>Berry Mix Complex™: Rich in vitamin C and antioxidants.\n        - Moisture Wrap™ technology: Locks in moisture for long-lasting\n        hydration.\n        Lines/Wrinkles, Dryness, and Dullness\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Ingredient Callouts</strong>:&nbsp;</span>Free of\n        parabens and phthalates.\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">What Else You Need to Know</strong>:&nbsp;</span>LANEIGE Lip Sleeping Mask is a special intensive-care mask for lips.\n        With exclusive Moisture Wrap™ Technology and nourishing Berry Mix\n        Complex™, this hydrating lip mask delivers intense moisture and\n        antioxidants while you sleep.<br/>\n        <span>-Gently wipe off excess in the morning as needed.</span>\n      </p>\n      <p>\n        <span><strong style=\"font-weight:600\">Suggested Usage</strong>:&nbsp;</span>-Apply generously to the lips in the evening and leave on\n        overnight.\n      </p>\n    </div>', 'Nhỏ', 312321, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653303056/cosmetic/products/Product1_1.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653303057/cosmetic/products/Product1_2.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653303059/cosmetic/products/Product1_3.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653303061/cosmetic/products/Product1_4.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653303063/cosmetic/products/Product1_5.jpg.webp\",\"https://res.cloudinary.com/cosmeticv1/image/upload/v1653303065/cosmetic/products/Product1_6.jpg.webp\"]', '25-05-2022 15:14:12', NULL, 1, 7),
(60, 'san pham son', 16, 0.5, 'mo ta san pham', 'Nhỏ', 154443, '[\"https://res.cloudinary.com/cosmeticv1/image/upload/v1656269088/cosmetic/products/product25_1.jpg.webp\"]', '27-06-2022 01:44:49', NULL, 9, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `star_rating`
--

CREATE TABLE `star_rating` (
  `id` int(4) NOT NULL,
  `pro_Id` int(4) NOT NULL,
  `user_Id` int(4) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `bill_details_Id` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `star_rating`
--

INSERT INTO `star_rating` (`id`, `pro_Id`, `user_Id`, `rating`, `bill_details_Id`) VALUES
(21, 16, 7, 5, 22),
(23, 18, 7, 2, 29),
(24, 17, 7, 4, 28),
(25, 19, 7, 3, 32);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(4) NOT NULL,
  `userName` char(50) DEFAULT NULL,
  `displayName` varchar(50) DEFAULT NULL,
  `password` varchar(1000) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `sex` varchar(6) DEFAULT NULL,
  `phoneNumber` int(20) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `avatar` char(100) DEFAULT NULL,
  `role` varchar(10) DEFAULT 'user',
  `createAt` char(20) DEFAULT NULL,
  `updateAt` char(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `userName`, `displayName`, `password`, `email`, `sex`, `phoneNumber`, `address`, `age`, `avatar`, `role`, `createAt`, `updateAt`) VALUES
(2, 'Nguyễn Hải Quân', 'Quan Nguyen', '123456789', 'haiquan321@gmail.com', 'nam', 987654321, '321 Bac Ninh', 21, NULL, 'user', '07/04/2022', NULL),
(7, 'dfdfdfdfdfd', 'Nguyen Hai Quan', '$2y$10$9NEWNN1.7ZTAW8xoi5WfpupB1/qG7Ddp4hAaQB1On3HiqSbTf.A2O', 'quan60@gmail.com', 'nam', 3232, 'bac ninh', 12, 'https://res.cloudinary.com/cosmeticv1/image/upload/v1653218158/cosmetic/avatar/avatar60.jpg.jpg', 'user', '22-05-2022', NULL),
(10, '21212121', '12121 2121', '$2y$10$wmUUxNduwlJw0pqlnzDcFueKMYDwcNrnBkERgKS1jp2o6yIgH9FqO', 'quan70@gmail.com', 'nữ', 123232, '343434343', 13, NULL, 'user', '15-06-2022 22:42:52', NULL),
(11, 'admin', 'Hoang Ngoc Nhat', '$2y$10$gkQd4U6ZmvsUr8FxymyreOH0DfFU2ucMhmXaGx/t4bTOcqqT8QGnS', 'admin@gmail.com', 'nam', 943343432, 'Ha tinh', 21, NULL, 'admin', '27-06-2022 01:38:04', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `User_Id` (`user_Id`) USING BTREE;

--
-- Chỉ mục cho bảng `bill_details`
--
ALTER TABLE `bill_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Pro_id` (`pro_Id`) USING BTREE,
  ADD KEY `Bill_Id` (`bill_Id`) USING BTREE;

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `User_Id` (`user_Id`);

--
-- Chỉ mục cho bảng `cart_details`
--
ALTER TABLE `cart_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_Id` (`cart_Id`),
  ADD KEY `pro_Id` (`pro_Id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fatherCateId` (`fatherCateId`);

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `User_Id` (`user_Id`) USING BTREE,
  ADD KEY `Pro_Id` (`pro_Id`) USING BTREE;

--
-- Chỉ mục cho bảng `manufacturers`
--
ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Manu_Id` (`manu_Id`) USING BTREE,
  ADD KEY `Cate_Id` (`cate_Id`) USING BTREE;

--
-- Chỉ mục cho bảng `star_rating`
--
ALTER TABLE `star_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pro_Id` (`pro_Id`),
  ADD KEY `user_Id` (`user_Id`),
  ADD KEY `bill_details_Id` (`bill_details_Id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `bills`
--
ALTER TABLE `bills`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT cho bảng `bill_details`
--
ALTER TABLE `bill_details`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT cho bảng `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT cho bảng `cart_details`
--
ALTER TABLE `cart_details`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT cho bảng `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT cho bảng `manufacturers`
--
ALTER TABLE `manufacturers`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT cho bảng `star_rating`
--
ALTER TABLE `star_rating`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`user_Id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `bill_details`
--
ALTER TABLE `bill_details`
  ADD CONSTRAINT `bill_details_ibfk_1` FOREIGN KEY (`bill_Id`) REFERENCES `bills` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bill_details_ibfk_2` FOREIGN KEY (`pro_Id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_Id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `cart_details`
--
ALTER TABLE `cart_details`
  ADD CONSTRAINT `cart_details_ibfk_1` FOREIGN KEY (`cart_Id`) REFERENCES `cart` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_details_ibfk_2` FOREIGN KEY (`pro_Id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_Id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`pro_Id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`manu_Id`) REFERENCES `manufacturers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`cate_Id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `star_rating`
--
ALTER TABLE `star_rating`
  ADD CONSTRAINT `star_rating_ibfk_1` FOREIGN KEY (`pro_Id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `star_rating_ibfk_2` FOREIGN KEY (`user_Id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `star_rating_ibfk_3` FOREIGN KEY (`bill_details_Id`) REFERENCES `bill_details` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
