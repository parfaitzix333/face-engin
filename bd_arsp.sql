-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 28 sep. 2026 à 01:45
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bd_arsp`
--

-- --------------------------------------------------------

--
-- Structure de la table `affectations`
--

CREATE TABLE `affectations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `categorie_id` bigint(20) UNSIGNED DEFAULT NULL,
  `poste_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `affectations`
--

INSERT INTO `affectations` (`id`, `employe_id`, `service_id`, `categorie_id`, `poste_id`, `date_debut`, `date_fin`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 3, 1, '2026-09-12', NULL, 3, '2026-09-11 22:59:38', '2026-09-11 22:59:38');

-- --------------------------------------------------------

--
-- Structure de la table `annees`
--

CREATE TABLE `annees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `annee` year(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `statut` enum('active','inactive') NOT NULL DEFAULT 'inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `annees`
--

INSERT INTO `annees` (`id`, `annee`, `created_at`, `updated_at`, `statut`) VALUES
(3, '2026', '2026-09-11 16:41:45', '2026-09-11 20:54:10', 'active'),
(4, '2025', '2026-09-11 18:55:49', '2026-09-11 18:56:23', 'inactive'),
(5, '2024', '2026-09-11 18:56:37', '2026-09-11 18:56:37', 'inactive');

-- --------------------------------------------------------

--
-- Structure de la table `archives`
--

CREATE TABLE `archives` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type_document` varchar(150) NOT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `fichier` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `date_archivage` date NOT NULL,
  `archive_par` bigint(20) UNSIGNED DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `archives`
--

INSERT INTO `archives` (`id`, `employe_id`, `type_document`, `titre`, `fichier`, `description`, `date_archivage`, `archive_par`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'electronique', 'archive 1', 'archives/UciwdygyCRmupCTuzaibaRWvBh4c54yZ56mcpCrR.pdf', '-', '2026-09-13', 1, 3, '2026-09-12 22:34:50', '2026-09-12 22:34:50');

-- --------------------------------------------------------

--
-- Structure de la table `audits`
--

CREATE TABLE `audits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `role` varchar(100) NOT NULL,
  `ordre` int(11) NOT NULL,
  `date_debut_service` date DEFAULT NULL,
  `date_fin_service` date DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `audits`
--

INSERT INTO `audits` (`id`, `employe_id`, `role`, `ordre`, `date_debut_service`, `date_fin_service`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'chargé de saisie', 4, '2026-09-12', NULL, 3, '2026-09-12 21:53:41', '2026-09-12 21:53:41'),
(2, 3, 'chargé de maintenance', 4, '2026-09-02', NULL, 3, '2026-09-20 11:15:26', '2026-09-20 11:15:26');

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-204|127.0.0.1', 'i:2;', 1790357200),
('laravel-cache-204|127.0.0.1:timer', 'i:1790357200;', 1790357200);

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `designation` varchar(150) NOT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `designation`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 'Menoeuvre', 3, '2026-09-11 21:02:05', '2026-09-11 21:02:05'),
(2, 'Travailleur Semi-Qualifié', 3, '2026-09-11 21:15:03', '2026-09-11 21:15:03'),
(3, 'Travailleur Qualifié', 3, '2026-09-11 21:15:27', '2026-09-11 21:15:27');

-- --------------------------------------------------------

--
-- Structure de la table `communiques`
--

CREATE TABLE `communiques` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titre` varchar(255) NOT NULL,
  `contenu` text NOT NULL,
  `piece_jointe` varchar(255) DEFAULT NULL,
  `role_cible` varchar(100) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_publication` datetime DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `communiques`
--

INSERT INTO `communiques` (`id`, `titre`, `contenu`, `piece_jointe`, `role_cible`, `user_id`, `date_publication`, `annee_id`, `created_at`, `updated_at`) VALUES
(6, 'Communiqué 1', 'Contenu 1 vvvvvvvvvvvvvvv dddddd ggggggggg rrrrrrrrrrrrrrrrrrrr kk', NULL, 'Employe', 2, '2026-09-03 11:01:00', 3, '2026-09-14 22:39:49', '2026-09-14 22:47:34'),
(7, 'Communiqué 2', 'Doooo fuuuu ffffff sjjjj ddff f   r ttttttttttj hhhhhhhhh', 'communiques/0GyxjyvRIfoVizy2axfNJHRANu8H3Q9VQXt8QP4p.pdf', 'tous', 2, '2026-09-09 11:11:00', 3, '2026-09-14 22:40:58', '2026-09-15 00:20:44'),
(8, 'Communiqué 3', 'ffffffffffffffffff dddddddddddddddddddddddddddd ssssssssssssssssssssssssssss', NULL, 'tous', 2, '2026-09-13 23:00:00', 3, '2026-09-14 22:44:41', '2026-09-14 22:47:16'),
(9, 'Communiqué 4', 'fffffffffffffffffffffffffff nnnnnnnnnnnnnnn rrrrrrrrrrrrrrrrrrrr ttttttttttttttttttt yyyyyyyyyyyyyy o', NULL, 'tous', 2, '2026-09-13 03:03:00', 3, '2026-09-14 22:47:06', '2026-09-14 22:47:06');

-- --------------------------------------------------------

--
-- Structure de la table `conges`
--

CREATE TABLE `conges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `designation` varchar(150) NOT NULL,
  `TYPE` enum('paye','non_paye') NOT NULL,
  `indice` enum('++','--') NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT 1,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `conges`
--

INSERT INTO `conges` (`id`, `designation`, `TYPE`, `indice`, `actif`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 'congé maladit', 'paye', '++', 1, 3, '2026-09-11 22:14:08', '2026-09-15 16:53:08'),
(2, 'Congé sabatique', 'paye', '++', 1, 3, '2026-09-15 08:14:08', '2026-09-15 08:14:08');

-- --------------------------------------------------------

--
-- Structure de la table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `whatsapp` varchar(50) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `contacts`
--

INSERT INTO `contacts` (`id`, `email`, `whatsapp`, `tel`, `adresse`, `longitude`, `latitude`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 'parfaitzix333@gmail.com', '+243900182599', '+243999385123', 'Av du 30 juin.comm annexs/Lubumbashi', 27.4955355, -11.6536973, 3, '2026-09-12 21:56:36', '2026-09-12 21:56:36');

-- --------------------------------------------------------

--
-- Structure de la table `demandes_conges`
--

CREATE TABLE `demandes_conges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `conge_id` bigint(20) UNSIGNED NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `nombre_jour` int(11) NOT NULL,
  `motif` text DEFAULT NULL,
  `statut` enum('brouillon','soumise','validee','refusee','annulee') NOT NULL DEFAULT 'soumise',
  `valide_par` bigint(20) UNSIGNED DEFAULT NULL,
  `date_validation` datetime DEFAULT NULL,
  `commentaire_validation` text DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `valide_national` tinyint(1) NOT NULL DEFAULT 0,
  `valide_secDg` tinyint(1) NOT NULL DEFAULT 0,
  `valide_serv` tinyint(1) NOT NULL DEFAULT 0,
  `piece_justificative` varchar(255) DEFAULT NULL,
  `interimaire_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `demandes_conges`
--

INSERT INTO `demandes_conges` (`id`, `employe_id`, `conge_id`, `date_debut`, `date_fin`, `nombre_jour`, `motif`, `statut`, `valide_par`, `date_validation`, `commentaire_validation`, `annee_id`, `created_at`, `updated_at`, `valide_national`, `valide_secDg`, `valide_serv`, `piece_justificative`, `interimaire_id`) VALUES
(4, 1, 1, '2026-09-24', '2026-09-26', 3, 'dfdfdfggfg', 'soumise', NULL, NULL, NULL, 3, '2026-09-22 17:46:41', '2026-09-25 12:19:08', 0, 1, 1, NULL, 3),
(5, 1, 2, '2026-09-25', '2026-10-24', 30, 'Pause annuel', 'soumise', NULL, NULL, NULL, 3, '2026-09-22 17:48:40', '2026-09-22 17:48:40', 0, 0, 0, NULL, NULL),
(6, 1, 1, '2026-09-28', '2026-10-02', 5, 'ddddd', 'soumise', NULL, NULL, NULL, 3, '2026-09-22 18:26:42', '2026-09-22 18:26:42', 0, 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `disciplines`
--

CREATE TABLE `disciplines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `sanction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `etat` enum('declaree','levee') NOT NULL DEFAULT 'declaree',
  `DATE` date NOT NULL,
  `contenu` text NOT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `disciplines`
--

INSERT INTO `disciplines` (`id`, `employe_id`, `sanction_id`, `etat`, `DATE`, `contenu`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'levee', '2026-09-12', 'Mumba Boaz est mise a pied avec éffet immediat.', 3, '2026-09-11 22:48:20', '2026-09-15 16:20:54');

-- --------------------------------------------------------

--
-- Structure de la table `dossiers_etude`
--

CREATE TABLE `dossiers_etude` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type_document` varchar(100) NOT NULL,
  `fichier` varchar(255) NOT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `employes`
--

CREATE TABLE `employes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `matricule` varchar(50) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `grade_id` bigint(20) UNSIGNED DEFAULT NULL,
  `service_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `lieu_naissance` varchar(150) DEFAULT NULL,
  `province_origine` varchar(150) DEFAULT NULL,
  `territoire` varchar(150) DEFAULT NULL,
  `localite` varchar(150) DEFAULT NULL,
  `niveau_etude` varchar(150) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `emploiyeur` varchar(50) NOT NULL DEFAULT 'ARSP',
  `date_engagement` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `employes`
--

INSERT INTO `employes` (`id`, `matricule`, `nom`, `grade_id`, `service_id`, `date_naissance`, `lieu_naissance`, `province_origine`, `territoire`, `localite`, `niveau_etude`, `user_id`, `annee_id`, `created_at`, `updated_at`, `emploiyeur`, `date_engagement`) VALUES
(1, '201', 'Allegresse Umba Malaka', 1, 1, '2026-09-10', 'Likasi', 'Tanganyika', 'Kabalo', 'Mwenga', NULL, 4, 3, '2026-09-11 22:23:13', '2026-09-27 19:15:54', 'ARSP', '2025-10-08'),
(2, '202', 'Baraka Umnba-Nguz', 3, 1, '2025-12-03', 'Likasi', 'Tanganyika', 'Kabalo', 'Mwenga', 'Master/Licence(AS)', 5, 3, '2026-09-14 22:43:35', '2026-09-27 19:16:32', 'ARSP', '2025-12-30'),
(3, '203', 'Sephora Nguz', 3, 1, '2000-09-01', 'Lubumbashi', 'Haut-Lomami', 'Bukama', 'Kinkonja', 'Master/Licence(AS)', 7, 3, '2026-09-15 20:18:29', '2026-09-27 19:11:37', 'ARSP', '2025-11-26'),
(4, '204', 'Numbi Kabange Guelord', 1, 1, '1996-12-25', 'Lubumbashi', 'Tanganyika', 'Kabalo', 'Mwenga', 'Master/Licence(AS)', 1, 3, '2026-09-22 18:57:32', '2026-09-22 18:57:32', 'ARSP', '2026-09-22'),
(5, '205', 'Mariclaire Nguz', 3, NULL, '2026-03-26', 'Lubumbashi', 'Tanganyika', 'Bukama', 'Kinkonja', 'Master/Licence(AS)', NULL, 3, '2026-09-27 19:30:38', '2026-09-27 19:30:38', 'ARSP', '2026-09-01');

-- --------------------------------------------------------

--
-- Structure de la table `face_templates`
--

CREATE TABLE `face_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `face_embedding` varbinary(3000) NOT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `face_templates`
--

INSERT INTO `face_templates` (`id`, `employe_id`, `face_embedding`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 4, 0xa57509bd3142e7bacb98b93c6b5ceebc2d5c773dca677c3ddbd1083da10123bcb7faf83bec83993d942b6bbb30aa1c3d1f42c5bdbaa42dbd18fc3f3c046b473d707298bd131159bbee50673de2674ebd9925123d076984bd8ae59c3daf6684bc5db7dfbcdc209f3d492b72bca67487bce3beff3bc897b4bc594531bd2627753d4ea44ebcdd7c6b3b469c5fbd46f6f83de1247fbd838ffabc27960b3bedf0903da2e1ebbcadfc013dcbdc0ebdb593a23d3759b0bd6318123c5dbaf03c26270c3d9c4048bcddb26b3cf2d797bd7e7988bb4e138e3d99323e3cc02d92bbb66383bdf18d8dbc2d64253de92d5b3cf73a163b3b59d8bc6af7ebbcdcaf34bda7c7453dfbb13b3c82f485bd7837f5bb3816f6bc6a5758bd44588e3db9b2f73c7784053b2cacb3bcd223b5bc5d8f7d3d91afd2bc0dc9b0bcda4d3dbd459c833c5f4ad8bda185dd3cae2360bd8c7835bd5ecfc03bf92f903d472b0abdbf51003dea0602bd79801b3c0364813d4897de3ddb0f363df48939bdf0cffbbb787e9f3c742978bc0671ab3c6ebc39bd1361463d73d6053d26086ebde7c23d39696e98bc0c1d093d4d9d1fbd2a329b3d83cbc8bc8f08383df4d9ee3b8751063d8d4ef93c90bfb43d2d04753d6237813dcee685bd853d783b800141bdc65498bd7c49d2b831b8813c962df0bb67d7b1bcabd0a1bdc8adebbdaef958bdc57a6abc6d91403c63406f3c476dc03b6e638c3c5dc26e3cb887a53b92479fbdb4f4e63c1af3623db6c9463d617820bd52b8333d131c5a3c24195e3de537fd3c3f97c9bc10faa33c1a0d103ceacfcf3cddbf9e3b8489023baf5e0a3d8a8045bd2a03833b26ef2cbc9d3a813c709402bd5279273d810a38bd3fb00e3d68dc6c3c6fdd0bbb0f67c3bd970ccabdef1111bdb63af0bbf0b069bd54d0d33c7e81243dfa7ee4bc2af3a33ce06282bcee77943ccf71cc3b89aff73beb128dbd8c2341bcf97207bd0295bb3cabc17dbd9887ba3cf2cd113d9eed023da15049bc3480c5ba8120823b7e0c1abba135ae3c6a6dbbbde438c23b7320a73c346f22bcf622cd3cabb0433c95c0bc3c9295913d07a9f6bc5a8f803a1c57b53cf57fc3bcb87f983c966639bd4de845bd752784bdab52f83c49d5413c0cab9dbdf86f253c5b8f053dd1a754bde609e53c9df4e6ba5368293bf88bfbbb67e476bc903019bc82caa33db913893a9d189c3d872a713d1b10eabc6484ec3c6e24c0bc430b4e3dc3e7873c95d1183d3d0f26bc4a0f34bcb662acbcb3c813bdf869bf3bf57503bd60a7623daeec363d2ebbd2bc07040c3e257038bd27943dbc4eb6783d7627ab3db277063d691f69bde67280bc026b49bcbb83713d03239b3d7c6aa9bd4e31b43d77f8f73c320916bdea35883dd55e13bd7faac7bd2678983ccd51233d0c0a503ce3a7b2bd3ddf82bd0ef892bc1a5ffd3c3c222cbd2dedb33ccf0397bcdf86d9bcc85358bd518b52bc69a4b7bde6fb343d5de2d83c65591f3c7b21523c3a0288bdd1a3fabc2c5b0a3da4fa2c3d304bd7bcd4330abd256437bd7e184bbd875512bdbcd92dbc7654ba3bc3020ebdedf338bcd765f93c4c2927bd776a59bd8cc487bdbed9e53b2ad4583d043cdcbde29f493dc5a9953d7a29243dab8941bcf74f4dbb1238bebbd7bade3dd4e4123d7c4b783c2daf123b1977153cb07b3ebc18724b3c096be2bb6d9dfe3a71fa163db89d98bdd963dd3cc13039bd6cfc2f3dc11652bd871a0b3d2aba67bcb96eb93ca427a03c44c78d3dce16c9bc2c0942bd70793b3dfb12b8bc35cdfb3ca42d0abcfd5d72bce77fe9bce644f23c4402c43c034a743cc20f73bce27da43c49cf34bdd8518dbcf827a0bcf8a7a0bde7e27ebc61e4e3bc87d45c3cbb0a08beaa2a81bddc08cd3da05fc53c07f938bcc0170e3c4701ecbb815e25bd305507b92be6fcbc07de603d0b1feabcf532113d31d68fbc3f73563c98d20e3d81832e3c6d7964bd4c5b9d3c024a8b3bd0887ebd7d27893dc9ceb83b2746f33c00f68ebb8fcc0ebd159d24bdd2e9c5bc7f9ed5bd3316f83bcb34c5bd410b26bde1371e3d5772ba3dd09825bae6abd8bc9d7181bc58bf813c84844cbdce1509bd889dccbdd39907bdb80732bd196849bd6fe209bd4306a1bd9f523fbca06c0ebd16b7d0bc2d4f5ebc01cc86bdacb188bda06eca3c65e3f53bac70a83cc4172dbd044cf6bb1054f2bc2897fb3c5266d63cae74ee3c1c4c6d3cb554913df5da0c3dde7c1a3ccfc258bd1584883c4611bd3c02c2debc858d053cd3ed8b3dca6b4ebc0e02a43ce19a3c3c488b2fbcca6386bd349afe3b2c66653b1b7c4cbc392c233d443f913ded95a2bccd514e3c4bc15d3aafe41bbd9b84e83b5d48bdbb344830bdb014c2bd74521bbcdc53a73d124894bd2fb21dbc22ecfebd4e06913d8256013e34dddfbc0482be3ca86ea73cce07debb756895bd31da833a202330bc503f7ebdaaf0a83b6e0f7fbc4bb831bd692ba2bc112b283d614ce83ce56b20bccffd80bb74d142bbb773e83a8071ad3a0bce29bdf9fa2a3d0fbd4dbdce47bc3c58384f3db1343bbb147e02bd847397bcbc27e03c42e35abdc1a4503c55a44dbb56fac7bc6492febcf63aebba9325af3b06da093d5dfd33bc6c8fb23ce4f75f3c601f9abdaa6f58bdf61c7abdd722913da5f0563cbff5283d6a12123cf03aa4bd7e5a6dbca9a420bdebcaecbd518cddbcbc05143d654748bd867df2bc2dad843d729dd23ce21d8abd350a0f3d533b1d3c12c888bcc4ab643cf4091ebd04dc913a2dcbfc3cf25f8f3db06bce3c45b7c63c78fe213c3cdf7c3d26aea33db773053d245fe83c063d84bd202913bdafcf08bdb402603d7148563cb1e4f33df674f4bc86ee1ebd265ecd3c539ba73cf51a54bc, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(2, 4, 0xbbda21bd5a04663c7db3403d19dcf0bcda9f043d7dba823d91eaacba1d13cebcdd4999bc880e2a3db89061bbc2951a3dd6d600beb1969cbcff9a623c06f1743db80593bce0da03bcde688f3decbbb6bc2be5d93c8ba4d6bc9e2ea73d83605abceaf145bd07a3a63d676afdbc0bf0d4bcdf9f393c44cb43bb5fe4dabc222c7d3d6af3c7bb9cb7273d946181bd2a39a83d467595bcb1f31ebd8690223b57b12d3d83ae59bbb078a0bcffc339bdb915bf3d8d88e8bd54870fbdf7341b3da2ab1d3de022183c6a79133c722ccabdcf48cdbc52fea23d7470033d507904bcbc4a50bd8bd447bd6d6d423dcfb7113d72fdc7bcbf5007bd1c10c83ad5df4fbd899df73c07ce123d9ce32ebd1c3b9fbc00d5d2bcede44bbde6281e3dcc869f3bd708313d8c9aa3bc9e2130bcd87f503dc81203bd66d6d3ba1d4c54bdce159c39f1d6b1bdb36b033d0f353dbd9dd544bdede839bca4ed543d4e815fbcdc56df3c8e7acebb53b15a3bb8c2f33cd5c4c93d4c0a8c3dffd3adbd1c310fbd02fa5c3d453940bc3cd32cbc6df658bdb778613c56d12f3d6f564fbc52e6d63cae9b933b2794683d286f2ebc5f724f3def8039bd7103113d6672113c821ff93c41f1ce3c5f00c83d5621f23cbf5c7f3dfd899dbd7a93a63cd2b127bd466c4cbdbdc3623c553d9a3c98e307bdf93e63bc3b0c67bdcf21cdbd551548bdaded95bdf07d843d4c07e63cf46ecfbc7027843c3c3cba3c1b24583d621582bdba3b1e3dbdafff3cdec74b3d3e1e4fbd1d10973cd3bfbe3c6083343d98e7f53c9d2a3ebbbde17e3bb1102b3cac66523d0f35053d1b6c0c3be0584d3dc0e319bd67c2333cf7f998bcf61e9d3c8ce81cbd5bc0563da20797bd7bd6b03c406b1dbdbfcfba3bc750cdbd1d67b4bd25c8f8bc761d27bdd82d59bd38f2273df7314a3d7206a2bb376bd03c976d2dbdde52b93c95812a3cea83b43b5914e4bc969a663c1bf4c3bcaa91ef3c29f781bd030f603d5e0e5c3bc177b53ce1f915bc115907bc799656ba19b6babc6580203b3384bcbdb115f4bcfe22193d50618a3cdd7df63b33d7e13c737a4dbc2075c03d200b41bd1dc61b3c55ccf63cfd8a3dbc06404abd1ad0bdbdba689ebcbb6570bc6d56043d730e313dd36c9dbdb578333cc561c23c159845bd1b695b3dbf16ab3ca9e2d5395fdc26bdb25cb6bc025ea4bc7c4e893d1440afbc99f51d3d6feaa73d468d323c80e43b3d310a59bc0770643d2fbc42bc1e309b3dfcdc8fbb3e9c98bc26f311bd6e5fb2bb71e6d53b4844c9bcfa1d6b3d6113173d8864f8bbfb9ce03dd9fa34bd3fce0f3c17a38d3ddd1e8f3d7a2bae3da35e7fbdc78091bb414dd4bc62730a3d7f19473d9dbe98bd4bb76d3d0583203dbf1be7bcde933f3d0f1ed5bc9611d5bd131f193cdff5ec3ca776043d3122b1bdb28279bd66bfeebc08eb6a3d1dd89fbd9f7f803cce6705bce71227bdb7382fbdcceeacbbeb4aa3bd4406193d0d97953c1bf2093c4e6b5e3ce57b64bdbbe1ffbc77f61a3dfc2fa53c6026a2bc9d8130bcfa0e0cbdff29bbbc996b93bc576b03bd4efd403bd66e2bbdbf0934bcb289263d31d6763ccf7523bdce1813bd0701883c8ac8923d66fec1bd8e1b833dbf7a8e3dee3f2e3da59e75bc08b1a4bb0c4ebdbc918ac83d1572a03de53a8cbcf1d7f7bb2279333c19f603bb219ebcbbff46d73a822dd0bb0daf323dd7257cbd863af13c6cf1b3bc870f3f3d5ef4a3bd4cae3a3d465765bcd4718e3c0e176b3d9fbd8d3dc22fe2bc7e7958bd3ed4323d455affbca2638f3c17d9b73c670eaebb5cfd62bda25c4e3afb74af3cd57eaf3c2789debc09ca743abf3964bc8a068f3cdc1efebc95f68bbd6206c0bca9a4f9bcc07e0d3c7367bdbdf02581bdd360bf3da919853cfa3461bacd35713a93b9073c3925bfbce8e91f3ca0d91a3a5616913d198e36bdc0a424bb2936afbba8e3bc3cd847263bdd640bbc5faa3dbd9301033ca32ab63ccd78e2bd663c653d218293bc3f16323ddba302bda867b8bc28cc3ebd536ff7bc29e675bd873adab7da87a9bd353892bddd36aa3cb4a4c23ddb4fedbace69abbc725801bd30e0fabb75654bbd038a22bc66f4a6bdc039cdbc10c50cbd773910bcb81d17bc5bb582bdbc82cdbcc2a6ba3bea1ddfbba82148bba98a93bc344fb1bd955e303d4860dd3bafd4b83c4f8f1fbb98a4b2bca6a8d0bb2456093d0565c93c461d0d3d5c2d763c0eb5843df24a523dde20d13c7f1c49bdad44233c5978b83b60caeabcc3ed553c3d141d3d508d12bdd21fb23c8b168e3c13da51bc13745abd8b34023cf325a3bcd20db4bcdab9323cb652b73d4dd683bdc8ef58bc5a50283bd73cf9bc02d6953b0b7b7fbc5e6797bda0a0d8bd72d91c3d2a269d3d3aa9f5bd646e4ebcde65f5bd93ff663d0035af3dc2d3c13a6b10cbba74bd083d5844d73b4d1b9ebd416838b8be1e81bc55b337bd7802ab3cf77ec13b78230abdc1c9153cfa80393c4b00083d91e30a3d36d5c0bbbdb66fbdec52a6bcfb39553bfb3023bd1ceb9a3d7d6688bc21afa63c98823f3d4dba8abcec065cbd6418f9bc726c4d3de22344bdefda3b3b7e4303bd54d1b7bccb93b4bcd3f378bc281dc93baf14fe3ceec08abbfb0ae83c35523b3dfdd6a1bddd8e52bd3d13b7bdec5b823d51b6373c7891533bf99379bb4da75bbc1c4c07bc6d645abde615bebd774986bccdbb023b3eaf4fbdc1f08dbc2da2893d2c5b5d3b866acbbd77d0a63c59408b3ce106fdbc0a3d9f3c0c6b8fbd3f296fbcbcb2963d8c37a43d6d23e63cd6118e3c507aa63c41606d3d4b1ea73dde54363dcfc3c83c158453bd07d914bd716f41bd97f80c3dc983fa3cf5bc023e0045d0bc5327b2bc13218d3c9904ecbc712e2fbd, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(3, 4, 0x8a30853b2289bf3cab5897bc9c7c79bced82043b9308c03c317c223cfd5910bdd33deebbaf7c113daf41bc3bc8f5403d5dac89bd65128cbca8f19bbc4d4aad3cd95937bdbf5fa0bcfda3f93c57f1c33c073e13bd8103ba3a47d6993d059019bd9827a7bd5c5ffc3dd030743c0b78a4bc6a9d0d3dbfdf073b82530cbc89680b3d4e104bbdc2ce4c3d6607a3bde469f23caaa5a8bcb71913bde681e1bc55a6303d90a33ebd1c7c263c2754a7bc18476b3dc07fe5bd17e07cbddb4dacbc81a4d43cafa7f5bc0aae5abcf7011dbd30e327bd4281b03dcb3cae3cd2775bbd41d7633b81c5cdbb3345c53d5b71b23cbff65ebd688bb3bb2738f9bc5af014bd37f22d3c1e548d3c87c3a9bd3fe905bd474cb1bc8d237dbd2efa3a3dbd596a3c8ed6403d523a65bda45505bc7513923dda8d63bcffd274ba8ed83abc9fae29bb3a807fbd2359363c5f189cbd0e6485bd8bcece3b57f7c53c178be1bc38c8473dc18e2f3cf3e3cebcf27d833df405a33d1684843dad6b8abd024d89bc3b7cef3cc29709bc87a703bd692387bc35377b3cd8f3243db2c017bc617fab3bec0598bc6bd7393d1bc97abd9bd4afba37e517bd1556863d3eab05bb9b7e173cc5263e3d7d279a3d2997673d2964813d780706bd7bdb4a3db57c11bb22579abd8b2b3dbc5c0ddd3ca90f4d3bae10323c287653bd7948cdbd86f320bd41d239bd91c7703ca87d1ebda58eff3b6376823c6ba29b3cd53fb03ce3895bbdf3b8163c0a862abc69c8323d50bc71bdd125783d4320d03cc4ab353d5e29b33c8a308bbbf6f3e53c4ae8153d9087843c881897bb600a2abc441ce83c6aa1f7bc940f113d2acd763c8296bd3c8cfa0cbdae78083d7d8b8ebd2e294d3ab5393fbbc7fdb03b708078bd90ba06bee00dcbbcea793cbdcc728bbdad76ed3c33ab563de1e8da3c8b08243d7ebd2fbd51af9ebc375b123cf9070d3d5a1bf7bc714f6c3c66a032bd5b0e3b3df6c162bdb6cf5c3d250a363dc4c8debb5a3a92bc12c3853c60b089bc5dfbd7bce11badbceebf99bd2ca44a3bd847b538b3ff293d732513bcfd94193cfa81bdbcac217e3dea3290bd323c253dad7106bb0bdf2bbcfd12ddbc9d815dbd654237bd699ea2bc9b559a3bf9155c3df39f9ebd97685f3d0851853cbb56c9bc73bb463d54d2e83c42f9043c0d907eba83d438bd130f7bbc76e44a3dc5a994bc8fd4673d74615c3d3148ce3c161c113d98eabfbc9015863dc11b2c3c2cff933d6e94163dfd6aed3cf8af49bd24180ebdc794263ddecc98bc3820213dfda4603d3ae9a33c0f21cf3dd3e7aebca67b22bd3872863df6294a3de4949b3d252481bd32f6493d446b073d6a46823b3839923d57b580bd3910843d72d142bb544e1cbdb683573dc25c02bee6e482bc6acddf3bf3e829bbefb9043de19685bd9d6b71bd82d20dbd1e74273df1b486bd701624b82c7dd3bc696672bc8a0532bd4e7eadbc0e1195bd6089063db0e55f3dca28efbc04044b3d16a761bd5802f8bce3292e3b0e18463c9c82fc3b8f15f73bb62348bd88352d3a683a68b867911fbc12808fbcc2c453bd7802f7bcb5efd83cde9cf93c621912bd30285c3b03831fbb4ad91e3dad6129bd11a0a43d0dbcef3b7c7f80bc8418f63ca16e2fbb98da89bcd5a97e3d195eb83c2add343c520495bcb0ab823a8e253e3d4f78e0bcd3705f3d575fa3bcf70f763d46c98cbc09363d3d301aa73c457a2d3dc119febd0b2a283da9f1afbc3f27023d31a0933c3ed8a83d1f2ed4bc64770abd8da3793b9496533cddd84b3d43859fbbc86de339e6d6fbbce3fd153c83a91d3c5e251cbddf9effbc92ab77bc3b43d2bbc1e3293d2c1f183c41de84bd207da5ba151ba4bcbc26d93c3bcd14bd3f43c43b6dc78b3d25754cbb961a2ebc4c7c883cc488113d49cff6ba31e4e6bba502b5bc8648103def5f4cbdaa61453dd03024bbf6b954bc8b77193d2a68333dd5ef73bd0688983cecda2b3d93cf0dbe68e6de3da10931bd9f2ce13b15333a3cc9791ebcc38d57bd7fa2b5ba9190b1bdc17847bc2d7181bd40cfd4bd294a0f3d843a253d1edb083d915ea9bc8ed917bd6ab191bb246d76bd683744bd0355bbbd89dd563cb02a84bdcb86b0bcc0b10dbc0fd74dbd9ed5c4bc31bdaeb8a73370bcf61a343d95b8aebd9ebc99bd7bcda73d364f1c3cdf45733d426000bd070abfbc4d70073d8aa3953d73a0063db60d6b3dba83863cc288023d2eb91a3d4c413a3d53b497bd99fa27bc22f857bb760519bdc7b1433daa45713d96ddac3a2b35313da5c5fa3bf01fd1bce0eac1bc1ee8843cf08ed5bc9e6602bd93c0d23b3b9e743d9c0d8bbd8eda07bd3f9e773ce79862bc0845a3bcb08195bc2ec8aebd0985ffbd5f7a873ce043823d574eabbd974641bd2b53f1bdb22f203cd6459b3d546fccbc115f07bced98c43c28c5e2bcc46c9abddfb41e3c3f058bbbc903eebc226e24bd37699b3ca942fdbccb2114bd87a7553d7f94513dacde983cb2d0813c10e4a6bda352903c995068bc22527ebd94fe963dae6b35bd0875923cd34ebabb3620b4bcb761bc3cef38cfbcc8583d3d680bed3c3d8266bc043d233c168471bdfca6bb3ba1707abc666dd73c559bcd3c17c70bbd551db1bbafe0e43ca20932bd6785af3cf0ea90bd57ef6c3d6150213d72a88a3ced5662bc60b109bc7eb994bb7a50bbbd25fdc7bd07c2fd3ca49a22bbb8737abdd8cefcbb35871b3d50938a3d71054abd4488423cd4d9963c91da96bd1b7b58bb7ad1aebd0fc416bd62076e3dfdd7993d2591803b9109ff3cd2455a3bbe545f3db082873dde298b3dc685423ade0269bd7fdb2bbd5d9057bd7268c63c521d0f3d34332e3ec9b274bd070ba63c3bad813dd30f2fbc23901bbd, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(4, 4, 0x86bc43bdc0126bbcacd11b3d3fa0e0bc3c0c313db2eb783c9736f83c9a6808bdf877103d268f5f3dcaf2643c9592a03d155db0bdd565fabb058f04bde3b3b2bb9a0182bd7c7cbebc6e21633c8c3590bda6e2a03c7aa013bd4b7b903d4a65523b4f3b59bd9a52b53d6e4d9b3cf2d709bd8c8d17bc72e347bd981c1fbc40d7ed3c877c2bbd38fb3b3ddbbe92bce579f03d8dfdb13c2ba8f7bca45a0bbd8b51293d9c72b1bcb459c43c75e083bd4226083d6b15a7bda57a12bada98f6bc5c53fd3c4c5a823c49049fbc1f8d94bdbed23ebc2e54a43dba0191ba40c481bd1394aabd22d43ebcba93983c2c22e2bba5049ebab51d13bc80f9013c8cf682bcb508343cf401183d73ef91bd1a423cbdc8c9a4bd70e390bcab2c8b3da50ce33c108e05bd1ef8c7bc3562a6bc1c18a33d6a88a2ba436cc93a9d8a8cbdf316b33ce94ce0bdb06877bc598391bd85fe96bcc60d683c58f67f3dd81d5fbc2186db3cd1d60dbc5b3f9dbcea58623ddb68823d71a5673d83ac153b3de8a8bcddeebebc651977bc016ea23b51af5f3cd325ea3bfb01713c9db344bda91ca4bb59e7a9bc1608293d9733b8ba5a63603c182a3bbd3a753cbc8edb123d32292f3d2cb37bbc7acba73d7c63c93d848bb13dead742bd6e601cbadbf36a3c07d06dbda425023b6d72243c32c2c63ce2569cbbb61c50bd074ad0bd80a984bc8145e7bc8574cfbb567d78bd8bc42fbc5df335bb8a56b13aca48debc81c3f8bca98d003cec45ba3c7038623d68e07ebbf755553dc9b82bbdb7adea3c27291f3c43fcc1bcceb93f3db7ab143dfccfbdbc9a31d7bb3cbaa8bbbe04e03cabe866bd9ce798bc9c3f813d2b14e93be8c794bc3f44dd3caf88803bffa825bcd331c2bb88930abdd79296bd4c32cabccb58adbdd885ecbc24b18fbdfe2a0e3d2943af3d3faf183c3b3fb13c4253303b5df585bc96e5ce3cdc3697bce91b94bdd6a4353c2a3de4bccdc24a3d7ebe82bda464e33cd70a0d3da755003d8a5c043dbfba533c4d6e7f3c1f60e1bc4b15f4bb3bb907be926e0ebc8b6b1bbc2a2d0bbd9a2bd73ab02d3a3d4affbf3cd9de283d7aed4dbdd32703bbf081efbb40b3d9bc9e7896bd026bb1bdd8660a3ba7af15bda5976a3d4193b5bc59c2a7bd06a79e3dd1b5163dc2c98cbd1572353dbe3b5c3d76e1c3ba9847123cb65e94bcabcd0bbd4959b73cd6648d3bb1bbd23c232fd33d5c34033cba8039bde5e188bc65995c3c3473acb99911473d98fc22bb9d0082ba44f968bcfbb3fdbc38b4d13c5dab71bd64fd1e3d04e9803d4f90253c0c2ca03da02346bc5e08473deeaf0d3d5e4b4d3d3bc77e3c961383bd16220ebda91a54bb98c4993c06256f3d25d122bd2b64873dfa90113ccdb8e438105e983d32e8babd5d7fa3bd8eb510bc26dd993c610303bb0685bbbd749e73bdbcd92bbcc843823dbec137ba0840e8bc9151693c92aaa1bd418dde3cc5f05abdce62a3bd6aafa03c9f7315ba814f293d898581ba14645bbdec7a8fbdd69242bb6dd4d43cf95921bc35693abd94dd9bbd676994bcc2c31bbd9de08fbc8b386a3d74abb4bdae17773c518c4a3b856eff3b76a7b1bc155b26bdb66c73bca8a4793dc5b5c0bdb324b7bbb4570c3d9eeb05bd56c4173c70b9c9bab850673c8a179d3ddf530b3d86d3ffbc79c94bbc75893d3c5cc7bb3c58c5403c7c7c743c5db13a3da0a8ad3d2103d8bc8fae533de7934bbd59cc753ddea294bd097ca83bddc6083cb218bd3b996edb3c11fa653d9a09b23c4dd172bde3f9373dae05d23cd61a8b3c16779c3c09fea8bca7e2b4bcb6fd773d01db5e3d87ed08bc48054bbc31550b3d715f0abdc01b5c3de53b7aba705292bd2318133cdc8fd3ba4aa0573cc24db3bd67fd42bd1e5a383d4001843d46e70fbd494f7f3d5be9d1bc6ba4d5bcea34053ddfa133bd6143693d6d0f61bd62e3143d808504bc441a143d1aa17a3dc24dbe3884a0a93c979f543cf6a45cbd86c689bdc126953dbe47c1bc4dfbef3c1ae2323c1bbad13972b8ae3cafc71bbc0a0ebdbd412f323d199e3dbd09bfa3bd7a9765bca7aa243dfd11db3cfd8368ba2127c3bc08d69ebccf0328bd6232713c5e4c0dbef82229bcea3d17bd3b2f69bc90c139bdd6f798bcf1787dbd137834bdc3c25abdb931b6bb39d3b7bd6bad0c394fa3a13d774682bc4703eb3a4b87cfbcaf73f8bc972b1fbddf1afe3cce56073d3007b73c0191a43bc10baa3dee73da3c0f6fdd3c55b2033dfe480ebb6350eebc968c2dbd27ef983c8e11233ded5a1c3beea5bd3cd95d0fbc610961bd45d537bdc329c33bc1eb1b3d9822293de4c15f3de3a72b3d14b2493d583c11bda62032bc2c22f6bb02b583bcf0f63dbd7fd79bbd543cb8bdaa3f08bd00e1573d8d0b31bd82839abd24f2d7bd899a9e3d4596993d5de667bd182f523cf21aad3cf12b8cbb64fe76bdbaf1a43c0ce4fb3bf40198bc55b1b43b921427bbc1c18ebdcc2861bc541cf9bbe2fa303d9503d9bcd8f08ebb48888abdb4a071bcdc7b59bc4ee92cbbee52fd3c015b37bd1b6b84bc8a143a3dfbfa34bc9ed586bc8052cd3c90d0313d52e8a53b2d35263d046dcb3cbd5c30bd99f90c3c80f35fbcf68b96bc50ba173c3cef1bbba67beaba90457b3c3b9d33bd61341bbb2a0da1bde8ecf93cfb29083d33b0813d6a5cb53c9bdbbd3baa4b083cc39da7bd357a0dbe3caf5abc0064413d02065ebde3c798bcc3798c3b7d63b43c032a44bdfae38bbc987b723d478031bd5128003cbf3870bca812a43a1f40a83deaf4943d8da1063d33402d3cfdb64bbca0a9303df241ca3de4aae53cb534523c4fd652bd55f498bc9ef56c3a4696913d0ece4d3db5d0503ebf4c97bd0a4b9cba8502193d89549d3cf5e8033b, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(5, 4, 0x583edabc5820c7bac221e6bc2e2485bdef5abf3c1b8ca73caa47843bde4299bcdc9bfb3c8eaa1539979da6bc3d53fe3a65fad2bd2dda0abc0e3cb7bc167a013d7c6884bd188a98bcd8015d3dee04bc3bc914a13d28b635bdf09ccd3c6a0ea53a5f4b1dbd274b593d9ee09fbdd9f80fbd6089fabc1e7d953a67c2de3becb52a3c9e15a43cb2525fbdb62ba5bdcda50b3d4be214bdfd086bba9594043d38d197bcf594b0390287093dddb9f2bc2cd1d1ba6cc5f3bd6174e3bc84600f3d86ff863c31ac39bd927f1bbc30404dbd715465bd13d6073e6bc3d93b83a7c4bc269606bdb2f0e0bcd212a53d3b2f2eba6394acbca5822ebd2f64c8bc0d5813bd23806d3d52307c3c0fe089bda770053cd02e833c6e6f55bc4c859a3cf3d216bd4b043f3cba063dbd7bd7363dc72aad3de2cba23c2f86a93bc7a359bd9a4e813d2617b5bd42bc983d9b08d5bbcb74e6bce373133d2011303d65ada5bc9494893ce31d2c3def8835bc236c5e3c96401f3ddc8eb33de67a94bd82a59d3cfd1c603c15c2efbbc02a143d8cce823c4a3d423d7c25543c06eae2bbd861233d6fd6ebbcfca5cd3d988feabc7e5f503d07ab71bcda33713d8a07153d0b59253c0de96e3d81cec73d671b2c3d3d8f8a3de760bbbcba03febba8cd9dbc9e3ebbbdda6aff3c67605abc742339bdf019e03b97dfdabbec7caebd737092bd772217bd774904bdf98e603c1bdee7bc6d8a893d65acf4bc824785bcab3316bd26c0a8bc56749b3d9cf3293d05fe6fbd1550423d81b3c1bb04ea9b3c50895e3cbef660bc6d812ebc5d40963d4a3b493d4ef3023d0b8d28bc2d29893dc9c2f4bbe993773d54448f3c69eea23c999323bdbb9e023cd3109abccdf0273cb922f73c27c3a5bbdd74f7bd412caabd386814bd906675bccc6e21bdca5095bc3e79a13ddd2c693dc89529bcec9189bd2e631e3cae05393b6c7070bc733d44bd07c9283c1ea1b3bc4c2f1b3dda465cbdf0e1db3c734289b8d941a0bc4108eabc64400cbc2ff3aa3b9312e63ce1d6a8bc4e56f3bd5f72603da8b4413d03910b3b987a393cbe23583dab2034bc3ef35b3dc6cce6bc5c34403b357437bd306bb63bfa341bbde6d4003ce4789fbc889aaf3b960ca93bc5b6713d985dc0bda628543dcf8395bc77dc0dbde8d92b3d8439c53c2ebfafbc2f08a2bcf908f4bbe669dabc55e7903c40dea33c87e8053d63deeb3cc2faadbce740b03ca791cabb5fed1f3dc3c8413d50af123d942bedbc7e1246bddec32fbca1b5623c9ad68a3d73fa8bbd1fd5c93ce1c4e23d3869c23b2369093db41afe3b1b67c33c7386af3dbe09c13dfe08013c286d8abd36ae8d3d8b07ad3ceb0e17bbfc263c3db548e1bdf6ba123da1f6803b2953dfbc48c81f3d2a7386bd3b80b4bdf249a63a3f94eb3c4f8ccd3c7ed884bdae2a42bdaf4db0bce1b2393daa33c2bdffa6723c8639c4bcbcfa3ebd42a684bbb7af8e3c642db9bc02e1683ddbe6b13c6eafcf3c55c10f3d5a71e6bd7ddb8fbd031e66bcf259a8ba63d64fbd5983f6bb2e98e6bc338d3ebd39c922bdf6eedbba6a7f5dbd93ca90bd1b876dbd6e510a3da324cf3cd63032bd608b98bcdf9a3cbdbe9f3e3cfe686cbd769a983d7841323d1d1c013c0dc53fbcee86093d589b553d67213c3c03d6ab3c185d9b396cef453c9d8a29bd381d1a3d0fffd4bc690acc3c9114f1bc8c60ba3df52ba7b874afcbbc65cfbebdf82b363db08ad0bc8ebc1d3c67e656bdb583893ce6d6433ce98f253d1b4282bc59d9bcbbff595e3d8423e4bcae1a0c3cb8cf493db2970b3c5ccb00bd16dfbc3c17d094bc3624cabc09478ebcd02dd93cea1c98bccb3b83bcbe43583cdaaf56bd3d3500bc90092abd755b99bcbeffbbbdcaca14bda8b9a13cabf63ebdc0f08cbd029aa63c21ca893dac1341bdcaee8e3b66c77b3cd4e9433da162ccbbf148863cec2d35bdbe2c193c77c350bc66ee1d3c8241a9bc375e1bbdfc57973cebf5f1bdbbb4b13d897bc63b01fa493d031fc3bb5b40443bd095a9bd3ba8413c2650b6bd0d0ad3bc171f86bd99ba8dbd0a28bcbcd6cb793d92b9103c5c06a23ce8f01bbd25990e3dbbc601bd7c355dbd3058a5bde26c80bd902108bd1e2babbc04fad4bb6802f0bb2b3416bcc46da93b49ee4bbc692f08bde97b84bdd011bcbddc8ba03d19dcf5bc3854c03ce13169bd21e58abd8d386cbc3cd37b3dd368c8bc6bb4873d2cc92fbdeff1923d30c4263c3b77873cd9567fbd216c59bd6b0e0abd64f13abd13f6e03c266bd43dadf1223de6a43ebbc4e8e23ca8bf9cbcd0d39bbd309bdbbba24f55bb1c9fd3bc3c4b653d17ea9b3d14c7a1bc9d2e023d8164acbc9452b8b9a383273c22643e3ddf0684bc835997bd9f8c073d7b7ec53ce1e814be5102a33cca06f0bd2bc5073d398ef63d9106b4bbbfadb23caa26723d6744053c566b4abd8af1a9bc7075f8bb7b0964bdd75318bbadff2ebd38382e3c73d8853cf30eafbb34a8debc016c09bc54ba273c7321603b1f32fabc6329d0bce69a33bd14eec13bee8b9abd0cd4073cf0f785bc9b46dc3c6cf42d3c7cb507bdb11cbabcb7e08bbd66c335bc6044823b817e28bc3b312cbcb464bd3cec6bf23c1b8513bc6e7e373cceba5f3dd653413dc6a5adbda8f5b7bc236130bd860427bc080ef1bbd4845cbd75a3d9bc92c9c23cf51818bded60cabdde5096bde4f4df3cbef6d5bc102f24bd5ff603bccfb89b3ced753b3def6d2abd607c88bc33d9b5bd60cc41bd9254fa3cf95318bdd5ac43bdd923163a6ca5c73dadada13c49ea2d3db48fc0bc23ba393d2fe9263df1a50a3d752fdf3bc12ccabbb51bccbc29f32f3cd129d63c486b28bb9f40bc3d7c0c32bdc4e48bbdc94c3abc964162bcd94563bc, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(6, 3, 0x97e887bcebecc03c1aca083df56f10bd62d4643d9ac6553ddab22a3db7fd66bdb46e9abcfa3cc6bc7f84a4bc6f7cc23c549356bca44e283c4be54c3c83b5333dc082cabc4868853b4f7d98bd5cbe19bc394463bc9bbe7cbd45b8a03da0ed7339ef25b63cde009ebc858fd23caaae3abd0734d5bd06f01f3d9a41483d5a08b23d624fb93c6e381b3d6303ba3c55888c3cf2780abc4ac3fbbbb342aebc860d1ebdefb849bcb7c504bd113f02bd692c973d4daf053e5398583d601e9f3c240c1f3d26f3ffbbf68c9d3b48c2a2bdd018c93c27aac23dea8a48bd9f88e4bb8b3b123dd51ca43c134dba3cc64ed53c4415883c96ff25bc1b5f1abd60e655bdee63b8bc3b5381bdf348a7bd00ed17be39e78b3d1c5aaa3d1b7e89babc1a1eba33df2c3dc544283d8324953cdea2c83a29fa07bccb94ed3c09996c3dbbf4c0bb4c99b23c11149a3cce31b8bc9e36ba3c252d883db318353d0e04c2ba5535c7bda53c1abdbfd9883d40b5d1bcd157b8bcdfe7073d410d573d257679bd89ffadbce01930bd40b78fbc9a71133d5029ddbc6720833c2c540aba0dcae13d1d21003d5ecfc6bb750165bcf476453d5957cebde21494bd6832d4bcd1ab203df1b0dcbc47e4443b065379bc9fe510bd7397afbcf423b03ca635fc3b8f54ab3d46b5b5ba94224bbc7a426bbd45575dbce83d0d3de1a26bbdf1715c3d0cf6813da16a2f3c0a6e763d05848d3d6dd574bc262974bd90b1b0bb71cf15bdeba2353d645b0a3c1c425d3d32aa85bd01dd36bd789510bb89c35bbd438009bd7083e13b1f648fbd6ec6c63db5b2463d13a9e73cfa5a6abd33c2283c0f9fb93b6a27623d48b3763c76760f3d8cf1e23d3b383d3c11ab23bd7b0ad53cd1cdbd3b4156e5bc794e30bd85f6b13bd7b8bbbc261535bcf9daa0bce96fa83cfe44a9bc65f1113d58e9e4bc54b7543a6884e03b61b8eebcd6f5843cbb81a73c35ada1bd68ee62bc078a583c636feebca1631cbd4318893d3cd997bce6fea9bb522682bcf48d82bd2753423d0f7f983d44f49fbdabb8c23d3826223dd478033d63c5fbbc9f68ff3c2f68d03cd8bd363da4b452bc6e5f47bda40604bdfb1632bc167cbc3c20296b3def5e72bde8d06a3c2546563a1ab9633c7e94f3bcb8d316bd0ebc5d3d1c47a93c8c63a83cc4dc503d180ad33c2d08dcbb78f942bdd571ecbbdd25023d5b3c9d3c35dd3a3df963553df09d473b0727d5bc32fa7b3c5cd2163d2681513d27e96c3cf42047bb15bb653df190b0bcea85973caa10983c98c6f33b50e44fbd6851503db46313bd714c033e6284753d362908bde2b632bd0783363dcb199c3ac74fe5bc9c43c3bdc204a43cf830883c4ca7d2bc255f6dbdade3073dde32c5bcb3afa5bdf30e9fbca3fc973c4ca415bde3bbabbd5b09d7bccdac153db300053d8abf0bbeecdd873cee57aabbaadf5abd2b8f973c90c49ebcb9326dbde685d23cf862cebb90d6b83ce808d1bc127a55bd3b878cbcbca4ae3c87a580bdb8f3f93cd578c13c7724253decc37abd38b2903db6e02b3d46d1f7bca1f84f3d79a446bdb145bdbb92c5d3baed7f1fbd46d584bdc62ab13cf62bad3c8119a23bc658583dfd0c90bd30b742bd0c7bd03d765e6d3d7e5817bc82168ebb02cd343d2b20ec3c25038dbc87bca5bcbacc483dfd99d4bd1e6c5abc79a17e3a322e2fbb9789293c74d84cbb46c88db97f73323c40948a3dec95c43dcdc61fbd704aa83c577b6c3df2070d3d0dd28abceccc3c3c9a23643cd056e8bb557ed0bcdc6fafbc4d5a0c3d331c2a3d011fbcbb75134a3d76a6733d6f98103ba59c94bcdf195f3de82aab3c87c7fdbc44b19dba65a87abd205c1b3d399fa8bd339d133c9e0afabbb018f93cb96b92bd185defbc1368983c0dbf07bd5735d8bcc3edffbbed9f8dbc78d79f3c03f28d3a5e237f3bfe0e483d913c27bd2a1b113bead988bcdfa489bd20b35e3d9630e8bc6821afbc80f2bf3d266d47bd2fed10bca189a9bd41d9183db702c93c5bdcdd3c0fb9bf3ae129f4ba81fcacbd9a0308bde0b6ff3c34fd68bd8d3c33bc7e5f6cbd57329f3ab687123d688c1b3dcd8224bc71a5323d06f144bd47bd6bbcd80b78bd2d93c4bd7249833dd75fbc3cda315fbde950debc6df18dbccb8aeabc5e36013ef8c12b3da1224f3c8c67dfbc53f24fbc4e84453a89afe13d1747cabc755789bdfc752f3decf44abc877d853d7f77bdbcffa5913c030b173d1721883bface623d7ae8c7bdb4a8a13b9c244fbd0bea5b3c995196bd2c94febcd83596bb2033e43d8093913d6bfeee3dbea108bdee4985bcb969d9bcbfd7663c8927db3c8711863b9a4a23bd00c9fa3cbe61893cf9fb96bd65ce88bd4df6b1bcb407d9bc7dd8d63de65df7bc28a8e1bc98dfa7bde8280dbd09b283bd6cc61c3d54408f3bf9623abd76f2923c2298d43ca52a39bdee972f3d2caf96bc95faf8bc5a85d63ca86d30bdcfe843bdcaddc3bbd499c63cc733383d474222bcbfaa18bbdd48863c169f9c3d3f6d75bcf28a1fbd0039bc3d1accec3c137668bcfc60ea3a7b858fbddc261ebd7883983ab6be3b3c546fabba0dc61ebb47342e3dbc7d6ebc0cf351bce9e0d53bc29a683cb607bd3ba4d7103d00a9723cff53033c0928a9bc20fe6cbdbeab48bce603b1b9ceb748bdd452803d09cb22bd0545613cd396a1bde6195ebd2d48d33b9a4f07bdc0a6153ce12718bd5da6583d048ca7bc077d7c3d90d2553d2445f53cc2ee3b3de294b3bc1a28a83b1672863c1a0260bd1605913cbee02cbdf5c01dbcd3862d3d5d633dbd431c5ebbf4fee13ccee26bbdf3040ebcdd6749bdab6d943dad91253d0cbe21bd3e9b68bd578032bc4eeecb3c818507bdb7211c3c2d3d783b48f6093c4f79d1bd, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(7, 3, 0xcf08963bafd59dbb5ccd293d0ff832bb56fbaa3c52ec8d3b5e2a7e3ce0387cbde4be57bb936d923c806a49bdec88b53ddeeb583c26e9ac3dc1b5833d495aa33c459411bdc5b9bf3c003bb0bde7d41d3d69b3d0bc57ebf7bc1748a13d84f5183dcd4397bb44c41c3d828177bc47b16fbdea8cd4bd9481b43dbf52773dc31e5c3d2ab884bc38662c3ca755b23c32261d3d9649703a5fbcc33c598d0dbd496396bd041483bd8164263da3b26c3c774e893a2ed4a53d661bdbbc0962703cfe67a53cb2008a3c084bcd3c92b568bd0e0b383d91ca843dd4a636bdef05bbbc5d4fdbbb5a6dee3c9d6f123d8af2133c6a510fbd41758e3c178792bd25a838bd95f235bd2af255bcb2fbf6bca2e2f2bd8214593cfc53833d1f3a03bc132a81bc259e1b3d1c1f7d3d7104903d7437113d714b2dbdccd23cbd0bfd023d40d581bdd4de693d463728bdcfff0bbc4217bbbc2531173d5ac9e2bc480b38bd89a7f9bdaba353bd568887bc4fce9cbcd249e6bb0b51f5bca3b3d13c3f430dbc3bfa3a3d719e57bd7b8225bd593ad33ce2d22b3ca7323c3d06d9f43cbc75243dd947c93c35104cbd9f5775bb8e5e6a3d68b953bd1a1d063d0ed733bc2a2ee3bcc1acdbbcfbb2af3bc4b959bc0081d5bd8ab014bd98a525bde828c0bc8c624b3dce673a3dc2fbc33c501b81bd7f8daabd0441243d29c43cbd4bd8023d5527ba3c7e932e3c35db3f3d75bb203d38f629bc1ce4c4bc4e79383ccb5439bd0142053d1d99bdbc290c173c6912d4bdd67afebc9a19a83c578ad3bd411684bc5872843d68b8a7bd8ae39f3dd31e7d3c8f4a7f3ddaf41cbb5af6983dd4122dbd117f1abb39c5aa3c2c8c643cb981ad3dc9b5563ce76653bd3ed2f83c6253cc3c939113bc6165803c12580abc38d537bdb92eafbc46df84bd540d323d9665653d6595a13c343392bc50223a3d04a7cb3cdf0580bccb107e3d58e87b3df1e478bdf08745bd55452ebdb36fadbcd52c12bd6d40a63b138481bcba483ebb2abe9fbc465c03bd8f1ba73c2d92c83d922d31bd078cdb3c11d17d3d558f8c3db403173dda0a3f3d0a2e043dda0b643d72830dbcba8caebc3bfda83cee343bbd0f8508bccff21a3d0c5b84bcc731073cb9e81c3a7454cf3c5d273fbdb611b33b1c5d343d6c66803d79b802bd560c1d3cfbbc1d3dd7e10c3d56b198bd615f443db68c763c44de7a3de706f93af9c6a43d37a611ba3ad68dbd1dd1d23ce66f863d7093a23dd81a833dabef3c3d1dbba63dc8765a3cebc7d63bfa8916bd22cdedbbf14ae03b3363383dd40d0bbd67b8a83d611cd03c2a2c76bcad5290bb157b3ebcf65be23cb575e1bc2317a4bdd2d7323dee978fbcc08a59bc81cd2bbc8c0b4d3dcdd9963c2b4b80bde7f477bc095f163c007e42bcbd7f99bdd87c65bca00a923d60b1b23c63f4f3bdb204c23b4d7e9fbcfbf615bdb1cf6c3ce571f63ce06f3cbd722e0ebcd31e0a3d6fd593bdbf0b463c223b90bb8029183ceb43bfbc854decbc073d443ce1476c3c04715bbb92a267bc2655163da810d33b65963e3b4f7c523c96c795bdfc8e9db801ec43bd4424dabb4cd515bd377466bcd593cb3c396685bc267e653d90adb1bdbe560e3a7bcfc23db2782c3d79a111bd21607a3c7c32ec3cf549e23b4818dfbbdf6f88bdeea5f8bb8751d0bd6dfe9abc1f3d93bc218144bd78dcbc3ba4540bbda17dc2bcca0891bc0f33b13dc558c83d06ec38bd144457bc8c01af3d435e1a3dc70183bc967fcf3a8f6d4ebd260670bcc4d161bd30f1a53c555d3a3d1b1e8a3ca8c3ebbc5f75443df3de213c9969813cfaee00bdc431383dc4644a3d8db370bdcac4dbbc61a4d7bc1586853b02b07cbd59dde03be86815bddf23eabc9792cabd6bcf41bc10814d3d9c6d68bd9c83a7bc7305ffb808a002bd9453df3cba8136b92efa833cbae7403dba329bbd10925e3d2cbc2b3cbe35f5bdc6cc033cf56fbebc34d9243c43c87e3d9b3db0bcdd4c45bd171cd13cce05f9bcb75c4e3ddf4b673d4d93f9bc67d02fbda03796bdd10e3cbdd531e5b92b10a9bd6cd93cbd88c229bd3587b13c4bc02dbc986358bcf603913ce665a63cd4bd0abdcc8f473cdd026abcc2b940bd450ff13c3f472dbd6d920dbdd8e38abdd9cd913c4645b23bf27f3c3d3e728c3d021517bc7e286cbd3031413bb309123dd589833dcf0c76bc30fe96bc14bf71bc0f5248bc8f749a3da0050bbc71bf283d7f1e333c607c6f3d772ac03dd716a5bd6a00fc3c2ca5adbbe5813bbcb310e0bd1b254cbdd1a4883d2e39c13df0614f3d54e7963d9a784ebdb5ca24bd53b2f8bc0a746e3d51555f3cf711913d78f11dbdafb43d3d1f53ac3cb1da8dbce2b33dbda3960bbd6a812cbda51cb73ddd1befbc5e6d77bb9fdb64bde03a7bbc4e85aabc23ea213d55680abcd9042a3bd110793a54c8353da59ddbbc71fd4a3d3ae54fbd7a047dbdafee653de0f7243d30bc8fbde1a393bcb26a1a3d6d7dad3c1b2f8bbcf59e003d621f183cceec813d23318abce869993ca3dd623d8b39a93d07d2ecbc37d9943dcd676fbd890652bd8e276b3d53c3ce3cf1642abb12e01ebc0590d43c6d701bbc1ad860bdbb9b43bdd560973b0b87b9bc40ce69bc2203383cce23c93c6dce7abdb41996bdf0a8aabbcc95983ce57721bd1470043dc9a8083c976f253db7e9bdbdcdb82cbd757f20bcb0d380bdb1b72cbc00e853bd77720d3d9b64fdbba3d59a3db8c1093d9ecec53c02d1803dc3badfbc4d7a8cbb5b1d05bd988f8bbd410d80bb8c94d8bb89f4003d47af05bd73152bbcc0100bbdd538353d6ae868bd7d0dd0bc6d0999bd15f7433dd174803c941389bd8fb654bd14eed73c0da31c3c5962a43c4db66abdeb2722bc18e3cbbc07dcb8bd, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(8, 3, 0x9f0ecb3cbc86fa3c98ef743df9e4543cb199cb3cf2318b3dae8fe63ca0411cbce8c272bc0b45ca3b2e0a05bc0784b73df87f30bc2504493d78a6973dec42bbbc2d63a4bbe42b183cec2870bdc3492e3d7bd9ffbb350a17bd8ea3893d5ae284bd74519c3c74ba1e3d486c83bcbfab2dbdb67bbdbda6db823cbfaefcbc203c6a3cf2c8cdba51ee413d4f5f8b3db0fe093df6dabebb6a60f4bc1d11b1bd8d562fbddf1b4ebdea3b13bdaab048bd8bbe0b3cb3f6813df6f216bca3c20a3ddfacf3bb10919f3d5c30013de766b4bd45f7a03d623f853d228c043c4af306bc3752fabc6320633dbbccb93ca9b17dbcbc12ad3c6e5018bd19c1b9bd5a2555bd322344bd45d839bd5ecccebd1bffe6bc9ca7ed3c1d4fd3bbcc86a9bc7df8693b8dcdbcbbea5660bc03c3023ddcff3b3c9fe941bd7fdc4bbca515653da61e2dbd4b52d2bc472ef0bc3e789cbd0200da3c7bb30d3d1fa6623c836e4dbcab9f083a137da7bd49ce143dc196a1bb0c8b07bd547c0dbce3b5443cf8b81d3b55b53b3db09e9fbc6aad91bd070cbd3cf6be2dbcbfea7b3d6ad521bdfdf6e03b764a5ebc769393bc5e37ce3b49ff263d10ce01bd59bb96bd26990abde8fa6f3ccce31fbdaea1bd3b8cb02fbd6779b6bc20db45bd76ddc5bc8f4fcb3ce5a0843ca3389f3cf9e3f4391bfab0bd9237ff3b2ee79d3cf3acc9bdf7a26b3da2b1c63c9c18563d2ae9093d3c40373d0bdd37bd0659c63c4a2304bdfbeea13c253c523c2e7297bbda1b013d8268b3bdf7e3c8bc8795b5bc49898fbd790d7e3cd4e759bc81df83bd9cc3923d74f7fa3c81f5923cb6c963bdd1e6713d7bc2e9bbb51b7fbc741c9ebc3e91913dfcb4c23dba9b103d69036cbd739107bc84b9033daacb43bd349aef3c64ce41bc0a2a9bbaae37e4bce9fc2abde4982b3de7cb11bc78c3573c9642f9bb512f89bc967e2a3da69890bd4500323d576d083d6d1b03bde4d86ebc4181ff3c223ba0bd08616a3c25a6633d776a723c43fe453dbee9083c3e3cb2bda7f28a3c6690693d3664c2bdb882993d6e07023c5771533d604d21bdb4c3d73ce49fa73aaf35c3bc669a82bd294e83bd3a353bbdaf8333bd08f9113cfdb63d3c5f8f2cbd3efd0c3cf25a90bc463ff8bb437500bd8ffd0ebd6450013dfa32453ce0624dbc2481dd3a91bf31bc2506423c7e3a4ebd153c7b3c11b3533de91c8d3cb92e893cfcaa763ddf67833ca8d5e5bc8baf7a3db7a8ff3ce95ae63df8f00d3d0b0d0e3d076ec83db34e0bba1c781fbdf6a582bd5ca34e3db63ac1bda751613d1fbab0bd4839023e102a413c11d918bbc4abe4bb9a63e8bcdbb412bdc4a991bd634991bdfb6772bce280f63c2bca093c2f7e0bbddc81163d6dc518bd1e1a7bbddddc87bc6e57103c7b5388bcd3debabd60bce0bcdc88fa3dcfb3073c8049dcbdf562463d0cfa1abcfe1716bd496d293d4d44fb3c15ce43bd444168bb94bc0e3c192b9bbdb0cf8d3d3acc63bd464d64bca340b6bb4fd8f1bc92c1ee3c1988223db305003aee96afbc0a22c83cbd9a193ddac921bd1b9fbc3cfdb481bbfac057bc9e7a83bce0657bbc90e989bdc6f772bcdb37cd3c0b46733d136f383ce06a48bc1cb67dbd99d3fb3d1d60d83ccae4623c9c4c82bb0e3f01bd4da33dbd2f28163cc0288ebc702246bceb4ac1bd327440bd96d83f3df0c2b5bc1dde33bccad966bc34db113d5267403c75ebfd3d37ecde3df4d3debc3211a1bc123e273d55b82c3ceb07fbbcaefdc63bd362913d911a2b3d4db9cebca2f80dbd3485b93c75bf663dae007d3c14e2433d3dca333d822d573df42591bdb139bd3ce699e7bb91f190bcf487b7bc3c2287bd5c10b43b0c17d3bc2676cf3c31d686385b74a93c928b46bdfc05d33c998b3abc01e1b9bbece184bd0fb8173c8fb845bd84f63d3d300456bc2e9060bc5926cc3d092331bd7c90813c88cf2d3aeb571bbd3b04493da14184bddf91913c3ed5cd3c30ce4dbd86b025bd74047a3c7299943d9f69ff3b79438f3c16b89dbcc573413dde67a4bccf581bbc24aa593d766586bd0438d5bbdfa7a9bdc045803d012d213c6fe1023da9453bbc6b1fd43c0d8133bd523623bd2031503c5fed05bef4884a3dc50a09bd7afe903c397c723bc9c3603d3e50de3c5bd1ce3d4940893d4f8fd33cea00863cad4cf43b4a3e88bccf92523d7ab62cbd072c37bd17841e3dae110bbd44211a3d90f3a8bc0ea3b03d30d98b3ceab9e53c25f2d23df9e605be136cda3c2afb013bd2f16c3c66f2043c4553bbbbaa1bd43c0b5b833d7e24973d88d1a53d0e9128bd81af01bd10ab06bdca9c1c3c110066bc00f61bbc608b9dbd11efb53bf6400c3d5bd651bdcc79c6bc0c22b13b53fb80bc4146823d30f5a43c9cfd853c379c35bdf1b087bd1f1b02bdf58282bd97b9d33b9417bdbc49467a3c934bba3c76c507bd334391bb83a503bde0e70abdf8119d3ca50831bdf05789ba5755c6bc87f5c5bc86d7ac3dadbd89bc12652d3da106553b224e3b3d53be833c27782a3c9153853d7db38c3db7cd05bd47a5273c31a6cabcc3c419bd296aaa3b2f9a083dfa88d5bcd9666b3c73c32c3d4c1d953cc4219bbd818472bdecaeb7bc299f3f3cb05807bc70ebe23cf27bc6bca67562bd28238ebd3631463bf39f633c3a7872bd2a66823d5ae564bd602eef3c8ab07dbdc0e480bcc755ef3c6d3a4abd6a132fbcdcd7e4bc72c6433df7f4c53cdc8ad43d0d7b0a3d68b9653d897f3c3c3367ccbb386c723bb344b4bdbd9046bd0a0efbbb49532d3c8031b73b40ebc43b0c4d14bd5d7cd73b150f5b3d2b4502bc865a36bb25bca5bd5917343df5d8a83d64a74c3c60cbfdbc02d0433cedad7d3d65e6163de7fbb03c6f0d94bcc68e3dbd828b8bbd, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(9, 3, 0x4a94f53809f4653936f8a73de2ec70bcbb4f873dafb87e3dd35a45bc2cf882bd4bab05bddc72223d915a5cbdebebd93d85f110bc4b37793d9cbecd3c490a193deed567bd1d209a3c98ba14bd5921bdbcaef941bd928683bd1539d53d4f28c9bcedeba2bb233821bb7fecacbc66c0a5bd743a8fbd80529b3c3b0902bc3f088f3cde7423bd635e953c7874c63c0e4d143dbf47413c9a3ae7bcecae973b120b86bd67743fbdcec1e5bc931b2dbd79d5883ce20cbc3cbd81563c1be35c3d24dea63a20f06f3d03371c3d3eec2dbbff62ae3b6cbf1c3d792ef53c1ec187bd2a17d0bc7675903dbfff7c3c1d6a3cbd1992c7bce9ea71bc155391bde1c1b4bc5d5c63bdc2ff1ebd46bb3fbdef3b08be0d7e133d2b430abd79a9e43c688655bd6567913dcc970b3d7007b63da8cb633d1ab305bd45c7193db439ea3c1dfb62bd76b0403d7e8941bdf48100bd4e5f173c54daa73dc5351d3df8298bbdf1db22bc748095bd16ffa83d4b8f12bc204aa9bda1a779bcfd7b2b3d1c68753ce5034f3dbef91dbd48cb5abd5b6e063d10d9a13a20351c3d3362d7bb5988f3bb5709dcbcd4ab1cbdab3f1a3d0f69c93d1ec223bd2590cfbce51b0cbdb3d6bebc480091bdd3b2383d677b33bd48c5b5bcb39f23bd93e3e1bc1103033c5e8124bbc66ba33cf771e83974d69abd65b999bd2e4fd93c70d2cdbdcbd1103d21b0873dedd7083d2b59a63d09dccc3cd65435bc5cf05d3cff7021bc7ce4afbcad02ecbc6180833c048c193c8a802cbd55432e3d39dac23cabab8fbd2232e6bc016bd4bb33bd8ebd3870873df6025dbb2498423d3a5a8fbc1a815d3d06a1a9bda504c7bc6e4e063c2d7f1a3d0da8113dabbe413d95ad88bc0a5ca63c394357bcabe9b6bc798d88bc441da6bcb3ab03bd85d3febcddfaedbc9bd0933d9122033d18e23e3cb88fb73bbf9c2f3d52cf833da02415bd17aef13c4096443cb13546bd2f891abd40ccdfbc26c17dbdc2558e3cde20153d3a8d19bd100b82bcd0aa4c3d9289c0bd8dea2d3d51f8883d2398d5bc58b4103dc8688ebb288c8b3d9426d1bcc430563d5f62903c244ab93bcfae9bbcb1fdc6bdadcf92bc0c340bbd1317633c22c5f83cd747a03ac74991bce83d063de7acc9bcdc3a9cbd843b083bfcf41c3c88838e3db71a733cae9a69bc98520b3d3ddeedbc78a6dabcecbc233df5ff673ce9c0f43c5529d33c4102973d0f41f6ba7e7be7bad32e583b80ea8b3d6a8dac3d14323f3d7120193d66fe913d53bcc9bc9648b93bf38a3dbd3efa713d466fa6bd2a1b513c89ba29bd587fe13db8c825bd888f2c3d205707bdd8c814bd161c71bd53eaffbcf84ab1bcc05b193d34e434bd29930cbda6525c3ca3f4b03d24e50fbd90704ebd81149dbc51cc17bd5cf120bdf5e713bdf4e73ebc6595263d1f8d903c3cd68dbdce765cbccb28613c248a2d3cc7da173df4789e3c9cb293bce104dfbcfa349f3d341d15bdb6232f3d1056c3bddfc62ebc7f26113dd0af41bd5fd9583c6eb377bc3f0cfa3bea1db0bc9d86863c47b9373c20101ebd230d1abcecf1f2bb48359abc5eadcfbc102bc6bb6eb3433d73ea603c22fe403d1fa6293c25ffeb3c5eb332bd102d87bc5907a03db758723cace405bc522c133d2d89513c7ae2dfbc1c0f73bc23c6533cd76438bd8191a1bda555e03c9afd133d5d69e7bbbdd2b1bbfa7394bc1e81d53cb34b8fbb2404813d23a3db3d01254dbb7b4829bdddb8d13d7a7f153d17c8893c31133d3db558c03c6647403ca1e238ba2a1fe33b5d919e3c7dff3d3b39cfa7bc83dd323d1715853d66889dbcd5ba73bda4bd8f3c98f12b3db51c28bd4e6d49bd5b0e6cbcb700963c3af2ecbc0912333d5b863abde1fec4bb1fbcd3bdb0e841bd6ea2e33b416e71bb92448ebc02bb0f3d3a9da3bdc8b3763d014fddbc2ae3c7bc1a3e823d06f06abc811e013df83d2cbd567306bd89df613c685b12bdee44333dda48763df7f9a8bc5188643b7055e0bca3bd0d3d9e82543db2ad67bbe61b47bdc4390c3d85525ebd6f9eb7bc27a05b3d386b3ebdafd21c3d016450bddfdf80bc81e9ac3c5541863c33171abc3ab55f3cfcd5a1bd1f9802bdc499b33c97c709beb371cc3c206ccb3c798b8e3c3bc973bc6d69bc3c506a1f3c7bc1d63d026e643dee0287397346d83b637cbc3a3407e53c00b3483d2abe9e3c27909c3d05eabcbcb723aabcba32123dc7a91abd8a39e53da54a17bd6708443d63916f3d2871cbbdcea27c3d4922abbca1288abbea0dcbbbe74fd53c93e0e03c6f60e43d3c56933cb23f7e3d39b98dbdf350003d362dd2bbf0f52a3d1972623d057dbc3df7822bbde9e6593d02a8cbbc50a5583c3122ddbc932278bd93bc01bc67b6c83df65bbcbc31da5cbcb9feb6bcff0922bdcbc399bdfc0e2cbdd2361ebdfe91973ced02323d4d10b13cceac4cbd898701bbf6c0c8bcf15b9bbd8cf5c93db6b8113c3474613b1f03323c4f9a103c87d37b3c6441c5bc9132663d704885bd5d95a93b5f75d63b4a845fbc422db03d0dbf923db48da0bb98436abd881da4bc31a19bba6dbe363d81e9e53c5c16093d3bcb083cdb6b923c426f3e3bfb15c7bdd0ea62bd7d3ca0bdeb68863d590e033c8fcd76bb720e1e3d32be34bdbcfaadbd6aa7ffbb1965e9bcfc5c8dbcbf1c1c3d478664bcecaeac3c92e0a2bde973e7bc4dd8263df4eb81bdf0c831bd98c2d33c89f1723d9c2a40bd5141973d8913943d4ab6763dd0102b3dc13ae53c82a4343d4147b0bcac41f3bc9b4f213d29f5553dcd4843bb6818e0bc01798dbbe2a1a9bc4d10e13c4eea26bda3e613bdfb5b0abcbbd09c3dd435233c36f92bbd9b3bf0bcd7e3733c9f01583d357a90b99596023d688292bd3265a53b24f96dbc, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(10, 3, 0x8c80f3bcfc0e08bc9fbc913d399974bdcab01d3d719e813d22915b3cc1427fbd0ede6ebdceac4ebc508be1bc4a11993d3c87de3bc267943c26d4373c0e97ec3c67bc8ebc339c433c867ab5bdc7f1313dc68ba2bce95d2bbae8408e3daeb13e3b960ff4bc7cc1213ca6af973cc6dc19bd699e31bd120c923dcc3be73ce7653b3af5e7053c6f5db0bc2a13b0bba3a8653c041e2e3dd38ccb3cac61bebc72d88abd2d1946bd407a483b6a9b243aa15152bb07ab283d012d9ebbed04663cb3e91e3c85431e3cfa2dfbbc2525b9bc9c60813c8e0f083e7e06043d9411a3bd00e9d2ba8922493def53463bd6fdf7bcd4042dbc83b1a5bc23706fbdf533d1bdc25429bcfa8735bdc0420cbd3aa6debd0999183d46a08b3d82ae94bcad0d33bd5133393dde4cab3c6267e33d31561ebda93a6dbd83a74f3dc7f4e93c85d5a1bca6dcac3d74a13abdf19facbc5b3527bc8c93843d7d3a2dbc6145dcbc4dc821bd01724cbdf321653d7b4e33bc16ea3dbdd8f8a8bc2d65593dd023473cc665443df68d58bdb71510bdd0d1a13c07ca98bce2bc173d7b9b1abca96f603d7e0922bde88e2abddb1384bc51138f3d88cc80bda83986bc52d12fbd03e969bae74e92bdf7cbbd3cb9ca343c77df15bd5848aabccd99a2bc2c20203de7bf113a5524853daca5863d0b958dbd8c4b98bdcea1783df57c52bd5718843d663f083d1f10be3cce5c813d2788523dbba2ceb94b9a6239e5bd29bc381a05bd85a1b2bcbc6b20bc1a57ad3b5803a5bd859a0abc4536a5bcd46297bd28251bbc0054a9ba7f21a9bd8706a03d103bb9bcec9f8f3df06200bd1661883d85213ebdc314043dd5228b3c3844563d4589533d88c3bcbb2c7e39bda1e1223cc6fff6bc0b7743bce941123c4ce4f2bcfcd02abc049889bb496c47bdd10d0d3d77d36ebcbb78e13c141925bc3ab51abc8ddf823cbb81a7bd30ac533d840cdb3cab1219bdee9f9ebd5939613cc4cbb33bc972703cf7da193d5637a3bc751c11bdf508d3bb8df7883ce92a8c3c5ff4043e9ffa81bdb067ae3d055ef23cebd0a03d244e183c61614e3d8c9bc33c832eab3c9ddb64bd92681fbd9a7467bc2d333ebc0434f3bcf6b8903d5fcd4d3a5582003d0f2e2dbd4ab85a3cf47b02bdaf95403d4437913b8c09e43b7c8c2e3ce43e223c318c813d94a5243dcc88a1bc8bee353cbd103d3d9c5f503d2f04d03a806c2a3d48e4023ddf8788bd7bb1723cc208963d4b66fd3c2b87053d26ccb83d8ffbc93de72325bd1bf80c3dbfb342bddf98393d3be094bcddf97f3b3f4e92bdc3a9873d90c6b33b8f1937bc3c818ebc863ee83b2127793b1a0f4ebdbb7b88bd1501723ddb8e92bddd5066bd9512fbbcbbf54c3d981b24bc09109abdc859ffbbf213f03ce20245bd1a70bebd90dfaebc395eaf3db70c2f3dfbb1b9bdaeec60bb77dc4dbbe95613bd38605d3d36fd0abc27ed82bdb6db0abc46a2783df43358bd45a215bacaad8fbcb718e0bc56904c3dc9ad9ebc6264e53cc4482e3dfa450a3dcab743bd3f2b9c3c4da9b9bc1c716c3ce8c68b3d1f7151bddea7813d2902163db1fa9abcd624923c5007923c5bc6993dce441f3c40f2eb3c896764bdf0b7993bd459833d12901d3d12e91bbd1f73723b22296c3c178cb53cbb7d9b3bc5e4e63c418a38bde15fd0bdd8e418bc585639ba92f1c03c6979b73c109c8dbdba4d1a3dbcde823c3cb59b3debf1ec3d321c6fbc5831073df363df3d4cfdbe3ca73e11bcd9f1a8bc190dd13be9fb963c9504adbdad6384bbbddb6f3b3440253dd056b7bbb03f29bc0ca0233c164bafbc027b0bbde9dfed3c5458023db68229bc193d50bd7d71c7bd87f5543d1afb5cbd36686b3b5ff116bde8ee9d3b28db73bdc64b84bc466fd43a08465abd3f3a45bcdf6a2c3cb30d50bcea56513d796092ba3b759e3c6d5da83d9b9313bd59331d3d49d8213d44fa99bdf6b3dc3cfa4159bdcab0913b546f643d11e63cbd26fdcbbcadf012bcf12935ba1a0f9f3cc985343db85350bd0dff7f3cf6ba9abd82013fbd97c58f39ddfa7abd7dd0ccbbfc5b60bdd217d93c0497a73c0bf0f43ac44f2ebd105dc03cb31238bda38fafbc114ab0bca2eaa9bd447083bcb1af9d3cbd32983cf49eeabc7fcc973b5e30383bb8b7d63de755623c4ce1b63cbebd6ebdac9a833bfd4b963d9929453d2cdaf5bc3132fabc555aa53be738a3bb29e03c3d02e41bbdb986a83c0370453d4baf363d329aba3d58b82dbd482b013d2b2d65bdd537013d556380bd540afb3bc37215bc47f5f33de008263d57c1a73d434d8dbc2bdda2bbc4c723bccf7e6f3d9afce43bb210a63d4a51043daa83093c143806bc1333eebc936084bda1de7fbd34d863bd5cb9ad3d1ccb993b289f0abcd1d80dbd49cf82bdbefa19bdf183af3be10925bd1f94f5bc865f3f3dffb21e3d016582bdef4be33c85439cbcf9c716bd652cba3dc53830bce9aea1bcb0032a3cc7b3a93c286da63c5b8f38bd9197113d9b079cbbfc169d3c8ae20abc8c3677bca124c73d45df543d5d1e29bdc1ce8f3c77b677bde08eb7bc37a8573de293cb3bcbed9b3c198efb3cef28243dd8a62a3d7cb59bbddfdda1bd89bd5e3d285eddbba20bb13b5da07e3dc062023d6a60acbc9231bfbd688d863c1eedcdbcfea207bde10abc3c3b540f3b1bf7f03ca9c09ebdf6ba79bdf5db883ccf27bfbcfac3fb3a90ce2abba1e0aa3c442c8fbb0687b23dddc5923df36ccbbcb149953c3ce4edbc661669bc2a5ee4bc5545f4bc0cd138bc8d9d233d5895ea3ab9e368bc05ba8dbde86dfd3be7009d3d390854bddb999d3b59e7eebdf18c6c3dc549623d2d6691bd620bd2bcb8bdcfbb53ebda3cccfc693cbfc5083cb90f383c7ae009bde0c87dbd, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(11, 1, 0x157569bde300a7bd8452913c0c8b953b011baebcc7fc24bd84fa48bb4f0485bd25277a3cb6805c3cadb1a9bb106bc23b60a4fa3c49a07b3d1791b5bc9e7b893d7668d5bc4546adbcc63d51bdbf22bcba341a683df3e6463d31898f3dc3f04cbdd8989dbc19d034bd31050a3dac3a893d3e13c73c3fc1a9bc5f1ff43bf4f03a3d5b8bc8bb702d3c3de87607bdb3a50abc1fb643be9227bf3c04d1023d1dcc4a3d46609dbc1f8433bd93e578bbb9167dbda6d50f3cf82485bde37f1c3cd71ba13c8c46893ce2906f3c3079423ccf801ebdc3b5a5bd1dcd7ebdd4a76eba9a15783da8016cbda6e67cbd567a903d7a6e32bdf4fad23c050ad2bd9a1aab3a81416dbde4aba1bd06b82f3c995559bdddbbb03be5705cbc5374d8bd20cb83bd57d8d03cf09c243d1226bebc7b03563c1f9c433c913ac33b7e08ce3ce90401bc3caf4f3d8ad0f7ba4e82dfbc626c0dbdd88198bd2aaf223dd5c86d3df6468a3c85ed8a3d6c77043dad3e4abd71741e3dad73843d5440513d129db0bc9ad95e3d9af74ebc6c7539bc98fdffbc5d28403de2e27a3d4b1202bc656494bcb2824d3ca276dd3b93ae62bcc01107bd91a6833cd099653da453973d6d3f913cc719123da4b45f3bf41daebca422a93b50681fbcea03393df7e183bd877e01bc173313bd13fc93bcabc48e3d64bea63cc2ef40bda87b0a3c8b8160bd079fe2bd175353bd8d4ec0bdd29afbbc67dfeebc4b8d12bd1c0951bdce62133d014a6f3d9ef36ebd837c2cbb8d3f2abd45beaabded1da63cda2a2b3d9c402b3d1ebd593d6c4c94bc384e31bdfd8974bc096fc0bd01d99ebdb42c193de0df923b020c6c3dd2799f3dfe903dbcb760393cb657a23c609c00bd095007bc9d2e063dae4e5a3db4a4c3bce83685bdc202c0bc51a1a63ce4f4bebc1e19e73b8af94f3d7384f2bb73b88abcf39d073da9c5603c475c133d5c75d2bc5d017b3a929e55bd984fe2bc3ca09a3db56576bdd4fc173ceab1e23d2b9e00bd0f1b223d69f65c3d0ae4b3bc2ba4473d0228973b50afaf3c0db9213d50d715bd83afe83be9de7f3c113fe33cef9717bd8ed80d3d0c9347bda38cf23c5849f03da92b0b3dd53cc7bc19891a3d8d6fb43d56f76c3d7ec9a13d5dc882bc99ee77bd0ac3f7bb9cddcd3c49d38ebca55291bdf58d46bcfcc84f3c72dd5fbd763c39bb56a4af3c8e6bf6bc29fd83bd6024c8bd2b4b563d6abb2ebc06fa813c36c4343da4f38ebbf841d33bf51370bca93f23bdc3c5843d341beebc69d7da3c6d090ebdf88a0f3db48f28bd1b00833ce1a59cbc0c5b65bd157f2039aeb65e3d74b1ea3df9956fbc52e5003cae175a3df866663befab86bc52dd93bd45f1103d1a1a433d77b6b83c0f04bc3ca4d7ffbcbe39c5bdee70953d3f98443dd8a0b73dc263793c193bdabc808c9d3d97a19ebc168504bcda433dba28a4d43c24a3fabc7f120e3d7b09c43df75226bceaeea53bf79db93b70fc0fbd2141b13ab954ac3d1c3c62bccb6fbc3c63c097bcffccae3bfe4f54bdce8ad9bceb0f33bdce8b7e3d1c1e19bd80862c3df0493e3d8ae266bb8c94d1bc883993bd446e153ddef4aabd3d63bdbc910415bc2bae283d08690abd5afc1bbd783fd33c8726debcfdd8f2bc71561fbcc10437bc496ea23d5d6e493d4857ac3dd257963b1ec171bc8c9baa3d3353093bebca0c3d673fb03d5a6b59bd32a371bd4052cd3a6f62cabc1021553d5f5d0d3d94a845bd3962423c15a2663d65a473bd7dd533bdfb2b543df405563cd819cb3d7fbdcfbc9f0c133beb6c033d3422a53d9f71ccbb205a8fbcfae3d2bc541c84bdaacf82bd4feffdbcb173d3bc981bb63ddecc83bd7f551b3d3daca7bd21774bbd4cc63e3d12e1ce3b07fadebcc2cba6bd22326abd54cde43a30b914bc25be49bc07db55ba67bfff3cf655debcf67ac1bb8ca8f8bc72b915bdfab1cfbccc5f633c83572e3ce3a3cd3c5582973b5c2135bcee73c5ba5a3a853a39a552bd65e31ebdfbfcc7bcecb2b9bd80f26b3b7eb73dbd7db36e3d4d705e3b09dc953c8ce4ec3c843122bd31dd933d02a005bbe1660dbcea1c21bc48832a3c415a0cbd3dc73b3df75a66bd775da6bc899080bdb005283c46581a3d1c699b3dbb3b323d91b5f4bc65f6ef3b7d75393a4811e23cb33c14bce3a5c6bd9673edbcfa06613d277181bc81a00e3d2c46863debc621bd37558a3d1413debc982bc3bc158280bdc189003c6c2291bc10c4403d45ca42bd34c4b23cf74f933c7a09f13b4f37da3ce2fc373ce7c127bd864a023df3cb9bbcfac0c7bb72cf77bc9ea0853c46ebec3c9cf1c8bc0af762bc285f3f3d87851d3d693197bc29c9f03c46e4253d9c7552bd854fc4bc1ed5a8bcbef6163d0c4c66bd83c08a3d4b71a43db88974bdef6c233d6e442abba0b5ba3c7a42c1bcc66dc63c5c61ca3ded7826bd200828bd1e35463da97d943dc50e7e3c84b9a6bb1eca4b3c372f2cbd9e608ebcee10ab3d12cb5c3ce65e13bdbfb7afbbcd9f433b4d1fdf3c267bbabc237881bd7e49a73c0cff55bdf0740b3d829f60bcbe07913d76ad73bd2bee913db80228bd5fdf193bc63102bde63b99bc4be187bdb4490bbd80b3a83d8fb654bc5da694bd8c775c3c9e31d33c55ea8e3be2ec16bda91655bd62b7b33a4471ad396cc629bd718a2cbdd975973d35be113d62f3373d5b3e553dddbbadbc4da30f3df1feacba2fce153cdbde24bda7e4cbbd23dced3a58dd3a3c0f2e0f3aee16893ddba7f63b90b78c3b6511f83bb8fe10bd47680f3d8a34f13cde3243bd35e950bd84c23dbc6eac2ebd276d583c8d776ebc7b6dd23cc316003a61f5edbc6260dc3bbe908a3c8a8ca6bc5cf2d03c6826fa3da6fe613de6b8533c4428093d24c66f3ca29104bd, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(12, 1, 0xe82a3fbc70e99cbc69cc3bbcecf9053d2eb7ab3dcc1051bc2196a53b81d935bdff5788bd61dc193d40aed1bcb91bc53c3a054dbc06cf46bde48f22bc0daf613d1ca12ebdcf38b63b9a8f4f3d13aaac3df8ba4d3d9a9dbabc86a5b63dd6f070bdde39e03952960abd26ba75bcacc74c3d3ab207bd4e21c1394e94703caa23043dfdc18d3d29bcfabc6424bbba3d1c0c3db1ef15befe93de3c1673ae3ce706813dd695fa3cb2fffabc58dc003c5d2f3fbdd44ced3b5ca746bdfc57853d1012223d51ce5e3dba76093c2e42a93cccedc1bcc60634bd3b4e9c3cd66b3b3d811c153d6b1db4bc1666553db8ca953c5d04033d84f80fbba1f5d9bd112d853dfc50363c443e24bdc50b3b3d6b59383d4490cd3a0c5738bb66c2b4bd61e420bdcec8f23c733c4e3d975de7bc47fc273c7e172abc4017a53c153b94bc4f52e83c8be709bc59e8d33c07352dbd781062bd2e764ebdeaaa423d4ef6993d86020f3d64737c3de4dda33dfe8b4abd7a42ba3cc453373df78e7c3c0ac7f33a87c3bbbc9cc92c3cdfab0bbc74a3cc3ce4092dbd0794bb3cb89e28bd7f34a5bc61f7323d29d49f3a0bad08bd4c23e0bcf09ed6bce22a5bbc998df239f3e365bcbf5dad3c864a10bda9cd10bdab399d3d763a803d4606573dc906debb56161f3e0181e13c3de198bda20a343d1407c6396d7f17bd6fe893bde0e5a1bd91d6babd2fa829bdafa3c9bd5ed087bd57b811bd46ca01bd299356bddc10473d1c5e013dd8f789bd0e84f1bc303729bd488a143cfff6bd3b301f0abd7be01d3cf2cb29b946e850bd40c346bd1803313ddb6019bded81c9bc2904733d8f36f6bc50ed23bdbfba133db7c8753ce207b2bcda7b40bd6a2a88bc6b1636bce9a88dbc5f80933cf2dc4cbc17198abd3bdd483c30175abcf3b975bcb72381bca255603de20756bc8581c03c8f2641ba6fb86c3d32d9733d967d343de8e225bd5989a43b3e878abaa14eb03dfadfc93c5fab4b3cd003eb3cb2cd9cbc026c693d90c48b3d0bfaf93cd796233df1da68bc19c065bd21089bbb88ced4bcaa855cbdd30f1d3de9a7303da0c0e73ba38bb43c6fd6b8bcf47f5039c6f39f3d76408b3dd7533e3c52df6e3d6fb2783d2b36553ddf4d313d2fc1b3bc76a3dbbc1eba0d3d31822a3df3cc9f3cb840473b13b3323ce916083ddbcb40bd53a793bd20e253ba6787dbbc449721bd5e2522bd60bc2d3d748f153ddcc600bd327ef8bc8995c7bba56ecd3c2a9a1c3cb1cf9dbb8135cabbd5e10ebd2c2672bc5b65fc3ab913303c133724bc3afe70bc8e17903c90c2fb3c06c49cbd4e63203dd4cc163d8f16a43cc95faabc062d283d9d62743dee166dbb16ce1ebd5fd0123c5470813c2aef053d587c2d3d7ea791bc6f31a2bce718bb3d7a5a91bb80fc6e3deaee6e3d964515bdf4adcc3d3489a4bba528843d3e33f73b34e1ea3ccfc2143dfe47d23c0c44713d5051693c4cdfad3bc07220bc331a9e3ce4589a3d3070ab3dfee765bda6717b3ac989c3bc40072a3ce722cabdb5af8c3c76beedbc91e0803c1f5f3abc87b4c4bb1101253dc706a4bb8615603d14ff2cbdeca5a3bdf697a7bd43d190bc0f5bc43c3e2139bd06f6913b4f665d3bdcce1d3d538c9abd085a1bbd99134a3b39c5073d677bd73da7ce793d0c4b693d90740ebc63f9cf3c0ef1903d4fc5c83ca8808a3ce3df823c338dbfbda37fb9bd14d3c13cf0fa1bbdd8b74b3c774fb7bca59c23bd4d90bf3c7e2ae23bcaf6c3bcd447a3bcf3e68d3d6de9803c83872d3d92d83bbd43ea0ebd47b03fbc22b4de3d6dd1653c222774bd83ff27bdd1988abdbdb0613df3d961bc561fb03cd969d73d3a85c7bb82c7c63ce059d1bdf92cdc3b08b7fc3c4603213d6559903cf30ddebc79808b3c57c152bd99a334bd30ac0bbc2c96183dee8ea23cec817ebdd21636bddd2d43bc8840773b929687bcf9af6bbd91dfc33ded790cbaa8ab893cd1572dbd9e5f1c3b4333e6bbf2420bbc812f943c2bed2d3ae02caabd3201993c0044eebcc50b48bbce2ba3baaff2bb3da2a10a3d687d59bd4b00913dda02a6bb511e9f3dad5dfcbc48ea6e3cd9e6ee3ad9a4173de15a8abdd85ac5bc49c98bbd98c7b03a22ea943d5dec143d4aebca3d8ae73a3cde64e13cf230f2bc21796a3d557033bd74dda7bd58e36b3c067a48bc004665bcbad894bb10729b3ddd4284bc1807b7bb6be970bb4406c2bccbf65ebd31afa13c00be283b715d483d087882bdaf520d3d692465bd3469d53dee9ae83de3e1fd3b482fdebcb8eeac3ddbd6003b2468193cc3c483bd7e7d26bd553959bdfe6b9cbdaed181bdf025583dd21b8c3d67e1e8bddf689c3ca17f063c9cf3dfbcea6a0c3d0b9f5bbc7fab593c3fd5e13cfa4ed73d4b80ee3c78e98bbdbffd743d0767bd3cfd42ab3cee75e73a2ea0ff3b7237203de0b5ffbc8665cd3c9379cb3c11b6463d8f36f7bbcb26103da8245cbcddbd953d4d356c3d4dbd333b13460bbcb541003d9910b03b13fb90bd7b90063d07ef8abd662ababbde3b843c8c18543b06f4463dd585a23c35c3d8bcc127d5bc55ecc93c591480bd209702bba9e2a1bcd2667ebd776d60bdfd0ca9bac027e73c571e87bc0072d3bca706bcbb22c2e8bcff19dfbc7a528a3c1cc0183d149208bd0ea15d3db40323bd73dca9bda9668cbd8b8cae3c9fec0cbcdfecb23c11b037bd8461afbce2d5ea3ceaeb96bc257c04bd387648bd4a093c3dea35e6bb9cbb64bc644b9a3c881b4f3abff5133dda4316bd59d3a7bb8facd43d6ce6edbae153523d9cae99bd703c863d994d24baca3c92bc9534e6bcbdffc53dbb7a213d65b7f9bca67c6fbd034cd23be50777bdda2f0c3bb721ab3d3cec753c75a5eabce8ce553db836a0bbe29063bd, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36');
INSERT INTO `face_templates` (`id`, `employe_id`, `face_embedding`, `annee_id`, `created_at`, `updated_at`) VALUES
(13, 1, 0x57ef4bbde5bd91bda94f703c704ea6bc2566aa3cc6267dbca0e690bb23810bbd970270bd36cb9c3c247bebbcda85d53c00a4a4bde9bbe03ca0d94f3d2f8def3cda255bbdf453363cc397f8bcafe81a3d79438dbc93d2e8bcdebca93d15f8b43b1fdb5d3c913396bb98ebba3cf6f3d4bbb02e3cbd5ffbea3b21074a3d6157643d40a8143dbf7d913df567a6bdcd29acbc0dbd86bd8e02443d206037bcd09de23ce2ec993bf1481fbda37312bcb9f179bd4d7098bcee9cbbbc6cc9483ce8f015bda2f08c3bcbb11dbb3544963b4fac1d3cba89ab3cacaf5e3da2615dbc0f47893cc5a1eebc5661dc3c7dce2f3d6b19953d1200a3bca3edb2bd12925b3d1d9f46bcfb0f003d740eb0bc16d9053cb73128bd387b25bd0f2ffdbb027c13bdd31512bd7cebd53c61d8cbbd9c39183dd27daf3cdc7146bda871d7bc448e853c453f483d389c0abd7931f9bc00bf84bd76f9dfbc42a784bb2448b23d98e8243dd6206b3c0d23943dba4931bd917c8fbc4ae51d3eb3ee853c835e2137a7b736bdac75883ca167903dc6f591bd3bdeeebbc330c63c2e1aedbc7c49c53cfaf3323d9d9cb3b79ec1b9bb0575a7bc93fc42bdaf2f15bd54ff9a3ceac37bbdfe05793cc012943c3e1d83bda30d873dd824ee3c2139d93c97ebf9bc22767d3c8459103be8a5a5bd9577f73c5aab633b19b18bbdb680f1bdf16b58bd159d39bd6defefbc649f85bd2ed843bd40ed3cbd49b747bdf3f535bd0db3053d3bd4103d759f25bd6082ac3c0718e0bc8d7390bc8fc276bcc39a893d3a212f3d0ba7533d9141b3bbaec4f1bc51405e3d181dd6bc6a8d1ebc2dc8c23c22b0a0bd5e4a05bda2ef9d3d55f67b3b28a37bbdd4245abd76b1183d91deb7bc8f09bc3d1a21d8bb65bf22bc62c404bd1b48643c8a24283d27f2c33c6e56a3bd1c8b713d7b27ca3c6bdec03c9678f2bcb01195bc11ed9d3ccac44e3d34c9b0bd588eb43c4ee794bc9343293deb0334bd3eaf89bca0a4203d3b1f6dbc967200ba6c47183de859823dff32a63d43ce023d97846f3cfe02073ca89719bda64c84badbc73fbdb242483dd1d3f2ba3fb8623dfa18d7bc8091063b054e3f3dfe39b73c9bd363bc45c4cc3ccfbeed3c7066ae3d31cba2bb8865bfbb5cf826bd08064c3d23f2d03cbc7a8db9feba85bd2fa2023c979e1a3da6dce6bc871b4cbd895d2e3cb33388bc42587abd9eea94bd86ca693b955bd33ce700623bf3a0b6b97cd2dfbc0d27d93ca9cf303d794c643d7dcd003d8cd027bce88f3e3dbd5adebc3e4f803d6f28cabc1af565bdf8bd8fbb05a30abd1041e0bceb7c063cf8b39a3d9aa7c13bde5a12bd4234ba3c5371393d4455483dd0896ebd2e392d3dc616063cd7a89a3d3e1c8bbc39b19d3c820703bdefc630bd3a149c3c3b7d123d00c2b43c3231733b0ff49b3dd3cab2bdf72e7e3dc319e2bca08ee43ce972163d7713afbc3bd0a33da4a79bbc554c613dcfbf45bd5c9bbf3b88eb3a3d2ad1993d5cdfae3b6d9ac7bc3f01293ca36bcfbc753dc3bdde0294bd39a476bcf3cc593d232f923c078dc5bc4e674ebc7dd2a8bb9bf3873da3fcb3bc3efe12bd6aca70bd842748bdd0110fbdcac512bb2f5abcbbc65e5ebcb80dc83b693675bd278856bc5628483cbc321abca2f43b3dd892dfbc614d823dc20975bdf80713bd1fdd87bae830b1bcab3dee3ca2b5a73ca425bebd8eccb0bd76b8af3cf83587bd64f8373c2d92febcc07e8b3bd7831e3d7f3e033d27ef9ebce4215e3cd065ba3cc82bd43c263e363d6a728abc31c3e1bca97a9d3c1d330e3e68234b3c9e637cbdcb522d3c332956bd2cb7203dc56fa7bd0d89fcbcc84a3e3bef3b78bc46b926bcd9cce0bd264ca4bc9e04543df2038e3c4a22d8bcc825c6bd293b27bdb1a0d3bb960433bbb9bdb1bbb81e283db97c803d0aeb2ebd80ba1a3d1914b7bc73898eba058f0cbdda88973cbe28993cc2ad723d6a814b3b330677bd22d39ebc597351397bd4883b02d3563d2fc15f3d984c58bdbfc6743dd5f4e2b920c9d23c2f4778bd6dde433d536b703a5904533cbaa4623d90c3313d0f60d33c2b9c803d7fa2ff3b0844833d81c1f43c22ab3d3c3a3f9bbbb0e92abdd5a47abd0de3af3d7e45a33caa1d483dc06637bd552594bc210c91bda41e583da62624bd8de1b7bd7a15c4bc6f9ee13c0fb829bb19e1243c7d001a3d1db5653dcc89953d25029fbcfd29bebde96d89bd20c5f23b8ea5b63c0b7e783c511143bdfbca573d95d81c3c7242543da362413dc635613d918fe3bc78123f3de606f9bbdc2bbe3b3d8b93bda7ffeebcc5878cbc002d4ebd933396bd0deee53db7ceb43cfb3382bd7a3a933d2d23933c4e28a0bdf3555c3d847b043c0e0c853c5bd543bd9675803ddb87d63c7c64aebde91ab13d15529d3c21ab4c3d6834463d6fcfd23c7f1c5f3d017c40bd1952b6bc7fa54e3de103153dbe5fd6bc74c46b3d06eb1dbd4358b83c0fac143ca78467bc537a0c3c8e61673ce64387bd162f953b12d0ee3c77f505bd085b173ca4d7eb3cb8b7893cd660cabb7ce617bdc2d969bc5ff805bda7c4593d8c6d77bc22ff3d3c0c6531bdf4f0eabdea10a5bd6bb7d0bcf5a0c93d698c4bbdf562cc3b368e173d72d498bcfb484d3dea869f3d529ecfbc216d7abd82774f3cc6585ebd5ae3a7bde6e8df3ca9e08bbcf61d5cbd1a653f3d3d5d1fbda859f83cf70528bd703cb83c56fa91bdcd9d87bde5d1713d8206d83c98850dbd169b433ddd42833d3001b03c2ae8ba3de69050bd3b4ff33c77345e3b9433abbce9740ebd5e4bda3d6d3bfe3c2625e43b54e26ebd3b5f323d2a3e913c9420cbbc381587bd52d237bdc35b153d6cb955bc397f9c3df3faf5bc5cd24fbb5bb1b93c603c713c4d8c08bc, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(14, 1, 0xfcdf9cbdd7a95bbd69a925bd94b3ddbc52b4703da2fb94bc2b149ebb41f143bd71a3f4bcfbbf893dd21353bc6f29133def2c77bda7051abd73d6feba27143fbc05fe83bd6f29eabc2304813d289f6a3dc537c33cc9cb42bd4907cc3d968655bdfe1b7c3d17efa9bd63142cbdca89043c662436bdc8f95fbd47d007bda0d6443d718b943ddfb8cfbcfcd360bd193379bb674ef9bd6620da3aa2779b3c7ce6a93d517f01bc62831bbd09a7b33cc1483bbdef13843c81f426bd37a31f3d45094e3bf02d9d3d5087683dce9ba83c383689bca110c1bc4825fd3b9d96a1bc786c1f3b67647fbd4568663d8538df3d043099bc3b8e34bad159f2bd25e8553d34246abc577e54bd20fe573d623409bde8163fbc40b64cbb9587a3bc502f2fbdd7505fbd390a7a3d858d6ebc8490583de223c4bcb59b2abd7a503d3c1797113d7626483ca288c53cbe4c0abd8ff3d8bcfad0ef3c0425193d7451a8bb5338f43c405ccb3d4ac7513d5b3ef6bcb2450abc51ad9c3dc43a053aa87d84b9d492fb3a7141cebc17bc50bd7e7878bcbcccd9bc67f9413d8518eebcc168583c0a188d3b11b8d4bbbb6d2f3c722675bd32c6e6bca38dcabc4cacb0bcbc8b8bbc93dd883b226fc0bc29adb9bc3c62ac3df3622d3d5322e83cb5f742bd0f639a3d5c724ebbb9003fbdb0770b3d84a756bd76f6fabc528abfbce60892bdd544c1bd418278bd6fa3e6bd4d7fc2bd860a29bd07f6edbc5cff9ebd830ab63dc605013d871e2cbd43b4a73cf51623bd78083f3c13be613d0167113de2b65e3d0b7d473c6b1c05bc750fefbcf07f343db3b748bd01f06abdde0d733dcf3800bd88a474bc7497213d536201bdf63020bde947c63c34ab9dbc3ea8263d34c290bc64aaa63c33c2c9bc178dea3cbc32e4bcd404283db8fb6bbd402706bd0d8c093d3daa533d22b94d3d7322d1bcffd144bb814d5c3d0ea3393cdc2f01bd086b64bcd760c73c7fcafb3d4a06dbbae5fd273b02ba093d6dea3abd278b8e3d0a861e3da3a9cb3b3928903d7f7f4a3d2afc80bd3208633c398c2cbd2cc4923c63e2423d9d089b3d1068713c2b32b83bd2e1a3bccfa89ebc66ce8e3d0bb236bc3f3564bbbca3d83ca5c1b63d87bcc03c3d4daa3d65d4e2bbb5f684bccba33c3c70686ebc2d0fb13c91eedbbb2dc5b63d13176e3c5e9c54bd9bf938bcb7704c3d060a6ebd5b53febc760a02bd737d5f3c7da4493d725390bdfc55c23bb6f8e03cc97309bde027e93b58ae8bbc65e7713d5ff85fbdab6f21bbb597cebb56b67f3b2143d4bb44a0debcfa050abd3ca2dc3ce1ba0c3c9bf5083d61e4e13cd895253b31141bbd03b22d3d8de3223d6ed8c8bcfce1a8bdeb08353da187fcbc9468d23c071f7f3d059e1dbdc84e0bbd3c0491bc76859b3ca9479b3d8712023dd649f339131fad3dd59b24bd04e4263be63fd2bc8803b43c3dcab1bad5cb4bbca421933d617f9cbc7430873d095099bcb65408bda9cef13c3962ea3df7b01abd29fcbebcce7f413c957b233c7debbdbd75950bbd381bcbbc8362bc3ca4c798bd7b15343d1d730f3d4cdf6abba762843df79371bde2eb70bd3430d2bd7132ed3bec9657bb52a1f6bc142ea8bd6cebe2bc8dac8d3d16e637bd9c5e6fbdf05c3e3d764f9cbc5163903d3ee14d3d5d7c5a3d6182b0bc1a3b223c09b7753d2a2257bcd3c11d3d36538e3b9985d6bdaab46abdf577823d0a7abdbc18e79f3c9966d73c2004bb3ba9b3413b664181bc0a050cbb74f68dbd44bd563d2c77043dd22a7b3d52ae80bd1a93b33b4bcc3d3a749e463dc181be3cd5ac5fbd63cfbdbc138d70bd9936b9b9d2cdc2bce7164a3db819693dce97133d5c1becbc477690bd2e22fb3b51c18b3dd841dbbc8dbe87bcd76791bd39e31c3cd520e6bbde9034bda869c23c8257113d8537a53c552a37bd59ee143dafdbf1bc373896bc67deb4bc94c910bd4e68b53b6ec8dabc7c89553d721a24bd69943c3d85d5493c7a1468bc9f861cbc427d6e3d121d89bd35f47d3c9217f9b8d381e7bc7a4faa3cce908a3d6ccccebc0974d83c581a183c5f24ca39950ada3c1ce4d7bc09bc453ca5bd5f3c02a7563c907e55bccb4900bc28ae68bd53b4383ca6b4ef3da59bea3c9705293d26d1c7bc008bb13cec8c3a3b6f0f993b8da327bd08f51dbde55c01bccb05733de03d07bd1c070bbd701d46bc33ae163dab9eae3cf99283bdce8bddbcf7da6ebd4c3a1c3d5f6ec13c73ba9c3d8f6137bd3a921b3d269500bcabb7673d6722d13d90d691bc92565bbd330b233c35adcb3dd05aff3c568493bc22a8b8bc09469b3c50ccedbdade952bc2234223cb9edd43c7736bbbd8495923ce54a1abbe1af96bb6a7bf73c494479bb74558c3d2cc24cb96a7f4f3d77ba9b3dd9e39dbde3474ebd5d60fb3b987673bcc66d1e3df1468ebd53daa4bca09396bdbfd8073da934f53c6abc2ebcab3a6dbce3213f3caca5403d6c79003d1eface3cbcb0be3b1074a63c5ab305bd9100663bf50fc8bdb6e8eebc669aabbda9e495bdd5f4d33c651ba33b8c787e3c8de94cbb34b6b03cb9b7adbc61dd023d1c5e83bdc1d314bde40e79bdf050cbbc24199cbdf241f5bb61ed0d3d5efc27bcad4d73bd3f5db5bca12b8abd44b49c3b6f38493cdfa5843c053bfabc63b9783d6a5730bde8897fbdeac597ba35b2b0bbeea5ab3c32915ebc98d691bd1378b9bc4d07ce3c0cd744bd80d8d1bc2c8c87bd907dd93c0f507d3b9603703d238e833d57eebc3ceaa7833dd1e5943d3f3768bbb802f53da05a233d26fdb13c745f6cbd73403e3de67c5f3c51d5e13cd74556bda54f033c9169233de36790bc0f3054bd3deecebb72176abb69ece13cdab0623c4c269b3d5f3b323b90ceff3c3e1de13ab983c43c, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(15, 1, 0x002415bdb68d163b6edba1bcb3db2fbd088d293d0e2c83bc11dc82bc0b55eabd7cc5b6bcdf39153d42b62ebb48114a3c2322563c9e13acbcb10cafbbaf556e3bc2e0f4bd2eba943a26ebb23c00bee33c9520383df8584abd6c3d8f3de94556bca50cb23ce174adbcc554803dce19693c2eac7bbdcd3085bd84d3d0bc8182383d5eded13c6a94fcbca47a123d5910ab3cd24e12bdd12dc53c3869c03d8648e83d65942abc244d02bc6b4e483dda18acbdd82086bc00bf17bc2470073dfa82023cca13493d3b1095bb8b1f143de6cffd3ac18056bdfdf9233d4c533c3dce90bf3cc6df2d3dea7c273d9b59693d9d513cbc66bb423c2eee91bdd45c2f3c6765043d7787c7bd975119bdb8414cbdfc25123dd1ca073cd29919beffd124bdff2ea33c6c2db83c4c4d37bac54ac0bb2c1ecbbca6813c3c599baa3ccdd6263d36594ebdc56bfebc61f322bd324b16bd717bc23b9835cf3b79f8833d418fb73ca53085bbafe7cabce59f0e3d3374473dab94863d73de823d00d417bc90559abce34e103cbf75b53b9f4e3d3d48d785bc5c12033df2e200bd5d1b893a613f96bd1cfb2ebdadb998bcffa377bdc96c4dbd3088473d5c9e053c994cf2bceefb1fbd07550dbdd9f099bd18342c3dec6f4dbc012341bc46c1c3bd429d513c3e4b5f3d7a11e7bc39c99cbc547777bbdb6750bd90378fbbec90ddbce85fd7bd595ed1bbdb0986bdca4692bdc12648bd56c9acbdee88c4bba81fd63c65a491bab52077bd89a8803c707b8dbc143473bc28dccb3c59ed8c3d44a217bd402b063c12700a3dd52a333d334fa9bcc95fefbc86f91ebd112bf73c19c8123d55ce98bc77cba63bd210333d03f10abd3f51d1bc267568bdbdb119bd90f29f3bd99f5d3df658e6bcddd74cbdfdffd3ba538fad3d2ca882bdcf3c193d4de130bd0bf59b3d8a3e0b3d52e01e3cff773e3c8c7fb93b5b469c3d52288dbcdc4e84bc5560c63c3dee9b3d6787d4bb9c01653d5550d13de75d22bd16dde33ca95eaa3de2e52b3d0a56b43c1d8ea33c4dd5abbc9725fd3c244738bb2b7e0abd419f403c34c0ab3ceb251d3dbd707d3d629e0abd4945e8bb7cbc983d6d36db3a299502bdbc5a06395895b23d6de20f3d43a7dc3c908448bc665036bc4c0f21bdc1cb2c3da91a4e3bc3e6bd3aa5fbe63c3073833ca21589bc3e72b9bda8d7e73cc02d96bc63b2eabc532762bdcffed8bc2f0c013d8af65dbdaa07a93c8b60863c8fed0b3d3f1f823dcbd32b3c620df43cdfad85bd652787bc94979e3b1c5dc43c78960dbd4114c83c275717bdfb58eb3c204844bde455da392b99953c3fb09d3c4c8ba1bc4c02b5bcb5b4403d93a6003dccd97c3b5d1bf53c97cfa53b7f0e503d8af4613d9d1c41bdd955c63ae0340d3dc786173d85ef533cb8cc5f3d4a80f53b6ba6663ddaa7703ca3ed783d2e2afd3ca36142bd1d6fd93ccf08043db9ecc13bfe7450bc6deebabc9ad30e3d01f7cdbd451db33c2206da3d82d9523c06f7543dff6ac93c047c9fbd134017bdea9bbfbca81727bd7ada0ebc16b191bda1f4003dd3a4333c6198033d3b451f3d43bc443b5c019fbdd57776bc0e90ab3c90711bbdce38383d9e2301bc0e0e2fbcabd5cc3c67a392bdddaa44bd4c6874bb44d9693c9a58bf3de48ff2bcba81993dca3cfc3b8ff721bcd054813da1ed0c3c3454d83c8786a23c5efbecbdde1fc4bc4031483bf82f24bd00757f3d01c3013be33636bde913873cb58a2ebc46c01c3d150638bdc0c5a93a337e883c3aa6133d6c836abdd1363ebd1eab873dc13d9a3def3b1fbca1ad80bdf06b2bbd989ffebc0eed893c940831bc049aa4bbe1f1b53d91b1dd3b6d9c5b3ddcf53dbda3c10e3db03f863cc776b0ba9b75313c2e4a3a3d50826d3ce070a5bdee9d173c2c10163d173b003dda9ac43c7763a6bd5e51d03c8a00093de5ba86bdc1c66fbccf4ec1bc5ce3213d4f2cf13c0504133d2ed824bd8aabb3bc46426bbc3db0b03c4a9b783c5382a13cf416d4bdcce13ebc7a40883cc70d983c6b5a5a3caf099a3d5ddd4abd4efd20bdc5ef893de7e1953d098b0a3dacf479bc71631f3c362ade3de363363d943975bda767773bfd1317bd869e4c3cf02e0a3df6399e3d6cff303d7f25fa3b4c018a3c8099b8bdda56823cd1ac3a3b60e7dfbc0d924dbc562cad3d7b79a73c370ed63c77648e3ca510f739c09f6c3dd8b581bd6470bbbd6a53c0bc3311ddbc8d59283dbcc6d7ba05a930bd7a1c603d7cf10dbd718b923bdba67e3cfbd95b3de35bb2bc2e664a3db55daa3ca814c03cc8829cbd0f8c0f3d1d81753cbcf007bdb70993bc955ccd3cab8a903bea38c23c2701793dbb4adc3b31a862bd22f16cbd1a5bf3bcd57e6d3d5ca3efbc491c533dbd52aa3d7d3ae3bd4c0e253d01cb09bc7a0bd43cc9fca23daada22bdf78c3d3dbc71f83b82418ebb283d6b3d665d56bc73f9323cccfd563cc5beca3cabc9cabbde584c3c21863bbd4d67113d07ffb53c64d803bb027524bd517a7d3dfff3503c7d583bbd07e2353d7aa367bd89e6e83dfccc4cbd3e66303d809f5ebdc5d7673d875f84bd440291bdaea6463d927b84bcb40447bd9f05803c5229783d73f4d2bb8e7342bc4b75243d45f61dbd68491a3ddf0c52bc1b79663dd1c04ebd63650e3ca7549bbd62ce9dbd7af2b83cbd2557bd46b9623d0888e9bcd328b2bd92abd03ca2343b3df97d1d3d5d4fc7bd142a8ebd7667853cb71f4d3ca403363d6cb7a03de6dd11bd5dbf553d3b10763db09a85bcc73d0b3cd8392fbdfa676ebce31fbdbd076f3dbdfc22413dbcc4ea3c334b763b4e1ae93c97a270bbaf0399bdde7c1f3df18521bd76941fbd60dc163c0614e63d4f485b3d29372f3d8c25b53b3f4412bc93d0a2bd, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(16, 2, 0x97a2223df8585a3d2aaf30bc380a5a3de853033a375aefbcb5f505bd2f5b87bd196d2cbd16f817bda5f4e33c8a3b083cb80436bd162b1e3d028088bca3991e3d7860543d3cbf11bc405b8d3bb726953ca2fbcb3d7e339a3d86e9863d7d8d30bc7f7449bd773e8abc747dfb3c631de7bcdd738abdd90fd3bc96a988bdea0db9bc57c7ca3b1eaf30bd3a0958bd41d0363c0bd9b9bc133c853befdc41bcaeb14fbd1cc902bdcefd683de3ff1ebcf2afb1bc16c0543dffd122bdf13caa392244dcbb1751ce3c3a2ad5bc76ad03be1b29243d131275bd92d84dbd0be3b4bc0799913dabd2543d92c79e3c249fb73d9905403cfc5c0e3d701313bd9f55d3bc502181bdd4a298bdfa2f76bd3505153deeb5973d15630b3d2bb1ad3c8ecd363c04b3c43c3edb3a3d2c7b873c713918bd3c6cfc3b99f9693da29550bc0341f2bb12f91cbbcefb0ab96867753d749c0bbd18c83cbd90e52c3d8dbf1ebd565b6eba9a83433c81119bbda37e21bce5539bbc09da833d8ac1363da2e057bd1fdd843b0589debcdac16cbdf93d09bdb09612ba094d3bbd942cb53cdf40313ca38cf23c981dce3c8e12f43c5507573d0373f1bd5ef6e43cb910113dc2f356bdab14cfbc3b4c023dcdb10ebccba569bd044b883b901a1d3d68382fbde59a073d44671f3ce4e76f3b2d31abbcb340c0bd48c13dbd80a43fbdec399a3de1d5823c7c7b383d6a1a74bd502c073d7d1b87bcbec964bdb0d2c73c2559603de52fa3bc012a3cbdf589273c360298bda075eabc254f9cbdc7a0dcbc27f5823bfd498f3da4d884bc0d65983c9166a6bd80c7743dcca08f3cb823223af309c1bc28fca13b6c36a13c3a18223dd38a2abca9ddd63c021805bd600775bb6ada7fbc7d900fbcaaf187bc826df23c5be9953ac810f1bcdab49dbc128249bdf2acadbc718e47bd1c429fbdb79bb43ce7f21bbd2ca364bc21d9063c8478fe3bcf8288bdda328fbd8f6c0dbc2491f03b2508083da149313df62a8d3c3be1143de903ba3bc06b283cf437d63d3e0eca3c4b28d6bcf31e30bccb466ebdc6303c3d2baf9e3cfa8dc83be4fdc23d67f70d3de688433be86e6abdce08153db4a483bdcf7284bdef87f03c3532f6bc7bb1283dbdac4e3c701eae3c84eb163c1dac173b317f4d3c3fd194bcc12ee03c17508d3d5998a53dc1e43739d8cfbdbd5a2e463cbbc341bdb2cfecb9079458ba04c22c3d1e34dd3c16df75bdd6ca513d26fc1b3e8414ac3d22cd523d5f74753d1f6c5bbcdd2ab63dbbdbe139f2ec4b3ce3c1a53b89ab923da0cd07bc7d91973d100f4fbbf59cfebc527721bdf04b48bb5a73313c82478e3c15e5f7bb5ca24ebdc02f323dbecb133d988ff63cfa14c33c36cb523dbb6c2cbd03a017be6e5ec33ce68a89bcedef9d3d7bc39c3a61369fbd5e9d053cbf289fbb0db34dbd071ea6bd021c2a3d118f9bbad762b6bcedaf923dba4bf9bc5f523bbd6303c73c4554e7bc3aa00fbdd807c1bcbe71013d68bc9dbd975f863dd0cc573b381a9f3d359495bc51459d3df4babc3c9b03cc3c7b9f4cbccdbf133d43ee1bbcb2a6bebc406c903ce7478a3d7e79c5bce58eec3cbfe4433dc3b50b3dffac1cbdf87e55bd8e7f2abd1a81c3bbd27d7d3d334020bd6c98663d014c523d6ff3f9bcf2df93bce8354cbd600717bd5c986ebcb6929dbb1242cf3cc2c1843ce7451f3d4098cfbcbba637bc70c563bd11af4c3dbcf5383e21b3e33cf4b9afbde4925a3db6fb6bbcf4332ebd9afb443c48e52a3d545087bc30e0e6bb17432fbd0995343d088c263dbb3004bb517f33bcbf04443dd7a1bb3c3a62213d94005a3cff01e43b87bb12bda796283d1843a83c5f30f93b067d5bbd40fa46bd83b6babb956d873d6272d6bb40a9953b4cf6bc3be5a3acbd1c603e3d6db8bfbb4c506b3d114acd3c632081bd2b1e2c3d7fe920bcb4cde13b08e932bd9b8a163da960c6bca1a300bd7ded1dbdfc3e283c9f57863b1bcb55bd00948c3d41e8143d611d2ebddb6600bd3f79363ca92bdabc76f20e3b305402bd3f53e0bd2b40bcbcb54572bd86565f3dfcf568bd32ccaebc7ac8413bbdb2813c56eb103d3268fcbc83fd1f3d38090ebd4ef53abd7155403d9b1b07bdd15e8dbc608bc13b1b0374bdd2107ebc3e8a433deb1cbdba5183673d754a83bc774ffd3c4a5a883b8e4d0e3d9fcb8e3dae3a9bbd8ab8043d3b58473d50c8b7bb53990b3c91e60c3c4c3a3e3d6f67ffbcf7f2173cf516503ca9a5b43bb6d3e9bc43106f3d47ae30bbec289ebc3cf542bd27f3763d2eda5abbbecbba3a815856bc6d5f773cb283c83d4529573c05f6203d713f8ebc6f7fd83bb8d09dbc2e01663c462297bca3f2453c2782203d1d8976bd55be003cadbf56bd7625d13dfcba61bb2ffe1bbdcbcd38bd5fd55dbbd1edcd3ceaf1c8bc11888e3c3649f33ce5f03c3c8c3fedbb124736bc4f4f19bdb17522bd570a0c3d0997c4bb887da1bd53ec2bbd44438abdc92bb63cfa25823d80b0273d9a8ea8bd997a8c3d8a8f893c6c67283d73241b3c736413bd2bc1bc3c8b15a73b9601b73ce71d66bd16c9243ddfbbaa3c760fadbca0cf053e77eeefbc3f27413d4851c33c5e4f18bb9714653d03297f3cbef598bd7dfbf33deccd1ebd6b95b7bb2fb5333cf1ef7e3deda3ecbc2cf49fbc3e5c30bdc8f2a0bd835d0bbd5b1f23bc7f0f41bd292da3bd9132a0bb5356803d3213abbc425ca43dec7be13c00d3e63cd73b123d1e6439bbda40d5bc361493bb2c2395bc80004dbd76dc23bd85c4e13c94997ebb62e4383c602382bc79a38cbd0d08aabdf458f43c52f690bbdedde13c72df41bc398b53bda449bebbc2aab43b4598f7bdbd28183d78772d3ca1ac383def60853c16e46b3d64e2ffbda4e506bc, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(17, 2, 0xf8264d3d3bf2463de42da2bc83d7c83ca05c06bdeb4ea6bc003c233dbb63dabc731000bc07fb83bdcaec0c3b1fea6cbcc4ea9cbcd8672abc4834c83ca51b883def9324bbd0d8a4bc85ebedbcae1b8fbdfe1d493dbab43a3cedad213d795bb3bbdd2eb2bd029fd5bc1b42dc3db7f390bcafa498bde85abbbc03cb83bd2f5402bdc5f659bdc22d82bc74c24dbd3ab44bbc04b7c5bc609baabc173bd4bba7d74cbca608c6bceff2613d097498bc4c7d41bbf6e6c6bc92c235bdb76f83bbbb9e7b3d0b8fa63a600b01bdc2398ebd403bc7bbbf815ebd4681ed39e4c2fd3c70c35e3d9f0ea63d37c78f3d35aa173eefa819bd72c202bd3ce0a5bc504c9d3b25d9a8bdc7bda1bd065209bdb5e51a3dfea9ae3ce3e5db3cb9648c3cf838b13cdf2b65bc3ea670bd897b2f3c51da86bcb506433da6a2a83d1b1a443cfd622cbc491736bc43a152bc9f83053d5d7048ba540703bdeac83e3c67278f3cd48881bc5a31313d45dd5bbd8c73703d0a8b8a3c0301a53d8246793d0e7f81bd74d115bd1a1ea2bc2db209bde46493bd3399ac3c589d6fbdb9a335bdc442683d86a567bddfd5923c21af1a3d1a10933d4f137fbdd09394bc423ba23bbee789bc0f5cecbbfca6523da8bbc23c0f534abdd17a91bd5bf9273dde55edbc76709f3c921766bdb015debb5fdaa3ba5d18cdbc29e952bd2e307cbdfae04a3ccbdb30bd3b30a23ca7cbb1bdcc0646bcc154fc3a56cd4fbdead0683b6ddcef3cc493b0bc69d004bdaa1a9a3cc06a87bd8ff966bd47de22bdf8e769bdde27dbbbd788783c8afc77bd83af333c125dbebd7881b63dba9e1c3daaf9303db09afcbc23ee0abc4f771c3d62e2c23c9d83e9bc9b1b853cf42caabd16f9043cd6107f3cbd9fb33ba31a4d3c622e8dbc185dcebc289590bda531823ca3346bbd225f243deab98fbdb7d30dbd16ab7a3df73ea43beed0643de2be4dbcf71ab1bc42f55ebdf63a56bd4c7c45bcd3a2503d0e7b713dd834363d9a5055380222173dd2e2383c5adf2c3da036b93d007059bc590d5fbda71691bc67662cba50c45d3b667d4abd54e96e3c7dc1db3d80ef8c3d8818a7bd4f1b76bd1ad6833d27d29abd207862bd0cd1693c8cbd42bc2d988d3ac897633dfd17bd3cd4e2b23cdbdb6cbca2e3543c3bba92bc33d7fc3bcd919c3c3da87a3d2315dcbce8ffa3bde0f8d93c56b0b9bc672d78bdf315c23b076a3a3dee3bc43a9775b63a45478f3d1f54aa3d5edead3d947d143d3115ff3c5cabc43bf4b3c93cde47fa3c73ebe03cb2fdc0bcdd482f3d1c349a3cabd6813cdd46fc3c332b9ebdb83f17bd3284193dec47213db72de83c65cbc7bc66f5b6bc0dc7c4bc9186443d6863d93c7fc557bdf7885b3d9ffd87bd19bda9bdd69e4fbb6be803bd7d68dd3ddccb68bd1a95bfbd5adf603de2ba5ebd276f7ebd9aa8fcbc9aaafd3c5dee683bc6693e3b0ec1d43b322a20bc48078dbdfaaa46bd541f94bc2cbf2e3c3dd861bd18d421bd685281bd464bd9bc72619c3c969d613dde2479bd230d463d6bb28d3ddfbc053d47a4fab9e86d6e3d7d9b56bc59630f3c6ef0f03c098f1f3d896b07bdd056bd3ca246093d75ad843cf5398abd32e521bd473151bc4728a43da129b63cfb024bbdf6bf3f3d6a7f463dd2515dbcd16061bd7e4395bd6a6118bd65accf3cb4b94bbd2a89403c799f52bd4f8d313d949282bc381a9fbbf28ba4bda8cf9f3c374dc43de5af953db2f564bdb278923c500f6b3c51409abc49921e3d6015563c9a7cf83b63528bbde70bd03c28afc2bc037c093d1e5133bd0432dbbb6c66463d299e0a3d9795003c6ffff13c3cea25bdd69322bd318d983d301df1bb29f9a1bbfce90ebe4a6f233c633c21bc8f84363daf9c2f3c8c88b4bc89bd003c4041a9bd4f9c8a3d3dba9c3a66d79fbb8c22c83ddb8e5dbdf6bac7bcd7da3cbb9727dcbd9eadfcbc1a6309bce2feaabcafdddbbb86903c3b2120a73b994059bd3c8b51bd13512a3d89e7133d85b4cabc855141bde0b99ebc9d3611bccae0ed3c88749abd99b194bdc9b9e3bb0c5798bdea86cfbc622d5cbd9147babc3be410bda3ee403a34ccd23cc0c962bc326faf3cfc58c9bc598531bcff11213c423e393ca834203cad5ec93ca40a66bd62ba17bd186d573c208a863cdcd5023dd04802bd3ca55bbcba25793dee406dbdd3dccf3defc36cbc5f547fbc7e0d473d2e49283cf696393b9bea053c13b081bba26df63be61aa5bcba58443c09e5dabb24b6fcba12d96cbb683b413bb59899b9e8578fbddef91e3db7b145bce1363c3cbb7dccbc7cbbfcbbf7feacba7aaa673de7c4a33d6796453c58259d3cb980f8bcadb4b03b4b5800bdb90c8e3ca78db13c0fce62bcb3b7b13cd1332dbd55a5543df240953b5d0397bb8b38543b0b454f3d447a64bc11fac6bdd0355dbd91a2c23cba8e643d7b78d2bc298ec0bd19fcc33c9475383cc742913cc73768bd99298cbd6025203d02dde3bc3a69ab3c71a3943d0877dd3b5a8804bd6334cf3dc64bca3cc5bcb43d71be013d3c8ac23ceafa7d3d4a2bb83c21f842bcc6eef7bc34f52c3de2226f3d0f2bdabc1a19bb3d3af137bd13fef13cc334093c830b0e3d79daa13cc996523b1263b8bdec44aa3df3f536bd8c3d37bdf2d86c3d0b6e7b3c18298bbdcc419fbcc05c253cbf9c6cbd2de289bd70ca19bdd2b40ebd1fc39bbc026527bc014ae23d1e45ab3a9994cc3d11d921bb5ccbfdbb611fd03c40536cbc2d6cf93cff3182bb3bf3f739fc7bfb3b40d5b2bd9bf4bc3c7ff106bdb521fdbc4c6515bd543c8fbd86f73eb9fa9aa43cf10a11bdf8d6d63c0c4014bc7edd4bbd595fb53b8a13233a46a6bebd9606983c5d0d403dc4fec43ce16a8d3d3ac1133dc136bfbdb20d133c, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(18, 2, 0xbd591c3db9e22a3d6f7d77bdcedadb3c0814b5bb692ccc3a1b8a343c562b63bd6f56f63ae5971fbd14e4983c6b7cb1b7288f21bc4cc9973d60daee3a260c113d8e30803d5efb05bc90c375bc3e2e963d9b94a33d21ef633dd28f8c3ce93e83bce502dcbb6aa0f7bcb281e53c66c68fba164696bd787fef3aace8cdbcf9a30abcb3e55dbbad20e4bc2b9cfabb315a2d3c47b850bc4b56f1bb061993bdb8da95bca80fd9bc3358463ddb8a84bc3d9e2fbdc1378f3b6a6ff8bcd11058bb0740173cdac1143d3b89bbbc0dcab8bdb1ec6f3dedb540bde3da3abd637e613869622a3da379bb3c7d88253d05016f3d8fe90bbc6a57773da85454bde4aebebc62f482bd264ba4bddc65dcbd81af7f3d626c8c3d136b1a3d34aa843cd4eec4bb832b7e3d36e506bb172871bc6b3df8bc8975fabbaba4563df039a4bcdb3202bdb99f1dbcdb81833be792d83ceb15e3bc8023babc58f7bdbc48560dbdd5e418bb049cd43c047a0bbd6037eb3cf4f46dbc03a51d3deab13b3d3536abbd78af273c533c8ebcdd20a7bcef0b59bc15edd53b120a8cbcaedbc73ce0105cbcbe2ecb3ca4fb333dca8e0c3dc202223da1108dbdb66d813ca0f3703ccff0b1bd5fc046bd3e26b43cd66f13bdd16716bda27a713cc7b2db3c923a35bdb175493d049015bd027828bd4c123c3c4d0383bd06b2c7bd69da88bd37a0353d50ad093c4681033dfa8c9cbd9a48acbb43103abd16ae57bd149fa53dc286ad3c79f5efbc1a2b36bd5999ec39c9f39cbd75a687bc80dbaebd2a398abdda42b93c2718aa3dbd4893bad65f913cfb3975bdf947983db2bb313cd26f43bce4f943bbad8fe8bc9e24ca3b532f223d3d6013bbf139adbc3efc09bb36dce7bc367e2cbda40d0cbcc1100fbdf25400bd2439b43b141ffdbc5a72fabbb1f919bd4f21e2bc85704b3b1df55cbd2036e33b0a08ec3c50c6f23bb0cb3dbb1182673c27d92cbdf755abbd26307fbc96501dbc478bcc3c0a541b3dc5adda3c66575e3d4dc8d2baae19943cf674b93df8fc30bd8bf543bd991060bd82c5bcbcc39e103d2543b93c9444cebc256fb73dc51e023d6f9ea83ca7bc12bd5f8cb23c428661bcb227acbd03b49c3b70507fbccf58ea3c8883d93c9453b23c83043bbc4cc6f3baa2bb443d25c38fbc2e06ae3bbb611f3de033973dfc0b4abc4d0557bdec488dbc9ff52fbdacc9f0bbadac49bddb07e63ca480143d9ac03dbd6372ea3cc641193e2c36a83d2eaca53d86b7983c04e7873b24d4023e5bfc163b9ec408bdbc534d3cf6d9cb3cb580053bea6b4b3d527f143dadfe40bd90119cba1342203c5b2b123cb17ae43aa69cb73ba15073bdc481283dc61be43b6c606d3d81912d3ca67d723dcdc16ebd1999ecbd1069ab3c3767b2bcf8f3943df4ceffbadd4e54bd857491bcc37c2ebc0fa935bd9326cabd462a603d18ea8f3ce007f5bb530d683d5b5e02bcce255cbcb347d73a5aad603a1e9fa5bc160e04bb816ff73c43ae43bd02df9e3d1d8503bd7bd8ce3dd91ff9bbe59f1a3de709263ddb6d843ddd2e0f3cb6832d3d9593803c97db23bdc254ecbc80f4413dd9d961bd2e95e8bcdd7355baf44af83c429a51bb7de70abd32a5a2bdc94d913c27d3183c0accd3bc2108213c8b2ae63c9901a7bc606c41bdd87b00bdd35782bc984e04bd43f1aebb2d70a13d6bca8cbda8149e3dc195bdbb81594fbb6a2866bd939a453cfdcf3b3e8eaf053d5746bdbd11ee2d3db29c583ce0dd59bdfd9d0dbdb6e99b3d5e9088bc7e76b43c6bc33abd2f646d3c44f0aa3d7d265c3c6900e93b848cfc3cd6b1d33c7c30cebcdc86e13bc74acf3c68cb8abdf50b633d2375453cad46c03c5609d3bdbd0c8cbd509526bb7575cc3d7e511d3cc3f38dbc7f18a0bce62f9abd3f1c413d741916bd4d1b253d1da9253d1f472ebdb6025a3d27fc0fbdec92febc4e592ebd9961203de1a372bd36adc7bcb4ee5cbd5f07503ca00ef83cd99d7bbd5098843df09465bc1b3d33bbfe7468bd15051c3c5bde21bd8a3a16bd7c5e56bb7c1fdabd0d7c13bd9c4a8fbdb733943d1a7422bd07b7803aa7ac3bbd9a48f6bbe4f32b3db0205a3b3b21043dec04c2bc0a2281bddefc5f3cc02ec63c43f606bccc33f53b249256bd90d8cabc9d63bd3c136d173c38eb0c3d81ea44bd2069843c35610abde21282bcfc95713da33097bdcaa8203dd486ee3c688a1a3b6ccba33b95cfcebb7041873d2a2b96bcd6a6da3c98c8513b172a103c5da8f6bc6dc2533d496cb13cbfc517bd241637bdafb9883dd3cd3aba986d32bc9e9f34bc0bc1b6bad75e303d80c09c3cabbd083c590117bcc10f5d3b77bf99bd5cc1debc72d55fbc2c76223dd028283dc27d83bd34c6853cb5b67abdf2f0b83dde66f23c204c88bdb4c487bc262d49bcf75ec43c8af90c3cbe5334bcd81f2b3cf5e6e1bbadefd3bc15fab13cd57691bde01cebbcca465f3d2da20bbd09f6efbd959c6cbde1e18ebd0115733c8789013db1227c3c93c85fbd4011613d73dc683dead8383dd12245b8c89c38bd8933563df5d021bca82239bbe8d1a7bd156b213debbd013dcbf11bbc011af23db6d293bd0f66253c5c0c103daec529bcac904b3d2119653d623a75bd79d9163e95aa6ebcfa85483c2fb5a63c2bfd8a3d3c4203bd79d686bcb9551fbdc9bbb0bdf7c75abddfcfe1bcbe5702bd1ec99cbdbfcbb1bca313453de44547bdb86af73ce7430a3c2a01d03c90ea743d7118cbbcf993993cbeeb27bcbd91ffbc5f8fa7bc8a7c1dbd6d5db73c9a7410bcba3aed3b89e995bd75f7bbbd3a6b84bdf27ccdba8909e7ba7250403d75ccf5bc08fa73bd034f243c6eb527ba304693bdb19e243d0269053da486013ca2e2a13d55dec83c96bfadbdb5b2503c, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(19, 2, 0xcf0a643d651704bdd3ac5d3cee401d3d865007bd0b2f813ce3a6083d34044cbd1cee423c8f3814bd47c803bd7924a33d715554bcd8a089bb0b87823d91c08b3c2c715d3d27aa1bbd659f1abbfba98c3dbe71753d7b71c13dd5ac2f3de9b103bc40de3cbd2282fbbc5d01a7bc1bb188bd8b3226bd6d020cbc735114bdc1d73a3c896d8ebd6c8c26bc1033d93c0fc9713d065a98bddd41c73c8a68833c6cc370bc633b1fbdb493d1bcc5ba3cbd313a623c4f90963df41e92bd2ef3f33c75ba7f3bc34d3a3de9c758bc3cab2dbd6e4d013d725aedbcf23ca4bdd72b23bda803723d0c60c83d04fdfe3cd4eb80bc9c42e9bc187b03bd375937bd1bb5a5bd7a5c2fbda975f3bdb0ca86bd1ae1973c7333d33c17c0aebb6ed3dfbb7e9d35bca169cc3d96b8afbc0f4f383d065cacbc72de0db91258833d702f133da1d2cbbcaf7a273d712229bcd0cf213daebf293d671d0b3c723705bd2c6accbd5aeb7e3d4ff7763d35d984bd4431f93b6f89fdbc822cd73c435af8bb8ed285bcfda3363db1a52a3ba631a6bda39797bc2ab0903c3c9e71bd4b55113d78f1b2bc1cfc25bd0cd3abbbd864333c0c10e83bf1aad0bc1b71203d010d8cbb372335bd1572c7bc9710083d52cbf6bce31c3cbd2f2d7d3d6af0193d495c863c26b013bcc9200d3ca647dcbc47a22c3df7068bbdd20c2fbd1ec61bbd64ad55bc0f7d173d819e613ce36718bd10a14bbdae8d34bc1f9713bdc9afc13d70f1893c09f59ebdf1491bbdc96a8b3ce3fc54bd348ec8bbe9c5213c6627803db963d3ba8c2fa43d035e2dbdffd4d7bce474d9bdd040913b8514243bd41dba3b32c2e2bb5a80353dcd260e3d4e5a103d23a6243c11f2513d7692dc3beae312bc6016b3bc35f7863d49e16abd153aa6bb67035abd3106e6bc0a4c44bd168e19bb83d7fb3c7b01b6bc78f39cbc833781bb7003cabc5551bebb15a4f6bbfa34b5bb3fa1413c27dbb5bd3ea48dbde803343dd73a573d6e6fc93d42130a3d75ee17bd5b191b3cdac8adbc07eb983c999b07bc8283fdbb81fb80bd2c6810bd3836a53dd7aaa43d7d3bfe3bd224623d8dc8313cf3c29a3d090c0dbd1cc011bdd5a0aabd24c173bd47fd973cde3424bd114ac3bcf72103bd95ca11bcd5aa12bd5c247abc81f6303d0afe233d40f02e3dc9b531bd7666113cf3d8dc3ce2b697bd53632a3db1e4f9bc4c1221bc79fe513dc6a08d3d9674763c71011cbdd23588bc42790d3e8d51233d1e03a63dcbbb01bd82a7d73c8883d03d1c9d9d3d7713d7bbba0e233d856a723dd4c08ebb5d263dbb4889f7bcea52afbc484d133b227c6b3c277af7bb1e9a333be62cf9bce10a1fbc7594523d4d2795bdff52843b14eb3a3d728e583dc08c95bcef2ef7bd8be02d3c041b99bc77c89c3dac4f4c3de6fb99bdbc02a6bb956acabba3762ebdcdc5bdbd1846bf3ab272d13cc3314bbbcb093e3da3b9ce3cbbb291bd4703403dfc80413b7e935fbdba1304bdacfc063cfc731bbdc000fa3ddac8023dc51faa3d6679a4bce38596bc92142b3d951639bdbbfe2cbb6a1a183d7966c2bcb80443bcd6e0073d9ba389bb4227fa3cc86095bc832e5f3cacf3e93b56c38ebc9342d9bdd51f1b3c82e4a9bc41ef9d3c31ef6dbddd717a3dec2acf3cbcd846bdd3d75dba8e8630bcdc894fbdd7e2b1bbc994fc3c48d25a3d731da3bd4ba9f8bacf448c38e8f50fbca6de9ebdf943bf3da80c163ec7a6d33c2edab9bd2a28a83de425733b69856fbc3c1063bcc06022bd23d8da3c4bcbd63b82e64dbdaaaf62bcb1629c3dabf79fbdcf5cd1bc84ce123d41b11b3d12f86cbccbedb6bc3efb753de37f20bd136c483de2c240bdb608313d23699ebbe277f4bc28a826bd62e6163d4ce6c73b6d690e3d020288bb3b1facbc1452c33cc390dbbc71a502bb8e70b8bb283474bc541b84bb795316bd640fee3c39ef86bcdbb027bc7fb064bd18008cbc38b688bd3051c23d5a6eed3d36d81dbd331b1d3c68b47d3be9b5cfbc9ccd873b2c4c2a3d080977bd7be4dc3cc3f27a3ceda0babc6fc0a0bcb85803bdb101743b68b66f3d4d0dc9bc6d5716bd8657813b76450cbdf33d74bdf6a89bbcac2c6c3c1c1490bdbbacc73d2a0b05bdfd82613dd5c61fbd090e8fbdd184be3cf2b355bc056acbbb2f3b8f3cc77e253d9d03c43c8bb2693d564de3bc2d9ea83da4aee9bc84646c3db328313d9f29c2bcc5ecfd3ce68e4e3d3eedbf3c8d3e783bf794303b23ac1f3d96c361bbb312cb3cecfd163d26b1c0ba47b2d13cafddbdbd62fa203c0d70863d987e2cbcc8a633bc9479553c7d9cbd3da49856bdc898893db34ad63b0332cf3cc32f513c7a81323d39b80cbc636f0e3d21f8823b3dfea1bc0aa0713cd099d5bb9967153ca62461bb16c2a8bd8ba214bdbcd5743c813d7ebc0b01a8bd3d5a60bdae0ddfbceed4123dc9fea5bc46a7b23c4fe6843d3214abbdaab4823d86c963bc13df8ebdc58ece3c172663bc03190cbc8e510cbd8294823def50d7bc90c7f13cb4bb893cf54b29bc1702f43a4b63793b4808c23d270703bd8b3519bc4e0794bd7160403d7f2d1b3d166124bd21e0873da820e0bccb33083d1d7b16bb8642be3cff951e3d611adbbb28159fbd87b0093d066a223c5a01833b32c091bddab65f3d0866283cfa643b3b0e9930bd71ad50bd4dcff6bc9cc041bd4a0a28bd495a28bd5633c1bc0a7c573d238180bc3d87b33d9264223c1c07323dd89f6b3cdf07083d2dab423d0842823c2b382fbc8d9719bce41e31bdb5a0413d7cee033d054f173dd05073bd43cb83bdab7e45bdab7367bc95280d3d18b14d3d1cb2aabaad46e6bc2ae22ebce8b1b03c343561bdfef22c3b48bd63bddaac963d83d3133daffb8c3c5fba40bd76f37d3c, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(20, 2, 0x625cc4bb232e35bc621e25bb0d87ba3c955e26bd2f869ebbd445a8bbee4264bdbcc44ebc48af313ca5cb5d3bf861c83c97c3373a0323593d62e809bb47d37a3d884c93babfcb913c1a3c1e3b24a8223db5269b3d3567583d25db043d7266fcbce01003bda969eebcba26b73b4fb50cbbcb25ebbce6a667bde9266ebd9ff596badd2a1ebc20d6c0bc21f88dbba935b63c8e3bb2bc19a83b3c63e9063d8470cabc0fa878bd4fd98f3d556f1fbdf07569bc147dc43cb284a1bc3c24c33c0462b3bb9e8fe43c99af47bcf19cd3bcb030033d45562bbd6c31f7bc0c2ff2bc4eaf353d8ab1d03d71a0743cffd0373da207dcbca7a7813d4a4978bd9bedcbbd0f94acbdcb64c2bd402b4ebdf7b5383d2325823bf046583cf3352f3d9380c63c3c668a3d442a12bc91f6af3c8dfd50bc8ac4c0ba00638b3da7fe593c662ad7bbfc36cbbc6d2203bd597ec03d30071abd3c20683c7c9db93c63b256bd493e2f3a9c458c3b177f0abd7f9f693c3a138fbcbfef3a3d3df3db3c17938ebdd02e2dbc682fa43ccbc68ebd5e00283dcaf30cbb79a37dbd3b73bc3c69dab9bcb498583cc842d8bb9ec40a3cc363c53bc27369bd3bb2b33cd66fd1bc3742fbbcca0188bccb9c063de58c8abaf215f8bdbf5b8b3c508a6f3cd66846bd2de423bd7d448f3bfc6f0d3c57a80f3db4246fbd49b70ebdd5f035bddbec133de016b83ce63c083d47bf3fbd055f9c3ceff2baba7daef0bc0047d13d1a5b8e3de84dbbbcd53970bd0f0c523caa4f97bdb4555abd36c3e9bc4a4729bd1ad031bd79dab33db80699bc4939473bc502c4bd0be0d03d084d1e3d4982e83c15273cbdb02f5e3c340acbbce23a733c20db99bc6e75143d45fbe1bb5934f3bc127718bcc4d58c3c49b8ebbc37ed503adf135c3a3d6d45bdd9f7a5bd69fb45bce3fac13c52ce19bd42697bbd29cf78bc514f023d8fb6ac3abb7f70bd5cf62a3caaa578bd8594aebd90959a3bef1fcabc64dbe33db5ccdb3c9f2f923c4fa0e03ca1159f3cec718f3bb4028d3d5eee2a3de4809dbca4c41bbdb9394ebd771b253cb84ac83c2a01b03a914cd83d522aae3ded692c3cd38c10bdd86c963c3dd9c8bde295fabd490a2dbdc368b6bbb69b2e3d395768bb12cf243d1361cbbcfcc0783dfbd7313c6fc89dbc91fdd83c83a32e3d37242b3dfcfebf399fc839bd6d65233be5128dbd40f5293d504e373d59fa433d18211ebde94b12bd8dbd173dd371173e0e78933d43b9923d85c1a3baaa8284bcc4339f3d36122a3da728413ad93938bda7ab5a3d3dbde0baddc85f3d68c05abd218d94bd281f32bd25ba6b3c102d82bc1a60943c8662bbbc40492dbdb2fed63c380e2fbbbe085c3ddcd6243ab86c823d8c57fbbc04aebfbd8ddb56bc1cb5d4bc3cb3b83c969f8d3b8fe55abd5e1d333cf2d3823bf6235fbc4a4688bdddb17e3c299a3abc7d0649bbf384083de12e3bbcbffb47bd6b40fc3cb7925fbc9f2e88bd107ed3bc27bfe9bb88677cbc083dd33d2fcb76bcfb97cc3d51a92ebdfd2fc13c118eeb3ae96b15bd7fdd98bb52e4c63d92eb1d3df26d00bd37cef9bb72062a3da60ea33c42ac233c54df643d92b0a73c05bec0bcd3aaa1bd56d501bcea21e53bb5050b3de36448bd93777b3dfaf2b23cf48b8bbddeaad63a774ab0bcbbfdb0bd15240dbce2898d3c06715e3cb16c7dbdd65e4e3d19bf02bd3d3e533cbe69fdbcdbd6b53d56f6313e5bc90a3d7ad790bd21a0943d854376bc3a0693bd05ace03c6fa2e03b76e05c3b7ee872bccb8ef33bbeeccabcc906d13cefd51fbc7e325f3cdcfbee3c06d895bb50be433bf859063d11f91b3de03d7abd08b3143de88503bb6a9b12bb3714c4bd62112dbd8fe824bd199f9d3dba9a0bbc12deb13a5bcd87bbfbe9b3bd708e7f3c5c2074bc2b0c363d74983c3ce4b54cbcf05d8c3ade8af4bc6063c4bc89378fbd2456a83b19db2abdf7a3c0bc762c873c839f89bc52cedb3cc61a58bdfc8e6c3b14a0313d9c2ab5bd07389abc7d4f32bc8e8f20bda65d10bd6aa0f2bcf66594bd757b63bd2803fcbdcd0c1d3c1df01bbcbe2e94bc37dd67bc5b25babcf7f5343da1ad33bd3e3d1e3de2ee5bbd875014bd9c26373d512ca23bc1b683bc5963973c59b4d0bc2a0ddcbc3be03b3d8d3813bd3983c13c6e0660bddb31ca3c8b74083db279d43a299a9e3d37ff6dbdedbfca3c037d9e3c0515c13a4a5de13b6e5916bd6b6742bc2c3c073cac4f473c139b31bddf02d8bc34a391bbe1d6873da03df23cf9ec41bc153288bd6d54513da1a9213a6a8f613c1f07b9bbcd59eabaa592b93d3c67d63c2a89993d88013fbd5fb66d3d3bec44bd7cce843ddae684bd68f31dbcbb8c2e3ddbae72bd58d2c73cc87e06bde029ce3d641c3cbc456b41bdb51c8dbdc52d183cbde0623bc4783fbc6239913ce674803ba1bc0dbccb2172bb753779bc151a88bc1de40cbd37ac2d3d71ed9c3b3a475dbdcbbbd1bce7d3b4bdc53416bdc04bbc3a30b9693d40d6b7bd374b8d3dd72795bb36641c3da6b9f63beaae8a3ce27f823da74779bd0c4348bdec33bdbdaeb7bf3d73212e3d0983c3bcfd9fc23ddc57f2bcbbb2363c5ae71dbd14d5693c5ec7443d2646c33cbc3ef5bd2a64a53d24bb24bb9fecdbbb923f35bd4342173d173e60b924f47fbdc20d34bdf2e0a1bd069c86bdebb081bc17dd74b90abc54bd5cf838bd61f9a73d0f6c143d068be53b9a8394bc4e9aa2bb7f6c053d29e2f63c59fac63c5afa9cb8527999bcf85a8ebc630590bcffd9583da3c16bbc5fe803bd7c6584bc3a85d7bc780bb2bc613aa5bc93c84dbd4b175f3c9b2804bc9a8b43bdb690f93b4336883cbf10bfbd5c0b993d4b6c3a3c680e1c3d9d32a23c3f493cbb7101a2bdc6d6d0bb, 3, '2026-09-27 17:03:36', '2026-09-27 17:03:36'),
(21, 5, 0xa57887bd04f0a5bd46ed4fbc02da9e3daab429bd35b0a1bd09d0c239846e0bbc39333dbd9a77833c3139e93ceb8a0c3db67618bc7eae123cd5ce0fbc4c8b993c2205ec3d550c35bda08e0b3d1ed84e3d9a831a3d4967ab3b623f94bb236654bd92db01bd0d50a4bdf6a731bd67ab4abd66b02cbda9c05ebd60d791bd8b964dbd7f19123da774ca3cfc4929bc3adc73bc59951cbc7012a63dac17153d0be2d03921f2a53b880811bd21626dbc16e4b3bb4aa090bc0eed64bd1334bb3b7759853c16b5fabc0ecc563df389913c6d16753d5193943d40e96fbb4e2e913aaf3ffebc55ddf33ce957c9bcb8fb7b3dfc79c43abaf926bc04c1f4bd586027bda15143bda57fa8bc9f9900bca14013bdb682ba3c38b982bd178dba3c47d324bd788be43da546223c5f3c14bd242749bb57633ebd56b623bc52ab243c477bec3bc37b5db9c6db293cbc5ab53d801003bc958947bd52ff823c86c8e9bb5f71193d42789cbd4db0de3c3df47ebdcc1013bb1e02003c496381bcb0f5953bd9cb9abc21378ebc08501b3d2591efbc8dea95bc887c1b3cf22224bdfdc310bcf461723d1c3dc7bc4efad43c46d2c53c8eaafa3c79e62bbd568890bc95da05bd588eee3c362fe6bbad77a1bd530d9d3de6548fbb3b074a3d24627bbdd704a03de7fbfb3c9c3452bdb4f839bd085165bd2a9e493c40a3d23c1379343d54fa2f3c3c2bd23c6081d2bc699c903a5bf52e3d705010bd2880573d7849cabddc895dbc5327cf3b2d527d3c5fa959bd3d2f82ba9ae438bc67c9df3adaf9933d30db903ce22a4a3d788ab0bd0b1435bc3c277e3de9813b3cc629213dfc5dcebc4c55ef3b7526eabc1ac7c3bcf4b19b3cf3024a3c973181bdccea8ebc7f69aaba478cb83d520b82bd9d1709bd1aef59bd5e4ccbbbed2eaa3c597b33bd7113e0bc11ee99bbf9f448bdbe1c8bbdf85907bd442119bd46f05b3d687852bd69a322bd3df81abd2058903db20ba5bdd16b7abbd47ece3c6059debce6a488bd03d12b3dc0ff96bd15eb7e3d8e504f3d2f70733c3828993c2a85f63d3b94cbbc3fa3fd3c750209bbc6b6743db5887abda95bb7bccbf684bd5ce9533dc7cc3c3d2e59133dd686fa3c84caf5bc4be13b3c8b06a6bd8e8dd33de50cba3b55bc213c000aca3cb35c763d6b0b653c5d16763caab58e3c26c11b3dafaf7e3c7983653d397a3bbbc1054e3d1394d3bdb48aec3c9428afbc61bbdebc9c66c0bcbb002fbcb2cea43dbc76513dea2972bc1b8d283de4fa11bc591649bdd52663bc8062263dbf8034bacfef3d3c35167bbdfed6713bacf5f03dc7f386bb65c9c53d190f7dbc53e129bd8fcacabd0f241a3dd465e43c31d121bcaa9ab3bc5f58413b94f4883d54b378bd86e2e03c65253bbded9b993c21a2003d5cbc743cc01941bb4df0563d8bf6af3b46aec6bd169da83cc3601e3c60aeaabc8d5d2d3db37c8ebcd66825bd8680cb3c47f5133cd00ba9bd17a0363d17d49a3d0d52a63ce4c2e43cb979bb3c688e9b3dddc22bbdc45c1abd0bde59bdeb88e1bc52d5033d6b7d12bdff34093cbd4a88bc6e6121bdcc762fbd32d9cbbc6af64d3d5d8cd0bda43d0f3ce4ab54bda3ab5a3d8a8003bd5390d23b60a00a3d61c5373d680ff1bcdfc1643921fd3bbdf8c2fa3c1425053c0505023d9fb29c3dc2a8803da5f62ebdab5540bd0d6bb83d6a65c8bc847cdbbbd6870a3daf7148bc83ddc9bc3cc8843af519023d8723093d231151bd9ec052bdf9e92cbbea2209bdb98d163de3fe233c8617733d39ee95bb488b8fbc2983a7bbb7ca8a3ddeef62bd50238cbd3c3fa83da823ae3c46de0c3d499add3bcabf853ca297ecbd2492bfbce6c6c23c971364bd153fc8bd759407bc5bb7c33d694ee5bc9ce425bd2f55bf3ca7399a3cd73a8fbd3a0858bc1b73bf3dbb714ebd6f1a9a3cbeae1ebca250b03cbe004abd0715eebb23a9153ca45fb1b998d1473caea2c93c204b2cbdd5a8a4bc92008fbb71bc003b0173173d5217043d739f12bce287e9bc5cfcc13d9d6a2dbd77ea6abc91bb48bdf185043c2e6d6dbd09f2803d84714cbd38da7d3d02e70dbdfa5cc0bca41656bd1046d13cb9e84bbca72a6cbc7e4ec33c5f615fbc7f35053da44c56bd417f65bd0d9cf8bcd479d8bc32ed40bb48b3dcbcfd338e3c5c6eb13bcfb216bd2ec80d3db8a710bd97a0df3c8ebea0bd7f88afbd7a5cf93bce5eb8bd2ac7183dd70f7abcb10e003dbbf5003d9a3b023dd822073d4d161abd765528bd4b2ccbbc40a7da3ca5960d3d72b50bbdc433243dcc2d0b3daa0bb63b6dd63c3d8964e63c2686adba47c795bd7f6c833c8ab056bc06fd8c3da750d8bd5659143c3667513d3c11583d6db94f3d7aa2bc3d11808a3c1e9c903d60f33d3c33b3933c5546cebb92206abdc414d0bc1fbe49bdcaa6a53d8a804ebdeef1a93c2d7609bd7930a4bd366ca7bdae18683cdafe913c32f01ebdd5e7653d85491abcd46303bc0f8395bc5bf7193c3943a53c343d903a96e2133d0e5f80bdff52c1bca504c5bdbde80d3c7646a23b0ad1993c25f2ef3a0efd1dbd640a693d64fead3ab23d9abdab5aa2bb8ef5d0bc3323113dd79a08bd053cdbbbdbdc5ebd2d58d13de9fa7bbc797c65bc5603e83bb66add3c82c3893c5add04bd4d3fc03c613171bc7ffcd73acc3514bc17f7bd3b536b783cbd6601bd531ec6bdb662b9bc16b0b7bce32ed13cf52dcc3c6c167cbd9db68dbdb20a803cc68d31bcac18a63d9d5a9d3da46b6bbd9119193c7410783d572b8a3d7eae343d1e6688bd3f3087bca41f9cbd625f36bd6e112c3d4a454f3de2ed4cbd4503933d17d105bdd07d8e3ceb171cbdf073583dfe9106bdd7e480bc4f413b3da6342cbddac1ddbba6f8a83c0178d6bb389735bd, 3, '2026-09-27 23:05:42', '2026-09-27 23:05:42'),
(22, 5, 0xd90b813c365a30bdc49f58bc02ef363d653b2abd5ff982bc2135123d455baabb39ca7cbd542821bdc590e13a7c3e463cbab88abd905ceebc38eeac3b37ef953d010c9e3d821a413afc54443c8492103ccd63aa3dceff4d3d2672373c477c613c2ceb38bce0e66fbdc6c771bd2fc8013d6515febcc188eabb8c3004bdc6ecd5bc8fbc15bd2626553d1c80d4bc1913cebc097026bc0cf9623b97e2c63cef8f99bc313edf3b4f43963cf935913cb7e569bd6075943c9572fbbccf4c963cb6b8c0bc7c14d03b8829603daf9e36bdd18e0c3dfe39d43ce79639bc74d416bd713181bca80417bc7b81a7bbf6fa88bd7e784c3de02d0abd0307eabdb1ec49bda22832bd9c68ac3bf271563debd5083dabdbfaba2adaa1bd99aa2a3b93369abccf94c63deea889bda1b46fbdc7e7473bae1d2cbd9f54293c25239fbb8d5dfe39478a4f3c9bf3053d573e7e3d24bfd93c3837a6bdd98694bc2e581f3df9aa0a3d8a0fddbc4f1f013d8d7ad6bce671383bb70a7f3dcb9dd03c97080c3d2fb1a0bd34d12c3d1fbe463d9148d8bdfc9e8c3c3b5d7bbd46ed20bd1f3c07bda569673da3a4293ceafec13c5470a1bae0a3a23dedfc33bd474f2d3dc62049bcf864253c82f8febc6cf462bd9fdde6bc4bb8b73c7bb8ad3dc55dbebdb6d3823d9d5c3f3d3bf7bbbbbbab2cbd22c4aebc8e9c5b3c4b8b8b3d4fcc6c3d2936063dc21ecc3c8a6040bdb2f29f3d6aee6d3d1d1438bd62da8f3d06c373bcc6a210bd2c83ac3c3f0034bc80074abcc60741bde65857bdb1807dbd5224573d44cc9fbb8ff12e3cd42ebabd18f446bd096cad3b900a093d55794cbc44cf29bd1cdccebb37f76ebafae6793c7fda163c2561093c4e3464bdae6ace3c760ef43c7cd2273dd70002bc7d47ad3c182baabd9ffb903d11a5163d35a296bcf564963cb4a7f6baea21abbcf05d1cbdcbef3a3bb7414dbc6519cf3d27f0a63c37b829bdae725dbb818d803d0dae34bdf12c2cbbf6d77cbc286f84bc4825d2bcf7a6ac3cbac118bd2e24f63ca9e8da3cf6dff43c44dd6ebdc54e333df7206e3c6cced3bcf5c32dbdbb8a623d38c7b9bdeca3ed3cda43b2bd07d6fa3cb279e43cf0f9553dbc2b28bbcd3b05bdd01554bc515ac0bc5c10a03df03daebc07346a3c926e98bc7223483dd42279bd560d1a3c5334843de66938bc72dd3d3c2e5ebc3be9bf00bc71c9733d07d117bd5587453d8333d03cd54cbb3c5567663d5cf53bbc7794883d60f3803a773f163da164bd3bcb8eb73c49c69fbafdb2403d4403f53c8ec3b13c7e6b5d3d1f0a0dbbdd80313d03eac73d4b04c43cd4cfc53da414d7ba3ba865bdca1c8fbcf9e4913a907a8a3df9401cbdd6a426bd36f825ba57152ebca82ca4bdb01a013c261844bd7d4893bcbff2a03defc2a63d0d8b62bd035fa43d9fe9803d5e77f9bdb8e58b3cbaf53ebd47a5a73c69d05ebca1a88abcbb7b04bdddf8a8bcda57b63c389809b979bca4bc10ff8c3ce14e0abdbbaa28bc1596423c77676c3dde46263ccb137b3da60887bb42dee1bc928700bca86f9e3c849268bd959639bdf824803c12de02bd26bb23ba16eed33c0f7c49bdaeb830bd1b7c11bdf2d93f3ddf8e37bd2696443d2b6effbcaf691f3d8681e2bc83d4debc5b00e9bc22a8373d081bae3c3fa1053c95d3d53cee36b83d62fcb2bdc81c2e3c36e6663c29035e3cc45a253df4118fbcb2bf14bd992d163c0778843bc65d243c18f2203c33ca85bd10ab60bdf7fddabc1fe8d9bd680f0a3daa2714bc73cdccbbe377393de6336b3d8d1a633d9ce9023e9164a63bd533163c55670a3e86ad413d8dda403cbef7cd3cff13b5bc0d769abd1dc80ebd6a77b93ddcbe92bd1b4097bd3b35403cec95d13dadb1bebc71cb4a3b096cbc3c8c8b0b3d49cf66bd077ce93c27a42b3dc09d31bd7eff563dccb5c2ba683176bd865a3bbdeeac893ccb5f0c3de600bdbcc358a2bb6be30dbdd3fbafbd368489bcb58289bd281fdd3bacfa033dc709c4bc2e86243dc9d3df3c7c667e3d072f97bdae5f203cb3e49ebd5e75fb3c96452ebd24b1e43dbb0249bb3c8d47bc6a990d3d0feb5c3dfe6bedbb162b1fbd4c2c6dbc8dacd23c7ec4233d9cb15dbc5e01983de84d8bbd2ae024bb70d5543dd87d08bd2c7c083d31c667bdecca7a3c1db398bbdf7c583b59d3ac3ccf0071bd5e542dbc75a22cba976c7ebcfcd7733dfca4bebded106f3dfd8b34bdfb7991bd7ba08fbca9ade6bc3f631b3d930aa5bdce8f81bc57bf45bc1e35d3b9af6fdc3c17b2afbd2376f63bcd264c3d54a569bc6a7f223dba734d3a7ebac2bcefa3aebba206e6bc3ff5043dd799a43da1bb7ebd73cc0b3df06d523d24c7c4bc6d9f863d105d743d01802b3c65ef86bc48ee4fbb30abc1bc4e1a193d46205a3db8d4083da818733daba13a3c64ab89bbe064573df06e27bd112eaebcc921d23b928add3c45e76e3d1a0418bba5005abcf91d2bbda343363db8b600bca053b7bb1f69dfbbcd2ca53d79cd573b3d6326bd4386d53adbab93bd817d3f3d5148ec3c4c549cbb37309d3c08d904bd50352cbdc910963d5ffecbbd6afcf13c618e68bc5de3ca3b9e946a3d2d6193bc423e033c181d2d3da0b4c73c38238f3cba8693bc43e9553dfbe9933d0a999fbdb51df5bcd28e0cbc39eb13bc0681acbcca4770bd59ba9bbad05b8abd6a56593dc25c813b889388bdd62621bdf81d043cbae2a03b8de1acbcd5c2d2bc64e228bdb6018b3dbeaa8a3dccf800bd0d5b7e3d81fbd13c61cbec3c7491d03c3d28bebdf675e7bc8ba7b7bc763b40bd22cb19bde1789e3d7a3723beec27383d37cec8bc6587783d18b89fbcb57f1f3d7dc8f6bca84abbbc441aa2bc75e785bd7a8da2ba71fcbb3cb71548bdcf83c4bc, 3, '2026-09-27 23:05:42', '2026-09-27 23:05:42'),
(23, 5, 0xbfdd12bcf7cb92bd032f01bd70d3943c0d7318bc3f5e68bdd98758bdc8458e3d8029a8bdfdff04bc0226a53df8859a3c346537bdd06d52bc3b0528bdbccbb23c6d859e3dfd14b3bca923203c11679b3c1e65103d8064ecbc93c728bd43c2a1bd21de023cf72fcfbcc35915bd64f35a3d7a6f85bc2173613c19bd90bdc888d2bcc2d31cbc7516503da09001bd81b476bbd29fa53c011a6b3d4d49dfbb937c6c3cf911a4bcc0a4193d63ed973b221126bd917919bc1ab7adbc8bd6e3bcbe80633c6319cc3a866ca73de2a092bca3288b3ddc278a3c7a4115bd5541c1bc5e6d25bdcfc7b53ca0e784baac2887bd515ddf3c8b2f86bcbf70c1bdbcf5553d109042bd9117cbbc8140483db8d4b03cdcbef03c119f07bd46f3513b81658dbd712ac93d1839e4bc810f87bbb94d893b68360fbdb176b03bfe6c373bfd4627bd2c379f3de74c883dff3f563d9108f63a41657dbd55c593ba7790573dfca1903df7ecdbbc120f7b3d5be9a1bdbb775c3c7c3175bcaf4e31bd93959bbc7b8a6abdec5a80bcd0d16f3d4c628e3bf7cc693ce861c2bcd237ba3c29740abcc317923d8f584fbd8840cc3c998b4e3dd5a5743dc811d2bc14c7093d077f7f3dffce123df3aca23c423e87bdc1d1143df5ed163d284bbc3c4be1d9bd3ad4cd3d52fd223d3b9b88bb597788bd11f9a4bce8b537bc18a45a3ca68fad3dac0846bd16131e3b63f4b9bc2ff7033db3e3993d65151dbd40dd4dbb8c880dbd7dc070bde3c4323da5f28cbdc775103ccc0dafbc7ccb2dbd3c9b85bd4035993c22bd4a3c7d97a33d53d5a0bdca07f9bccd235f3d6aaf2d3dc9f7843ca78dd5bb31f8143d8d1bf5ba8be3ab3a674e34bc4877bebc675b95bd0641853c7abbfe3ccf4aae3ccc12da3c121208bd8a5774bdd1bf8f3d0eb6003d0ba702bdc608a13c32a8ab3c5a9b3bbd236997bd3a1b003c3d7d0ebde06ea33d7acd843d2ba101bd2e9918bc4495083d3d16bfbc02d534b97039c8bb2333d9ba6dc009bd87801a3c1b6525bde2ce403d65c0d73a16924e3d12e706bd715b903daf5913bdeb1527bc816875bdabe09b3d34d390bdc884a43c9e1d62bd52424e3de1a05f3dbd8f123e6ff9a23c31a5cabc463b943cf019a6bd9b18173dea539fbd4bcb9cbc9afd09bd52eea63d5b11cfbdd76351bd0f7d3d3d8d6723bdcce34abcdfc2a83d009f67bc922a253c85a351bdce0b2dbdbd64733a803fbdbceef61ebda73873bde4aabb3df958ebbc0006043d3d4ebbbacbaa07bc22053abdfd33a53b66de383dcf68263c87a2febbf33d38bca297813df4070a3d2fbba83b04d8c93df35eff3baf520a3c5b08e6bc775d323d9e2cb43d9674353c3b59dabb59bfd8b9987ca03d94843bbd46180f3d42e4a1bdd5d12b3c36e1553d1f7b37bc5cce71ba3775ef3c143e093dd73dfabd918c703c63ba053c148c293c8a00813cd0773ebd48b975bc881d01bc574f56bb9e3454bdc42e2b3c2f7c3b3d1444653d32110dbb830f2a3d1017ab3d3c6407bd8671453d195d0abd61c927bdda66953c794b3e3c8b0d073cd67479bd2811a8bcfcce91bdb873083d1617233d3380ecbdbc5d5ebda501aabc63808cbbfb7c193c3fb86e3c65ad98bcddc3463c3873fbbc3620a9bc71878cbcad5e913c40933d3d5cf315bd13913b3ddc765b3d0eb1aabd61166abc5db5353d4a01673c358f60bd081cefbb424702bc11a387bd8ac6cebbb526973b47982d3c3e835fbdb264bebc0f5c98bd7ccc50bdfb664d3cdee1c93b82a317bd58dd633c876cd6bbf5a66e3cd5eb0c3d6dd9c2bb8c0b12bdf99d4f3cf8bb2b3d1558b33dda308a3cc4c3a13ccbd5a8bd766251bd31260d3d689085bcaf93acbd387c723d297ed43df4ce65bd4ee0f7bca1f60a3d19fe843d522a19bd66572e3dfad7b23ddcb98ebdd9ee913c9c3341bda127ecbcd92bcebcfa32d03cae6e95bb908b4c3d874aec3cb9c2103d0b1e0ebec36b6cbb0a55fbbc4c18f13ccbea083d8c9d7bbd03911dbd09fbf0bceca78a3dc346a3bd3d253c3bafb3b7bd2fa48c3cd6258fbdfbb5bd3dbfb92bbd412e343d1db89c3c4a0a8b3cab77513ce64c133d5d6bacbc5729d73c044eb5bc029b09bd46103abc2d084bbc3b33bbbc5f05c43b2f906bbd2383d13ca8a4b7bcecb869bc138a5fbd2873133d79fe593d35713fbdec1e11bd542527bd30a880bd6bdccf3cb11712be1a47493bad89223c3e0aa3bc28340bbd4cc44ebd6f25d5bc896588bd59cf1f3d6cac0dbd8cf41a3db2f5a53a592799bd251c913d7e07513dc09326bacaed913d4857b53c4ba501bd954765bcac52a9bbde1493bc9054703d49c2a2bdcb75f9bcccd4793d883821bd13ea0e3d53ea113ddb6eedbc748f923dca1cad3b7bfc393d822e023dff87393cd00e29bc12bf24bd6b405f3ce5cfdfbc5ddd893b2e823c3c0c8ac7bdeaf38abbc9178d3cfc6a343cb9dc3ebd79b81e3da819a4bcc39023bdacd5e73c6317863c7e00263d725e453d0b389a3ccc75cdbc658b4ebc20b587bbdd42ea3c88b04d3d98a0053ca1034cbcafa7dbbc82d4fbbc1fc6233d3c48dabd9733073d6c469abc7d4b113d2905783c8a77abbca7c319bd23ad1f3dc97513bc4b7f5fbd229c553c4a6a193df24a7e3b8919073d29b14cbda346a03b442be83c547e263de710863b83937e3c63282abd5a5018bc4c38103d2e772f3c07530abb7ae8673c456ccbbb7f717ebd85d218bd6c4e90bdd9ca00bc7ff58d3d95c0d0bde9b9a33d15e0d33c55acf93c7c2bd236a468bebd99c95dbc3dfc10bde1faf33c746e303c4005ed3c5e1a75bd64fb59baa8c566bcc3ce83bcf0d20ebdfd31a7bb75b013bd96281ebc59fc39bc984f2ebda37a6ebc6fa110bc00c2bfbcabbc0ebd, 3, '2026-09-27 23:05:42', '2026-09-27 23:05:42'),
(24, 5, 0x3c5eedbcde2f02be03b3173d4d10a83db66e16bdca7de3bc8a555c3cb89d5b3d3d00d4bc05757d3c1c476f3d1db45b3d9e0e873c638359bdefec01bd7c7b6c3de4d5a7bb956916bdd685323c5a6dafbb340e953d55b485bde497c83b8a33bfbd34b9133c6bdbc9bc9633b4bc8c94073d0ebe21bd0f443b3c5d94a0bdfdc10ebc5a82febca2e70a3d0ddfd1bc63ee8bbb0defe6ba4151f03caea4253d3b7c553cfe9135bdd42f4b3de362b1bc354c5e3ccb1763bc772532bd72ffd5bce145ddbaacc774bd4e14fd3d8a140bbd26a6813d0c3eadbcd5eb5cbcd4212d3d2a7986bc4959323dc1d777bd2dd5ddb94ed3d6bc230d10bdd3e412bef28b903c8ad572bb5fa560bc94fce33cfcfaebbc44d3183d3c2e01bd2b4893bb1d02913c3c821b3e43dc943c9448dfbbcca056bcb5196fbd1396f9bc00dd193d81f1593ce9352a3d9459d8bc3c12aa3dd7e6123c3d6084bdf134ae3c42b516bcb114dfbc307ca6bb75c7e93d88c6f8bc08c8843d8677c83c1c8945bc1517473da4ed28bc4235283dbdac2d3d894f90bc5f46a73a5ad814b93b6aa1bc190bfbbcdb22033cbe11a9bc21516ebd48ed1d3d3e51873d2a46cebd2423213dcf94a73c511a87bc413ab03bd4ec9fbd663f0e3d2e0718bdb34aebbcc0819abde79afc3c64b7073d3182a83c6b6f8dbdf97d773b4b01c4bc448e623d9b48be3c8d10013d023838bc8a1a79bcfa11683d1c9daa3cce9eeb39bf40763cc67812bc83eab9bcfdbc223ce449553c2898273dee3706bd62f0d93cbbef8abb7963233d06a838bd25004d3db429c2bd8ba56f3c6d4b5f3dce5c39bb65da47bc082af2bb758e383d424e12bd0fdef3bcf983c1bb688a933bfffb4fbd929ecc3caad9423cdab8823d5eaf93bd8dc01fbd378244bdca85df3b9296cabcdc9c1c3d77be1abd4073173d7945f9bb8d6832bd2d1d99bc81127dbd32618a3db851703c16205bbd34c267bc4e33503ddc0ab8bdeb8b02bd7afee33c25208abc15b6cabc93b9353c16ee43bdb18a9d3c0705a739737ff83cadca7dbdbb68c23db2522abca8e770bcd2b6de3beefbd63d49ec6cbdfc7fe73c67fc08be1ca6663d46477dbdec84c03d29a271bca6b132bdad48063d7afa13bd4f26d13c6c7369bdb1d3da3c86f675bd2314f93b604d9bbcbc7f4c3de250213d5a963fbc84471e3c7210ac3d39c92cbd53eba4bcdab1bcbcab24c9bc82c00ebda9d659bce5be2ebd8bd553bb03542b3d191ff43bf5ab0b38757411bdbbcb693b97c833bbe3bc8e38e0055c3da71eea3c1a2e853c9e8d76bd8afac23dd7648dbddca4393ddfd3b83dc1ed03bd104d4ebc0df621bda2eaa23cd1470e3df8ce683db09d123dfebba5bc1a800d3dc5c930bd4e7b203d6556b9bb12c6203c3c66233d3f5e063c60e98abc2a51c03de883363d3f6383bd7058edba75ac2bbc3194a3bced13303cfc5c60bdb572dcbc3a3bc93aca07253df47fa4bd6b35963cb19b6bbb7454113d8b563f3cb190873ddcae983da32982bcab19213df3f7f03cb7431fbc0e2aad3b5e85643ba0ebe33cc38016bdee5809bdd77e07bdc279723be9ee003d9b4defbd861717bb72b093bdf05c983cd86043bc498757bc18b8bfbcc96567bd3e15143ac351d0bc99c7ddbc1c8c1e3da5f80f3d6eab92bb29fa163d9d48c93dd235aebd0b123abc706b1c3d1305643d53a850bca99e4abd1f108dbcb5e73abcbcc985bba05ac33cd0445d3d8142f63c814c10bd3b6d0fbd733fd0bb5751a53ddfc1183d43e625bbe9128c3df926dbbc9eb5003cec0d773bc0aa86bd89b6c13cc405c03d8f79613de0fbc73cbb7b29bcab4aafbc9ecc09bd09590bbd401f883d99f720bd9f3d83bd79ac16bc0eb95c3da663e5bc1958db3c6987013da079e03cb4ee7b3c1a05063cb59eb83d2d59d83bcecff63de32b83bd9a6a55bd18edf5bc20020d3d2e23f5bb8a5c6a3d0ffc0b3d1ad5863ce35dadbd52522ebdfd6285bdc5279e3c422ccb3d6f27303cc20842bd89df56bd24a51d3dab2bd13ca37f733bcde7fbbbc091a93cf211b3bd44379d3d64ab473d434bda3c4f5f94bc05a0cabb68a1dc3c83efe73c001d3dbd2f938c3cf64f4a3dbeb6df3b64485d3d9dd784bd7940a6bd87c5213cbc0b1abd55bac73c0520dabc20be7a3c9b5a9dbd681b1f3dbc9a833d94a70a3b44826b3cf10710bd599142bdd8e92b3dca39b3bdbd4e05bd667a48bc2233683d97d4383d3739cdbc0d1cd1bbfceb42bddd72903c5238aabc3f41d5bc9e09cf3c438248bde5dc833c8d99c23cd441b83b46be353d8ffc3d3ccfda083d7c8bee3ccce7d6bc6294093daf46c43c0d5b96bdf51884bc95f93c3d5501293ccb00a83df249573d7072723c1607913ccddaab3c4b2ce13ba82a68bc810afb3ca9ccc4bd02611a3d1a1c0ebce35e63ba867a843df97744bd9028f3bdc51f583c2e0dce3dc909fc3be9cd09bc9f2784bc89831d3d3120f23cbff31b3b478557bd22833e3d0e4f413d59c5e63cdcb231bd96f9ddbc0d1b56bddf70113de7d99abcf920163de9dfe9bd82ec22bdeab85c3adef781bc90e2a2bcafe111bd1786a2bc181d05bdbcd7613bf56cb2bca4e1a53da8b54b3dfabc873ceab5433d172a123c2d8e36bd0652563bd31b913c5c3149bdeb33333c026e3e3cf6e85d3dd9161fbda7fddabcab0c1fbd4f8b9dbc701d363d5a3f61bc185c203c0d16963d3b6a0cbd81543abce02c91bd886239bd2e65b83bc561de3d674266bb5260593dd3ee3c3de442923d68d5d1bc9288a4bd02f3bdbc6af862bdc247613c5547ebbc4f7fc53c8e2b423c4f21fd3cebd4a2bb58a092bdbb6032bd3621823dc40910bd835d27bd9e7b39bcc8455abd69c59e3c752805bdc29f19bbe3c0ee3c, 3, '2026-09-27 23:05:42', '2026-09-27 23:05:42');
INSERT INTO `face_templates` (`id`, `employe_id`, `face_embedding`, `annee_id`, `created_at`, `updated_at`) VALUES
(25, 5, 0x5706c8bcf71094bd9e5822bc65d9913daad23abd405d69bd7708c83c582c3cbd09e3adbd497ee6bce392f93c39abd63c943d11bd156c07bb29c96abd65bd343d0e249a3d6e3caa3b12ac9c3a2515c13d027fa03dc4aec1bb970086bd64b42dbc5216c7bc42c3c9bca72b97bd1d09e43b665046bd74e942bdcde244bc7619c53b696e583cd2f4483d577d2dbdd352473c345abebc3df2133d7eaf1e3cbe40ef3cca617fbc0193a83c7df424bd69c51abd0e5458bc0a20b63aebdb55bd1042133d44b717bd31e3b13d509995bc43658e3d3f06ec3c582e73bc29dfcd3cf4d3e4bcc92e4f3d857420bd5425a23c52f7153c64c5923a6271c2bd727126bd4b6e7cbb33f9393d8c83963ccb71063d57632a3d94c289bc18f4003b560d23bdd4f3e33d316cb8bb563815bd6416a23bca5d9fbd223321bcc2b56abd44a7abbcb7ac1e3c0240f0bc8a94a23df25e5cbc8b7d87bdeaa033bd122f9bbb104a9d3c6ca254bd894de13d22a8d3bd49e2853cd72ba2ba0532403c9f4c303cb231c7bcb31206bcaf4b123d2a3229bbab9d313c30ae6dbca90945bd9277e5bcac142a3dcd2d81bc0d5eccbc75d313bb1066263d5ba14fbd1127983c3a8f49bdf0f3c6bb614aaabd439056bd7d68a9bbd1c9243d5c19a7bbef63cebd75afa23d7ffc793ccddd953c06a896bd1f67a53c561a33bb62731bbc5248073d7b29f13c7ba6113d5d3273bc41b62ebbfb65233d7dcba0bc77cd83bbed3efbbc165060bdf1db4f3d7484f8ba90096dbcd627e0bc94cfaa3cdef646bd2e15933c49c2e8bcd0199b3c725eacbd1d53843da4fc7abc84f90f3d9ee41f3d975ab3bc40cff23b20705abdef990bbd34a75abca3e49abc561058bd92860f3d726e9e3d2598a83cde9b29bd68a839bd7217c2bc660de23ca67931bcfdc5b33c46b8083d350b9e3d6e9cb1bc5123bcbc470720bca8fdeabcd18d9f3d8889b6bc1a54a7bd295386bdd9d4f03c5b32c3bd90d94bbd5e543cba1e9cb0bc6a561fbd2eae0b3c4fbd9ebdac8b783d7d326ebc8a9add3c3252f0bcf830ba3dafb0cabc4f55c9bca04cdbbd2dd3973db91b88bdc9ac1a3c2dbc8cbdc077843d6f2b01bc6cdd6a3d7e3b05bd6b36f4bc68450b3d588e73bd0953283d913389bc9440d83cf9bf0fbdad75123dbe491bbd5ad05dbc6d5d2d3b858ce9bc49f4e03bd25d773db88a66bcb569c2bc916b9abd6546eabcff42303d89f786bc6baa19bd0d073c3c71ad543df737cbbcdaee3cbcd824443a7a7ab6bb03bd613bc98595bcf075683db661a0bcec923bbb0d3f9cbcde57dc3d7f7ccebc547f723d2f4f083e061057bc44e9acbc226e41bd2027cb3c33e7a13d6e79a7bcffdcb63a33b01b3d1d8ef73ce78a1abda7f10b3db0f373bc5979b03d2c3bc43ce92650bc32b4a3ba403e373dc1ef523d6866c3bdadda3c3d721fccba75404e3c5fa9c83a4b2addbc78b9973c0316073d1fa4ad3c134c56bd38d4593d71e6823c04fd663d9b1c593d02d34d3ced6ad83dc63f21bda8a6343d48ce853c957c5cbccfd8a93a268f393c32ebf3baf9d116bda37f32bc728d53bd00aee7bcb2c4a93bb2518ebd663f5cbd8affdcbc1b7fccbcdb6d69bcfedbe33cd74f003c8c8d37bcfde4d1bb7ccc32bd007dd5bc5f2b683dac56d93cd1eaa1bbd2f4b53df4daee3d3e2b89bd6bc7c5bc75fb453c7e1483bb246826bd385387bc32e2f23b021541bdfd95c53cebcf83bcf02089bb8a8f723c5a7c41bde1e601bd1537a4bd3e205e3d3d53f4bc3c532e3ce7fa083d3fafc93c176e873cfd69883d03c6a8bbda8612bdb472633d5662923d833fb33d9b60fa3b5a72f23cfc34b5bd25e346bdb32d763dc8ed31bcba4b91bd0d23813c2ef7913db45095bd0e061bbd051b703ddb8f073d052ad2bbc5dd843daad7b43d3420b63cc017aa3c4c1e60bdda7d76bd971558bd40ac163c03c13fbd4fee863ca9f7883df8f9a13c07b5dabd3e6967bd06b6babcc618973c53627a3d8c5dd23cd6f0b7bc0192f9bcaaef513d862a93bdd49d343d824c7abd993c063d426486bd6c1ec23d79bb1cbd09003a3de54bb83984b2223d2ee249bc5a43823de1a123bd1402cf3c2653383d527c50bdc6180c3d9b35aabda7f8b1bcf90602bdc774fabc65c54d3c0ec7afbc4e80353d658f99bc0fcb0d3d6f728c3db4a1223de5213b3c552fd23b2476ebbc4a91683d740078bd8b8bf1bc34494e3c260fa73c6380e2bb709f70bdafd67fbbddceb6bdf6592bbcf27b5abbed53b1bcde25ebbcb471c2bcf575033dbdcf883df2e931bd4039b03dcfbd593d2a9377bd2ddd35bc03e862bd50e4193dab3a823d533a94bd3d2d853caf0e433d2c5b3cbca336ef3d6d2dc23d9636c7bc0d7da83c5dc1a43d245905bcd99e33bc5dfc683c01c000bde70a40bb523db33ced2d583bf8aa063dfb98b5bc96d9a9bd833a90bb5524ab3b2d40c13c28e73bbd730c7a3d08f2ed3cbb1a063d44c4f63c4a9cb839f46e233ded2915bd07f75a3d7fd595bcb28b00bcfe1abdbd0718c03ccc834dbc408d0a3d74aae0bc74b447bd7504193db1765d3dc2615cbd6269e53ce320803cf5eb0e3c00bbecbbb1efc8bb6e9e273cda738e3d2ec0163c37f3753dfa6c66bb0ec4bb3cf460123bc25946bc6e3b83bd710196bc14e12c3d6816cf3c809442bd28f2b4bcee32b4bc623e1cbd6fe33a3ceb5e4c3b927c0abc98f94a3d4006c5bdd72025bd5543a7bbcee31bbc8a4c12bbc8fc273df1a734bdb874213d6dafc03cceb1d03c342e303d5b8e8dbd54422cbd302cdbbd441ab13c0d81273d1a0d083d41340fbc32de823dc9e925bce783403ce5a7c7bd8af650bcaf1e43bc901a7dbdb43e353d19e07cbdcb994f3ca24163bd19569cbc3bfb0c3c, 3, '2026-09-27 23:05:42', '2026-09-27 23:05:42');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `formations`
--

CREATE TABLE `formations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `domaine` varchar(150) DEFAULT NULL,
  `intitule` varchar(200) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `nb_jour` int(11) DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `formations`
--

INSERT INTO `formations` (`id`, `domaine`, `intitule`, `date_debut`, `date_fin`, `nb_jour`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 'Informatique', 'Initiation sur le leadership des equipes de terrain.', '2026-09-19', '2026-09-25', 7, 3, '2026-09-12 19:12:52', '2026-09-12 19:12:52');

-- --------------------------------------------------------

--
-- Structure de la table `formation_employes`
--

CREATE TABLE `formation_employes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `formation_id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `statut` varchar(100) DEFAULT NULL,
  `resultat` varchar(100) DEFAULT NULL,
  `certificat` varchar(255) DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `formation_employes`
--

INSERT INTO `formation_employes` (`id`, `formation_id`, `employe_id`, `statut`, `resultat`, `certificat`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, NULL, 3, '2026-09-12 19:57:32', '2026-09-12 19:57:32'),
(2, 1, 1, NULL, 'excellent', 'formations-employes/vdBEv2Lpo3XigtHmBSiVN5BUZoQqFAD7XSV7h5Zo.pdf', 3, '2026-09-12 22:30:49', '2026-09-12 22:30:49');

-- --------------------------------------------------------

--
-- Structure de la table `grades`
--

CREATE TABLE `grades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero` int(11) NOT NULL,
  `designation` varchar(200) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `grades`
--

INSERT INTO `grades` (`id`, `numero`, `designation`, `created_at`, `updated_at`) VALUES
(1, 1, 'CC', '2026-09-15 13:04:49', '2026-09-15 13:04:49'),
(2, 2, 'CS', '2026-09-15 13:08:40', '2026-09-15 13:08:40'),
(3, 3, 'CB', '2026-09-15 13:22:46', '2026-09-15 13:22:46'),
(4, 3, 'CD', '2026-09-15 13:24:18', '2026-09-15 13:24:18');

-- --------------------------------------------------------

--
-- Structure de la table `historiques`
--

CREATE TABLE `historiques` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `historiques`
--

INSERT INTO `historiques` (`id`, `user_id`, `action`, `ip`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'Création d\'une année : 2026', NULL, 3, '2026-09-11 16:41:45', '2026-09-11 16:41:45'),
(2, 1, 'Mise à jour de l\'année : 2026', NULL, 3, '2026-09-11 16:41:54', '2026-09-11 16:41:54'),
(3, 1, 'Mise à jour de l\'année : 2026', NULL, 3, '2026-09-11 16:42:05', '2026-09-11 16:42:05'),
(4, 1, 'Mise à jour de l\'année : 2026', NULL, 3, '2026-09-11 16:48:20', '2026-09-11 16:48:20'),
(5, 1, 'Mise à jour de l\'année : 2026', NULL, 3, '2026-09-11 16:50:37', '2026-09-11 16:50:37'),
(6, 1, 'Mise à jour de l\'année : 2026', NULL, 3, '2026-09-11 16:50:40', '2026-09-11 16:50:40'),
(7, 1, 'Mise à jour de l\'année : 2026', NULL, 3, '2026-09-11 16:50:43', '2026-09-11 16:50:43'),
(8, 1, 'Mise à jour de l\'utilisateur : dg', NULL, 3, '2026-09-11 18:50:37', '2026-09-11 18:50:37'),
(9, 1, 'Mise à jour de l\'utilisateur : dg', NULL, 3, '2026-09-11 18:51:51', '2026-09-11 18:51:51'),
(10, 1, 'Mise à jour de l\'utilisateur : dg', NULL, 3, '2026-09-11 18:52:09', '2026-09-11 18:52:09'),
(11, 1, 'Mise à jour de l\'utilisateur : dg', NULL, 3, '2026-09-11 18:52:57', '2026-09-11 18:52:57'),
(12, 1, 'Création d\'une année : 2024', NULL, 3, '2026-09-11 18:55:49', '2026-09-11 18:55:49'),
(13, 1, 'Mise à jour de l\'année : 2025', NULL, 3, '2026-09-11 18:56:23', '2026-09-11 18:56:23'),
(14, 1, 'Création d\'une année : 2024', NULL, 3, '2026-09-11 18:56:37', '2026-09-11 18:56:37'),
(16, 1, 'Création de la catégorie : Menoeuvre', NULL, 3, '2026-09-11 21:02:05', '2026-09-11 21:02:05'),
(17, 1, 'Création de la catégorie : Travailleur Semi-Qualifié', NULL, 3, '2026-09-11 21:15:03', '2026-09-11 21:15:03'),
(18, 1, 'Création de la catégorie : Travailleur Qualifié', NULL, 3, '2026-09-11 21:15:27', '2026-09-11 21:15:27'),
(22, 1, 'Suppression de tous les historiques sélectionnées parDirecteur JONAS', '127.0.0.1', 3, '2026-09-11 22:06:15', '2026-09-11 22:06:15'),
(23, 1, 'Mise à jour de la catégorie : Menoeuvre', '127.0.0.1', 3, '2026-09-11 22:10:59', '2026-09-11 22:10:59'),
(24, 1, 'Mise à jour du service : Supervision de ponctualité', '127.0.0.1', 3, '2026-09-11 22:12:09', '2026-09-11 22:12:09'),
(25, 1, 'Création du type de congé : congé maladit', '127.0.0.1', 3, '2026-09-11 22:14:08', '2026-09-11 22:14:08'),
(26, 1, 'Mise à jour du type de congé : congé maladit', '127.0.0.1', 3, '2026-09-11 22:14:35', '2026-09-11 22:14:35'),
(27, 1, 'Mise à jour du type de congé : congé maladit', '127.0.0.1', 3, '2026-09-11 22:14:44', '2026-09-11 22:14:44'),
(28, 1, 'Création de l’employé : Mumba Kisimba Boaz', '127.0.0.1', 3, '2026-09-11 22:23:13', '2026-09-11 22:23:13'),
(29, 1, 'Mise à jour de l’employé : Mumba Kisimba Boaz', '127.0.0.1', 3, '2026-09-11 22:34:35', '2026-09-11 22:34:35'),
(30, 1, 'Mise à jour de l’employé : Mumba Kisimba Boaz', '127.0.0.1', 3, '2026-09-11 22:34:44', '2026-09-11 22:34:44'),
(31, 1, 'Création de la sanction : Mise à pied', '127.0.0.1', 3, '2026-09-11 22:47:04', '2026-09-11 22:47:04'),
(32, 1, 'Création de la discipline #1', '127.0.0.1', 3, '2026-09-11 22:48:20', '2026-09-11 22:48:20'),
(33, 1, 'Création du poste : Operateur de saisie', '127.0.0.1', 3, '2026-09-11 22:50:03', '2026-09-11 22:50:03'),
(34, 1, 'Création de l’affectation #1', '127.0.0.1', 3, '2026-09-11 22:59:38', '2026-09-11 22:59:38'),
(35, 1, 'Création de la formation : Initiation sur le leadership des equipes de terrain.', '127.0.0.1', 3, '2026-09-12 19:12:52', '2026-09-12 19:12:52'),
(36, 1, 'Création de l’inscription à la formation #1', '127.0.0.1', 3, '2026-09-12 19:57:32', '2026-09-12 19:57:32'),
(37, 1, 'Création du mouvement #1', '127.0.0.1', 3, '2026-09-12 20:05:25', '2026-09-12 20:05:25'),
(38, 1, 'Mise à jour du mouvement #1', '127.0.0.1', 3, '2026-09-12 20:20:58', '2026-09-12 20:20:58'),
(39, 1, 'Mise à jour du mouvement #1', '127.0.0.1', 3, '2026-09-12 20:21:03', '2026-09-12 20:21:03'),
(40, 1, 'Mise à jour du mouvement #1', '127.0.0.1', 3, '2026-09-12 20:27:17', '2026-09-12 20:27:17'),
(41, 1, 'Création du communiqué : Communiqué 1', '127.0.0.1', 3, '2026-09-12 21:06:36', '2026-09-12 21:06:36'),
(42, 1, 'Création du communiqué : Communiqué 2', '127.0.0.1', 3, '2026-09-12 21:10:43', '2026-09-12 21:10:43'),
(43, 1, 'Création du communiqué : Communiqué 3', '127.0.0.1', 3, '2026-09-12 21:18:32', '2026-09-12 21:18:32'),
(44, 1, 'Mise à jour du communiqué : Communiqué 3', '127.0.0.1', 3, '2026-09-12 21:18:58', '2026-09-12 21:18:58'),
(45, 1, 'Mise à jour du communiqué : Communiqué 3', '127.0.0.1', 3, '2026-09-12 21:41:30', '2026-09-12 21:41:30'),
(46, 1, 'Mise à jour du communiqué : Communiqué 2', '127.0.0.1', 3, '2026-09-12 21:44:59', '2026-09-12 21:44:59'),
(47, 1, 'Création de l’audit #1', '127.0.0.1', 3, '2026-09-12 21:53:41', '2026-09-12 21:53:41'),
(48, 1, 'Mise à jour de l’audit #1', '127.0.0.1', 3, '2026-09-12 21:53:49', '2026-09-12 21:53:49'),
(49, 1, 'Ajout d\'un contact : parfaitzix333@gmail.com', '127.0.0.1', 3, '2026-09-12 21:56:36', '2026-09-12 21:56:36'),
(50, 1, 'Création de la propriété : A propos de nous', '127.0.0.1', 3, '2026-09-12 22:04:24', '2026-09-12 22:04:24'),
(51, 1, 'Création du règlement #1', '127.0.0.1', 3, '2026-09-12 22:08:53', '2026-09-12 22:08:53'),
(52, 1, 'Mise à jour du règlement #1', '127.0.0.1', 3, '2026-09-12 22:09:20', '2026-09-12 22:09:20'),
(53, 1, 'Mise à jour du règlement #1', '127.0.0.1', 3, '2026-09-12 22:09:55', '2026-09-12 22:09:55'),
(54, 1, 'Mise à jour du règlement #1', '127.0.0.1', 3, '2026-09-12 22:19:25', '2026-09-12 22:19:25'),
(55, 1, 'Création de l’inscription à la formation #2', '127.0.0.1', 3, '2026-09-12 22:30:49', '2026-09-12 22:30:49'),
(56, 1, 'Création de l’archive #1', '127.0.0.1', 3, '2026-09-12 22:34:50', '2026-09-12 22:34:50'),
(57, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-13 00:08:17', '2026-09-13 00:08:17'),
(58, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-13 00:09:27', '2026-09-13 00:09:27'),
(59, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-13 00:09:33', '2026-09-13 00:09:33'),
(60, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-13 00:09:47', '2026-09-13 00:09:47'),
(61, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-13 00:11:52', '2026-09-13 00:11:52'),
(62, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-13 00:11:56', '2026-09-13 00:11:56'),
(63, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-13 10:37:08', '2026-09-13 10:37:08'),
(64, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-13 12:49:36', '2026-09-13 12:49:36'),
(65, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-13 12:50:25', '2026-09-13 12:50:25'),
(66, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-13 13:08:36', '2026-09-13 13:08:36'),
(67, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-13 13:09:40', '2026-09-13 13:09:40'),
(68, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-13 13:12:41', '2026-09-13 13:12:41'),
(69, 2, 'Mise à jour de l’affectation #1', '127.0.0.1', 3, '2026-09-13 13:13:27', '2026-09-13 13:13:27'),
(70, 2, 'Mise à jour de l\'utilisateur : numbi', NULL, 3, '2026-09-13 20:42:46', '2026-09-13 20:42:46'),
(71, 1, 'Mise à jour de l\'utilisateur : numbi', NULL, 3, '2026-09-13 21:59:01', '2026-09-13 21:59:01'),
(72, 1, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-13 23:45:07', '2026-09-13 23:45:07'),
(73, 2, 'Suppression du communiqué : Communiqué 1', '127.0.0.1', 3, '2026-09-14 21:47:37', '2026-09-14 21:47:37'),
(74, 2, 'Suppression du communiqué : Communiqué 2', '127.0.0.1', 3, '2026-09-14 21:47:39', '2026-09-14 21:47:39'),
(75, 2, 'Suppression du communiqué : Communiqué 3', '127.0.0.1', 3, '2026-09-14 21:47:56', '2026-09-14 21:47:56'),
(76, 2, 'Création du communiqué : Titre 2', '127.0.0.1', 3, '2026-09-14 22:34:26', '2026-09-14 22:34:26'),
(77, 2, 'Suppression du communiqué : Titre 2', '127.0.0.1', 3, '2026-09-14 22:39:07', '2026-09-14 22:39:07'),
(78, 2, 'Suppression du communiqué : Titre 1', '127.0.0.1', 3, '2026-09-14 22:39:10', '2026-09-14 22:39:10'),
(79, 2, 'Création du communiqué : Communiqué 1', '127.0.0.1', 3, '2026-09-14 22:39:49', '2026-09-14 22:39:49'),
(80, 2, 'Création du communiqué : Communiqué 2', '127.0.0.1', 3, '2026-09-14 22:40:58', '2026-09-14 22:40:58'),
(81, 2, 'Création de l’employé : Benjamain Hemedi', '127.0.0.1', 3, '2026-09-14 22:43:35', '2026-09-14 22:43:35'),
(82, 2, 'Création du communiqué : Communiqué 3', '127.0.0.1', 3, '2026-09-14 22:44:41', '2026-09-14 22:44:41'),
(83, 2, 'Création du communiqué : Communiqué 4', '127.0.0.1', 3, '2026-09-14 22:47:06', '2026-09-14 22:47:06'),
(84, 2, 'Mise à jour du communiqué : Communiqué 3', '127.0.0.1', 3, '2026-09-14 22:47:16', '2026-09-14 22:47:16'),
(85, 2, 'Mise à jour du communiqué : Communiqué 2', '127.0.0.1', 3, '2026-09-14 22:47:25', '2026-09-14 22:47:25'),
(86, 2, 'Mise à jour du communiqué : Communiqué 1', '127.0.0.1', 3, '2026-09-14 22:47:34', '2026-09-14 22:47:34'),
(87, 2, 'Mise à jour du communiqué : Communiqué 2', '127.0.0.1', 3, '2026-09-15 00:20:44', '2026-09-15 00:20:44'),
(88, 4, 'Soumission de la demande de congé #1', '127.0.0.1', 3, '2026-09-15 08:14:08', '2026-09-15 08:14:08'),
(89, 3, 'Validation de la demande de congé #1 par le Chef Service', '127.0.0.1', 3, '2026-09-15 09:05:00', '2026-09-15 09:05:00'),
(90, 3, 'Rejet de la demande de congé #1 par le Chef Service', '127.0.0.1', 3, '2026-09-15 09:05:16', '2026-09-15 09:05:16'),
(91, 3, 'Validation de la demande de congé #1 par le Chef Service', '127.0.0.1', 3, '2026-09-15 09:05:21', '2026-09-15 09:05:21'),
(92, 2, 'Validation de la demande de congé #1 par le SecDG', '127.0.0.1', 3, '2026-09-15 09:36:03', '2026-09-15 09:36:03'),
(93, 4, 'Soumission de la demande de congé #2', '127.0.0.1', 3, '2026-09-15 10:35:23', '2026-09-15 10:35:23'),
(94, 3, 'Validation de la demande de congé #2 par le Chef Service', '127.0.0.1', 3, '2026-09-15 10:35:44', '2026-09-15 10:35:44'),
(95, 2, 'Validation niveau SecDG de la demande #2', '127.0.0.1', 3, '2026-09-15 10:40:39', '2026-09-15 10:40:39'),
(96, 2, 'Création du grade : CC', '127.0.0.1', 3, '2026-09-15 13:04:49', '2026-09-15 13:04:49'),
(97, 2, 'Création du grade : CS', '127.0.0.1', 3, '2026-09-15 13:08:40', '2026-09-15 13:08:40'),
(98, 2, 'Création du grade : CB', '127.0.0.1', 3, '2026-09-15 13:22:46', '2026-09-15 13:22:46'),
(99, 2, 'Création du grade : CD', '127.0.0.1', 3, '2026-09-15 13:24:18', '2026-09-15 13:24:18'),
(100, 2, 'Mise à jour de l’employé : Mumba Kisimba Boaz', '127.0.0.1', 3, '2026-09-15 13:31:03', '2026-09-15 13:31:03'),
(101, 2, 'Validation nationale de la demande #2', '127.0.0.1', 3, '2026-09-15 16:12:10', '2026-09-15 16:12:10'),
(102, 2, 'Mise à jour de la discipline #1', '127.0.0.1', 3, '2026-09-15 16:20:54', '2026-09-15 16:20:54'),
(103, 2, 'Mise à jour du type de congé : congé maladit', '127.0.0.1', 3, '2026-09-15 16:52:20', '2026-09-15 16:52:20'),
(104, 2, 'Mise à jour du type de congé : congé maladit', '127.0.0.1', 3, '2026-09-15 16:53:08', '2026-09-15 16:53:08'),
(105, 2, 'Mise à jour de l\'utilisateur : Ruth Mputu', NULL, 3, '2026-09-15 19:20:49', '2026-09-15 19:20:49'),
(106, 2, 'Création de l’employé : Bliss Ngoie', '127.0.0.1', 3, '2026-09-15 20:18:29', '2026-09-15 20:18:29'),
(107, 2, 'Mise à jour de l\'utilisateur : Bliss Ngoie', NULL, 3, '2026-09-15 20:22:42', '2026-09-15 20:22:42'),
(108, 7, 'Soumission de la demande de congé #3', '127.0.0.1', 3, '2026-09-15 20:32:46', '2026-09-15 20:32:46'),
(109, 3, 'Validation de la demande de congé #3 par le Chef Service', '127.0.0.1', 3, '2026-09-15 20:35:36', '2026-09-15 20:35:36'),
(110, 2, 'Validation niveau SecDG de la demande #3', '127.0.0.1', 3, '2026-09-15 20:43:24', '2026-09-15 20:43:24'),
(111, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-18 17:08:18', '2026-09-18 17:08:18'),
(112, 1, 'Mise à jour de l’employé : Mumba Kisimba Boaz', '127.0.0.1', 3, '2026-09-18 21:10:58', '2026-09-18 21:10:58'),
(113, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-19 21:38:38', '2026-09-19 21:38:38'),
(114, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-19 21:38:51', '2026-09-19 21:38:51'),
(115, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-19 21:38:57', '2026-09-19 21:38:57'),
(116, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-19 21:39:04', '2026-09-19 21:39:04'),
(117, 1, 'Mise à jour de l\'utilisateur : Ruth Mputu', NULL, 3, '2026-09-19 22:16:35', '2026-09-19 22:16:35'),
(118, 2, 'Mise à jour de la demande de congé #2', '127.0.0.1', 3, '2026-09-20 09:24:25', '2026-09-20 09:24:25'),
(119, 2, 'Mise à jour de l’intérim #1', '127.0.0.1', 3, '2026-09-20 10:57:36', '2026-09-20 10:57:36'),
(120, 2, 'Mise à jour de la demande de congé #2', '127.0.0.1', 3, '2026-09-20 11:11:58', '2026-09-20 11:11:58'),
(121, 2, 'Création de l’audit #2', '127.0.0.1', 3, '2026-09-20 11:15:26', '2026-09-20 11:15:26'),
(122, 2, 'Mise à jour de la demande de congé #2', '127.0.0.1', 3, '2026-09-20 11:38:07', '2026-09-20 11:38:07'),
(123, 2, 'Mise à jour de l’intérim #1', '127.0.0.1', 3, '2026-09-20 11:40:15', '2026-09-20 11:40:15'),
(124, 2, 'Mise à jour de la demande de congé #2', '127.0.0.1', 3, '2026-09-20 11:40:53', '2026-09-20 11:40:53'),
(125, 2, 'Suppression de l’intérim #2', '127.0.0.1', 3, '2026-09-20 11:41:57', '2026-09-20 11:41:57'),
(126, 2, 'Mise à jour de la demande de congé #2', '127.0.0.1', 3, '2026-09-20 11:42:10', '2026-09-20 11:42:10'),
(127, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-22 17:41:33', '2026-09-22 17:41:33'),
(128, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-22 17:42:51', '2026-09-22 17:42:51'),
(129, 4, 'Soumission de la demande de congé #4', '127.0.0.1', 3, '2026-09-22 17:46:41', '2026-09-22 17:46:41'),
(130, 2, 'Suppression de la demande de congé #3', '127.0.0.1', 3, '2026-09-22 17:48:20', '2026-09-22 17:48:20'),
(131, 2, 'Suppression de la demande de congé #2', '127.0.0.1', 3, '2026-09-22 17:48:22', '2026-09-22 17:48:22'),
(132, 4, 'Soumission de la demande de congé #5', '127.0.0.1', 3, '2026-09-22 17:48:40', '2026-09-22 17:48:40'),
(133, 4, 'Soumission de la demande de congé #6', '127.0.0.1', 3, '2026-09-22 18:26:42', '2026-09-22 18:26:42'),
(134, 2, 'Création de l’employé : Numbi Kabange Guelord', '127.0.0.1', 3, '2026-09-22 18:57:32', '2026-09-22 18:57:32'),
(135, 3, 'Validation de la demande de congé #4 par le Chef Service', '127.0.0.1', 3, '2026-09-22 20:41:05', '2026-09-22 20:41:05'),
(136, 2, 'Validation niveau SecDG de la demande #4', '127.0.0.1', 3, '2026-09-22 22:15:03', '2026-09-22 22:15:03'),
(138, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-22 22:28:06', '2026-09-22 22:28:06'),
(139, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-22 22:28:15', '2026-09-22 22:28:15'),
(140, 1, 'Suppression de tous les historiques sélectionnées par Directeur JONAS', '127.0.0.1', 3, '2026-09-22 22:30:28', '2026-09-22 22:30:28'),
(141, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-23 12:57:16', '2026-09-23 12:57:16'),
(142, 1, 'Mise à jour de l\'utilisateur : Abigael', NULL, 3, '2026-09-23 13:41:19', '2026-09-23 13:41:19'),
(143, 6, 'Mise à jour de l\'utilisateur : Ruth Mputu xxxx', NULL, 3, '2026-09-23 14:47:19', '2026-09-23 14:47:19'),
(144, 6, 'Mise à jour de l\'utilisateur : Ruth Mputu', NULL, 3, '2026-09-23 14:47:26', '2026-09-23 14:47:26'),
(145, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS X', NULL, 3, '2026-09-23 14:48:25', '2026-09-23 14:48:25'),
(146, 1, 'Mise à jour de l\'utilisateur : Directeur JONAS', NULL, 3, '2026-09-23 14:48:35', '2026-09-23 14:48:35'),
(147, 1, 'Mise à jour de l\'utilisateur : Ruth Mputu', NULL, 3, '2026-09-23 15:22:54', '2026-09-23 15:22:54'),
(148, 2, 'Mise à jour de la demande de congé #4', '127.0.0.1', 3, '2026-09-25 12:19:08', '2026-09-25 12:19:08'),
(149, 2, 'Mise à jour de l\'utilisateur : Bliss Ngoie', NULL, 3, '2026-09-25 13:30:31', '2026-09-25 13:30:31'),
(150, 2, 'Mise à jour de l\'utilisateur : Bliss Ngoie', NULL, 3, '2026-09-25 14:16:45', '2026-09-25 14:16:45'),
(151, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 14:17:05', '2026-09-25 14:17:05'),
(152, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 14:17:38', '2026-09-25 14:17:38'),
(153, 4, 'Création du mouvement #2', '127.0.0.1', 3, '2026-09-25 15:33:50', '2026-09-25 15:33:50'),
(154, 2, 'Mise à jour de l\'utilisateur : Bliss Ngoie', NULL, 3, '2026-09-25 15:39:56', '2026-09-25 15:39:56'),
(155, 2, 'Mise à jour de l\'utilisateur : Bliss Ngoie', NULL, 3, '2026-09-25 15:40:22', '2026-09-25 15:40:22'),
(156, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 15:40:28', '2026-09-25 15:40:28'),
(157, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 15:40:47', '2026-09-25 15:40:47'),
(158, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 15:42:07', '2026-09-25 15:42:07'),
(159, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 15:42:23', '2026-09-25 15:42:23'),
(160, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 16:14:40', '2026-09-25 16:14:40'),
(161, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 18:31:37', '2026-09-25 18:31:37'),
(162, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 18:32:00', '2026-09-25 18:32:00'),
(163, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 18:33:29', '2026-09-25 18:33:29'),
(164, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 18:36:28', '2026-09-25 18:36:28'),
(165, 2, 'Mise à jour de l\'utilisateur : Mumba Kisimba Boaz', NULL, 3, '2026-09-25 18:36:43', '2026-09-25 18:36:43'),
(166, 2, 'Mise à jour de l’employé : Sephora Nguz', '127.0.0.1', 3, '2026-09-27 19:10:57', '2026-09-27 19:10:57'),
(167, 2, 'Mise à jour de l’employé : Benjamain Hemedi', '127.0.0.1', 3, '2026-09-27 19:11:10', '2026-09-27 19:11:10'),
(168, 2, 'Mise à jour de l’employé : Benjamain Hemedi', '127.0.0.1', 3, '2026-09-27 19:11:22', '2026-09-27 19:11:22'),
(169, 2, 'Mise à jour de l’employé : Sephora Nguz', '127.0.0.1', 3, '2026-09-27 19:11:37', '2026-09-27 19:11:37'),
(170, 2, 'Mise à jour de l’employé : Allegresse Umba Malaka', '127.0.0.1', 3, '2026-09-27 19:15:54', '2026-09-27 19:15:54'),
(171, 2, 'Mise à jour de l’employé : Baraka Umnba-Nguz', '127.0.0.1', 3, '2026-09-27 19:16:32', '2026-09-27 19:16:32'),
(172, 2, 'Création de l’employé : Mariclaire Nguz', '127.0.0.1', 3, '2026-09-27 19:30:38', '2026-09-27 19:30:38');

-- --------------------------------------------------------

--
-- Structure de la table `interimes`
--

CREATE TABLE `interimes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `interimaire_id` bigint(20) UNSIGNED DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `interimes`
--

INSERT INTO `interimes` (`id`, `employe_id`, `interimaire_id`, `annee_id`, `date_debut`, `date_fin`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 3, NULL, NULL, '2026-09-20 09:24:25', '2026-09-20 11:40:15');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `lectures`
--

CREATE TABLE `lectures` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `communique_id` bigint(20) UNSIGNED NOT NULL,
  `lu` tinyint(1) NOT NULL DEFAULT 0,
  `lu_a` timestamp NULL DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL DEFAULT 3,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `lectures`
--

INSERT INTO `lectures` (`id`, `employe_id`, `communique_id`, `lu`, `lu_a`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 1, 6, 1, '2026-09-15 10:34:52', 3, '2026-09-14 22:39:49', '2026-09-15 10:34:52'),
(3, 1, 8, 0, NULL, 3, '2026-09-14 22:44:41', '2026-09-14 22:44:41'),
(4, 1, 9, 1, '2026-09-15 00:15:47', 3, '2026-09-14 22:47:06', '2026-09-15 00:15:47'),
(5, 2, 9, 0, NULL, 3, '2026-09-14 22:47:06', '2026-09-14 22:47:06'),
(6, 1, 7, 1, '2026-09-15 00:21:36', 3, '2026-09-15 00:20:44', '2026-09-15 00:21:36'),
(7, 2, 7, 0, NULL, 3, '2026-09-15 00:20:44', '2026-09-15 00:20:44');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(121, '0001_01_01_000000_create_users_table', 1),
(122, '0001_01_01_000001_create_cache_table', 1),
(123, '0001_01_01_000002_create_jobs_table', 1),
(124, '2026_09_10_214517_create_annees_table', 1),
(125, '2026_09_10_215308_create_services_table', 1),
(126, '2026_09_10_215328_create_categories_table', 1),
(127, '2026_09_10_215340_create_postes_table', 1),
(128, '2026_09_10_215405_create_employes_table', 1),
(129, '2026_09_10_215515_create_affectations_table', 1),
(130, '2026_09_10_215551_create_dossiers_etudes_table', 1),
(131, '2026_09_10_220031_create_sanctions_table', 1),
(132, '2026_09_10_220052_create_disciplines_table', 1),
(133, '2026_09_10_220852_create_formations_table', 1),
(134, '2026_09_10_220904_create_formation_employes_table', 1),
(135, '2026_09_10_220952_create_audits_table', 1),
(136, '2026_09_10_221140_create_performances_table', 1),
(137, '2026_09_10_221205_create_communiques_table', 1),
(138, '2026_09_10_221236_create_archives_table', 1),
(140, '2026_09_10_221337_create_presences_table', 1),
(141, '2026_09_10_221442_create_conges_table', 1),
(142, '2026_09_10_221556_create_demandes_conges_table', 1),
(143, '2026_09_10_221636_create_proprietes_table', 1),
(144, '2026_09_10_221713_create_contacts_table', 1),
(145, '2026_09_10_221734_create_retours_table', 1),
(146, '2026_09_10_221754_create_historiques_table', 1),
(147, '2026_09_10_223640_create_reglements_table', 1),
(148, '2026_09_10_224650_create_mouvements_table', 1),
(149, '2026_09_10_230650_create_grades_table', 1),
(151, '2026_09_14_232615_create_lectures_table', 2),
(152, '2026_09_20_003728_create_interimes_table', 3),
(153, '2026_09_20_010000_make_interimaire_nullable', 4),
(154, '2026_09_10_221309_create_face_templates_table', 5),
(155, '2026_09_23_000001_rename_dg_role_to_dp', 5);

-- --------------------------------------------------------

--
-- Structure de la table `mouvements`
--

CREATE TABLE `mouvements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mouvement` enum('Entrée','Sortie') NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `heure` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `annee_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `mouvements`
--

INSERT INTO `mouvements` (`id`, `mouvement`, `employe_id`, `heure`, `created_at`, `updated_at`, `annee_id`) VALUES
(1, 'Entrée', 1, '07:00:00', '2026-09-12 20:05:25', '2026-09-12 20:27:17', 3),
(2, 'Sortie', 2, '10:39:00', '2026-09-25 15:33:50', '2026-09-25 15:33:50', 3);

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `performances`
--

CREATE TABLE `performances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `evaluateur_id` bigint(20) UNSIGNED DEFAULT NULL,
  `periode_debut` date NOT NULL,
  `periode_fin` date NOT NULL,
  `objectifs` text DEFAULT NULL,
  `qualite_travail` decimal(5,2) DEFAULT NULL,
  `productivite` decimal(5,2) DEFAULT NULL,
  `ponctualite` decimal(5,2) DEFAULT NULL,
  `assiduite` decimal(5,2) DEFAULT NULL,
  `comportement` decimal(5,2) DEFAULT NULL,
  `travail_equipe` decimal(5,2) DEFAULT NULL,
  `cote_generale` decimal(5,2) DEFAULT NULL,
  `appreciation` text DEFAULT NULL,
  `recommandations` text DEFAULT NULL,
  `statut` enum('brouillon','soumise','validee') NOT NULL DEFAULT 'brouillon',
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `performances`
--

INSERT INTO `performances` (`id`, `employe_id`, `evaluateur_id`, `periode_debut`, `periode_fin`, `objectifs`, `qualite_travail`, `productivite`, `ponctualite`, `assiduite`, `comportement`, `travail_equipe`, `cote_generale`, `appreciation`, `recommandations`, `statut`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-08-01', '2026-08-31', '-', 8.00, 9.50, 0.20, 7.30, 9.00, 6.00, 40.00, 'Excellent', '-', 'brouillon', 3, '2026-09-12 23:37:50', '2026-09-12 23:46:31');

-- --------------------------------------------------------

--
-- Structure de la table `postes`
--

CREATE TABLE `postes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `intitule` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `postes`
--

INSERT INTO `postes` (`id`, `intitule`, `description`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 'Operateur de saisie', 'Prise en charge de saisie.', 3, '2026-09-11 22:50:03', '2026-09-11 22:50:03');

-- --------------------------------------------------------

--
-- Structure de la table `presences`
--

CREATE TABLE `presences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employe_id` bigint(20) UNSIGNED NOT NULL,
  `DATE` date NOT NULL,
  `heure` time NOT NULL,
  `mouvement` enum('entree','sortie') NOT NULL,
  `score_reconnaissance` decimal(6,5) DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `presences`
--

INSERT INTO `presences` (`id`, `employe_id`, `DATE`, `heure`, `mouvement`, `score_reconnaissance`, `annee_id`, `created_at`, `updated_at`) VALUES
(2, 2, '2026-09-25', '09:46:00', 'entree', NULL, 3, '2026-09-25 18:46:37', '2026-09-25 18:59:33'),
(3, 4, '2026-09-27', '22:51:16', 'entree', 0.45532, 3, '2026-09-27 20:51:16', '2026-09-27 20:51:16'),
(4, 4, '2026-09-27', '22:51:47', 'sortie', 0.46255, 3, '2026-09-27 20:51:47', '2026-09-27 20:51:47'),
(5, 3, '2026-09-27', '23:12:35', 'entree', 0.41343, 3, '2026-09-27 21:12:35', '2026-09-27 21:12:35'),
(6, 1, '2026-09-27', '23:15:04', 'entree', 0.57080, 3, '2026-09-27 21:15:04', '2026-09-27 21:15:04'),
(7, 2, '2026-09-27', '23:18:48', 'entree', 0.41634, 3, '2026-09-27 21:18:48', '2026-09-27 21:18:48'),
(8, 1, '2026-09-27', '23:19:03', 'sortie', 0.53237, 3, '2026-09-27 21:19:03', '2026-09-27 21:19:03'),
(9, 2, '2026-09-27', '23:19:21', 'sortie', 0.41138, 3, '2026-09-27 21:19:21', '2026-09-27 21:19:21'),
(10, 3, '2026-09-27', '23:19:51', 'sortie', 0.67043, 3, '2026-09-27 21:19:51', '2026-09-27 21:19:51'),
(11, 4, '2026-09-28', '01:12:32', 'entree', 0.41979, 3, '2026-09-27 23:12:32', '2026-09-27 23:12:32'),
(12, 5, '2026-09-28', '01:12:34', 'entree', 0.47423, 3, '2026-09-27 23:12:34', '2026-09-27 23:12:34'),
(13, 4, '2026-09-28', '01:13:52', 'sortie', 0.46679, 3, '2026-09-27 23:13:52', '2026-09-27 23:13:52');

-- --------------------------------------------------------

--
-- Structure de la table `proprietes`
--

CREATE TABLE `proprietes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titre` varchar(200) NOT NULL,
  `nos_info` text DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `proprietes`
--

INSERT INTO `proprietes` (`id`, `titre`, `nos_info`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 'A propos de nous', 'Nos information...', 3, '2026-09-12 22:04:24', '2026-09-12 22:04:24');

-- --------------------------------------------------------

--
-- Structure de la table `reglements`
--

CREATE TABLE `reglements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero` int(11) NOT NULL,
  `designation` varchar(500) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `titre` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `reglements`
--

INSERT INTO `reglements` (`id`, `numero`, `designation`, `created_at`, `updated_at`, `titre`) VALUES
(1, 1, 'Tout agent est tenu de respecter les heures de travail fixées par la société et de signaler toute absence ou tout retard à son supérieur hiérarchique.', '2026-09-12 22:08:53', '2026-09-12 22:19:25', 'Ponctualité et assiduité :');

-- --------------------------------------------------------

--
-- Structure de la table `retours`
--

CREATE TABLE `retours` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `retour_utilisateur` text NOT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sanctions`
--

CREATE TABLE `sanctions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `designation` varchar(200) NOT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sanctions`
--

INSERT INTO `sanctions` (`id`, `designation`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 'Mise à pied', 3, '2026-09-11 22:47:04', '2026-09-11 22:47:04');

-- --------------------------------------------------------

--
-- Structure de la table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nom_service` varchar(150) NOT NULL,
  `domaine` varchar(150) DEFAULT NULL,
  `annee_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `services`
--

INSERT INTO `services` (`id`, `nom_service`, `domaine`, `annee_id`, `created_at`, `updated_at`) VALUES
(1, 'Supervision de ponctualité', 'Informatique', 3, '2026-09-11 21:19:19', '2026-09-11 21:19:19');

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('CIxQISdd1Pga4MR3HeEp5ky73ezvlC3k1oee41vP', 4, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36 OPR/136.0.0.0', 'eyJfdG9rZW4iOiJNa2QzZlp2N3lnc2s0ZUQwTDhKOHU0Wk1pbVU2YzJUZEFRQVRsVllyIiwidXJsIjp7ImludGVuZGVkIjoiaHR0cDpcL1wvMTI3LjAuMC4xOjgwMDBcL2FjY3VlaWxfZW1wbG95ZSJ9LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvMTI3LjAuMC4xOjgwMDBcL2xlc19wcmVzZW5jZXNfam91cl9jYiIsInJvdXRlIjoibGVzX3ByZXNlbmNlc19qb3VyX2NiIn0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfSwibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiOjR9', 1790551900),
('PWKw6DomLMFTYAnky4ZIrKzLESfnwfptIAuoC7hq', 2, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0', 'eyJfdG9rZW4iOiJFOTN3T3RiRXNqVWVyWENMczcxVXNkYXZDdERMYUNYUWVpZXR3Qzg0IiwidXJsIjp7ImludGVuZGVkIjoiaHR0cDpcL1wvMTI3LjAuMC4xOjgwMDBcL2xlc19lbXBsb3llc19TRyJ9LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvMTI3LjAuMC4xOjgwMDBcL2xlc19wcmVzZW5jZXNfU0ciLCJyb3V0ZSI6Imxlc19wcmVzZW5jZXNfU0cifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6Mn0=', 1790551422);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `annee_id` bigint(20) DEFAULT NULL,
  `autorisation` tinyint(1) NOT NULL DEFAULT 0,
  `matricule` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `role`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `annee_id`, `autorisation`, `matricule`) VALUES
(1, 'Directeur JONAS', 'DP', 'dg@gmail.com', NULL, '$2y$12$U9xAv2VFC2.YnBuuAkRg2O/P24SZJPvtVSwJV2gxjFhZufBzKOo1u', NULL, '2026-09-10 23:09:11', '2026-09-23 14:48:35', 3, 0, NULL),
(2, 'Abigael', 'SecDG', 'aby@gmail.com', NULL, '$2y$12$HXeEfAjyQIRdg6.QvOP3H.jpyKPIVH7WnYzRkdkJp7JZIUdIUq6CC', NULL, '2026-09-12 22:53:43', '2026-09-23 13:41:19', 3, 1, NULL),
(3, 'numbi', 'Chef-Service', 'numbi@gmail.com', NULL, '$2y$12$eDrpBbWEa7V.gUGqD8aO2.JTCxklN3hwAyZfPr4lUNmzVQaZxKSQ.', NULL, '2026-09-13 20:41:49', '2026-09-13 21:59:01', 3, 1, NULL),
(4, 'Mumba Kisimba Boaz', 'Chef-Bureau1', 'boaz@gmail.com', NULL, '$2y$12$DMKCJBBilTe5HC2nIMA6huyZctOs.lZhXOPWp2xkPa8s/CLBkgry.', NULL, '2026-09-13 23:16:22', '2026-09-25 18:36:43', NULL, 1, '201'),
(5, 'Benjamain Hemedi', 'Employe', 'ben@gmail.com', NULL, '$2y$12$Hc2z757QR.8Jy2ntdcBpp.vbsQzJCiFwHI.AT0/0ogAnnxRfnyNTC', 'XbnIy4pNQVih4Tif9NiNtUAm51P80eNi9yPYQdSWESIz6VqTrE0rVtcq3BxX', '2026-09-14 22:45:34', '2026-09-14 22:45:34', NULL, 0, '202'),
(6, 'Ruth Mputu', 'Chef-Division', 'ruth@gmail.com', NULL, '$2y$12$3vUWj24NvQ6CP8j0ebw2vO.fP5N2hclohttQaDzWI42xnVqmD3fUW', NULL, '2026-09-15 19:17:22', '2026-09-23 15:22:54', NULL, 1, NULL),
(7, 'Bliss Ngoie', 'Chef-Bureau2', 'bliss@gmail.com', NULL, '$2y$12$/ko.Qon00jwnUiajil3xw.4/0eMVJxm/E.lVx2mjfeN.3LnnsbSxi', NULL, '2026-09-15 20:18:57', '2026-09-25 15:40:22', NULL, 0, '203');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `affectations`
--
ALTER TABLE `affectations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `affectations_employe_id_foreign` (`employe_id`),
  ADD KEY `affectations_service_id_foreign` (`service_id`),
  ADD KEY `affectations_categorie_id_foreign` (`categorie_id`),
  ADD KEY `affectations_poste_id_foreign` (`poste_id`),
  ADD KEY `affectations_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `annees`
--
ALTER TABLE `annees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `annees_annee_unique` (`annee`);

--
-- Index pour la table `archives`
--
ALTER TABLE `archives`
  ADD PRIMARY KEY (`id`),
  ADD KEY `archives_employe_id_foreign` (`employe_id`),
  ADD KEY `archives_archive_par_foreign` (`archive_par`),
  ADD KEY `archives_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `audits`
--
ALTER TABLE `audits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audits_employe_id_foreign` (`employe_id`),
  ADD KEY `audits_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Index pour la table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `communiques`
--
ALTER TABLE `communiques`
  ADD PRIMARY KEY (`id`),
  ADD KEY `communiques_user_id_foreign` (`user_id`),
  ADD KEY `communiques_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `conges`
--
ALTER TABLE `conges`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conges_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `demandes_conges`
--
ALTER TABLE `demandes_conges`
  ADD PRIMARY KEY (`id`),
  ADD KEY `demandes_conges_employe_id_foreign` (`employe_id`),
  ADD KEY `demandes_conges_conge_id_foreign` (`conge_id`),
  ADD KEY `demandes_conges_valide_par_foreign` (`valide_par`),
  ADD KEY `demandes_conges_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `disciplines`
--
ALTER TABLE `disciplines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `disciplines_employe_id_foreign` (`employe_id`),
  ADD KEY `disciplines_sanction_id_foreign` (`sanction_id`),
  ADD KEY `disciplines_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `dossiers_etude`
--
ALTER TABLE `dossiers_etude`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dossiers_etude_annee_id_foreign` (`annee_id`),
  ADD KEY `dossiers_etude_employe_id_foreign` (`employe_id`);

--
-- Index pour la table `employes`
--
ALTER TABLE `employes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employes_matricule_unique` (`matricule`),
  ADD KEY `employes_user_id_foreign` (`user_id`),
  ADD KEY `employes_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `face_templates`
--
ALTER TABLE `face_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `face_templates_employe_id_foreign` (`employe_id`),
  ADD KEY `face_templates_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `formations`
--
ALTER TABLE `formations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `formations_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `formation_employes`
--
ALTER TABLE `formation_employes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `formation_employes_formation_id_foreign` (`formation_id`),
  ADD KEY `formation_employes_employe_id_foreign` (`employe_id`),
  ADD KEY `formation_employes_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `historiques`
--
ALTER TABLE `historiques`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historiques_user_id_foreign` (`user_id`),
  ADD KEY `historiques_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `interimes`
--
ALTER TABLE `interimes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `interimes_employe_id_foreign` (`employe_id`),
  ADD KEY `interimes_interimaire_id_foreign` (`interimaire_id`),
  ADD KEY `interimes_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Index pour la table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lectures`
--
ALTER TABLE `lectures`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `mouvements`
--
ALTER TABLE `mouvements`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `performances`
--
ALTER TABLE `performances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `performances_employe_id_foreign` (`employe_id`),
  ADD KEY `performances_evaluateur_id_foreign` (`evaluateur_id`),
  ADD KEY `performances_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `postes`
--
ALTER TABLE `postes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `postes_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `presences`
--
ALTER TABLE `presences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `presences_employe_id_foreign` (`employe_id`),
  ADD KEY `presences_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `proprietes`
--
ALTER TABLE `proprietes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proprietes_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `reglements`
--
ALTER TABLE `reglements`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `retours`
--
ALTER TABLE `retours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `retours_user_id_foreign` (`user_id`),
  ADD KEY `retours_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `sanctions`
--
ALTER TABLE `sanctions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sanctions_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_annee_id_foreign` (`annee_id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `affectations`
--
ALTER TABLE `affectations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `annees`
--
ALTER TABLE `annees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `archives`
--
ALTER TABLE `archives`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `audits`
--
ALTER TABLE `audits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `communiques`
--
ALTER TABLE `communiques`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `conges`
--
ALTER TABLE `conges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `demandes_conges`
--
ALTER TABLE `demandes_conges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `disciplines`
--
ALTER TABLE `disciplines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `dossiers_etude`
--
ALTER TABLE `dossiers_etude`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `employes`
--
ALTER TABLE `employes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `face_templates`
--
ALTER TABLE `face_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `formations`
--
ALTER TABLE `formations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `formation_employes`
--
ALTER TABLE `formation_employes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `grades`
--
ALTER TABLE `grades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `historiques`
--
ALTER TABLE `historiques`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT pour la table `interimes`
--
ALTER TABLE `interimes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `lectures`
--
ALTER TABLE `lectures`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT pour la table `mouvements`
--
ALTER TABLE `mouvements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `performances`
--
ALTER TABLE `performances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `postes`
--
ALTER TABLE `postes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `presences`
--
ALTER TABLE `presences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `proprietes`
--
ALTER TABLE `proprietes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `reglements`
--
ALTER TABLE `reglements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `retours`
--
ALTER TABLE `retours`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `sanctions`
--
ALTER TABLE `sanctions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `affectations`
--
ALTER TABLE `affectations`
  ADD CONSTRAINT `affectations_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `affectations_categorie_id_foreign` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `affectations_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`),
  ADD CONSTRAINT `affectations_poste_id_foreign` FOREIGN KEY (`poste_id`) REFERENCES `postes` (`id`),
  ADD CONSTRAINT `affectations_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Contraintes pour la table `archives`
--
ALTER TABLE `archives`
  ADD CONSTRAINT `archives_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `archives_archive_par_foreign` FOREIGN KEY (`archive_par`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `archives_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`);

--
-- Contraintes pour la table `audits`
--
ALTER TABLE `audits`
  ADD CONSTRAINT `audits_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `audits_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`);

--
-- Contraintes pour la table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`);

--
-- Contraintes pour la table `communiques`
--
ALTER TABLE `communiques`
  ADD CONSTRAINT `communiques_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `communiques_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `conges`
--
ALTER TABLE `conges`
  ADD CONSTRAINT `conges_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`);

--
-- Contraintes pour la table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`);

--
-- Contraintes pour la table `demandes_conges`
--
ALTER TABLE `demandes_conges`
  ADD CONSTRAINT `demandes_conges_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `demandes_conges_conge_id_foreign` FOREIGN KEY (`conge_id`) REFERENCES `conges` (`id`),
  ADD CONSTRAINT `demandes_conges_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`),
  ADD CONSTRAINT `demandes_conges_valide_par_foreign` FOREIGN KEY (`valide_par`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `disciplines`
--
ALTER TABLE `disciplines`
  ADD CONSTRAINT `disciplines_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `disciplines_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`),
  ADD CONSTRAINT `disciplines_sanction_id_foreign` FOREIGN KEY (`sanction_id`) REFERENCES `sanctions` (`id`);

--
-- Contraintes pour la table `dossiers_etude`
--
ALTER TABLE `dossiers_etude`
  ADD CONSTRAINT `dossiers_etude_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `dossiers_etude_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`);

--
-- Contraintes pour la table `employes`
--
ALTER TABLE `employes`
  ADD CONSTRAINT `employes_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `employes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `face_templates`
--
ALTER TABLE `face_templates`
  ADD CONSTRAINT `face_templates_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `face_templates_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`);

--
-- Contraintes pour la table `formations`
--
ALTER TABLE `formations`
  ADD CONSTRAINT `formations_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`);

--
-- Contraintes pour la table `formation_employes`
--
ALTER TABLE `formation_employes`
  ADD CONSTRAINT `formation_employes_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `formation_employes_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`),
  ADD CONSTRAINT `formation_employes_formation_id_foreign` FOREIGN KEY (`formation_id`) REFERENCES `formations` (`id`);

--
-- Contraintes pour la table `historiques`
--
ALTER TABLE `historiques`
  ADD CONSTRAINT `historiques_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `historiques_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `interimes`
--
ALTER TABLE `interimes`
  ADD CONSTRAINT `interimes_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `interimes_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`),
  ADD CONSTRAINT `interimes_interimaire_id_foreign` FOREIGN KEY (`interimaire_id`) REFERENCES `employes` (`id`);

--
-- Contraintes pour la table `performances`
--
ALTER TABLE `performances`
  ADD CONSTRAINT `performances_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `performances_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`),
  ADD CONSTRAINT `performances_evaluateur_id_foreign` FOREIGN KEY (`evaluateur_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `postes`
--
ALTER TABLE `postes`
  ADD CONSTRAINT `postes_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`);

--
-- Contraintes pour la table `presences`
--
ALTER TABLE `presences`
  ADD CONSTRAINT `presences_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `presences_employe_id_foreign` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`);

--
-- Contraintes pour la table `proprietes`
--
ALTER TABLE `proprietes`
  ADD CONSTRAINT `proprietes_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`);

--
-- Contraintes pour la table `retours`
--
ALTER TABLE `retours`
  ADD CONSTRAINT `retours_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`),
  ADD CONSTRAINT `retours_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `sanctions`
--
ALTER TABLE `sanctions`
  ADD CONSTRAINT `sanctions_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`);

--
-- Contraintes pour la table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_annee_id_foreign` FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
