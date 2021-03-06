-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  lun. 24 sep. 2018 à 11:51
-- Version du serveur :  5.7.21
-- Version de PHP :  5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `miniboys`
--

-- --------------------------------------------------------

--
-- Structure de la table `campagne`
--

DROP TABLE IF EXISTS `campagne`;
CREATE TABLE IF NOT EXISTS `campagne` (
  `id_campagne` int(11) NOT NULL AUTO_INCREMENT,
  `xp_gagne` int(11) NOT NULL,
  `niveau` int(11) NOT NULL,
  `id_ennemi` int(11) NOT NULL,
  `resolu` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_campagne`),
  UNIQUE KEY `campagne_AK` (`niveau`),
  KEY `campagne_ennemi0_FK` (`id_ennemi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `campagne`
--

INSERT INTO `campagne` (`id_campagne`, `xp_gagne`, `niveau`, `id_ennemi`, `resolu`) VALUES
(1, 100, 1, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ennemi`
--

DROP TABLE IF EXISTS `ennemi`;
CREATE TABLE IF NOT EXISTS `ennemi` (
  `id_ennemi` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `attaque` int(11) NOT NULL,
  `defense` int(11) NOT NULL,
  `vie` int(11) NOT NULL,
  `critique` int(11) NOT NULL,
  PRIMARY KEY (`id_ennemi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `ennemi`
--

INSERT INTO `ennemi` (`id_ennemi`, `nom`, `attaque`, `defense`, `vie`, `critique`) VALUES
(1, 'coccinelle', 1, 1, 10, 1);

-- --------------------------------------------------------

--
-- Structure de la table `equipement`
--

DROP TABLE IF EXISTS `equipement`;
CREATE TABLE IF NOT EXISTS `equipement` (
  `id_equipement` int(11) NOT NULL AUTO_INCREMENT,
  `nom_equipement` varchar(200) NOT NULL,
  `attaque` int(11) NOT NULL,
  `defense` int(11) NOT NULL,
  `vie` int(11) NOT NULL,
  `critique` int(11) NOT NULL,
  `level_min` int(11) NOT NULL,
  `pour_loot` int(11) NOT NULL,
  PRIMARY KEY (`id_equipement`),
  UNIQUE KEY `nom_equipement` (`nom_equipement`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `equipement`
--

INSERT INTO `equipement` (`id_equipement`, `nom_equipement`, `attaque`, `defense`, `vie`, `critique`, `level_min`, `pour_loot`) VALUES
(1, 'épée coccinelle', 2, 0, 0, 0, 1, 50);

-- --------------------------------------------------------

--
-- Structure de la table `inventaire`
--

DROP TABLE IF EXISTS `inventaire`;
CREATE TABLE IF NOT EXISTS `inventaire` (
  `id_inventaire` int(11) NOT NULL AUTO_INCREMENT,
  `id_personnage` int(11) NOT NULL,
  `id_equipement` int(11) NOT NULL,
  PRIMARY KEY (`id_inventaire`),
  KEY `inventaire_personnage0_FK` (`id_personnage`),
  KEY `inventaire_equipement1_FK` (`id_equipement`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `personnage`
--

DROP TABLE IF EXISTS `personnage`;
CREATE TABLE IF NOT EXISTS `personnage` (
  `id_personnage` int(11) NOT NULL AUTO_INCREMENT,
  `nb_xp` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `sexe` int(11) NOT NULL,
  `attaque` int(11) NOT NULL,
  `defense` int(11) NOT NULL,
  `vie` int(11) NOT NULL,
  `critique` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id_personnage`),
  UNIQUE KEY `personnage_utilisateur0_AK` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `relation_equipement_campagne`
--

DROP TABLE IF EXISTS `relation_equipement_campagne`;
CREATE TABLE IF NOT EXISTS `relation_equipement_campagne` (
  `id_campagne` int(11) NOT NULL,
  `id_equipement` int(11) NOT NULL,
  PRIMARY KEY (`id_campagne`,`id_equipement`),
  KEY `relation_equipement_campagne_equipement1_FK` (`id_equipement`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(250) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `utilisateur_AK0` (`username`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `campagne`
--
ALTER TABLE `campagne`
  ADD CONSTRAINT `campagne_ennemi0_FK` FOREIGN KEY (`id_ennemi`) REFERENCES `ennemi` (`id_ennemi`);

--
-- Contraintes pour la table `inventaire`
--
ALTER TABLE `inventaire`
  ADD CONSTRAINT `inventaire_equipement1_FK` FOREIGN KEY (`id_equipement`) REFERENCES `equipement` (`id_equipement`),
  ADD CONSTRAINT `inventaire_personnage0_FK` FOREIGN KEY (`id_personnage`) REFERENCES `personnage` (`id_personnage`);

--
-- Contraintes pour la table `personnage`
--
ALTER TABLE `personnage`
  ADD CONSTRAINT `personnage_utilisateur0_FK` FOREIGN KEY (`id_utilisateur`) REFERENCES `users` (`id_utilisateur`);

--
-- Contraintes pour la table `relation_equipement_campagne`
--
ALTER TABLE `relation_equipement_campagne`
  ADD CONSTRAINT `relation_equipement_campagne_campagne0_FK` FOREIGN KEY (`id_campagne`) REFERENCES `campagne` (`id_campagne`),
  ADD CONSTRAINT `relation_equipement_campagne_equipement1_FK` FOREIGN KEY (`id_equipement`) REFERENCES `equipement` (`id_equipement`);


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
