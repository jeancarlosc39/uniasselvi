-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 06-Maio-2019 às 15:28
-- Versão do servidor: 10.1.38-MariaDB
-- versão do PHP: 7.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lua`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `cpf`, `email`, `created`, `updated`, `modified`) VALUES
(3, 'volnei', '00337638950', 'jean@jean.com', '2019-04-30 21:27:42', NULL, '2019-04-30 21:54:21'),
(4, 'jean', '00337638950', 'jean@jean.com', '2019-04-30 21:27:48', NULL, '2019-04-30 21:27:48'),
(5, 'marcio', '31212121212', 'marcio@marcio.com.br', '2019-04-30 21:34:44', NULL, '2019-04-30 21:34:44'),
(6, 'bartolomeu', '31231312312', 'joao@joao.com.br', '2019-04-30 21:40:28', NULL, '2019-04-30 21:54:10'),
(7, 'jandir', '00337638950', 'joao@joao.com.br', '2019-04-30 21:48:18', NULL, '2019-04-30 21:53:58'),
(8, 'ivao', '32131231312', 'ivan@ivacn.com.br', '2019-04-30 21:52:09', NULL, '2019-04-30 21:52:09'),
(9, 'juarez', '31231231232', 'juarez@juarez.com.br', '2019-04-30 21:52:41', NULL, '2019-04-30 21:52:41'),
(10, 'claudio', '31213123132', 'claudio@claudio.com.br', '2019-04-30 21:53:29', NULL, '2019-04-30 21:53:29'),
(12, 'godofredo', '55435354353', 'gogofredo@godofredo.com.br', '2019-04-30 21:54:52', NULL, '2019-04-30 21:54:52'),
(13, 'silvio', '97676567575', 'silvio@silvio.com.br', '2019-04-30 21:55:18', NULL, '2019-04-30 21:55:18'),
(14, 'cesar', '65464646464', 'cesar@cesar.com.br', '2019-04-30 21:55:34', NULL, '2019-04-30 21:55:34'),
(15, 'douglas', '24243152453', 'douglas@douglas.com.br', '2019-04-30 21:55:58', NULL, '2019-04-30 21:55:58'),
(16, 'marcos', '31322131321', 'marcos@marcos.com.br', '2019-04-30 21:56:14', NULL, '2019-04-30 21:56:14'),
(17, 'daiane', '31231312313', 'daiane@daiane.com.br', '2019-04-30 21:56:29', NULL, '2019-04-30 21:56:29'),
(18, 'ramos', '31231231321', 'ramos@ramos.com.br', '2019-04-30 21:56:49', NULL, '2019-04-30 21:56:49'),
(19, 'antonio', '31313131313', 'antonio@antonio.com.br', '2019-04-30 21:57:04', NULL, '2019-04-30 21:57:04'),
(20, 'graice', '45243123165', 'graice@graice.com.br', '2019-04-30 21:57:36', NULL, '2019-04-30 21:57:36'),
(21, 'jose', '32131313131', 'jose@jose.com.br', '2019-04-30 22:04:18', NULL, '2019-04-30 22:04:18'),
(22, 'gabriel', '32131231332', 'gabriel@gabriel.com.br', '2019-04-30 22:04:46', NULL, '2019-04-30 22:04:46'),
(23, 'ildemar', '31212111111', 'ildemar@ildemar.com.br', '2019-04-30 22:05:11', NULL, '2019-04-30 22:05:11'),
(24, 'Murara', '32131313213', 'murara@murara.com.br', '2019-04-30 22:48:52', NULL, '2019-04-30 22:48:52');

-- --------------------------------------------------------

--
-- Stand-in structure for view `detalhe_itens`
-- (See below for the actual view)
--
CREATE TABLE `detalhe_itens` (
`cliente` varchar(100)
,`cpf` varchar(11)
,`pedido` int(10) unsigned
,`produto` varchar(255)
,`qtde` int(11)
,`id` int(11)
,`produto_id` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(322, '2014_10_12_000000_create_users_table', 1),
(323, '2014_10_12_100000_create_password_resets_table', 1),
(324, '2019_04_29_213648_clientes', 1),
(325, '2019_04_30_205051_produtos', 1),
(326, '2019_05_03_011156_teste', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(10) UNSIGNED NOT NULL,
  `cliente_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dtpedido` date NOT NULL,
  `desconto` int(11) NOT NULL DEFAULT '0',
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `pedidos`
--

INSERT INTO `pedidos` (`id`, `cliente_id`, `status`, `dtpedido`, `desconto`, `modified`, `created`, `updated`) VALUES
(1, 19, 'Aberto', '1970-01-24', 50, '2019-05-03 01:33:40', '2019-05-03 01:33:40', NULL),
(2, 10, 'Aberto', '1970-05-21', 30, '2019-05-03 17:25:40', '2019-05-03 17:25:40', NULL),
(3, 14, 'Aberto', '1970-02-05', 80, '2019-05-03 18:39:13', '2019-05-03 17:31:23', NULL),
(5, 19, 'Cancelado', '2010-12-23', 56, '2019-05-03 20:17:16', '2019-05-03 19:14:09', NULL),
(6, 19, 'Pago', '2019-02-12', 50, '2019-05-03 20:16:51', '2019-05-03 19:24:11', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos_itens`
--

CREATE TABLE `pedidos_itens` (
  `id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `qtde` int(11) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `pedidos_itens`
--

INSERT INTO `pedidos_itens` (`id`, `produto_id`, `pedido_id`, `qtde`, `modified`, `created`, `updated`) VALUES
(1, 3, 1, 2, '2019-05-03 16:06:55', '2019-05-03 16:06:55', NULL),
(2, 4, 1, 1, '2019-05-03 16:07:14', '2019-05-03 16:07:14', NULL),
(3, 4, 2, 3, '2019-05-03 17:29:33', '2019-05-03 17:29:33', NULL),
(4, 4, 3, 111, '2019-05-06 01:11:10', '2019-05-03 17:34:17', NULL),
(5, 4, 3, 10, '2019-05-06 01:10:50', '2019-05-03 17:51:55', NULL),
(6, 3, 3, 45, '2019-05-03 18:38:58', '2019-05-03 18:38:58', NULL),
(7, 4, 6, 500, '2019-05-03 19:24:51', '2019-05-03 19:24:51', NULL),
(8, 4, 5, 8, '2019-05-03 19:25:56', '2019-05-03 19:25:56', NULL),
(9, 4, 4, 1, '2019-05-03 19:26:24', '2019-05-03 19:26:24', NULL),
(10, 3, 4, 50, '2019-05-03 19:30:41', '2019-05-03 19:30:41', NULL),
(11, 4, 4, 400, '2019-05-03 21:23:04', '2019-05-03 21:23:04', NULL),
(12, 3, 3, 99, NULL, NULL, NULL),
(13, 3, 3, 111, '2019-05-06 02:31:00', '2019-05-06 02:31:00', NULL),
(14, 4, 3, 43, '2019-05-06 02:32:42', '2019-05-06 02:32:42', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codbarras` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` decimal(13,2) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `codbarras`, `valor`, `created`, `updated`, `modified`) VALUES
(3, 'Coca Cola', '11111111111111111111', '6.50', '2019-05-01 17:51:03', NULL, '2019-05-01 18:31:17'),
(4, 'Fanta', '22222222222222222222', '6.00', '2019-05-01 18:10:24', NULL, '2019-05-01 18:30:25');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'jean', 'jean.c.goncalves@gmail.com', '$2y$10$NshhxpZ3mHsF3GDfqzQEsuf/UvzqatnZAK4L8ehhcADLMONzKUYy.', NULL, '2019-05-06 02:58:12', '2019-05-06 02:58:12');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_pedidos`
-- (See below for the actual view)
--
CREATE TABLE `view_pedidos` (
`id` int(10) unsigned
,`desconto` int(11)
,`status` varchar(255)
,`dtpedido` varchar(10)
,`valortotal` decimal(45,2)
,`valordesconto` varchar(115)
,`nome` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure for view `detalhe_itens`
--
DROP TABLE IF EXISTS `detalhe_itens`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detalhe_itens`  AS  select `cli`.`nome` AS `cliente`,`cli`.`cpf` AS `cpf`,`p`.`id` AS `pedido`,`prod`.`nome` AS `produto`,`i`.`qtde` AS `qtde`,`i`.`id` AS `id`,`i`.`produto_id` AS `produto_id` from (((`pedidos_itens` `i` join `pedidos` `p` on((`i`.`pedido_id` = `p`.`id`))) join `produtos` `prod` on((`i`.`produto_id` = `prod`.`id`))) join `clientes` `cli` on((`p`.`cliente_id` = `cli`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_pedidos`
--
DROP TABLE IF EXISTS `view_pedidos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pedidos`  AS  select `pedidos`.`id` AS `id`,`pedidos`.`desconto` AS `desconto`,`pedidos`.`status` AS `status`,date_format(`pedidos`.`dtpedido`,'%d/%m/%Y') AS `dtpedido`,sum((`produtos`.`valor` * `pedidos_itens`.`qtde`)) AS `valortotal`,format(if((`pedidos`.`desconto` = 0),0,(sum((`produtos`.`valor` * `pedidos_itens`.`qtde`)) - ((sum((`produtos`.`valor` * `pedidos_itens`.`qtde`)) * `pedidos`.`desconto`) / 100))),2) AS `valordesconto`,`clientes`.`nome` AS `nome` from (((`pedidos` left join `pedidos_itens` on((`pedidos`.`id` = `pedidos_itens`.`pedido_id`))) left join `produtos` on((`pedidos_itens`.`produto_id` = `produtos`.`id`))) left join `clientes` on((`pedidos`.`cliente_id` = `clientes`.`id`))) group by `pedidos`.`id`,`pedidos`.`status`,`pedidos`.`dtpedido`,`pedidos`.`desconto`,`clientes`.`nome` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pedidos_itens`
--
ALTER TABLE `pedidos_itens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;

--
-- AUTO_INCREMENT for table `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pedidos_itens`
--
ALTER TABLE `pedidos_itens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
