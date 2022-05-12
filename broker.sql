-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 12 mai 2022 à 13:16
-- Version du serveur : 10.4.24-MariaDB
-- Version de PHP : 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `broker`
--
CREATE DATABASE IF NOT EXISTS `broker` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `broker`;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id`, `title`, `description`, `image`) VALUES
(3, 'villa', 'Une villa est un type de maison qui était à l\'origine une ancienne maison de campagne romaine de la classe supérieure. Depuis ses origines dans la villa romaine, l\'idée et la fonction d\'une villa ont considérablement évolué.', 'villa-62717e5c09018.webp'),
(4, 'appartement', 'Appartement mis à disposition par un employeur durant l\'exercice de ses fonctions professionnelles.', 'appartement-62717ee2c6c57.jpg'),
(5, 'terrain', 'Espace, étendue de terre, emplacement, parcelle.', 'terrain-62717f9d11e7c.jpg'),
(6, 'maison d\'hôtes', 'Une chambre d\'hôtes est une chambre meublée située chez l\'habitant en vue d\'accueillir des touristes. Un meublé de tourisme est une formule de location saisonnière dans un logement qui n\'est généralement pas la résidence du propriétaire.', 'maison-d-hote-62717fcf6e4b5.jpg'),
(7, 'usine', 'Établissement de la grande industrie destiné à la fabrication d\'objets ou de produits, à la transformation de matières premières, à la production d\'énergie.', 'using-62718013b7d3d.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20220502143433', '2022-05-02 16:35:24', 4158),
('DoctrineMigrations\\Version20220502144432', '2022-05-02 16:44:59', 1317),
('DoctrineMigrations\\Version20220502150028', '2022-05-02 17:00:44', 9327),
('DoctrineMigrations\\Version20220502231848', '2022-05-03 01:19:06', 417),
('DoctrineMigrations\\Version20220503203544', '2022-05-03 22:36:05', 2729),
('DoctrineMigrations\\Version20220503205121', '2022-05-03 22:51:27', 612),
('DoctrineMigrations\\Version20220508101709', '2022-05-08 12:32:04', 5955);

-- --------------------------------------------------------

--
-- Structure de la table `image`
--

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `image`
--

INSERT INTO `image` (`id`, `item_id`, `author_id`, `path`) VALUES
(6, 4, 4, 'villa1-627183e99290b.jpg'),
(7, 3, 4, 'villa2-6271840ef1c45.jpg'),
(8, 3, 4, 'villa3-6271842484f87.jpg'),
(9, 3, 4, 'villa4-6271843f64a11.jpg'),
(10, 3, 4, 'villa5-627184623e6b3.jpg'),
(11, 4, 5, 'villa3-6271c3ee7fdb8.jpg'),
(12, 4, 5, 'H5-626bc8ca22d1f-6271c577638f2.jpg'),
(13, 5, 4, 'terrain1-6276bf5dc98d9.jpg'),
(14, 5, 4, 'terrain2-6276bf7d81525.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `item`
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `categorie_id` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `rooms` int(11) DEFAULT NULL,
  `bathrooms` int(11) DEFAULT NULL,
  `large` double DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `item`
--

INSERT INTO `item` (`id`, `author_id`, `categorie_id`, `label`, `description`, `price`, `created_at`, `rooms`, `bathrooms`, `large`, `address`) VALUES
(3, 4, 3, 'villa avec piscine', 'Situé au calme à 8 kms du centre ville au sein d\'un domaine sécurisé avec bar-Wi-Fi, restaurant et vaste piscine-bain à bulles en partage, Dar Beldi est une résidence locative réalisée dans la tradition marocaine, sans vis-à-vis et privatisable.  Au cœur', 1499.99, '2022-05-03 21:25:07', 5, 2, 152, 'Boulevard Mohamed VI - Marrakech-Safi'),
(4, 5, 4, 'Dar Erka', 'Le Dar Erka est située dans le village berbère authentique de Oumnas à 20 km au sud de Marrakech sur la route du lac de Lalla Takerkoust, la villa dispose de 3 grandes suites avec coin salon et salle de bain séparée et 1 chambre avec salle de bain et wc .', 299.9, '2022-05-04 02:05:42', 4, 4, 250, 'Marrakech sur la route du lac de Lalla Takerkoust'),
(5, 4, 5, 'Terrain à vendre', 'PROJET À NE PAS RATER, Je vous propose un joli projet très intéressant à un prix très abordable. Un terrain de 504 mètres carrés titré et très bien situé à Guéliz Marrakech (Avec autorisation d\'un appart hôtel ou un immeuble R5 qui se compose de 22 appart', 6800.99, '2022-05-07 20:46:14', 0, 0, 504, 'tata');

-- --------------------------------------------------------

--
-- Structure de la table `position`
--

CREATE TABLE `position` (
  `id` int(11) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `username`, `roles`, `password`, `firstname`, `lastname`, `phone`, `profile`, `created_at`, `email`) VALUES
(4, 'tenant1.tenant', '[\"ROLE_TENANT\"]', '$2y$13$8pCFRRBGjSx40JOVZKTtQOpo3w0dTsfCa4wSLJLfdFxRHLjFbl7rS', 'tenant1', 'tenant', '(+212) 6 36 75 68 52', 'H6-627157426112b.jpg', '2022-05-03 18:24:34', 'tenant1@gmail.com'),
(5, 'tenant2.tenant', '[\"ROLE_TENANT\"]', '$2y$13$TwzU4j8mw8Ssjn.DpIx6ZOHQtfeUW7huzbMPHGmB4HlngWtV.HQnS', 'tenant2', 'tenant', '(+212) 6 36 75 68 74', 'H5-627157eeb7005.jpg', '2022-05-03 18:27:26', 'tenant2@gmail.com'),
(6, 'admin2.admin', '[\"ROLE_ADMIN\"]', '$2y$13$G5L64uQGGdabfCJ3ehlOqObp2S7Nnd8pvCUmxFu5lRygBOGtrLlu.', 'admin2', 'admin', '(+212) 6 36 75 68 11', 'H4-62715852cadfc.jpg', '2022-05-03 18:30:38', 'admin2@gmail.com'),
(7, 'admin1.admin', '[\"ROLE_ADMIN\"]', '$2y$13$XDhfx4RwDFq8QJGe/eINIOGhl2uWpu9HNeNF0VHGro8IzHtDfaQii', 'admin1', 'admin', '(+212) 6 36 75 68 50', 'H3-62715892c2ea9.jpg', '2022-05-03 18:30:10', 'admin1@gmail.com');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C53D045F126F525E` (`item_id`),
  ADD KEY `IDX_C53D045FF675F31B` (`author_id`);

--
-- Index pour la table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1F1B251EF675F31B` (`author_id`),
  ADD KEY `IDX_1F1B251EBCF5E72D` (`categorie_id`);

--
-- Index pour la table `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649F85E0677` (`username`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `image`
--
ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `position`
--
ALTER TABLE `position`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=940;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `FK_C53D045F126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `FK_C53D045FF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `FK_1F1B251EBCF5E72D` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`),
  ADD CONSTRAINT `FK_1F1B251EF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
