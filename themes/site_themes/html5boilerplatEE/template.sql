-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 05, 2011 at 10:42 AM
-- Server version: 5.0.92
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


-- --------------------------------------------------------

--
-- Table structure for table `exp_accessories`
--

CREATE TABLE IF NOT EXISTS `exp_accessories` (
  `accessory_id` int(10) unsigned NOT NULL auto_increment,
  `class` varchar(75) NOT NULL default '',
  `member_groups` varchar(50) NOT NULL default 'all',
  `controllers` text,
  `accessory_version` varchar(12) NOT NULL,
  PRIMARY KEY  (`accessory_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_accessories`
--

INSERT INTO `exp_accessories` (`accessory_id`, `class`, `member_groups`, `controllers`, `accessory_version`) VALUES
(1, 'Expressionengine_info_acc', '1|5', 'content_files_modal|design|tools_communicate|tools_data|tools|homepage|admin_content|addons_plugins|content_files|content_edit|addons|tools_logs|addons_extensions|admin_system|addons_modules|tools_utilities|addons_accessories|content|content_publish|myaccount|addons_fieldtypes|members', '1.0');

-- --------------------------------------------------------

--
-- Table structure for table `exp_actions`
--

CREATE TABLE IF NOT EXISTS `exp_actions` (
  `action_id` int(4) unsigned NOT NULL auto_increment,
  `class` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  PRIMARY KEY  (`action_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `exp_actions`
--

INSERT INTO `exp_actions` (`action_id`, `class`, `method`) VALUES
(1, 'Safecracker', 'submit_entry'),
(2, 'Safecracker', 'combo_loader'),
(3, 'Channel', 'insert_new_entry'),
(4, 'Channel', 'filemanager_endpoint'),
(5, 'Channel', 'smiley_pop'),
(6, 'Member', 'registration_form'),
(7, 'Member', 'register_member'),
(8, 'Member', 'activate_member'),
(9, 'Member', 'member_login'),
(10, 'Member', 'member_logout'),
(11, 'Member', 'retrieve_password'),
(12, 'Member', 'reset_password'),
(13, 'Member', 'send_member_email'),
(14, 'Member', 'update_un_pw'),
(15, 'Member', 'member_search'),
(16, 'Member', 'member_delete'),
(17, 'Email', 'send_email'),
(18, 'Comment', 'insert_new_comment'),
(19, 'Comment_mcp', 'delete_comment_notification'),
(20, 'Comment', 'comment_subscribe'),
(21, 'Comment', 'edit_comment'),
(22, 'Search', 'do_search'),
(23, 'Mailinglist', 'insert_new_email'),
(24, 'Mailinglist', 'authorize_email'),
(25, 'Mailinglist', 'unsubscribe'),
(26, 'Freeform', 'insert_new_entry'),
(27, 'Freeform', 'retrieve_entries'),
(28, 'Freeform', 'delete_freeform_notification');

-- --------------------------------------------------------

--
-- Table structure for table `exp_captcha`
--

CREATE TABLE IF NOT EXISTS `exp_captcha` (
  `captcha_id` bigint(13) unsigned NOT NULL auto_increment,
  `date` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL default '0',
  `word` varchar(20) NOT NULL,
  PRIMARY KEY  (`captcha_id`),
  KEY `word` (`word`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_captcha`
--

INSERT INTO `exp_captcha` (`captcha_id`, `date`, `ip_address`, `word`) VALUES
(1, 1317803251, '81.149.49.226', 'research49');

-- --------------------------------------------------------

--
-- Table structure for table `exp_categories`
--

CREATE TABLE IF NOT EXISTS `exp_categories` (
  `cat_id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_id` int(6) unsigned NOT NULL,
  `parent_id` int(4) unsigned NOT NULL,
  `cat_name` varchar(100) NOT NULL,
  `cat_url_title` varchar(75) NOT NULL,
  `cat_description` text,
  `cat_image` varchar(120) default NULL,
  `cat_order` int(4) unsigned NOT NULL,
  PRIMARY KEY  (`cat_id`),
  KEY `group_id` (`group_id`),
  KEY `cat_name` (`cat_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `exp_categories`
--

INSERT INTO `exp_categories` (`cat_id`, `site_id`, `group_id`, `parent_id`, `cat_name`, `cat_url_title`, `cat_description`, `cat_image`, `cat_order`) VALUES
(1, 1, 1, 0, 'News', 'news', '', '', 1),
(2, 1, 1, 0, 'Press', 'press', '', '', 2);

-- --------------------------------------------------------

--
-- Table structure for table `exp_category_fields`
--

CREATE TABLE IF NOT EXISTS `exp_category_fields` (
  `field_id` int(6) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_id` int(4) unsigned NOT NULL,
  `field_name` varchar(32) NOT NULL default '',
  `field_label` varchar(50) NOT NULL default '',
  `field_type` varchar(12) NOT NULL default 'text',
  `field_list_items` text NOT NULL,
  `field_maxl` smallint(3) NOT NULL default '128',
  `field_ta_rows` tinyint(2) NOT NULL default '8',
  `field_default_fmt` varchar(40) NOT NULL default 'none',
  `field_show_fmt` char(1) NOT NULL default 'y',
  `field_text_direction` char(3) NOT NULL default 'ltr',
  `field_required` char(1) NOT NULL default 'n',
  `field_order` int(3) unsigned NOT NULL,
  PRIMARY KEY  (`field_id`),
  KEY `site_id` (`site_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_category_field_data`
--

CREATE TABLE IF NOT EXISTS `exp_category_field_data` (
  `cat_id` int(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_id` int(4) unsigned NOT NULL,
  PRIMARY KEY  (`cat_id`),
  KEY `site_id` (`site_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_category_field_data`
--

INSERT INTO `exp_category_field_data` (`cat_id`, `site_id`, `group_id`) VALUES
(1, 1, 1),
(2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `exp_category_groups`
--

CREATE TABLE IF NOT EXISTS `exp_category_groups` (
  `group_id` int(6) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_name` varchar(50) NOT NULL,
  `sort_order` char(1) NOT NULL default 'a',
  `field_html_formatting` char(4) NOT NULL default 'all',
  `can_edit_categories` text,
  `can_delete_categories` text,
  PRIMARY KEY  (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_category_groups`
--

INSERT INTO `exp_category_groups` (`group_id`, `site_id`, `group_name`, `sort_order`, `field_html_formatting`, `can_edit_categories`, `can_delete_categories`) VALUES
(1, 1, 'Blog', 'a', 'all', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `exp_category_posts`
--

CREATE TABLE IF NOT EXISTS `exp_category_posts` (
  `entry_id` int(10) unsigned NOT NULL,
  `cat_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`entry_id`,`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_category_posts`
--

INSERT INTO `exp_category_posts` (`entry_id`, `cat_id`) VALUES
(3, 2),
(6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `exp_channels`
--

CREATE TABLE IF NOT EXISTS `exp_channels` (
  `channel_id` int(6) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `channel_name` varchar(40) NOT NULL,
  `channel_title` varchar(100) NOT NULL,
  `channel_url` varchar(100) NOT NULL,
  `channel_description` varchar(225) default NULL,
  `channel_lang` varchar(12) NOT NULL,
  `total_entries` mediumint(8) NOT NULL default '0',
  `total_comments` mediumint(8) NOT NULL default '0',
  `last_entry_date` int(10) unsigned NOT NULL default '0',
  `last_comment_date` int(10) unsigned NOT NULL default '0',
  `cat_group` varchar(255) default NULL,
  `status_group` int(4) unsigned default NULL,
  `deft_status` varchar(50) NOT NULL default 'open',
  `field_group` int(4) unsigned default NULL,
  `search_excerpt` int(4) unsigned default NULL,
  `deft_category` varchar(60) default NULL,
  `deft_comments` char(1) NOT NULL default 'y',
  `channel_require_membership` char(1) NOT NULL default 'y',
  `channel_max_chars` int(5) unsigned default NULL,
  `channel_html_formatting` char(4) NOT NULL default 'all',
  `channel_allow_img_urls` char(1) NOT NULL default 'y',
  `channel_auto_link_urls` char(1) NOT NULL default 'y',
  `channel_notify` char(1) NOT NULL default 'n',
  `channel_notify_emails` varchar(255) default NULL,
  `comment_url` varchar(80) default NULL,
  `comment_system_enabled` char(1) NOT NULL default 'y',
  `comment_require_membership` char(1) NOT NULL default 'n',
  `comment_use_captcha` char(1) NOT NULL default 'n',
  `comment_moderate` char(1) NOT NULL default 'n',
  `comment_max_chars` int(5) unsigned default '5000',
  `comment_timelock` int(5) unsigned NOT NULL default '0',
  `comment_require_email` char(1) NOT NULL default 'y',
  `comment_text_formatting` char(5) NOT NULL default 'xhtml',
  `comment_html_formatting` char(4) NOT NULL default 'safe',
  `comment_allow_img_urls` char(1) NOT NULL default 'n',
  `comment_auto_link_urls` char(1) NOT NULL default 'y',
  `comment_notify` char(1) NOT NULL default 'n',
  `comment_notify_authors` char(1) NOT NULL default 'n',
  `comment_notify_emails` varchar(255) default NULL,
  `comment_expiration` int(4) unsigned NOT NULL default '0',
  `search_results_url` varchar(80) default NULL,
  `ping_return_url` varchar(80) default NULL,
  `show_button_cluster` char(1) NOT NULL default 'y',
  `rss_url` varchar(80) default NULL,
  `enable_versioning` char(1) NOT NULL default 'n',
  `max_revisions` smallint(4) unsigned NOT NULL default '10',
  `default_entry_title` varchar(100) default NULL,
  `url_title_prefix` varchar(80) default NULL,
  `live_look_template` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`channel_id`),
  KEY `cat_group` (`cat_group`),
  KEY `status_group` (`status_group`),
  KEY `field_group` (`field_group`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `exp_channels`
--

INSERT INTO `exp_channels` (`channel_id`, `site_id`, `channel_name`, `channel_title`, `channel_url`, `channel_description`, `channel_lang`, `total_entries`, `total_comments`, `last_entry_date`, `last_comment_date`, `cat_group`, `status_group`, `deft_status`, `field_group`, `search_excerpt`, `deft_category`, `deft_comments`, `channel_require_membership`, `channel_max_chars`, `channel_html_formatting`, `channel_allow_img_urls`, `channel_auto_link_urls`, `channel_notify`, `channel_notify_emails`, `comment_url`, `comment_system_enabled`, `comment_require_membership`, `comment_use_captcha`, `comment_moderate`, `comment_max_chars`, `comment_timelock`, `comment_require_email`, `comment_text_formatting`, `comment_html_formatting`, `comment_allow_img_urls`, `comment_auto_link_urls`, `comment_notify`, `comment_notify_authors`, `comment_notify_emails`, `comment_expiration`, `search_results_url`, `ping_return_url`, `show_button_cluster`, `rss_url`, `enable_versioning`, `max_revisions`, `default_entry_title`, `url_title_prefix`, `live_look_template`) VALUES
(1, 1, 'about', 'About', '/about', '', 'en', 3, 0, 1281569808, 0, NULL, 1, 'open', 1, 1, '', 'y', 'y', NULL, 'all', 'y', 'y', 'n', '', '/about', 'y', 'n', 'n', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', '', 0, '/about', '', 'y', '', 'n', 10, '', '', 0),
(2, 1, 'blog', 'Blog', '/blog/comments', '', 'en', 2, 2, 1281568111, 1282613638, '1', 1, 'open', 3, 2, '', 'y', 'y', NULL, 'all', 'y', 'y', 'n', '', '/blog/comments', 'y', 'n', 'n', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', '', 0, '/blog/comments', '', 'y', '/blog/rss', 'n', 10, '', '', 0),
(5, 1, 'static-content', 'Static Content', '', '', 'en', 0, 0, 0, 0, NULL, 1, 'open', 4, 8, '', 'y', 'y', NULL, 'all', 'y', 'y', 'n', '', '', 'y', 'n', 'n', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', '', 0, '', '', 'y', '', 'n', 10, '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_data`
--

CREATE TABLE IF NOT EXISTS `exp_channel_data` (
  `entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL default '1',
  `channel_id` int(4) unsigned NOT NULL,
  `field_id_1` text,
  `field_ft_1` tinytext,
  `field_id_2` text,
  `field_ft_2` tinytext,
  `field_id_8` text,
  `field_ft_8` tinytext,
  PRIMARY KEY  (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_channel_data`
--

INSERT INTO `exp_channel_data` (`entry_id`, `site_id`, `channel_id`, `field_id_1`, `field_ft_1`, `field_id_2`, `field_ft_2`, `field_id_8`, `field_ft_8`) VALUES
(3, 1, 2, '', NULL, 'But Ahab''s glance was averted; like a blighted fruit tree he shook, and cast his last, cindered apple to the soil. "What is it, what nameless, inscrutable, unearthly thing is it; what cozening, hidden lord and master, and cruel, remorseless emperor commands me; that against all natural lovings and longings, I so keep pushing, and crowding, and jamming myself on all the time; recklessly making me ready to do what in my own proper, natural heart, I durst not so much as dare? Is Ahab, Ahab? Is it I, God, or who, that lifts this arm? But if the great sun move not of himself; but is as an errand-boy in heaven; nor one single star can revolve, but by some invisible power; how then can this one small heart beat; this one small brain think thoughts; unless God does that beating, does that thinking, does that living, and not I. By heaven, man, we are turned round and round in this world, like yonder windlass, and Fate is the handspike. And all the time, lo! that smiling sky,', 'xhtml', '', NULL),
(6, 1, 2, '', NULL, 'But Ahab''s glance was averted; like a blighted fruit tree he shook, and cast his last, cindered apple to the soil. "What is it, what nameless, inscrutable, unearthly thing is it; what cozening, hidden lord and master, and cruel, remorseless emperor commands me; that against all natural lovings and longings, I so keep pushing, and crowding, and jamming myself on all the time; recklessly making me ready to do what in my own proper, natural heart, I durst not so much as dare? \n\nIs Ahab, Ahab? Is it I, God, or who, that lifts this arm? But if the great sun move not of himself; but is as an errand-boy in heaven; nor one single star can revolve, but by some invisible power; how then can this one small heart beat; this one small brain think thoughts; unless God does that beating, does that thinking, does that living, and not I. By heaven, man, we are turned round and round in this world, like yonder windlass, and Fate is the handspike. And all the time, lo! that smiling sky,', 'xhtml', '', NULL),
(7, 1, 1, 'But Ahab''s glance was averted; like a blighted fruit tree he shook, and cast his last, cindered apple to the soil. "What is it, what nameless, inscrutable, unearthly thing is it; what cozening, hidden lord and master, and cruel, remorseless emperor commands me; that against all natural lovings and longings, I so keep pushing, and crowding, and jamming myself on all the time; recklessly making me ready to do what in my own proper, natural heart, I durst not so much as dare? Is Ahab, Ahab? Is it I, God, or who, that lifts this arm? But if the great sun move not of himself; but is as an errand-boy in heaven; nor one single star can revolve, but by some invisible power; how then can this one small heart beat; this one small brain think thoughts; unless God does that beating, does that thinking, does that living, and not I. By heaven, man, we are turned round and round in this world, like yonder windlass, and Fate is the handspike. And all the time, lo! that smiling sky,', 'xhtml', '', NULL, '', NULL),
(8, 1, 1, 'But Ahab''s glance was averted; like a blighted fruit tree he shook, and cast his last, cindered apple to the soil. "What is it, what nameless, inscrutable, unearthly thing is it; what cozening, hidden lord and master, and cruel, remorseless emperor commands me; that against all natural lovings and longings, I so keep pushing, and crowding, and jamming myself on all the time; recklessly making me ready to do what in my own proper, natural heart, I durst not so much as dare? Is Ahab, Ahab? Is it I, God, or who, that lifts this arm? But if the great sun move not of himself; but is as an errand-boy in heaven; nor one single star can revolve, but by some invisible power; how then can this one small heart beat; this one small brain think thoughts; unless God does that beating, does that thinking, does that living, and not I. By heaven, man, we are turned round and round in this world, like yonder windlass, and Fate is the handspike. And all the time, lo! that smiling sky,', 'xhtml', '', NULL, '', NULL),
(9, 1, 1, 'Maybe add some help text here...\n\nBut Ahab''s glance was averted; like a blighted fruit tree he shook, and cast his last, cindered apple to the soil. "What is it, what nameless, inscrutable, unearthly thing is it; what cozening, hidden lord and master, and cruel, remorseless emperor commands me; that against all natural lovings and longings, I so keep pushing, and crowding, and jamming myself on all the time; recklessly making me ready to do what in my own proper, natural heart, I durst not so much as dare? Is Ahab, Ahab? Is it I, God, or who, that lifts this arm? But if the great sun move not of himself; but is as an errand-boy in heaven; nor one single star can revolve, but by some invisible power; how then can this one small heart beat; this one small brain think thoughts; unless God does that beating, does that thinking, does that living, and not I. By heaven, man, we are turned round and round in this world, like yonder windlass, and Fate is the handspike. And all the time, lo! that smiling sky,', 'xhtml', '', NULL, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_entries_autosave`
--

CREATE TABLE IF NOT EXISTS `exp_channel_entries_autosave` (
  `entry_id` int(10) unsigned NOT NULL auto_increment,
  `original_entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL default '1',
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL default '0',
  `pentry_id` int(10) NOT NULL default '0',
  `forum_topic_id` int(10) unsigned default NULL,
  `ip_address` varchar(16) NOT NULL,
  `title` varchar(100) NOT NULL,
  `url_title` varchar(75) NOT NULL,
  `status` varchar(50) NOT NULL,
  `versioning_enabled` char(1) NOT NULL default 'n',
  `view_count_one` int(10) unsigned NOT NULL default '0',
  `view_count_two` int(10) unsigned NOT NULL default '0',
  `view_count_three` int(10) unsigned NOT NULL default '0',
  `view_count_four` int(10) unsigned NOT NULL default '0',
  `allow_comments` varchar(1) NOT NULL default 'y',
  `sticky` varchar(1) NOT NULL default 'n',
  `entry_date` int(10) NOT NULL,
  `dst_enabled` varchar(1) NOT NULL default 'n',
  `year` char(4) NOT NULL,
  `month` char(2) NOT NULL,
  `day` char(3) NOT NULL,
  `expiration_date` int(10) NOT NULL default '0',
  `comment_expiration_date` int(10) NOT NULL default '0',
  `edit_date` bigint(14) default NULL,
  `recent_comment_date` int(10) default NULL,
  `comment_total` int(4) unsigned NOT NULL default '0',
  `entry_data` text,
  PRIMARY KEY  (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `author_id` (`author_id`),
  KEY `url_title` (`url_title`),
  KEY `status` (`status`),
  KEY `entry_date` (`entry_date`),
  KEY `expiration_date` (`expiration_date`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_fields`
--

CREATE TABLE IF NOT EXISTS `exp_channel_fields` (
  `field_id` int(6) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_id` int(4) unsigned NOT NULL,
  `field_name` varchar(32) NOT NULL,
  `field_label` varchar(50) NOT NULL,
  `field_instructions` text,
  `field_type` varchar(50) NOT NULL default 'text',
  `field_list_items` text NOT NULL,
  `field_pre_populate` char(1) NOT NULL default 'n',
  `field_pre_channel_id` int(6) unsigned default NULL,
  `field_pre_field_id` int(6) unsigned default NULL,
  `field_related_to` varchar(12) NOT NULL default 'channel',
  `field_related_id` int(6) unsigned NOT NULL default '0',
  `field_related_orderby` varchar(12) NOT NULL default 'date',
  `field_related_sort` varchar(4) NOT NULL default 'desc',
  `field_related_max` smallint(4) NOT NULL default '0',
  `field_ta_rows` tinyint(2) default '8',
  `field_maxl` smallint(3) default NULL,
  `field_required` char(1) NOT NULL default 'n',
  `field_text_direction` char(3) NOT NULL default 'ltr',
  `field_search` char(1) NOT NULL default 'n',
  `field_is_hidden` char(1) NOT NULL default 'n',
  `field_fmt` varchar(40) NOT NULL default 'xhtml',
  `field_show_fmt` char(1) NOT NULL default 'y',
  `field_order` int(3) unsigned NOT NULL,
  `field_content_type` varchar(20) NOT NULL default 'any',
  `field_settings` text,
  PRIMARY KEY  (`field_id`),
  KEY `group_id` (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `exp_channel_fields`
--

INSERT INTO `exp_channel_fields` (`field_id`, `site_id`, `group_id`, `field_name`, `field_label`, `field_instructions`, `field_type`, `field_list_items`, `field_pre_populate`, `field_pre_channel_id`, `field_pre_field_id`, `field_related_to`, `field_related_id`, `field_related_orderby`, `field_related_sort`, `field_related_max`, `field_ta_rows`, `field_maxl`, `field_required`, `field_text_direction`, `field_search`, `field_is_hidden`, `field_fmt`, `field_show_fmt`, `field_order`, `field_content_type`, `field_settings`) VALUES
(1, 1, 1, 'about_content', 'Content', '', 'textarea', '', '0', 0, 0, 'channel', 1, 'title', 'desc', 0, 12, 128, 'y', 'ltr', 'y', 'n', 'xhtml', 'n', 1, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToieSI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6InkiO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(2, 1, 3, 'blog_content', 'Content', '', 'textarea', '', '0', 0, 0, 'channel', 1, 'title', 'desc', 0, 12, 128, 'y', 'ltr', 'y', 'n', 'xhtml', 'n', 1, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToieSI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6InkiO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(8, 1, 4, 'static_content', 'Content', '', 'textarea', '', '0', 0, 0, 'channel', 1, 'title', 'desc', 0, 12, 128, 'y', 'ltr', 'y', 'n', 'xhtml', 'n', 1, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToieSI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6InkiO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30=');

-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_channel_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `channel_id` int(6) unsigned NOT NULL,
  PRIMARY KEY  (`group_id`,`channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_channel_titles`
--

CREATE TABLE IF NOT EXISTS `exp_channel_titles` (
  `entry_id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL default '0',
  `pentry_id` int(10) NOT NULL default '0',
  `forum_topic_id` int(10) unsigned default NULL,
  `ip_address` varchar(16) NOT NULL,
  `title` varchar(100) NOT NULL,
  `url_title` varchar(75) NOT NULL,
  `status` varchar(50) NOT NULL,
  `versioning_enabled` char(1) NOT NULL default 'n',
  `view_count_one` int(10) unsigned NOT NULL default '0',
  `view_count_two` int(10) unsigned NOT NULL default '0',
  `view_count_three` int(10) unsigned NOT NULL default '0',
  `view_count_four` int(10) unsigned NOT NULL default '0',
  `allow_comments` varchar(1) NOT NULL default 'y',
  `sticky` varchar(1) NOT NULL default 'n',
  `entry_date` int(10) NOT NULL,
  `dst_enabled` varchar(1) NOT NULL default 'n',
  `year` char(4) NOT NULL,
  `month` char(2) NOT NULL,
  `day` char(3) NOT NULL,
  `expiration_date` int(10) NOT NULL default '0',
  `comment_expiration_date` int(10) NOT NULL default '0',
  `edit_date` bigint(14) default NULL,
  `recent_comment_date` int(10) default NULL,
  `comment_total` int(4) unsigned NOT NULL default '0',
  PRIMARY KEY  (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `author_id` (`author_id`),
  KEY `url_title` (`url_title`),
  KEY `status` (`status`),
  KEY `entry_date` (`entry_date`),
  KEY `expiration_date` (`expiration_date`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `exp_channel_titles`
--

INSERT INTO `exp_channel_titles` (`entry_id`, `site_id`, `channel_id`, `author_id`, `pentry_id`, `forum_topic_id`, `ip_address`, `title`, `url_title`, `status`, `versioning_enabled`, `view_count_one`, `view_count_two`, `view_count_three`, `view_count_four`, `allow_comments`, `sticky`, `entry_date`, `dst_enabled`, `year`, `month`, `day`, `expiration_date`, `comment_expiration_date`, `edit_date`, `recent_comment_date`, `comment_total`) VALUES
(3, 1, 2, 1, 0, 0, '81.149.49.226', 'Test Blog Entry', 'test_blog_entry', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1281566210, 'n', '2010', '08', '11', 0, 0, 20111004180851, 0, 0),
(6, 1, 2, 1, 0, 0, '81.149.49.226', 'Test Blog Entry 2', 'test_blog_entry_2', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1281568111, 'n', '2010', '08', '12', 0, 0, 20111004180932, 0, 2),
(7, 1, 1, 1, 0, 0, '81.149.49.226', 'Services', 'services', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1281568253, 'n', '2010', '08', '12', 0, 0, 20111005091554, 0, 0),
(8, 1, 1, 1, 0, 0, '81.149.49.226', 'Features', 'features', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1281569453, 'n', '2010', '08', '12', 0, 0, 20111004181054, 0, 0),
(9, 1, 1, 1, 0, 0, '81.149.49.226', 'About Us', 'aboutus', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1281569808, 'n', '2010', '08', '12', 0, 0, 20111005091450, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `exp_comments`
--

CREATE TABLE IF NOT EXISTS `exp_comments` (
  `comment_id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) default '1',
  `entry_id` int(10) unsigned default '0',
  `channel_id` int(4) unsigned default '1',
  `author_id` int(10) unsigned default '0',
  `status` char(1) default '0',
  `name` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  `url` varchar(75) default NULL,
  `location` varchar(50) default NULL,
  `ip_address` varchar(16) default NULL,
  `comment_date` int(10) default NULL,
  `edit_date` int(10) default NULL,
  `comment` text,
  `notify` char(1) default 'n',
  PRIMARY KEY  (`comment_id`),
  KEY `entry_id` (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `author_id` (`author_id`),
  KEY `status` (`status`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `exp_comments`
--

INSERT INTO `exp_comments` (`comment_id`, `site_id`, `entry_id`, `channel_id`, `author_id`, `status`, `name`, `email`, `url`, `location`, `ip_address`, `comment_date`, `edit_date`, `comment`, `notify`) VALUES
(1, 1, 6, 2, 1, 'o', 'admin', 'info@example.com', '', '0', '68.220.177.100', 1282613628, NULL, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ''Content here, content here'', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for ''lorem ipsum'' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 'y'),
(2, 1, 6, 2, 1, 'o', 'admin', 'info@example.com', '', '0', '68.220.177.100', 1282613638, NULL, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ''Content here, content here'', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for ''lorem ipsum'' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `exp_comment_subscriptions`
--

CREATE TABLE IF NOT EXISTS `exp_comment_subscriptions` (
  `subscription_id` int(10) unsigned NOT NULL auto_increment,
  `entry_id` int(10) unsigned default NULL,
  `member_id` int(10) default '0',
  `email` varchar(50) default NULL,
  `subscription_date` varchar(10) default NULL,
  `notification_sent` char(1) default 'n',
  `hash` varchar(15) default NULL,
  PRIMARY KEY  (`subscription_id`),
  KEY `entry_id` (`entry_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_cp_log`
--

CREATE TABLE IF NOT EXISTS `exp_cp_log` (
  `id` int(10) NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `member_id` int(10) unsigned NOT NULL,
  `username` varchar(32) NOT NULL,
  `ip_address` varchar(16) NOT NULL default '0',
  `act_date` int(10) NOT NULL,
  `action` varchar(200) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `exp_cp_log`
--

INSERT INTO `exp_cp_log` (`id`, `site_id`, `member_id`, `username`, `ip_address`, `act_date`, `action`) VALUES
(1, 1, 1, 'pledbrook', '81.149.49.226', 1317746053, 'Logged in'),
(2, 1, 1, 'pledbrook', '81.149.49.226', 1317747703, 'Channel Deleted:&nbsp;&nbsp;Front Page Images'),
(3, 1, 1, 'pledbrook', '81.149.49.226', 1317747756, 'Field group Deleted:&nbsp;&nbsp;front page image rotator'),
(4, 1, 1, 'pledbrook', '81.149.49.226', 1317747783, 'Custom Field Deleted:&nbsp;Event Description'),
(5, 1, 1, 'pledbrook', '81.149.49.226', 1317747789, 'Custom Field Deleted:&nbsp;Event Contact'),
(6, 1, 1, 'pledbrook', '81.149.49.226', 1317747836, 'Custom Field Deleted:&nbsp;Event Contact Phone Number'),
(7, 1, 1, 'pledbrook', '81.149.49.226', 1317747877, 'Field group Deleted:&nbsp;&nbsp;events'),
(8, 1, 1, 'pledbrook', '81.149.49.226', 1317747982, 'Channel Deleted:&nbsp;&nbsp;Events'),
(9, 1, 1, 'pledbrook', '81.149.49.226', 1317801309, 'Logged in'),
(10, 1, 1, 'pledbrook', '81.149.49.226', 1317803503, 'Logged in');

-- --------------------------------------------------------

--
-- Table structure for table `exp_cp_search_index`
--

CREATE TABLE IF NOT EXISTS `exp_cp_search_index` (
  `search_id` int(10) unsigned NOT NULL auto_increment,
  `controller` varchar(20) default NULL,
  `method` varchar(50) default NULL,
  `language` varchar(20) default NULL,
  `access` varchar(50) default NULL,
  `keywords` text,
  PRIMARY KEY  (`search_id`),
  FULLTEXT KEY `keywords` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_email_cache`
--

CREATE TABLE IF NOT EXISTS `exp_email_cache` (
  `cache_id` int(6) unsigned NOT NULL auto_increment,
  `cache_date` int(10) unsigned NOT NULL default '0',
  `total_sent` int(6) unsigned NOT NULL,
  `from_name` varchar(70) NOT NULL,
  `from_email` varchar(70) NOT NULL,
  `recipient` text NOT NULL,
  `cc` text NOT NULL,
  `bcc` text NOT NULL,
  `recipient_array` mediumtext NOT NULL,
  `subject` varchar(120) NOT NULL,
  `message` mediumtext NOT NULL,
  `plaintext_alt` mediumtext NOT NULL,
  `mailinglist` char(1) NOT NULL default 'n',
  `mailtype` varchar(6) NOT NULL,
  `text_fmt` varchar(40) NOT NULL,
  `wordwrap` char(1) NOT NULL default 'y',
  `priority` char(1) NOT NULL default '3',
  PRIMARY KEY  (`cache_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_email_cache_mg`
--

CREATE TABLE IF NOT EXISTS `exp_email_cache_mg` (
  `cache_id` int(6) unsigned NOT NULL,
  `group_id` smallint(4) NOT NULL,
  PRIMARY KEY  (`cache_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_email_cache_ml`
--

CREATE TABLE IF NOT EXISTS `exp_email_cache_ml` (
  `cache_id` int(6) unsigned NOT NULL,
  `list_id` smallint(4) NOT NULL,
  PRIMARY KEY  (`cache_id`,`list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_email_console_cache`
--

CREATE TABLE IF NOT EXISTS `exp_email_console_cache` (
  `cache_id` int(6) unsigned NOT NULL auto_increment,
  `cache_date` int(10) unsigned NOT NULL default '0',
  `member_id` int(10) unsigned NOT NULL,
  `member_name` varchar(50) NOT NULL,
  `ip_address` varchar(16) NOT NULL default '0',
  `recipient` varchar(70) NOT NULL,
  `recipient_name` varchar(50) NOT NULL,
  `subject` varchar(120) NOT NULL,
  `message` mediumtext NOT NULL,
  PRIMARY KEY  (`cache_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_email_tracker`
--

CREATE TABLE IF NOT EXISTS `exp_email_tracker` (
  `email_id` int(10) unsigned NOT NULL auto_increment,
  `email_date` int(10) unsigned NOT NULL default '0',
  `sender_ip` varchar(16) NOT NULL,
  `sender_email` varchar(75) NOT NULL,
  `sender_username` varchar(50) NOT NULL,
  `number_recipients` int(4) unsigned NOT NULL default '1',
  PRIMARY KEY  (`email_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_entry_ping_status`
--

CREATE TABLE IF NOT EXISTS `exp_entry_ping_status` (
  `entry_id` int(10) unsigned NOT NULL,
  `ping_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`entry_id`,`ping_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_entry_versioning`
--

CREATE TABLE IF NOT EXISTS `exp_entry_versioning` (
  `version_id` int(10) unsigned NOT NULL auto_increment,
  `entry_id` int(10) unsigned NOT NULL,
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `version_date` int(10) NOT NULL,
  `version_data` mediumtext NOT NULL,
  PRIMARY KEY  (`version_id`),
  KEY `entry_id` (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_extensions`
--

CREATE TABLE IF NOT EXISTS `exp_extensions` (
  `extension_id` int(10) unsigned NOT NULL auto_increment,
  `class` varchar(50) NOT NULL default '',
  `method` varchar(50) NOT NULL default '',
  `hook` varchar(50) NOT NULL default '',
  `settings` text NOT NULL,
  `priority` int(2) NOT NULL default '10',
  `version` varchar(10) NOT NULL default '',
  `enabled` char(1) NOT NULL default 'y',
  PRIMARY KEY  (`extension_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_extensions`
--

INSERT INTO `exp_extensions` (`extension_id`, `class`, `method`, `hook`, `settings`, `priority`, `version`, `enabled`) VALUES
(1, 'Safecracker_ext', 'form_declaration_modify_data', 'form_declaration_modify_data', '', 10, '2.1', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `exp_fieldtypes`
--

CREATE TABLE IF NOT EXISTS `exp_fieldtypes` (
  `fieldtype_id` int(4) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `version` varchar(12) NOT NULL,
  `settings` text,
  `has_global_settings` char(1) default 'n',
  PRIMARY KEY  (`fieldtype_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `exp_fieldtypes`
--

INSERT INTO `exp_fieldtypes` (`fieldtype_id`, `name`, `version`, `settings`, `has_global_settings`) VALUES
(1, 'select', '1.0', 'YTowOnt9', 'n'),
(2, 'text', '1.0', 'YTowOnt9', 'n'),
(3, 'textarea', '1.0', 'YTowOnt9', 'n'),
(4, 'date', '1.0', 'YTowOnt9', 'n'),
(5, 'file', '1.0', 'YTowOnt9', 'n'),
(6, 'multi_select', '1.0', 'YTowOnt9', 'n'),
(7, 'checkboxes', '1.0', 'YTowOnt9', 'n'),
(8, 'radio', '1.0', 'YTowOnt9', 'n'),
(9, 'rel', '1.0', 'YTowOnt9', 'n');

-- --------------------------------------------------------

--
-- Table structure for table `exp_field_formatting`
--

CREATE TABLE IF NOT EXISTS `exp_field_formatting` (
  `formatting_id` int(10) unsigned NOT NULL auto_increment,
  `field_id` int(10) unsigned NOT NULL,
  `field_fmt` varchar(40) NOT NULL,
  PRIMARY KEY  (`formatting_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `exp_field_formatting`
--

INSERT INTO `exp_field_formatting` (`formatting_id`, `field_id`, `field_fmt`) VALUES
(1, 1, 'none'),
(2, 1, 'br'),
(3, 1, 'xhtml'),
(4, 2, 'none'),
(5, 2, 'br'),
(6, 2, 'xhtml'),
(22, 8, 'none'),
(23, 8, 'br'),
(24, 8, 'xhtml');

-- --------------------------------------------------------

--
-- Table structure for table `exp_field_groups`
--

CREATE TABLE IF NOT EXISTS `exp_field_groups` (
  `group_id` int(4) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_name` varchar(50) NOT NULL,
  PRIMARY KEY  (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `exp_field_groups`
--

INSERT INTO `exp_field_groups` (`group_id`, `site_id`, `group_name`) VALUES
(1, 1, 'about'),
(3, 1, 'blog'),
(4, 1, 'static content');

-- --------------------------------------------------------

--
-- Table structure for table `exp_files`
--

CREATE TABLE IF NOT EXISTS `exp_files` (
  `file_id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned default '1',
  `title` varchar(255) default NULL,
  `upload_location_id` int(4) unsigned default '0',
  `rel_path` varchar(255) default NULL,
  `status` char(1) default 'o',
  `mime_type` varchar(255) default NULL,
  `file_name` varchar(255) default NULL,
  `file_size` int(10) default '0',
  `caption` text,
  `field_1` text,
  `field_1_fmt` tinytext,
  `field_2` text,
  `field_2_fmt` tinytext,
  `field_3` text,
  `field_3_fmt` tinytext,
  `field_4` text,
  `field_4_fmt` tinytext,
  `field_5` text,
  `field_5_fmt` tinytext,
  `field_6` text,
  `field_6_fmt` tinytext,
  `metadata` mediumtext,
  `uploaded_by_member_id` int(10) unsigned default '0',
  `upload_date` int(10) default NULL,
  `modified_by_member_id` int(10) unsigned default '0',
  `modified_date` int(10) default NULL,
  `file_hw_original` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`file_id`),
  KEY `upload_location_id` (`upload_location_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_file_categories`
--

CREATE TABLE IF NOT EXISTS `exp_file_categories` (
  `file_id` int(10) unsigned default NULL,
  `cat_id` int(10) unsigned default NULL,
  `sort` int(10) unsigned default '0',
  `is_cover` char(1) default 'n',
  KEY `file_id` (`file_id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_file_dimensions`
--

CREATE TABLE IF NOT EXISTS `exp_file_dimensions` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `upload_location_id` int(4) unsigned default NULL,
  `title` varchar(255) default '',
  `short_name` varchar(255) default '',
  `resize_type` varchar(50) default '',
  `width` int(10) default '0',
  `height` int(10) default '0',
  `watermark_id` int(4) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `upload_location_id` (`upload_location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_file_watermarks`
--

CREATE TABLE IF NOT EXISTS `exp_file_watermarks` (
  `wm_id` int(4) unsigned NOT NULL auto_increment,
  `wm_name` varchar(80) default NULL,
  `wm_type` varchar(10) default 'text',
  `wm_image_path` varchar(100) default NULL,
  `wm_test_image_path` varchar(100) default NULL,
  `wm_use_font` char(1) default 'y',
  `wm_font` varchar(30) default NULL,
  `wm_font_size` int(3) unsigned default NULL,
  `wm_text` varchar(100) default NULL,
  `wm_vrt_alignment` varchar(10) default 'top',
  `wm_hor_alignment` varchar(10) default 'left',
  `wm_padding` int(3) unsigned default NULL,
  `wm_opacity` int(3) unsigned default NULL,
  `wm_x_offset` int(4) unsigned default NULL,
  `wm_y_offset` int(4) unsigned default NULL,
  `wm_x_transp` int(4) default NULL,
  `wm_y_transp` int(4) default NULL,
  `wm_font_color` varchar(7) default NULL,
  `wm_use_drop_shadow` char(1) default 'y',
  `wm_shadow_distance` int(3) unsigned default NULL,
  `wm_shadow_color` varchar(7) default NULL,
  PRIMARY KEY  (`wm_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_attachments`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_attachments` (
  `attachment_id` int(10) unsigned NOT NULL auto_increment,
  `entry_id` int(10) unsigned NOT NULL,
  `pref_id` int(10) unsigned NOT NULL,
  `entry_date` int(10) NOT NULL,
  `server_path` varchar(150) NOT NULL,
  `filename` varchar(150) NOT NULL,
  `extension` varchar(7) NOT NULL,
  `filesize` int(10) NOT NULL,
  `emailed` char(1) NOT NULL default 'n',
  PRIMARY KEY  (`attachment_id`),
  KEY `entry_id` (`entry_id`),
  KEY `pref_id` (`pref_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_entries`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_entries` (
  `entry_id` int(10) unsigned NOT NULL auto_increment,
  `group_id` int(10) unsigned NOT NULL default '0',
  `weblog_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL default '0',
  `ip_address` varchar(16) NOT NULL default '0',
  `form_name` varchar(50) NOT NULL,
  `template` varchar(150) NOT NULL,
  `entry_date` int(10) NOT NULL,
  `edit_date` int(10) NOT NULL,
  `status` char(10) NOT NULL default 'open',
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `website` varchar(50) NOT NULL,
  `street1` varchar(50) NOT NULL,
  `street2` varchar(50) NOT NULL,
  `street3` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `postalcode` varchar(50) NOT NULL,
  `phone1` varchar(50) NOT NULL,
  `phone2` varchar(50) NOT NULL,
  `fax` varchar(50) NOT NULL,
  PRIMARY KEY  (`entry_id`),
  KEY `author_id` (`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_fields`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_fields` (
  `field_id` int(10) unsigned NOT NULL auto_increment,
  `field_order` int(10) NOT NULL default '0',
  `field_type` varchar(50) NOT NULL default 'text',
  `field_length` int(3) NOT NULL default '150',
  `form_name` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `name_old` varchar(50) NOT NULL,
  `label` varchar(100) NOT NULL,
  `weblog_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL default '0',
  `entry_date` int(10) NOT NULL,
  `edit_date` int(10) NOT NULL,
  `editable` char(1) NOT NULL default 'y',
  `status` char(10) NOT NULL default 'open',
  PRIMARY KEY  (`field_id`),
  KEY `name` (`name`),
  KEY `author_id` (`author_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `exp_freeform_fields`
--

INSERT INTO `exp_freeform_fields` (`field_id`, `field_order`, `field_type`, `field_length`, `form_name`, `name`, `name_old`, `label`, `weblog_id`, `author_id`, `entry_date`, `edit_date`, `editable`, `status`) VALUES
(1, 1, 'text', 150, '', 'name', '', 'Name', 0, 0, 0, 0, 'n', ''),
(2, 2, 'text', 150, '', 'email', '', 'Email', 0, 0, 0, 0, 'n', ''),
(3, 3, 'text', 150, '', 'website', '', 'Website', 0, 0, 0, 0, 'n', ''),
(4, 4, 'text', 150, '', 'street1', '', 'Street 1', 0, 0, 0, 0, 'n', ''),
(5, 5, 'text', 150, '', 'street2', '', 'Street 2', 0, 0, 0, 0, 'n', ''),
(6, 6, 'text', 150, '', 'street3', '', 'Street 3', 0, 0, 0, 0, 'n', ''),
(7, 7, 'text', 150, '', 'city', '', 'City', 0, 0, 0, 0, 'n', ''),
(8, 8, 'text', 150, '', 'state', '', 'State', 0, 0, 0, 0, 'n', ''),
(9, 9, 'text', 150, '', 'country', '', 'Country', 0, 0, 0, 0, 'n', ''),
(10, 10, 'text', 150, '', 'postalcode', '', 'Postal Code', 0, 0, 0, 0, 'n', ''),
(11, 11, 'text', 150, '', 'phone1', '', 'Phone 1', 0, 0, 0, 0, 'n', ''),
(12, 12, 'text', 150, '', 'phone2', '', 'Phone 2', 0, 0, 0, 0, 'n', ''),
(13, 13, 'text', 150, '', 'fax', '', 'Fax', 0, 0, 0, 0, 'n', '');

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_params`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_params` (
  `params_id` int(10) unsigned NOT NULL auto_increment,
  `entry_date` int(10) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY  (`params_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `exp_freeform_params`
--

INSERT INTO `exp_freeform_params` (`params_id`, `entry_date`, `data`) VALUES
(1, 1317801767, 'a:22:{s:15:"require_captcha";s:3:"yes";s:9:"form_name";s:12:"default_form";s:10:"require_ip";s:0:"";s:11:"ee_required";s:24:"firstname|lastname|email";s:9:"ee_notify";s:16:"info@example.com";s:18:"allowed_file_types";s:0:"";s:8:"reply_to";b:0;s:20:"reply_to_email_field";s:0:"";s:19:"reply_to_name_field";s:0:"";s:10:"recipients";s:1:"n";s:15:"recipient_limit";s:2:"10";s:17:"static_recipients";b:0;s:22:"static_recipients_list";a:0:{}s:18:"recipient_template";s:16:"default_template";s:13:"discard_field";s:0:"";s:15:"send_attachment";s:0:"";s:15:"send_user_email";s:0:"";s:20:"send_user_attachment";s:0:"";s:19:"user_email_template";s:16:"default_template";s:8:"template";s:16:"default_template";s:20:"prevent_duplicate_on";s:0:"";s:11:"file_upload";s:0:"";}'),
(2, 1317801822, 'a:22:{s:15:"require_captcha";s:3:"yes";s:9:"form_name";s:12:"default_form";s:10:"require_ip";s:0:"";s:11:"ee_required";s:24:"firstname|lastname|email";s:9:"ee_notify";s:16:"info@example.com";s:18:"allowed_file_types";s:0:"";s:8:"reply_to";b:0;s:20:"reply_to_email_field";s:0:"";s:19:"reply_to_name_field";s:0:"";s:10:"recipients";s:1:"n";s:15:"recipient_limit";s:2:"10";s:17:"static_recipients";b:0;s:22:"static_recipients_list";a:0:{}s:18:"recipient_template";s:16:"default_template";s:13:"discard_field";s:0:"";s:15:"send_attachment";s:0:"";s:15:"send_user_email";s:0:"";s:20:"send_user_attachment";s:0:"";s:19:"user_email_template";s:16:"default_template";s:8:"template";s:16:"default_template";s:20:"prevent_duplicate_on";s:0:"";s:11:"file_upload";s:0:"";}'),
(3, 1317802634, 'a:22:{s:15:"require_captcha";s:3:"yes";s:9:"form_name";s:12:"default_form";s:10:"require_ip";s:0:"";s:11:"ee_required";s:24:"firstname|lastname|email";s:9:"ee_notify";s:16:"info@example.com";s:18:"allowed_file_types";s:0:"";s:8:"reply_to";b:0;s:20:"reply_to_email_field";s:0:"";s:19:"reply_to_name_field";s:0:"";s:10:"recipients";s:1:"n";s:15:"recipient_limit";s:2:"10";s:17:"static_recipients";b:0;s:22:"static_recipients_list";a:0:{}s:18:"recipient_template";s:16:"default_template";s:13:"discard_field";s:0:"";s:15:"send_attachment";s:0:"";s:15:"send_user_email";s:0:"";s:20:"send_user_attachment";s:0:"";s:19:"user_email_template";s:16:"default_template";s:8:"template";s:16:"default_template";s:20:"prevent_duplicate_on";s:0:"";s:11:"file_upload";s:0:"";}'),
(4, 1317802643, 'a:22:{s:15:"require_captcha";s:3:"yes";s:9:"form_name";s:12:"default_form";s:10:"require_ip";s:0:"";s:11:"ee_required";s:24:"firstname|lastname|email";s:9:"ee_notify";s:16:"info@example.com";s:18:"allowed_file_types";s:0:"";s:8:"reply_to";b:0;s:20:"reply_to_email_field";s:0:"";s:19:"reply_to_name_field";s:0:"";s:10:"recipients";s:1:"n";s:15:"recipient_limit";s:2:"10";s:17:"static_recipients";b:0;s:22:"static_recipients_list";a:0:{}s:18:"recipient_template";s:16:"default_template";s:13:"discard_field";s:0:"";s:15:"send_attachment";s:0:"";s:15:"send_user_email";s:0:"";s:20:"send_user_attachment";s:0:"";s:19:"user_email_template";s:16:"default_template";s:8:"template";s:16:"default_template";s:20:"prevent_duplicate_on";s:0:"";s:11:"file_upload";s:0:"";}'),
(5, 1317802950, 'a:22:{s:15:"require_captcha";s:3:"yes";s:9:"form_name";s:12:"default_form";s:10:"require_ip";s:0:"";s:11:"ee_required";s:24:"firstname|lastname|email";s:9:"ee_notify";s:16:"info@example.com";s:18:"allowed_file_types";s:0:"";s:8:"reply_to";b:0;s:20:"reply_to_email_field";s:0:"";s:19:"reply_to_name_field";s:0:"";s:10:"recipients";s:1:"n";s:15:"recipient_limit";s:2:"10";s:17:"static_recipients";b:0;s:22:"static_recipients_list";a:0:{}s:18:"recipient_template";s:16:"default_template";s:13:"discard_field";s:0:"";s:15:"send_attachment";s:0:"";s:15:"send_user_email";s:0:"";s:20:"send_user_attachment";s:0:"";s:19:"user_email_template";s:16:"default_template";s:8:"template";s:16:"default_template";s:20:"prevent_duplicate_on";s:0:"";s:11:"file_upload";s:0:"";}'),
(6, 1317803251, 'a:22:{s:15:"require_captcha";s:3:"yes";s:9:"form_name";s:12:"default_form";s:10:"require_ip";s:0:"";s:11:"ee_required";s:24:"firstname|lastname|email";s:9:"ee_notify";s:16:"info@example.com";s:18:"allowed_file_types";s:0:"";s:8:"reply_to";b:0;s:20:"reply_to_email_field";s:0:"";s:19:"reply_to_name_field";s:0:"";s:10:"recipients";s:1:"n";s:15:"recipient_limit";s:2:"10";s:17:"static_recipients";b:0;s:22:"static_recipients_list";a:0:{}s:18:"recipient_template";s:16:"default_template";s:13:"discard_field";s:0:"";s:15:"send_attachment";s:0:"";s:15:"send_user_email";s:0:"";s:20:"send_user_attachment";s:0:"";s:19:"user_email_template";s:16:"default_template";s:8:"template";s:16:"default_template";s:20:"prevent_duplicate_on";s:0:"";s:11:"file_upload";s:0:"";}');

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_preferences`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_preferences` (
  `preference_id` int(10) unsigned NOT NULL auto_increment,
  `preference_name` varchar(80) NOT NULL,
  `preference_value` text NOT NULL,
  PRIMARY KEY  (`preference_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_templates`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_templates` (
  `template_id` int(6) unsigned NOT NULL auto_increment,
  `enable_template` char(1) NOT NULL default 'y',
  `wordwrap` char(1) NOT NULL default 'y',
  `html` char(1) NOT NULL default 'n',
  `template_name` varchar(150) NOT NULL,
  `template_label` varchar(150) NOT NULL,
  `data_from_name` varchar(150) NOT NULL,
  `data_from_email` varchar(200) NOT NULL,
  `data_title` varchar(80) NOT NULL,
  `template_data` text NOT NULL,
  PRIMARY KEY  (`template_id`),
  KEY `template_name` (`template_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_freeform_templates`
--

INSERT INTO `exp_freeform_templates` (`template_id`, `enable_template`, `wordwrap`, `html`, `template_name`, `template_label`, `data_from_name`, `data_from_email`, `data_title`, `template_data`) VALUES
(1, 'y', 'y', 'n', 'default_template', 'Default Template', '', '', 'Someone has posted to Freeform', 'Someone has posted to Freeform. Here are the details:  \n			 		\nEntry Date: {entry_date}\n{all_custom_fields}');

-- --------------------------------------------------------

--
-- Table structure for table `exp_freeform_user_email`
--

CREATE TABLE IF NOT EXISTS `exp_freeform_user_email` (
  `email_id` int(10) unsigned NOT NULL auto_increment,
  `entry_id` int(10) unsigned NOT NULL,
  `email_count` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`email_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_global_variables`
--

CREATE TABLE IF NOT EXISTS `exp_global_variables` (
  `variable_id` int(6) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `variable_name` varchar(50) NOT NULL,
  `variable_data` text NOT NULL,
  PRIMARY KEY  (`variable_id`),
  KEY `variable_name` (`variable_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_html_buttons`
--

CREATE TABLE IF NOT EXISTS `exp_html_buttons` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `member_id` int(10) NOT NULL default '0',
  `tag_name` varchar(32) NOT NULL,
  `tag_open` varchar(120) NOT NULL,
  `tag_close` varchar(120) NOT NULL,
  `accesskey` varchar(32) NOT NULL,
  `tag_order` int(3) unsigned NOT NULL,
  `tag_row` char(1) NOT NULL default '1',
  `classname` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `exp_html_buttons`
--

INSERT INTO `exp_html_buttons` (`id`, `site_id`, `member_id`, `tag_name`, `tag_open`, `tag_close`, `accesskey`, `tag_order`, `tag_row`, `classname`) VALUES
(1, 1, 0, 'b', '<strong>', '</strong>', 'b', 1, '1', 'btn_b'),
(2, 1, 0, 'i', '<em>', '</em>', 'i', 2, '1', 'btn_i'),
(3, 1, 0, 'blockquote', '<blockquote>', '</blockquote>', 'q', 3, '1', 'btn_blockquote'),
(4, 1, 0, 'a', '<a href="[![Link:!:http://]!]"(!( title="[![Title]!]")!)>', '</a>', 'a', 4, '1', 'btn_a'),
(5, 1, 0, 'img', '<img src="[![Link:!:http://]!]" alt="[![Alternative text]!]" />', '', '', 5, '1', 'btn_img');

-- --------------------------------------------------------

--
-- Table structure for table `exp_layout_publish`
--

CREATE TABLE IF NOT EXISTS `exp_layout_publish` (
  `layout_id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `member_group` int(4) unsigned NOT NULL default '0',
  `channel_id` int(4) unsigned NOT NULL default '0',
  `field_layout` text,
  PRIMARY KEY  (`layout_id`),
  KEY `site_id` (`site_id`),
  KEY `member_group` (`member_group`),
  KEY `channel_id` (`channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_mailing_list`
--

CREATE TABLE IF NOT EXISTS `exp_mailing_list` (
  `user_id` int(10) unsigned NOT NULL auto_increment,
  `list_id` int(7) unsigned NOT NULL,
  `authcode` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  PRIMARY KEY  (`user_id`),
  KEY `list_id` (`list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_mailing_lists`
--

CREATE TABLE IF NOT EXISTS `exp_mailing_lists` (
  `list_id` int(7) unsigned NOT NULL auto_increment,
  `list_name` varchar(40) NOT NULL,
  `list_title` varchar(100) NOT NULL,
  `list_template` text NOT NULL,
  PRIMARY KEY  (`list_id`),
  KEY `list_name` (`list_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_mailing_lists`
--

INSERT INTO `exp_mailing_lists` (`list_id`, `list_name`, `list_title`, `list_template`) VALUES
(1, 'default', 'Default Mailing List', '{message_text}\n\nTo remove your email from this mailing list, click here:\n{if html_email}<a href=\\"{unsubscribe_url}\\">{unsubscribe_url}</a>{/if}\n{if plain_email}{unsubscribe_url}{/if}');

-- --------------------------------------------------------

--
-- Table structure for table `exp_mailing_list_queue`
--

CREATE TABLE IF NOT EXISTS `exp_mailing_list_queue` (
  `queue_id` int(10) unsigned NOT NULL auto_increment,
  `email` varchar(50) NOT NULL,
  `list_id` int(7) unsigned NOT NULL default '0',
  `authcode` varchar(10) NOT NULL,
  `date` int(10) NOT NULL,
  PRIMARY KEY  (`queue_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_members`
--

CREATE TABLE IF NOT EXISTS `exp_members` (
  `member_id` int(10) unsigned NOT NULL auto_increment,
  `group_id` smallint(4) NOT NULL default '0',
  `username` varchar(50) NOT NULL,
  `screen_name` varchar(50) NOT NULL,
  `password` varchar(128) NOT NULL,
  `salt` varchar(128) NOT NULL default '',
  `unique_id` varchar(40) NOT NULL,
  `remember_me` varchar(32) NOT NULL default '',
  `crypt_key` varchar(40) default NULL,
  `authcode` varchar(10) default NULL,
  `email` varchar(72) NOT NULL,
  `url` varchar(150) default NULL,
  `location` varchar(50) default NULL,
  `occupation` varchar(80) default NULL,
  `interests` varchar(120) default NULL,
  `bday_d` int(2) default NULL,
  `bday_m` int(2) default NULL,
  `bday_y` int(4) default NULL,
  `aol_im` varchar(50) default NULL,
  `yahoo_im` varchar(50) default NULL,
  `msn_im` varchar(50) default NULL,
  `icq` varchar(50) default NULL,
  `bio` text,
  `signature` text,
  `avatar_filename` varchar(120) default NULL,
  `avatar_width` int(4) unsigned default NULL,
  `avatar_height` int(4) unsigned default NULL,
  `photo_filename` varchar(120) default NULL,
  `photo_width` int(4) unsigned default NULL,
  `photo_height` int(4) unsigned default NULL,
  `sig_img_filename` varchar(120) default NULL,
  `sig_img_width` int(4) unsigned default NULL,
  `sig_img_height` int(4) unsigned default NULL,
  `ignore_list` text,
  `private_messages` int(4) unsigned NOT NULL default '0',
  `accept_messages` char(1) NOT NULL default 'y',
  `last_view_bulletins` int(10) NOT NULL default '0',
  `last_bulletin_date` int(10) NOT NULL default '0',
  `ip_address` varchar(16) NOT NULL default '0',
  `join_date` int(10) unsigned NOT NULL default '0',
  `last_visit` int(10) unsigned NOT NULL default '0',
  `last_activity` int(10) unsigned NOT NULL default '0',
  `total_entries` smallint(5) unsigned NOT NULL default '0',
  `total_comments` smallint(5) unsigned NOT NULL default '0',
  `total_forum_topics` mediumint(8) NOT NULL default '0',
  `total_forum_posts` mediumint(8) NOT NULL default '0',
  `last_entry_date` int(10) unsigned NOT NULL default '0',
  `last_comment_date` int(10) unsigned NOT NULL default '0',
  `last_forum_post_date` int(10) unsigned NOT NULL default '0',
  `last_email_date` int(10) unsigned NOT NULL default '0',
  `in_authorlist` char(1) NOT NULL default 'n',
  `accept_admin_email` char(1) NOT NULL default 'y',
  `accept_user_email` char(1) NOT NULL default 'y',
  `notify_by_default` char(1) NOT NULL default 'y',
  `notify_of_pm` char(1) NOT NULL default 'y',
  `display_avatars` char(1) NOT NULL default 'y',
  `display_signatures` char(1) NOT NULL default 'y',
  `parse_smileys` char(1) NOT NULL default 'y',
  `smart_notifications` char(1) NOT NULL default 'y',
  `language` varchar(50) NOT NULL,
  `timezone` varchar(8) NOT NULL,
  `daylight_savings` char(1) NOT NULL default 'n',
  `localization_is_site_default` char(1) NOT NULL default 'n',
  `time_format` char(2) NOT NULL default 'us',
  `cp_theme` varchar(32) default NULL,
  `profile_theme` varchar(32) default NULL,
  `forum_theme` varchar(32) default NULL,
  `tracker` text,
  `template_size` varchar(2) NOT NULL default '20',
  `notepad` text,
  `notepad_size` varchar(2) NOT NULL default '18',
  `quick_links` text,
  `quick_tabs` text,
  `show_sidebar` char(1) NOT NULL default 'n',
  `pmember_id` int(10) NOT NULL default '0',
  PRIMARY KEY  (`member_id`),
  KEY `group_id` (`group_id`),
  KEY `unique_id` (`unique_id`),
  KEY `password` (`password`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_members`
--

INSERT INTO `exp_members` (`member_id`, `group_id`, `username`, `screen_name`, `password`, `salt`, `unique_id`, `remember_me`, `crypt_key`, `authcode`, `email`, `url`, `location`, `occupation`, `interests`, `bday_d`, `bday_m`, `bday_y`, `aol_im`, `yahoo_im`, `msn_im`, `icq`, `bio`, `signature`, `avatar_filename`, `avatar_width`, `avatar_height`, `photo_filename`, `photo_width`, `photo_height`, `sig_img_filename`, `sig_img_width`, `sig_img_height`, `ignore_list`, `private_messages`, `accept_messages`, `last_view_bulletins`, `last_bulletin_date`, `ip_address`, `join_date`, `last_visit`, `last_activity`, `total_entries`, `total_comments`, `total_forum_topics`, `total_forum_posts`, `last_entry_date`, `last_comment_date`, `last_forum_post_date`, `last_email_date`, `in_authorlist`, `accept_admin_email`, `accept_user_email`, `notify_by_default`, `notify_of_pm`, `display_avatars`, `display_signatures`, `parse_smileys`, `smart_notifications`, `language`, `timezone`, `daylight_savings`, `localization_is_site_default`, `time_format`, `cp_theme`, `profile_theme`, `forum_theme`, `tracker`, `template_size`, `notepad`, `notepad_size`, `quick_links`, `quick_tabs`, `show_sidebar`, `pmember_id`) VALUES
(1, 1, 'pledbrook', 'Paul Ledbrook', 'af477c3baca34ab3489eafe7ae6a754213358d7223a052c66eb7221776c6dc8eeb78816c091c7cdc881220652c273ae1a95813fe75ef7560c661a91249c2bd21', 'EvAau''l8{`?*P!>>q?J/|Au8Eiu^S_;2xXPm]NuA,Wfjd4R@#IrEXZ0dqY~F@epQ]G#}:f,q8RyuAN,P8;WF)Z0k=A`T[8?Tv_4n.x&ccOLBap7~D\\({!0w~E^X^XT"{', '3fb2277cf6087f3c6af0a07d41f1554f68313f47', '', 'cd2f3d9fb0c2887456b518c121090342a912c5db', NULL, 'paul@k-collective.co.uk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'y', 0, 0, '81.149.49.226', 1317745894, 1317751599, 1317806061, 5, 2, 0, 0, 0, 0, 0, 0, 'n', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'english', 'UTC', 'y', 'n', 'us', NULL, NULL, NULL, NULL, '20', NULL, '18', '', NULL, 'y', 0);

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_bulletin_board`
--

CREATE TABLE IF NOT EXISTS `exp_member_bulletin_board` (
  `bulletin_id` int(10) unsigned NOT NULL auto_increment,
  `sender_id` int(10) unsigned NOT NULL,
  `bulletin_group` int(8) unsigned NOT NULL,
  `bulletin_date` int(10) unsigned NOT NULL,
  `hash` varchar(10) NOT NULL default '',
  `bulletin_expires` int(10) unsigned NOT NULL default '0',
  `bulletin_message` text NOT NULL,
  PRIMARY KEY  (`bulletin_id`),
  KEY `sender_id` (`sender_id`),
  KEY `hash` (`hash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_data`
--

CREATE TABLE IF NOT EXISTS `exp_member_data` (
  `member_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_member_data`
--

INSERT INTO `exp_member_data` (`member_id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_fields`
--

CREATE TABLE IF NOT EXISTS `exp_member_fields` (
  `m_field_id` int(4) unsigned NOT NULL auto_increment,
  `m_field_name` varchar(32) NOT NULL,
  `m_field_label` varchar(50) NOT NULL,
  `m_field_description` text NOT NULL,
  `m_field_type` varchar(12) NOT NULL default 'text',
  `m_field_list_items` text NOT NULL,
  `m_field_ta_rows` tinyint(2) default '8',
  `m_field_maxl` smallint(3) NOT NULL,
  `m_field_width` varchar(6) NOT NULL,
  `m_field_search` char(1) NOT NULL default 'y',
  `m_field_required` char(1) NOT NULL default 'n',
  `m_field_public` char(1) NOT NULL default 'y',
  `m_field_reg` char(1) NOT NULL default 'n',
  `m_field_cp_reg` char(1) NOT NULL default 'n',
  `m_field_fmt` char(5) NOT NULL default 'none',
  `m_field_order` int(3) unsigned NOT NULL,
  PRIMARY KEY  (`m_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_title` varchar(100) NOT NULL,
  `group_description` text NOT NULL,
  `is_locked` char(1) NOT NULL default 'y',
  `can_view_offline_system` char(1) NOT NULL default 'n',
  `can_view_online_system` char(1) NOT NULL default 'y',
  `can_access_cp` char(1) NOT NULL default 'y',
  `can_access_content` char(1) NOT NULL default 'n',
  `can_access_publish` char(1) NOT NULL default 'n',
  `can_access_edit` char(1) NOT NULL default 'n',
  `can_access_files` char(1) NOT NULL default 'n',
  `can_access_fieldtypes` char(1) NOT NULL default 'n',
  `can_access_design` char(1) NOT NULL default 'n',
  `can_access_addons` char(1) NOT NULL default 'n',
  `can_access_modules` char(1) NOT NULL default 'n',
  `can_access_extensions` char(1) NOT NULL default 'n',
  `can_access_accessories` char(1) NOT NULL default 'n',
  `can_access_plugins` char(1) NOT NULL default 'n',
  `can_access_members` char(1) NOT NULL default 'n',
  `can_access_admin` char(1) NOT NULL default 'n',
  `can_access_sys_prefs` char(1) NOT NULL default 'n',
  `can_access_content_prefs` char(1) NOT NULL default 'n',
  `can_access_tools` char(1) NOT NULL default 'n',
  `can_access_comm` char(1) NOT NULL default 'n',
  `can_access_utilities` char(1) NOT NULL default 'n',
  `can_access_data` char(1) NOT NULL default 'n',
  `can_access_logs` char(1) NOT NULL default 'n',
  `can_admin_channels` char(1) NOT NULL default 'n',
  `can_admin_upload_prefs` char(1) NOT NULL default 'n',
  `can_admin_design` char(1) NOT NULL default 'n',
  `can_admin_members` char(1) NOT NULL default 'n',
  `can_delete_members` char(1) NOT NULL default 'n',
  `can_admin_mbr_groups` char(1) NOT NULL default 'n',
  `can_admin_mbr_templates` char(1) NOT NULL default 'n',
  `can_ban_users` char(1) NOT NULL default 'n',
  `can_admin_modules` char(1) NOT NULL default 'n',
  `can_admin_templates` char(1) NOT NULL default 'n',
  `can_admin_accessories` char(1) NOT NULL default 'n',
  `can_edit_categories` char(1) NOT NULL default 'n',
  `can_delete_categories` char(1) NOT NULL default 'n',
  `can_view_other_entries` char(1) NOT NULL default 'n',
  `can_edit_other_entries` char(1) NOT NULL default 'n',
  `can_assign_post_authors` char(1) NOT NULL default 'n',
  `can_delete_self_entries` char(1) NOT NULL default 'n',
  `can_delete_all_entries` char(1) NOT NULL default 'n',
  `can_view_other_comments` char(1) NOT NULL default 'n',
  `can_edit_own_comments` char(1) NOT NULL default 'n',
  `can_delete_own_comments` char(1) NOT NULL default 'n',
  `can_edit_all_comments` char(1) NOT NULL default 'n',
  `can_delete_all_comments` char(1) NOT NULL default 'n',
  `can_moderate_comments` char(1) NOT NULL default 'n',
  `can_send_email` char(1) NOT NULL default 'n',
  `can_send_cached_email` char(1) NOT NULL default 'n',
  `can_email_member_groups` char(1) NOT NULL default 'n',
  `can_email_mailinglist` char(1) NOT NULL default 'n',
  `can_email_from_profile` char(1) NOT NULL default 'n',
  `can_view_profiles` char(1) NOT NULL default 'n',
  `can_edit_html_buttons` char(1) NOT NULL default 'n',
  `can_delete_self` char(1) NOT NULL default 'n',
  `mbr_delete_notify_emails` varchar(255) default NULL,
  `can_post_comments` char(1) NOT NULL default 'n',
  `exclude_from_moderation` char(1) NOT NULL default 'n',
  `can_search` char(1) NOT NULL default 'n',
  `search_flood_control` mediumint(5) unsigned NOT NULL,
  `can_send_private_messages` char(1) NOT NULL default 'n',
  `prv_msg_send_limit` smallint(5) unsigned NOT NULL default '20',
  `prv_msg_storage_limit` smallint(5) unsigned NOT NULL default '60',
  `can_attach_in_private_messages` char(1) NOT NULL default 'n',
  `can_send_bulletins` char(1) NOT NULL default 'n',
  `include_in_authorlist` char(1) NOT NULL default 'n',
  `include_in_memberlist` char(1) NOT NULL default 'y',
  `include_in_mailinglists` char(1) NOT NULL default 'y',
  PRIMARY KEY  (`group_id`,`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_member_groups`
--

INSERT INTO `exp_member_groups` (`group_id`, `site_id`, `group_title`, `group_description`, `is_locked`, `can_view_offline_system`, `can_view_online_system`, `can_access_cp`, `can_access_content`, `can_access_publish`, `can_access_edit`, `can_access_files`, `can_access_fieldtypes`, `can_access_design`, `can_access_addons`, `can_access_modules`, `can_access_extensions`, `can_access_accessories`, `can_access_plugins`, `can_access_members`, `can_access_admin`, `can_access_sys_prefs`, `can_access_content_prefs`, `can_access_tools`, `can_access_comm`, `can_access_utilities`, `can_access_data`, `can_access_logs`, `can_admin_channels`, `can_admin_upload_prefs`, `can_admin_design`, `can_admin_members`, `can_delete_members`, `can_admin_mbr_groups`, `can_admin_mbr_templates`, `can_ban_users`, `can_admin_modules`, `can_admin_templates`, `can_admin_accessories`, `can_edit_categories`, `can_delete_categories`, `can_view_other_entries`, `can_edit_other_entries`, `can_assign_post_authors`, `can_delete_self_entries`, `can_delete_all_entries`, `can_view_other_comments`, `can_edit_own_comments`, `can_delete_own_comments`, `can_edit_all_comments`, `can_delete_all_comments`, `can_moderate_comments`, `can_send_email`, `can_send_cached_email`, `can_email_member_groups`, `can_email_mailinglist`, `can_email_from_profile`, `can_view_profiles`, `can_edit_html_buttons`, `can_delete_self`, `mbr_delete_notify_emails`, `can_post_comments`, `exclude_from_moderation`, `can_search`, `search_flood_control`, `can_send_private_messages`, `prv_msg_send_limit`, `prv_msg_storage_limit`, `can_attach_in_private_messages`, `can_send_bulletins`, `include_in_authorlist`, `include_in_memberlist`, `include_in_mailinglists`) VALUES
(1, 1, 'Super Admins', '', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', '', 'y', 'y', 'y', 0, 'y', 20, 60, 'y', 'y', 'y', 'y', 'y'),
(2, 1, 'Banned', '', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', '', 'n', 'n', 'n', 60, 'n', 20, 60, 'n', 'n', 'n', 'n', 'n'),
(3, 1, 'Guests', '', 'y', 'n', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'y', 'n', 'n', 'n', 'n', '', 'y', 'n', 'y', 15, 'n', 20, 60, 'n', 'n', 'n', 'n', 'n'),
(4, 1, 'Pending', '', 'y', 'n', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'y', 'n', 'n', 'n', 'n', '', 'y', 'n', 'y', 15, 'n', 20, 60, 'n', 'n', 'n', 'n', 'n'),
(5, 1, 'Members', '', 'y', 'n', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'y', 'y', 'y', 'n', '', 'y', 'n', 'y', 10, 'y', 20, 60, 'y', 'n', 'n', 'y', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_homepage`
--

CREATE TABLE IF NOT EXISTS `exp_member_homepage` (
  `member_id` int(10) unsigned NOT NULL,
  `recent_entries` char(1) NOT NULL default 'l',
  `recent_entries_order` int(3) unsigned NOT NULL default '0',
  `recent_comments` char(1) NOT NULL default 'l',
  `recent_comments_order` int(3) unsigned NOT NULL default '0',
  `recent_members` char(1) NOT NULL default 'n',
  `recent_members_order` int(3) unsigned NOT NULL default '0',
  `site_statistics` char(1) NOT NULL default 'r',
  `site_statistics_order` int(3) unsigned NOT NULL default '0',
  `member_search_form` char(1) NOT NULL default 'n',
  `member_search_form_order` int(3) unsigned NOT NULL default '0',
  `notepad` char(1) NOT NULL default 'r',
  `notepad_order` int(3) unsigned NOT NULL default '0',
  `bulletin_board` char(1) NOT NULL default 'r',
  `bulletin_board_order` int(3) unsigned NOT NULL default '0',
  `pmachine_news_feed` char(1) NOT NULL default 'n',
  `pmachine_news_feed_order` int(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_member_homepage`
--

INSERT INTO `exp_member_homepage` (`member_id`, `recent_entries`, `recent_entries_order`, `recent_comments`, `recent_comments_order`, `recent_members`, `recent_members_order`, `site_statistics`, `site_statistics_order`, `member_search_form`, `member_search_form_order`, `notepad`, `notepad_order`, `bulletin_board`, `bulletin_board_order`, `pmachine_news_feed`, `pmachine_news_feed_order`) VALUES
(1, 'l', 1, 'l', 2, 'n', 0, 'r', 1, 'n', 0, 'r', 2, 'r', 0, 'l', 0);

-- --------------------------------------------------------

--
-- Table structure for table `exp_member_search`
--

CREATE TABLE IF NOT EXISTS `exp_member_search` (
  `search_id` varchar(32) NOT NULL,
  `site_id` int(4) unsigned NOT NULL default '1',
  `search_date` int(10) unsigned NOT NULL,
  `keywords` varchar(200) NOT NULL,
  `fields` varchar(200) NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  `total_results` int(8) unsigned NOT NULL,
  `query` text NOT NULL,
  PRIMARY KEY  (`search_id`),
  KEY `member_id` (`member_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_message_attachments`
--

CREATE TABLE IF NOT EXISTS `exp_message_attachments` (
  `attachment_id` int(10) unsigned NOT NULL auto_increment,
  `sender_id` int(10) unsigned NOT NULL default '0',
  `message_id` int(10) unsigned NOT NULL default '0',
  `attachment_name` varchar(50) NOT NULL default '',
  `attachment_hash` varchar(40) NOT NULL default '',
  `attachment_extension` varchar(20) NOT NULL default '',
  `attachment_location` varchar(150) NOT NULL default '',
  `attachment_date` int(10) unsigned NOT NULL default '0',
  `attachment_size` int(10) unsigned NOT NULL default '0',
  `is_temp` char(1) NOT NULL default 'y',
  PRIMARY KEY  (`attachment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_message_copies`
--

CREATE TABLE IF NOT EXISTS `exp_message_copies` (
  `copy_id` int(10) unsigned NOT NULL auto_increment,
  `message_id` int(10) unsigned NOT NULL default '0',
  `sender_id` int(10) unsigned NOT NULL default '0',
  `recipient_id` int(10) unsigned NOT NULL default '0',
  `message_received` char(1) NOT NULL default 'n',
  `message_read` char(1) NOT NULL default 'n',
  `message_time_read` int(10) unsigned NOT NULL default '0',
  `attachment_downloaded` char(1) NOT NULL default 'n',
  `message_folder` int(10) unsigned NOT NULL default '1',
  `message_authcode` varchar(10) NOT NULL default '',
  `message_deleted` char(1) NOT NULL default 'n',
  `message_status` varchar(10) NOT NULL default '',
  PRIMARY KEY  (`copy_id`),
  KEY `message_id` (`message_id`),
  KEY `recipient_id` (`recipient_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_message_data`
--

CREATE TABLE IF NOT EXISTS `exp_message_data` (
  `message_id` int(10) unsigned NOT NULL auto_increment,
  `sender_id` int(10) unsigned NOT NULL default '0',
  `message_date` int(10) unsigned NOT NULL default '0',
  `message_subject` varchar(255) NOT NULL default '',
  `message_body` text NOT NULL,
  `message_tracking` char(1) NOT NULL default 'y',
  `message_attachments` char(1) NOT NULL default 'n',
  `message_recipients` varchar(200) NOT NULL default '',
  `message_cc` varchar(200) NOT NULL default '',
  `message_hide_cc` char(1) NOT NULL default 'n',
  `message_sent_copy` char(1) NOT NULL default 'n',
  `total_recipients` int(5) unsigned NOT NULL default '0',
  `message_status` varchar(25) NOT NULL default '',
  PRIMARY KEY  (`message_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_message_folders`
--

CREATE TABLE IF NOT EXISTS `exp_message_folders` (
  `member_id` int(10) unsigned NOT NULL default '0',
  `folder1_name` varchar(50) NOT NULL default 'InBox',
  `folder2_name` varchar(50) NOT NULL default 'Sent',
  `folder3_name` varchar(50) NOT NULL default '',
  `folder4_name` varchar(50) NOT NULL default '',
  `folder5_name` varchar(50) NOT NULL default '',
  `folder6_name` varchar(50) NOT NULL default '',
  `folder7_name` varchar(50) NOT NULL default '',
  `folder8_name` varchar(50) NOT NULL default '',
  `folder9_name` varchar(50) NOT NULL default '',
  `folder10_name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_message_listed`
--

CREATE TABLE IF NOT EXISTS `exp_message_listed` (
  `listed_id` int(10) unsigned NOT NULL auto_increment,
  `member_id` int(10) unsigned NOT NULL default '0',
  `listed_member` int(10) unsigned NOT NULL default '0',
  `listed_description` varchar(100) NOT NULL default '',
  `listed_type` varchar(10) NOT NULL default 'blocked',
  PRIMARY KEY  (`listed_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_modules`
--

CREATE TABLE IF NOT EXISTS `exp_modules` (
  `module_id` int(4) unsigned NOT NULL auto_increment,
  `module_name` varchar(50) NOT NULL,
  `module_version` varchar(12) NOT NULL,
  `has_cp_backend` char(1) NOT NULL default 'n',
  `has_publish_fields` char(1) NOT NULL default 'n',
  PRIMARY KEY  (`module_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `exp_modules`
--

INSERT INTO `exp_modules` (`module_id`, `module_name`, `module_version`, `has_cp_backend`, `has_publish_fields`) VALUES
(1, 'Emoticon', '2.0', 'n', 'n'),
(2, 'Jquery', '1.0', 'n', 'n'),
(3, 'Safecracker', '2.1', 'y', 'n'),
(4, 'Channel', '2.0.1', 'n', 'n'),
(5, 'Member', '2.1', 'n', 'n'),
(6, 'Stats', '2.0', 'n', 'n'),
(7, 'Email', '2.0', 'n', 'n'),
(8, 'Rss', '2.0', 'n', 'n'),
(9, 'Comment', '2.2', 'y', 'n'),
(10, 'Search', '2.1', 'n', 'n'),
(11, 'Mailinglist', '3.0', 'y', 'n'),
(12, 'Freeform', '3.1.0', 'y', 'n');

-- --------------------------------------------------------

--
-- Table structure for table `exp_module_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_module_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `module_id` mediumint(5) unsigned NOT NULL,
  PRIMARY KEY  (`group_id`,`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_online_users`
--

CREATE TABLE IF NOT EXISTS `exp_online_users` (
  `online_id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `member_id` int(10) NOT NULL default '0',
  `in_forum` char(1) NOT NULL default 'n',
  `name` varchar(50) NOT NULL default '0',
  `ip_address` varchar(16) NOT NULL default '0',
  `date` int(10) unsigned NOT NULL default '0',
  `anon` char(1) NOT NULL,
  PRIMARY KEY  (`online_id`),
  KEY `date` (`date`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `exp_online_users`
--

INSERT INTO `exp_online_users` (`online_id`, `site_id`, `member_id`, `in_forum`, `name`, `ip_address`, `date`, `anon`) VALUES
(2, 1, 1, 'n', 'Paul Ledbrook', '81.149.49.226', 1317806072, 'y'),
(3, 1, 1, 'n', 'Paul Ledbrook', '81.149.49.226', 1317806072, 'y'),
(8, 1, 1, 'n', 'Paul Ledbrook', '81.149.49.226', 1317806072, 'y'),
(6, 1, 1, 'n', 'Paul Ledbrook', '81.149.49.226', 1317806072, 'y');

-- --------------------------------------------------------

--
-- Table structure for table `exp_password_lockout`
--

CREATE TABLE IF NOT EXISTS `exp_password_lockout` (
  `lockout_id` int(10) unsigned NOT NULL auto_increment,
  `login_date` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL default '0',
  `user_agent` varchar(120) NOT NULL,
  `username` varchar(50) NOT NULL,
  PRIMARY KEY  (`lockout_id`),
  KEY `login_date` (`login_date`),
  KEY `ip_address` (`ip_address`),
  KEY `user_agent` (`user_agent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_ping_servers`
--

CREATE TABLE IF NOT EXISTS `exp_ping_servers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `member_id` int(10) NOT NULL default '0',
  `server_name` varchar(32) NOT NULL,
  `server_url` varchar(150) NOT NULL,
  `port` varchar(4) NOT NULL default '80',
  `ping_protocol` varchar(12) NOT NULL default 'xmlrpc',
  `is_default` char(1) NOT NULL default 'y',
  `server_order` int(3) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_relationships`
--

CREATE TABLE IF NOT EXISTS `exp_relationships` (
  `rel_id` int(6) unsigned NOT NULL auto_increment,
  `rel_parent_id` int(10) NOT NULL default '0',
  `rel_child_id` int(10) NOT NULL default '0',
  `rel_type` varchar(12) NOT NULL,
  `rel_data` mediumtext NOT NULL,
  `reverse_rel_data` mediumtext NOT NULL,
  PRIMARY KEY  (`rel_id`),
  KEY `rel_parent_id` (`rel_parent_id`),
  KEY `rel_child_id` (`rel_child_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_reset_password`
--

CREATE TABLE IF NOT EXISTS `exp_reset_password` (
  `reset_id` int(10) unsigned NOT NULL auto_increment,
  `member_id` int(10) unsigned NOT NULL,
  `resetcode` varchar(12) NOT NULL,
  `date` int(10) NOT NULL,
  PRIMARY KEY  (`reset_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_revision_tracker`
--

CREATE TABLE IF NOT EXISTS `exp_revision_tracker` (
  `tracker_id` int(10) unsigned NOT NULL auto_increment,
  `item_id` int(10) unsigned NOT NULL,
  `item_table` varchar(20) NOT NULL,
  `item_field` varchar(20) NOT NULL,
  `item_date` int(10) NOT NULL,
  `item_author_id` int(10) unsigned NOT NULL,
  `item_data` mediumtext NOT NULL,
  PRIMARY KEY  (`tracker_id`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_search`
--

CREATE TABLE IF NOT EXISTS `exp_search` (
  `search_id` varchar(32) NOT NULL,
  `site_id` int(4) NOT NULL default '1',
  `search_date` int(10) NOT NULL,
  `keywords` varchar(60) NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  `total_results` int(6) NOT NULL,
  `per_page` tinyint(3) unsigned NOT NULL,
  `query` mediumtext,
  `custom_fields` mediumtext,
  `result_page` varchar(70) NOT NULL,
  PRIMARY KEY  (`search_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_search_log`
--

CREATE TABLE IF NOT EXISTS `exp_search_log` (
  `id` int(10) NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `member_id` int(10) unsigned NOT NULL,
  `screen_name` varchar(50) NOT NULL,
  `ip_address` varchar(16) NOT NULL default '0',
  `search_date` int(10) NOT NULL,
  `search_type` varchar(32) NOT NULL,
  `search_terms` varchar(200) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_security_hashes`
--

CREATE TABLE IF NOT EXISTS `exp_security_hashes` (
  `hash_id` int(10) unsigned NOT NULL auto_increment,
  `date` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL default '0',
  `hash` varchar(40) NOT NULL,
  PRIMARY KEY  (`hash_id`),
  KEY `hash` (`hash`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=503 ;

--
-- Dumping data for table `exp_security_hashes`
--

INSERT INTO `exp_security_hashes` (`hash_id`, `date`, `ip_address`, `hash`) VALUES
(498, 1317806108, '81.149.49.226', 'b4a0c888794ed337057b7255fee0a9270e5a9ea9'),
(497, 1317806108, '81.149.49.226', 'd522c201ed38773a77b69ae87908dbf23a040d9d'),
(496, 1317806102, '81.149.49.226', '269a65b06ad72acbf5a846108997f218418e6e36'),
(495, 1317806097, '81.149.49.226', 'fd48583bdad68b77f6e325a6ff148ce04b58f990'),
(494, 1317806097, '81.149.49.226', '8db4218e6bc7240e4bbc9169f3ed1fca8a71ceff'),
(493, 1317806092, '81.149.49.226', '3c9095de8056aacb289b1ef0e42af24d13221b77'),
(492, 1317806072, '81.149.49.226', '814f4298a50e4a148aa3717476203982c2298740'),
(491, 1317806070, '81.149.49.226', '9be64b51c122aceed4d9a6ead934cdb4df2304ce'),
(490, 1317806067, '81.149.49.226', 'c2db634e7f97e415fb7d65a22929a1153ac57754'),
(489, 1317806061, '81.149.49.226', 'a8ef64b621c801d8a1441aa84dd1304bc6310a98'),
(488, 1317806061, '81.149.49.226', '3882223a3ac5800bf91188fdde161af725a76432'),
(487, 1317805618, '81.149.49.226', 'e2ad22b3d2d92b88d4d2029effb847bcbc35c48e'),
(486, 1317805612, '81.149.49.226', '4bdd212b7316d6660a28bdc68fa4f451886906eb'),
(485, 1317805607, '81.149.49.226', '8d7b8feaa3ae8848cee2051ceed4a096af8fbf54'),
(484, 1317805606, '81.149.49.226', 'c87aea69f64d8b3f0d82e7dcaf63ec702edf180e'),
(483, 1317805602, '81.149.49.226', '034ff2fa37659a28dd795af0b7baefdff7fabcba'),
(482, 1317805596, '81.149.49.226', '405f37ec4cda4cb1a6e33b5062edc28f0c625f74'),
(481, 1317805593, '81.149.49.226', '8ea6fb5f795c5626aeea24846a867fa7d12ea9c2'),
(480, 1317805592, '81.149.49.226', 'a9528622b861338f1360a7c98d6e6a3f8bd9f24b'),
(479, 1317805580, '81.149.49.226', '455d731d44da00458964dda02cd19f5ac79d9140'),
(478, 1317805577, '81.149.49.226', '213ce94c67941a67771dec75b0f9453f3e1a1cd7'),
(477, 1317805576, '81.149.49.226', 'e31c6421214f7f0587cb8f84be53ba27929ee6c2'),
(476, 1317805573, '81.149.49.226', '18b9ed146ee7306f38ac95c8897b052c442828de'),
(475, 1317805569, '81.149.49.226', 'd19c2141cad69a1f04f6e51b8088258f42932cd6'),
(474, 1317805569, '81.149.49.226', 'a31f33850ce1c33ae804de775b02f26409a3839c'),
(473, 1317805566, '81.149.49.226', '58e311fe670c35d08474ea878dfb15d9f7577f60'),
(472, 1317805551, '81.149.49.226', 'c7d27297fe67a767e494060594b4ea4d62c6ed9c'),
(471, 1317805551, '81.149.49.226', 'abd03aa2df31a9386c940aace7e9a29fc6e5705e'),
(470, 1317805551, '81.149.49.226', '9d645b481d03b1bec51cd15e5cda90c6019daf74'),
(469, 1317805538, '81.149.49.226', '3c7ccc6afa75581ab7e8602fede2949fb0ea980c'),
(468, 1317805538, '81.149.49.226', 'f6e0074c050ef0462cf6b5f6de5ee8838a33b26f'),
(467, 1317805538, '81.149.49.226', 'e0eb24c75bdafb9e78d30b7053ccab63f7845fc4'),
(466, 1317805530, '81.149.49.226', 'a30728da5c215268f2cfe4b3735a87d23627364f'),
(465, 1317805522, '81.149.49.226', 'b7d0948f158c5e75f620758016315606d7d789a9'),
(464, 1317805521, '81.149.49.226', 'ba237c3c35ce0d637f1b0661ed549072102b2259'),
(463, 1317805517, '81.149.49.226', '3a4bcb83fc4f3ee449da380841c66cd481c38814'),
(462, 1317805515, '81.149.49.226', '38a168c96b20d79e04f001ff79bc9aae05d5e7a4'),
(461, 1317805515, '81.149.49.226', '3c1e34c8a6890745999c29ade016d9347eabf381'),
(460, 1317805508, '81.149.49.226', 'd076f1ac2ac04cb1a966ce5a2ec8a69c21b3b187'),
(459, 1317805504, '81.149.49.226', 'e21be599db0fbe99a4ab0bce55c3cf1324f1b040'),
(458, 1317805504, '81.149.49.226', '96b06f2151c598cbde4b8d3c7c9f2f74e5895822'),
(457, 1317805499, '81.149.49.226', 'aa45e2b3b63819119f8cafa2322a386b735ebf71'),
(456, 1317805494, '81.149.49.226', '4d239b5b8d3dfcbd26dede99cef361c06f12a03b'),
(455, 1317805494, '81.149.49.226', 'a17bc719f1ed88d6b27417fea8a380617529b632'),
(454, 1317805482, '81.149.49.226', '2b9e4e978f722fedf83068abdd620143af663ae3'),
(453, 1317805478, '81.149.49.226', '81c2313cbd10b7aedd73ccf6364d249e55edae0d'),
(452, 1317805478, '81.149.49.226', '2a6ef10e44ab0b68483ae6c8fc6119031b0130e8'),
(451, 1317805473, '81.149.49.226', '29e7433a4c8e5c1d48bd536e0ca642b57c86a897'),
(450, 1317805464, '81.149.49.226', '2b7a358b4c8fb7786635086f5f205efe3f0da7c6'),
(449, 1317805464, '81.149.49.226', '3d02a9beb45e23624f9a4611376d3e9fb95ee8e7'),
(448, 1317805461, '81.149.49.226', 'b1a4c320d987f5004a33adc60fbd16880fec49a3'),
(447, 1317805458, '81.149.49.226', '20d2c2be4d430c714c844071bef7b5e3017af6c7'),
(446, 1317805458, '81.149.49.226', 'e53d1fd2570c2f964d399abd25eab25621fb71d1'),
(445, 1317805452, '81.149.49.226', '6315e3988a32aff0d8862c6e857c96a121567ed4'),
(444, 1317805449, '81.149.49.226', 'f6e7d5cc1e5d5cfc7769b1693f6e364a5dea8711'),
(443, 1317805449, '81.149.49.226', '8a126fd6974e2b1cec55bc1505df1ffe59fcec36'),
(442, 1317805439, '81.149.49.226', 'ebcaf8d89822eca9892f4fe01ef91ed0c56844bb'),
(441, 1317805433, '81.149.49.226', '3bd37386d0ca34eb7a2084827f4ddcb7f6ac54ee'),
(440, 1317805425, '81.149.49.226', '17edf2bd46bc033970c01dd6da9fda192f24ee52'),
(439, 1317805412, '81.149.49.226', 'e8c2f056c5d6717222792e7c27409317951a6c20'),
(438, 1317805405, '81.149.49.226', '16129a8229c5638e99f84894c021b53ee13f5770'),
(437, 1317805384, '81.149.49.226', '64e18db89f509a5210e1e793116cdb7204f03948'),
(436, 1317805378, '81.149.49.226', 'f5b481384e7fd21bdb8211b1544afc46e88b812f'),
(435, 1317805374, '81.149.49.226', 'b882d68ee097320ab6aad741abe278638e641456'),
(434, 1317805367, '81.149.49.226', '87215905edf2f8322f562e3617df7d5080dd3a16'),
(433, 1317805367, '81.149.49.226', '5812b616c9fc593bb00764ac056ff3d111f215d5'),
(432, 1317805333, '81.149.49.226', '532af671efc35208d1b1d9f1b37019fff174735b'),
(431, 1317805330, '81.149.49.226', 'acd7457882c6e296a2d8c4f59681e815ed98bd69'),
(430, 1317805329, '81.149.49.226', 'a2b2d2b31e19b299e05d6995cddf67b82bda4b6b'),
(429, 1317805326, '81.149.49.226', '56739c1a56fecde5921fbb9789acd8788058d8a5'),
(428, 1317805322, '81.149.49.226', 'f0469952a0ab2d43974d9c1e82eae2973c0544af'),
(427, 1317805321, '81.149.49.226', 'c90bf1e9290fecd3d1756e9e9e914cb529518fd5'),
(426, 1317805317, '81.149.49.226', 'd882d46a09a5892c20f3dce91b34103791a10add'),
(425, 1317805314, '81.149.49.226', '444e2143d9d4944be7398e96538f64799f8e0cb6'),
(424, 1317805314, '81.149.49.226', '1686071b140a612f8946b563d9313a5f1d81407e'),
(423, 1317805309, '81.149.49.226', 'ba3dd2eb7b3f7af0e95c29fce65afe9b65829282'),
(422, 1317805304, '81.149.49.226', 'bc42958bae2cdaf7bf5791400389d8f3f60d69c5'),
(421, 1317805304, '81.149.49.226', '22c1d7f50ac910ac8b8fac1c5412cd408b7a786d'),
(420, 1317805300, '81.149.49.226', 'c2a6a1dae758c83e83a74f5b6ebdd650f8e9143a'),
(419, 1317805297, '81.149.49.226', 'a3bfb2c00a9ce7037cf709fccf61bdd5692fae46'),
(418, 1317805296, '81.149.49.226', 'fc34169b8f0593dfd99ed70493fc7c7e12f2efa9'),
(417, 1317805292, '81.149.49.226', '35b56ffcc66fde12bb34f7364e6bd01f36382e66'),
(416, 1317805282, '81.149.49.226', '85f7d7be6e788a16022ed5e2860c8d210cb76984'),
(415, 1317805282, '81.149.49.226', '3ef478047ed4bd6dc45a62e98a5fb7b6e1a9285c'),
(414, 1317805276, '81.149.49.226', 'fe1c868f98efa284e8e1c0aa9926bd0364d971c9'),
(413, 1317805263, '81.149.49.226', '9cea8b13e92607760e5d454ac9492359dac7858d'),
(412, 1317805221, '81.149.49.226', '250d40295c04d3c368b23a14a9fcd296d7be9902'),
(411, 1317805221, '81.149.49.226', '9882a8abdf64a22b3b4f8711504806a253e5d5e5'),
(410, 1317805215, '81.149.49.226', '2086b539de5443690e4cdd945e51dd30cca3c032'),
(409, 1317805199, '81.149.49.226', 'a38671026d1f0f33d1745b4e9c2f8f977c2add3f'),
(408, 1317805199, '81.149.49.226', '00daa579c080df9c5221ca4c837b454ac951ce38'),
(407, 1317805189, '81.149.49.226', 'dcb7c6f072767e0e611ecd6840a96f4a99641225'),
(406, 1317805183, '81.149.49.226', '3cde32ce8b099d58def04eefb5c036bbe504bd0d'),
(405, 1317805183, '81.149.49.226', '4b0e79761a3fd7b6726e442402ec27eef42fea0c'),
(404, 1317805175, '81.149.49.226', '6f5656cdd87e8f9dc3e26b39a399bbdc358a3a0d'),
(403, 1317805166, '81.149.49.226', '6c22da0af926f6255e40479c594e107890e085b3'),
(402, 1317805160, '81.149.49.226', '9780621ea7d31e5282878bf1be5f23b666d27965'),
(401, 1317805110, '81.149.49.226', 'eb78468fc4c939a06ef0c80c502c65313dd2401f'),
(400, 1317805110, '81.149.49.226', 'e84d6666e950065d4864d7d2d86f89c6072a30d0'),
(399, 1317805097, '81.149.49.226', 'e0efc4806113d3cca0e91d42720ee64d999a5974'),
(398, 1317805077, '81.149.49.226', '893e99ea7715da4a538d028aa6cb6a0815825751'),
(397, 1317805064, '81.149.49.226', 'bf4e5949238e2c3045ce94a7a68a533c1bd4ab75'),
(396, 1317804283, '81.149.49.226', '6abe9558d978b5de783cbb005a40228c85af1149'),
(395, 1317804270, '81.149.49.226', '6dec9a3370c93289f48333e8ad0d8e04bae6192b'),
(394, 1317804250, '81.149.49.226', 'f55e4bba3f2506e8068b250e0a2fa60408675ef9'),
(393, 1317804249, '81.149.49.226', '8a0df986e15e4ba997a8960691f0b30d1fd0bbd6'),
(392, 1317804237, '81.149.49.226', '240fce2fa208ffb6cdddb5e152655450aa50692d'),
(391, 1317804232, '81.149.49.226', 'a1788613704390f819cca3b755bf16e0f8cedbf1'),
(390, 1317804229, '81.149.49.226', '797a03304e470af52dd41465fbf34a3466527274'),
(389, 1317804227, '81.149.49.226', 'd4654454a30cf1c2869b61cf4f75cc65ddea5ee3'),
(388, 1317804218, '81.149.49.226', 'eb2665c6e6798bb8d82dec710bdeb0f213f15689'),
(387, 1317804218, '81.149.49.226', '42fc7091a52c492e83b35f98d48c4f9024421415'),
(386, 1317804182, '81.149.49.226', '8699189a229e9180fb2b6a98d158dcb27e3a0abc'),
(385, 1317804166, '81.149.49.226', 'bf89572dd46fdd532b8d4aa9178281c8f4c0eb55'),
(384, 1317803992, '81.149.49.226', '092d1f87068bfa781e365fc8da4957cb8517bbbb'),
(383, 1317803985, '81.149.49.226', 'f9d8b8a75a78480dc6580c9f4cc4e1d2fccda300'),
(382, 1317803974, '81.149.49.226', '5d24da0f1dcefcb9c01a66c5279100b371572223'),
(381, 1317803965, '81.149.49.226', '5f5ec45ef317c35db37d0c09fcc8c146ad3b3ae6'),
(380, 1317803944, '81.149.49.226', 'df76bc1a44339ba88e18efbbbd2e48449b18ae04'),
(379, 1317803925, '81.149.49.226', '8cfdbc76c1832c3c572d5637b760614ea52b791b'),
(378, 1317803906, '81.149.49.226', 'aa63becb498acf6188707ea22712e42f644b4903'),
(377, 1317803887, '81.149.49.226', '46c0dba7836a61daad4f8da43bf55823a757d0c1'),
(376, 1317803878, '81.149.49.226', '86795a7a6b9429f63dcad4df204ab23a1461c4a5'),
(375, 1317803861, '81.149.49.226', 'a515b2ede208ef1d9c143edc84623bbe89d0d8b1'),
(374, 1317803851, '81.149.49.226', 'eafe7c59027cebf80a06993dc71121ad88b618bc'),
(373, 1317803826, '81.149.49.226', '3ae9b5ceed51a5affeba895c419ea39320da6996'),
(372, 1317803766, '81.149.49.226', '475619439c3d9293ecb8d289e13652fd0830d6c5'),
(371, 1317803615, '81.149.49.226', '39a5a8dc27768c78f8ac529ebaf24ac2baa87de8'),
(370, 1317803615, '81.149.49.226', '8e32e4ff7d3526f4b24a63711117e71ef52324ca'),
(369, 1317803608, '81.149.49.226', 'da1f1c106a452dd885cba676a0f33c94fec3c991'),
(368, 1317803608, '81.149.49.226', 'a58933b41c54dadfb16821cdbd563551686a168a'),
(367, 1317803603, '81.149.49.226', 'ae0bb20f547a6b8a04033baa15c9a92594246731'),
(366, 1317803599, '81.149.49.226', 'c85888ba40423d03cb9a594b055d5434a08e0371'),
(365, 1317803594, '81.149.49.226', 'f67aa9cc21ab8c16b4766bfce27ca3253fbb7f36'),
(364, 1317803589, '81.149.49.226', '21b9a19c3dfc466d2f978b35c819fad35018cf0b'),
(363, 1317803588, '81.149.49.226', '37590286c50a99881abbd2f27c196d3ed1eb49ea'),
(362, 1317803575, '81.149.49.226', '7f3c3ac61d894c98365045a7fdaa97d5ed8a5e57'),
(361, 1317803572, '81.149.49.226', 'f4bfd326a03d28e8479ae29018478a5a70384f26'),
(360, 1317803572, '81.149.49.226', '19dcab246f11ae6ba073612326065ff6aaf8bce1'),
(359, 1317803548, '81.149.49.226', '1db49531e03a507edc1053adfbb00dc30bc92f85'),
(358, 1317803544, '81.149.49.226', 'a28f4de8c94699de103abfce16bc1bae3c164edf'),
(357, 1317803541, '81.149.49.226', '71edd7e1b62aa976ab05024398ba8e43084a16c3'),
(356, 1317803537, '81.149.49.226', 'c1505e60d4a5e6664808000c4f2aaef0eb2fa6e1'),
(355, 1317803533, '81.149.49.226', '4e194d573dee12cafc2427328270e16abbdc4be4'),
(354, 1317803533, '81.149.49.226', 'f48b4e299dc1f02dde26f3160efcc89d0e61fb56'),
(353, 1317803509, '81.149.49.226', '341310cab17bbce409e85a32055f4503020ab177'),
(352, 1317803503, '81.149.49.226', 'ecf70c7bcd5149577761ebfe3907256e90aa7e0c'),
(351, 1317803503, '81.149.49.226', '707b60ed9b399032dcca557ef21fdc9e2dce41e3'),
(350, 1317803490, '81.149.49.226', 'd92e7204c87f4f40d0932c30240697028470eca7'),
(349, 1317803263, '81.149.49.226', '74e14087f62f93a3655fa50924c1d3da636e70ea'),
(348, 1317803260, '81.149.49.226', 'ba0a15920f8491cb372134c881e4e963feb2a364'),
(347, 1317803257, '81.149.49.226', 'e99039afd316a453b6364f268ce146fd0893c7f2'),
(346, 1317803251, '81.149.49.226', 'b6b05a0b00a812cebf89906d2a87184abc1b4688'),
(345, 1317803251, '81.149.49.226', '39b8a52b89112976842f18086b2e8a0ee35be6e3'),
(344, 1317803248, '81.149.49.226', 'ace7ac966541f3a895e7765b65db7e96f454b204'),
(343, 1317803245, '81.149.49.226', 'd2b23d54f30baad5fea9411770ab16a77f6a7859'),
(342, 1317803242, '81.149.49.226', '3bf5f4ba5fce43382ef99ba75060d6b34343be6d'),
(341, 1317803008, '81.149.49.226', '5b922f7b913e4ee9f46c1cc162b4485f7f2e2c71'),
(340, 1317803004, '81.149.49.226', 'e23e0e5bf4ea8bc8d7b9735c86f536651da1b878'),
(339, 1317802996, '81.149.49.226', '7a313ed409955b5add4f12625534d74d5d90eef7'),
(338, 1317802956, '81.149.49.226', 'b8f07225ca5dea94b944249224f2525294d2fce2'),
(337, 1317802951, '81.149.49.226', 'bbb6a668e127432903a9da525c1b179172496d5d'),
(336, 1317802951, '81.149.49.226', 'a58ae6638a2cb01edf994418c969178c8e27b35f'),
(335, 1317802945, '81.149.49.226', 'e89ace22200fc67e8a1d14c64158c216e9895d41'),
(334, 1317802940, '81.149.49.226', 'faf03f671fcc295f165e029fd7748822bc3db771'),
(333, 1317802940, '81.149.49.226', '38549cd7fc3383a835c02cb88a1b36f28ec2cc2e'),
(332, 1317802931, '81.149.49.226', '99b23be9342bc9a1238b02b68efb7fbddbc28fa5'),
(331, 1317802800, '81.149.49.226', 'f26ea7247936bd0166c9e61ca2bb32d1b57de792'),
(330, 1317802797, '81.149.49.226', 'b74e9cd9f7a4d1e15572247f9e7b0e45f65e24e3'),
(329, 1317802787, '81.149.49.226', 'af18fb3bf4b4548f82303b8a9740924dbac5fae9'),
(328, 1317802786, '81.149.49.226', 'efa1925f8bb6c54e3a1264ea1ab8a1616f20cb4b'),
(327, 1317802780, '81.149.49.226', '19f5415c8349cfde6f756e85aca05fe0a4f35e39'),
(326, 1317802779, '81.149.49.226', 'a070da48f59b8150482a46de3242dd62e236b7e9'),
(325, 1317802768, '81.149.49.226', '8cf47251fd905edbb4e0bdb2626fc28d40edb821'),
(324, 1317802767, '81.149.49.226', '9e36ffde262a158832428ede74c0518963e91716'),
(323, 1317802752, '81.149.49.226', '05ca54e448f843a2af00586f5fa49c04fa09e21d'),
(322, 1317802751, '81.149.49.226', '61e69d16085eaff9ea4295a11df6f28e2e96d144'),
(321, 1317802746, '81.149.49.226', 'a5bc45c0d2763d61bf77011c39d77f136553cf43'),
(320, 1317802745, '81.149.49.226', '0360ad843ff1d701a85e391834ec661facb822f6'),
(319, 1317802745, '81.149.49.226', 'f6ec33a974185e04b22a926fedab0ad4c2a3abc5'),
(318, 1317802730, '81.149.49.226', 'b672113fa06a5740244dfaaf845992e664739a79'),
(317, 1317802729, '81.149.49.226', 'b31356c943a7a7e0043511ed8cf92f698fc4d5ae'),
(316, 1317802725, '81.149.49.226', '760d521773dd13da59f77d7a681d748a16c0fe04'),
(315, 1317802724, '81.149.49.226', '91894e9ef57124d10007037f37133f8a5cecca45'),
(314, 1317802721, '81.149.49.226', '5bf859c0bda1fc3a8f45ff3b19a4ace3d44e2592'),
(313, 1317802720, '81.149.49.226', '08e4bb7d98ec6eb34f24da01b1b5b8b13c181141'),
(312, 1317802717, '81.149.49.226', '54554bb73c3876c9520c805c8dae3a47d999c642'),
(311, 1317802716, '81.149.49.226', 'daa10f5dc28f2caf3d7843dc0caf81217e444676'),
(310, 1317802698, '81.149.49.226', '8de9abf8f18362100321a552c436c1ae59214049'),
(309, 1317802664, '81.149.49.226', 'a6de872da8b08f27cc2803f377bc43aab61f439b'),
(308, 1317802660, '81.149.49.226', 'b3236544bb7d0130a0cad5df89e8a3b7def86f47'),
(307, 1317802659, '81.149.49.226', 'af0ae392f18739abfb0e99b2a232c5c8a80307d4'),
(306, 1317802651, '81.149.49.226', '6377e73c7814f9a6bc84ea3fee2e29d40a48cbeb'),
(305, 1317802645, '81.149.49.226', '074838648417ac888f55f1f9c2684ccb8870a71c'),
(304, 1317802643, '81.149.49.226', 'a620c6bdb76e08b2a483c779b5b3a5781b3d8396'),
(303, 1317802643, '81.149.49.226', 'f875a91cad4c37993b1f15409a98c83e0acdfeea'),
(302, 1317802635, '81.149.49.226', 'ebf4899a4e013c0d30271e5254253abc6fc4cbd5'),
(301, 1317802634, '81.149.49.226', 'fe2140786bcd81d37a3f730a6612b03d7266ce2f'),
(300, 1317802634, '81.149.49.226', '0ee55e03462a1e9f42a9796df17c5b3cbfc20425'),
(299, 1317802578, '81.149.49.226', '997234cd915f7a635bc4ac7b9a23ea23b6af4df9'),
(298, 1317802578, '81.149.49.226', '779d07dc2f5e0fcb7db3fdf983ae012d030b32d9'),
(297, 1317802562, '81.149.49.226', '179d12d69c6b0b997115a5065df6eede1b2e54cb'),
(296, 1317802554, '81.149.49.226', '4ec54202e0001d0ba5e76ef26f0547a701323f44'),
(295, 1317802554, '81.149.49.226', '2de99d0c59d775456afefcfbbce0fb793af1d68f'),
(294, 1317802538, '81.149.49.226', 'c45cd1e4765d3c0795c06cd5a637a6255d082d27'),
(293, 1317802538, '81.149.49.226', 'db27e52934f63dd3a9db9001e14257afef1a53df'),
(292, 1317802538, '81.149.49.226', 'beced22eb179c4f5e517261f22c17527e1538b7f'),
(291, 1317802536, '81.149.49.226', '13c537f5360748087b49146bf3b804f3abb08458'),
(290, 1317802534, '81.149.49.226', '006f5a9ab920bde988627f3d3b8c36ec84908997'),
(289, 1317802533, '81.149.49.226', 'a62e38dca75d0973d7ba438c421141981643fb05'),
(288, 1317802528, '81.149.49.226', '503221e489eeba0508228b75750522dbf913ffaa'),
(287, 1317802528, '81.149.49.226', 'e6b8f3eabcb516608b2be26be220c549e849f93f'),
(286, 1317802499, '81.149.49.226', 'bd347735be89ec1df07d9af747567bfbd8c0845f'),
(285, 1317802490, '81.149.49.226', '14c930092d73b4a34b9cdf1e136665264a799bab'),
(284, 1317802489, '81.149.49.226', '89f2780f05601d99d71bee87e5a56174a1275e36'),
(283, 1317802478, '81.149.49.226', 'c623104308dabdb42aaad9cc05ce54ca14fe76aa'),
(282, 1317802478, '81.149.49.226', '143a467cb46136f7bc9beab144af4dce8848299b'),
(281, 1317802477, '81.149.49.226', '6f1d376e656a047a3259dd755d1db6bf2f2fa041'),
(280, 1317802475, '81.149.49.226', '8aeb1210e5322ba2c94329cd5aa78a987153db51'),
(279, 1317802471, '81.149.49.226', 'f39620c590cefd1fc90f417489d33d852e94f70f'),
(278, 1317802469, '81.149.49.226', '2429721e30a6941d2b59c225c318feca0a1c6461'),
(277, 1317801941, '81.149.49.226', 'ab94d283521453015532fa4278b6c947c59c13e7'),
(276, 1317801940, '81.149.49.226', 'e3803ae5b5b88672055f72053fee8197eea13b92'),
(275, 1317801931, '81.149.49.226', '179e722d74d166ae8c1712d5cad13f7efc8ae8a2'),
(274, 1317801930, '81.149.49.226', 'cb4f888d7829ae3edb7e21b270480b9ee1cf10f7'),
(273, 1317801923, '81.149.49.226', '20ca8c9f88e94b5e1ff72751beef18facb272b72'),
(272, 1317801877, '81.149.49.226', 'e78f9c8d11930d6aaa50820d60b1aa2e88985c15'),
(271, 1317801876, '81.149.49.226', '8db6d3ec1a5e198efdd806e1014063fde23b8098'),
(270, 1317801849, '81.149.49.226', 'cfb45ad884b52ac67dcaeb709010290a93801552'),
(269, 1317801841, '81.149.49.226', '9c063101c9ada83b219190814904b38d745fa218'),
(268, 1317801836, '81.149.49.226', '4972270a5fd2f6ca930fcb76a43af15ac8ae32c6'),
(267, 1317801823, '81.149.49.226', '7563286d550134327d1cb84fd9dd7a987378fef0'),
(266, 1317801822, '81.149.49.226', '6031d1c6c058ae1574874806681fe02c7ebdc876'),
(265, 1317801822, '81.149.49.226', '1cc4d85513ab73c90d38e3410f96b16e0026f853'),
(264, 1317801804, '81.149.49.226', '82b60ed05cd9c96cec8d3934f4cf28354e592b07'),
(263, 1317801803, '81.149.49.226', '8e04c49394124a786e9e7587f944a3f43fae6113'),
(262, 1317801799, '81.149.49.226', '7b639ccb2dfc537d65cc9df54e24005be384043e'),
(261, 1317801798, '81.149.49.226', '163f05b5b624cd949edd965cf2565827463a0083'),
(260, 1317801769, '81.149.49.226', 'e53bcb91bc20d12d4301b46da81b97ce0f4ee5cb'),
(259, 1317801767, '81.149.49.226', '4674b24c00b603edd2fe31e91dd885d3c4e2129e'),
(258, 1317801767, '81.149.49.226', '887492372c1079579092f093f01c35b0feb99338'),
(257, 1317801763, '81.149.49.226', 'b0ec3879131032ce33bc630196d1d9dc8362c7d5'),
(256, 1317801762, '81.149.49.226', 'b711d8d1249c0c000ae83c197e25008aae8b3640'),
(255, 1317801758, '81.149.49.226', 'feb5bf4779bdacda7c1f5d17a39a64958aa02d3d'),
(254, 1317801727, '81.149.49.226', 'eb0755024ab6f82eb587642acab068df9068e879'),
(253, 1317801333, '81.149.49.226', '816f2f7968df2452c5fe22493e57d60f9ccb40d0'),
(252, 1317801309, '81.149.49.226', '33f3768bb4b9e9c3f5bd1d40764f755407aa8dcb'),
(251, 1317801309, '81.149.49.226', '8a69e7effbb7c2813396308fd3910448606d90b4'),
(249, 1317801291, '81.149.49.226', 'c0477afa1122d9cea72ebc0bd5354597b31cb09e'),
(250, 1317801292, '81.149.49.226', '1a58e8ebd0dc2e2d994692df0ae978d686751626'),
(499, 1317806117, '81.149.49.226', '0c65a7f8586f8440f334a4bffcf49cae21bed1f2'),
(500, 1317806125, '81.149.49.226', '305e329527a57cadc8a22bd84c51229d8573d210'),
(501, 1317806134, '81.149.49.226', '22c7b3f207e296885b855486dc290d69dc330737'),
(502, 1317806135, '81.149.49.226', '1f75f010469a8312763ca3e80013c4ffa99de7f8');

-- --------------------------------------------------------

--
-- Table structure for table `exp_sessions`
--

CREATE TABLE IF NOT EXISTS `exp_sessions` (
  `session_id` varchar(40) NOT NULL default '0',
  `site_id` int(4) unsigned NOT NULL default '1',
  `member_id` int(10) NOT NULL default '0',
  `admin_sess` tinyint(1) NOT NULL default '0',
  `ip_address` varchar(16) NOT NULL default '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`session_id`),
  KEY `member_id` (`member_id`),
  KEY `site_id` (`site_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_sessions`
--

INSERT INTO `exp_sessions` (`session_id`, `site_id`, `member_id`, `admin_sess`, `ip_address`, `user_agent`, `last_activity`) VALUES
('1f675c30af486313646ede384a5986971ff57906', 1, 1, 1, '81.149.49.226', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7) AppleWebKit/534.48.3 (KHTML, like Gecko) Version/5.1 Safari/534.48.3', 1317806135),
('31a0324720022aeb14fd5b54a1bdf7dfc9df79b1', 1, 1, 1, '81.149.49.226', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7) AppleWebKit/534.48.3 (KHTML, like Gecko) Version/5.1 Safari/534.48.3', 1317803008);

-- --------------------------------------------------------

--
-- Table structure for table `exp_sites`
--

CREATE TABLE IF NOT EXISTS `exp_sites` (
  `site_id` int(5) unsigned NOT NULL auto_increment,
  `site_label` varchar(100) NOT NULL default '',
  `site_name` varchar(50) NOT NULL default '',
  `site_description` text,
  `site_system_preferences` text NOT NULL,
  `site_mailinglist_preferences` text NOT NULL,
  `site_member_preferences` text NOT NULL,
  `site_template_preferences` text NOT NULL,
  `site_channel_preferences` text NOT NULL,
  `site_bootstrap_checksums` text NOT NULL,
  PRIMARY KEY  (`site_id`),
  KEY `site_name` (`site_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_sites`
--

INSERT INTO `exp_sites` (`site_id`, `site_label`, `site_name`, `site_description`, `site_system_preferences`, `site_mailinglist_preferences`, `site_member_preferences`, `site_template_preferences`, `site_channel_preferences`, `site_bootstrap_checksums`) VALUES
(1, 'Drai Fine Art', 'default_site', NULL, 'YTo5MDp7czoxMDoic2l0ZV9pbmRleCI7czowOiIiO3M6ODoic2l0ZV91cmwiO3M6Mjc6Imh0dHA6Ly93d3cuZHJhaWZpbmVhcnQuY29tLyI7czoxNjoidGhlbWVfZm9sZGVyX3VybCI7czozNDoiaHR0cDovL3d3dy5kcmFpZmluZWFydC5jb20vdGhlbWVzLyI7czoxNToid2VibWFzdGVyX2VtYWlsIjtzOjIzOiJwYXVsQGstY29sbGVjdGl2ZS5jby51ayI7czoxNDoid2VibWFzdGVyX25hbWUiO3M6MDoiIjtzOjIwOiJjaGFubmVsX25vbWVuY2xhdHVyZSI7czo3OiJjaGFubmVsIjtzOjEwOiJtYXhfY2FjaGVzIjtzOjM6IjE1MCI7czoxMToiY2FwdGNoYV91cmwiO3M6NDM6Imh0dHA6Ly93d3cuZHJhaWZpbmVhcnQuY29tL2ltYWdlcy9jYXB0Y2hhcy8iO3M6MTI6ImNhcHRjaGFfcGF0aCI7czo0NDoiL2hvbWUyL2RyYWlmaW5lL3B1YmxpY19odG1sL2ltYWdlcy9jYXB0Y2hhcy8iO3M6MTI6ImNhcHRjaGFfZm9udCI7czoxOiJ5IjtzOjEyOiJjYXB0Y2hhX3JhbmQiO3M6MToieSI7czoyMzoiY2FwdGNoYV9yZXF1aXJlX21lbWJlcnMiO3M6MToibiI7czoxNzoiZW5hYmxlX2RiX2NhY2hpbmciO3M6MToibiI7czoxODoiZW5hYmxlX3NxbF9jYWNoaW5nIjtzOjE6Im4iO3M6MTg6ImZvcmNlX3F1ZXJ5X3N0cmluZyI7czoxOiJuIjtzOjEzOiJzaG93X3Byb2ZpbGVyIjtzOjE6Im4iO3M6MTg6InRlbXBsYXRlX2RlYnVnZ2luZyI7czoxOiJuIjtzOjE1OiJpbmNsdWRlX3NlY29uZHMiO3M6MToibiI7czoxMzoiY29va2llX2RvbWFpbiI7czowOiIiO3M6MTE6ImNvb2tpZV9wYXRoIjtzOjA6IiI7czoxNzoidXNlcl9zZXNzaW9uX3R5cGUiO3M6MToiYyI7czoxODoiYWRtaW5fc2Vzc2lvbl90eXBlIjtzOjI6ImNzIjtzOjIxOiJhbGxvd191c2VybmFtZV9jaGFuZ2UiO3M6MToieSI7czoxODoiYWxsb3dfbXVsdGlfbG9naW5zIjtzOjE6InkiO3M6MTY6InBhc3N3b3JkX2xvY2tvdXQiO3M6MToieSI7czoyNToicGFzc3dvcmRfbG9ja291dF9pbnRlcnZhbCI7czoxOiIxIjtzOjIwOiJyZXF1aXJlX2lwX2Zvcl9sb2dpbiI7czoxOiJ5IjtzOjIyOiJyZXF1aXJlX2lwX2Zvcl9wb3N0aW5nIjtzOjE6InkiO3M6MjQ6InJlcXVpcmVfc2VjdXJlX3Bhc3N3b3JkcyI7czoxOiJuIjtzOjE5OiJhbGxvd19kaWN0aW9uYXJ5X3B3IjtzOjE6InkiO3M6MjM6Im5hbWVfb2ZfZGljdGlvbmFyeV9maWxlIjtzOjA6IiI7czoxNzoieHNzX2NsZWFuX3VwbG9hZHMiO3M6MToieSI7czoxNToicmVkaXJlY3RfbWV0aG9kIjtzOjg6InJlZGlyZWN0IjtzOjk6ImRlZnRfbGFuZyI7czo3OiJlbmdsaXNoIjtzOjg6InhtbF9sYW5nIjtzOjI6ImVuIjtzOjEyOiJzZW5kX2hlYWRlcnMiO3M6MToieSI7czoxMToiZ3ppcF9vdXRwdXQiO3M6MToibiI7czoxMzoibG9nX3JlZmVycmVycyI7czoxOiJuIjtzOjEzOiJtYXhfcmVmZXJyZXJzIjtzOjM6IjUwMCI7czoxMToidGltZV9mb3JtYXQiO3M6MjoidXMiO3M6MTU6InNlcnZlcl90aW1lem9uZSI7czozOiJVVEMiO3M6MTM6InNlcnZlcl9vZmZzZXQiO3M6MDoiIjtzOjE2OiJkYXlsaWdodF9zYXZpbmdzIjtzOjE6InkiO3M6MjE6ImRlZmF1bHRfc2l0ZV90aW1lem9uZSI7czozOiJVVEMiO3M6MTY6ImRlZmF1bHRfc2l0ZV9kc3QiO3M6MToieSI7czoxNToiaG9ub3JfZW50cnlfZHN0IjtzOjE6InkiO3M6MTM6Im1haWxfcHJvdG9jb2wiO3M6NDoibWFpbCI7czoxMToic210cF9zZXJ2ZXIiO3M6MDoiIjtzOjEzOiJzbXRwX3VzZXJuYW1lIjtzOjA6IiI7czoxMzoic210cF9wYXNzd29yZCI7czowOiIiO3M6MTE6ImVtYWlsX2RlYnVnIjtzOjE6Im4iO3M6MTM6ImVtYWlsX2NoYXJzZXQiO3M6NToidXRmLTgiO3M6MTU6ImVtYWlsX2JhdGNobW9kZSI7czoxOiJuIjtzOjE2OiJlbWFpbF9iYXRjaF9zaXplIjtzOjA6IiI7czoxMToibWFpbF9mb3JtYXQiO3M6NToicGxhaW4iO3M6OToid29yZF93cmFwIjtzOjE6InkiO3M6MjI6ImVtYWlsX2NvbnNvbGVfdGltZWxvY2siO3M6MToiNSI7czoyMjoibG9nX2VtYWlsX2NvbnNvbGVfbXNncyI7czoxOiJ5IjtzOjg6ImNwX3RoZW1lIjtzOjc6ImRlZmF1bHQiO3M6MjE6ImVtYWlsX21vZHVsZV9jYXB0Y2hhcyI7czoxOiJuIjtzOjE2OiJsb2dfc2VhcmNoX3Rlcm1zIjtzOjE6InkiO3M6MTI6InNlY3VyZV9mb3JtcyI7czoxOiJ5IjtzOjE5OiJkZW55X2R1cGxpY2F0ZV9kYXRhIjtzOjE6InkiO3M6MjQ6InJlZGlyZWN0X3N1Ym1pdHRlZF9saW5rcyI7czoxOiJuIjtzOjE2OiJlbmFibGVfY2Vuc29yaW5nIjtzOjE6Im4iO3M6MTQ6ImNlbnNvcmVkX3dvcmRzIjtzOjA6IiI7czoxODoiY2Vuc29yX3JlcGxhY2VtZW50IjtzOjA6IiI7czoxMDoiYmFubmVkX2lwcyI7czowOiIiO3M6MTM6ImJhbm5lZF9lbWFpbHMiO3M6MDoiIjtzOjE2OiJiYW5uZWRfdXNlcm5hbWVzIjtzOjA6IiI7czoxOToiYmFubmVkX3NjcmVlbl9uYW1lcyI7czowOiIiO3M6MTA6ImJhbl9hY3Rpb24iO3M6ODoicmVzdHJpY3QiO3M6MTE6ImJhbl9tZXNzYWdlIjtzOjM0OiJUaGlzIHNpdGUgaXMgY3VycmVudGx5IHVuYXZhaWxhYmxlIjtzOjE1OiJiYW5fZGVzdGluYXRpb24iO3M6MjE6Imh0dHA6Ly93d3cueWFob28uY29tLyI7czoxNjoiZW5hYmxlX2Vtb3RpY29ucyI7czoxOiJ5IjtzOjEzOiJlbW90aWNvbl9wYXRoIjtzOjQyOiJodHRwOi8vd3d3LmRyYWlmaW5lYXJ0LmNvbS9pbWFnZXMvc21pbGV5cy8iO3M6MTk6InJlY291bnRfYmF0Y2hfdG90YWwiO3M6NDoiMTAwMCI7czoxNzoibmV3X3ZlcnNpb25fY2hlY2siO3M6MToieSI7czoxNzoiZW5hYmxlX3Rocm90dGxpbmciO3M6MToibiI7czoxNzoiYmFuaXNoX21hc2tlZF9pcHMiO3M6MToieSI7czoxNDoibWF4X3BhZ2VfbG9hZHMiO3M6MjoiMTAiO3M6MTM6InRpbWVfaW50ZXJ2YWwiO3M6MToiOCI7czoxMjoibG9ja291dF90aW1lIjtzOjI6IjMwIjtzOjE1OiJiYW5pc2htZW50X3R5cGUiO3M6NzoibWVzc2FnZSI7czoxNDoiYmFuaXNobWVudF91cmwiO3M6MDoiIjtzOjE4OiJiYW5pc2htZW50X21lc3NhZ2UiO3M6NTA6IllvdSBoYXZlIGV4Y2VlZGVkIHRoZSBhbGxvd2VkIHBhZ2UgbG9hZCBmcmVxdWVuY3kuIjtzOjE3OiJlbmFibGVfc2VhcmNoX2xvZyI7czoxOiJ5IjtzOjE5OiJtYXhfbG9nZ2VkX3NlYXJjaGVzIjtzOjM6IjUwMCI7czoxNzoidGhlbWVfZm9sZGVyX3BhdGgiO3M6MzU6Ii9ob21lMi9kcmFpZmluZS9wdWJsaWNfaHRtbC90aGVtZXMvIjtzOjEwOiJpc19zaXRlX29uIjtzOjE6InkiO30=', 'YTozOntzOjE5OiJtYWlsaW5nbGlzdF9lbmFibGVkIjtzOjE6InkiO3M6MTg6Im1haWxpbmdsaXN0X25vdGlmeSI7czoxOiJuIjtzOjI1OiJtYWlsaW5nbGlzdF9ub3RpZnlfZW1haWxzIjtzOjA6IiI7fQ==', 'YTo0NDp7czoxMDoidW5fbWluX2xlbiI7czoxOiI0IjtzOjEwOiJwd19taW5fbGVuIjtzOjE6IjUiO3M6MjU6ImFsbG93X21lbWJlcl9yZWdpc3RyYXRpb24iO3M6MToibiI7czoyNToiYWxsb3dfbWVtYmVyX2xvY2FsaXphdGlvbiI7czoxOiJ5IjtzOjE4OiJyZXFfbWJyX2FjdGl2YXRpb24iO3M6NToiZW1haWwiO3M6MjM6Im5ld19tZW1iZXJfbm90aWZpY2F0aW9uIjtzOjE6Im4iO3M6MjM6Im1icl9ub3RpZmljYXRpb25fZW1haWxzIjtzOjA6IiI7czoyNDoicmVxdWlyZV90ZXJtc19vZl9zZXJ2aWNlIjtzOjE6InkiO3M6MjI6InVzZV9tZW1iZXJzaGlwX2NhcHRjaGEiO3M6MToibiI7czoyMDoiZGVmYXVsdF9tZW1iZXJfZ3JvdXAiO3M6MToiNSI7czoxNToicHJvZmlsZV90cmlnZ2VyIjtzOjY6Im1lbWJlciI7czoxMjoibWVtYmVyX3RoZW1lIjtzOjc6ImRlZmF1bHQiO3M6MTQ6ImVuYWJsZV9hdmF0YXJzIjtzOjE6InkiO3M6MjA6ImFsbG93X2F2YXRhcl91cGxvYWRzIjtzOjE6Im4iO3M6MTA6ImF2YXRhcl91cmwiO3M6NDI6Imh0dHA6Ly93d3cuZHJhaWZpbmVhcnQuY29tL2ltYWdlcy9hdmF0YXJzLyI7czoxMToiYXZhdGFyX3BhdGgiO3M6NDM6Ii9ob21lMi9kcmFpZmluZS9wdWJsaWNfaHRtbC9pbWFnZXMvYXZhdGFycy8iO3M6MTY6ImF2YXRhcl9tYXhfd2lkdGgiO3M6MzoiMTAwIjtzOjE3OiJhdmF0YXJfbWF4X2hlaWdodCI7czozOiIxMDAiO3M6MTM6ImF2YXRhcl9tYXhfa2IiO3M6MjoiNTAiO3M6MTM6ImVuYWJsZV9waG90b3MiO3M6MToibiI7czo5OiJwaG90b191cmwiO3M6NDg6Imh0dHA6Ly93d3cuZHJhaWZpbmVhcnQuY29tL2ltYWdlcy9tZW1iZXJfcGhvdG9zLyI7czoxMDoicGhvdG9fcGF0aCI7czo0OToiL2hvbWUyL2RyYWlmaW5lL3B1YmxpY19odG1sL2ltYWdlcy9tZW1iZXJfcGhvdG9zLyI7czoxNToicGhvdG9fbWF4X3dpZHRoIjtzOjM6IjEwMCI7czoxNjoicGhvdG9fbWF4X2hlaWdodCI7czozOiIxMDAiO3M6MTI6InBob3RvX21heF9rYiI7czoyOiI1MCI7czoxNjoiYWxsb3dfc2lnbmF0dXJlcyI7czoxOiJ5IjtzOjEzOiJzaWdfbWF4bGVuZ3RoIjtzOjM6IjUwMCI7czoyMToic2lnX2FsbG93X2ltZ19ob3RsaW5rIjtzOjE6Im4iO3M6MjA6InNpZ19hbGxvd19pbWdfdXBsb2FkIjtzOjE6Im4iO3M6MTE6InNpZ19pbWdfdXJsIjtzOjU2OiJodHRwOi8vd3d3LmRyYWlmaW5lYXJ0LmNvbS9pbWFnZXMvc2lnbmF0dXJlX2F0dGFjaG1lbnRzLyI7czoxMjoic2lnX2ltZ19wYXRoIjtzOjU3OiIvaG9tZTIvZHJhaWZpbmUvcHVibGljX2h0bWwvaW1hZ2VzL3NpZ25hdHVyZV9hdHRhY2htZW50cy8iO3M6MTc6InNpZ19pbWdfbWF4X3dpZHRoIjtzOjM6IjQ4MCI7czoxODoic2lnX2ltZ19tYXhfaGVpZ2h0IjtzOjI6IjgwIjtzOjE0OiJzaWdfaW1nX21heF9rYiI7czoyOiIzMCI7czoxOToicHJ2X21zZ191cGxvYWRfcGF0aCI7czo1MDoiL2hvbWUyL2RyYWlmaW5lL3B1YmxpY19odG1sL2ltYWdlcy9wbV9hdHRhY2htZW50cy8iO3M6MjM6InBydl9tc2dfbWF4X2F0dGFjaG1lbnRzIjtzOjE6IjMiO3M6MjI6InBydl9tc2dfYXR0YWNoX21heHNpemUiO3M6MzoiMjUwIjtzOjIwOiJwcnZfbXNnX2F0dGFjaF90b3RhbCI7czozOiIxMDAiO3M6MTk6InBydl9tc2dfaHRtbF9mb3JtYXQiO3M6NDoic2FmZSI7czoxODoicHJ2X21zZ19hdXRvX2xpbmtzIjtzOjE6InkiO3M6MTc6InBydl9tc2dfbWF4X2NoYXJzIjtzOjQ6IjYwMDAiO3M6MTk6Im1lbWJlcmxpc3Rfb3JkZXJfYnkiO3M6MTE6InRvdGFsX3Bvc3RzIjtzOjIxOiJtZW1iZXJsaXN0X3NvcnRfb3JkZXIiO3M6NDoiZGVzYyI7czoyMDoibWVtYmVybGlzdF9yb3dfbGltaXQiO3M6MjoiMjAiO30=', 'YTo2OntzOjExOiJzdHJpY3RfdXJscyI7czoxOiJuIjtzOjg6InNpdGVfNDA0IjtzOjg6InNpdGUvNDA0IjtzOjE5OiJzYXZlX3RtcGxfcmV2aXNpb25zIjtzOjE6Im4iO3M6MTg6Im1heF90bXBsX3JldmlzaW9ucyI7czoxOiI1IjtzOjE1OiJzYXZlX3RtcGxfZmlsZXMiO3M6MToieSI7czoxODoidG1wbF9maWxlX2Jhc2VwYXRoIjtzOjY0OiIvaG9tZTIvZHJhaWZpbmUvcHVibGljX2h0bWwvdGhlbWVzL3NpdGVfdGhlbWVzL2h0bWw1Ym9pbGVycGxhdEVFIjt9', 'YTo5OntzOjIxOiJpbWFnZV9yZXNpemVfcHJvdG9jb2wiO3M6MzoiZ2QyIjtzOjE4OiJpbWFnZV9saWJyYXJ5X3BhdGgiO3M6MDoiIjtzOjE2OiJ0aHVtYm5haWxfcHJlZml4IjtzOjU6InRodW1iIjtzOjE0OiJ3b3JkX3NlcGFyYXRvciI7czoxMDoidW5kZXJzY29yZSI7czoxNzoidXNlX2NhdGVnb3J5X25hbWUiO3M6MToibiI7czoyMjoicmVzZXJ2ZWRfY2F0ZWdvcnlfd29yZCI7czo4OiJjYXRlZ29yeSI7czoyMzoiYXV0b19jb252ZXJ0X2hpZ2hfYXNjaWkiO3M6MToibiI7czoyMjoibmV3X3Bvc3RzX2NsZWFyX2NhY2hlcyI7czoxOiJ5IjtzOjIzOiJhdXRvX2Fzc2lnbl9jYXRfcGFyZW50cyI7czoxOiJ5Ijt9', 'YToxOntzOjM3OiIvaG9tZTIvZHJhaWZpbmUvcHVibGljX2h0bWwvaW5kZXgucGhwIjtzOjMyOiI3MmIxMjc5OGU1NzI0OWUyMThiMDBkNjk3ZDMxMjZjMSI7fQ==');

-- --------------------------------------------------------

--
-- Table structure for table `exp_snippets`
--

CREATE TABLE IF NOT EXISTS `exp_snippets` (
  `snippet_id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) NOT NULL,
  `snippet_name` varchar(75) NOT NULL,
  `snippet_contents` text,
  PRIMARY KEY  (`snippet_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `exp_snippets`
--

INSERT INTO `exp_snippets` (`snippet_id`, `site_id`, `snippet_name`, `snippet_contents`) VALUES
(1, 1, 'companyname', 'html5boilerplate for EE'),
(2, 1, 'tagline', 'HTML5 boilerplate for ExpressionEngine'),
(3, 1, 'emailaddress', 'info@example.com'),
(4, 1, 'phone', '(123) 456-7890'),
(5, 1, 'fax', '(123) 456-7890'),
(6, 1, 'streetaddress', '25558 xxxxx Road'),
(7, 1, 'city', 'xxxxx'),
(8, 1, 'state', 'xxx'),
(9, 1, 'zip', 'xxx xxx'),
(10, 1, 'twitter', 'http://twitter.com/<your twitter name>'),
(11, 1, 'google_map', 'http://maps.google.com/maps?q=london&hl=en&ll=51.495065,-0.126343&spn=0.420224,0.937271&sll=51.349056,1.18927&sspn=0.205638,0.468636&vpsrc=0&hnear=Westminster,+London,+United+Kingdom&t=m&z=11');

-- --------------------------------------------------------

--
-- Table structure for table `exp_specialty_templates`
--

CREATE TABLE IF NOT EXISTS `exp_specialty_templates` (
  `template_id` int(6) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `enable_template` char(1) NOT NULL default 'y',
  `template_name` varchar(50) NOT NULL,
  `data_title` varchar(80) NOT NULL,
  `template_data` text NOT NULL,
  PRIMARY KEY  (`template_id`),
  KEY `template_name` (`template_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `exp_specialty_templates`
--

INSERT INTO `exp_specialty_templates` (`template_id`, `site_id`, `enable_template`, `template_name`, `data_title`, `template_data`) VALUES
(1, 1, 'y', 'offline_template', '', '<html>\n<head>\n\n<title>System Offline</title>\n\n<style type="text/css">\n\nbody { \nbackground-color:	#ffffff; \nmargin:				50px; \nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size:			11px;\ncolor:				#000;\nbackground-color:	#fff;\n}\n\na {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nletter-spacing:		.09em;\ntext-decoration:	none;\ncolor:			  #330099;\nbackground-color:	transparent;\n}\n  \na:visited {\ncolor:				#330099;\nbackground-color:	transparent;\n}\n\na:hover {\ncolor:				#000;\ntext-decoration:	underline;\nbackground-color:	transparent;\n}\n\n#content  {\nborder:				#999999 1px solid;\npadding:			22px 25px 14px 25px;\n}\n\nh1 {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nfont-size:			14px;\ncolor:				#000;\nmargin-top: 		0;\nmargin-bottom:		14px;\n}\n\np {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		12px;\nmargin-bottom: 		14px;\ncolor: 				#000;\n}\n</style>\n\n</head>\n\n<body>\n\n<div id="content">\n\n<h1>System Offline</h1>\n\n<p>This site is currently offline</p>\n\n</div>\n\n</body>\n\n</html>'),
(2, 1, 'y', 'message_template', '', '<html>\n<head>\n\n<title>{title}</title>\n\n<meta http-equiv=''content-type'' content=''text/html; charset={charset}'' />\n\n{meta_refresh}\n\n<style type="text/css">\n\nbody { \nbackground-color:	#ffffff; \nmargin:				50px; \nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size:			11px;\ncolor:				#000;\nbackground-color:	#fff;\n}\n\na {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nletter-spacing:		.09em;\ntext-decoration:	none;\ncolor:			  #330099;\nbackground-color:	transparent;\n}\n  \na:visited {\ncolor:				#330099;\nbackground-color:	transparent;\n}\n\na:active {\ncolor:				#ccc;\nbackground-color:	transparent;\n}\n\na:hover {\ncolor:				#000;\ntext-decoration:	underline;\nbackground-color:	transparent;\n}\n\n#content  {\nborder:				#000 1px solid;\nbackground-color: 	#DEDFE3;\npadding:			22px 25px 14px 25px;\n}\n\nh1 {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nfont-size:			14px;\ncolor:				#000;\nmargin-top: 		0;\nmargin-bottom:		14px;\n}\n\np {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		12px;\nmargin-bottom: 		14px;\ncolor: 				#000;\n}\n\nul {\nmargin-bottom: 		16px;\n}\n\nli {\nlist-style:			square;\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		8px;\nmargin-bottom: 		8px;\ncolor: 				#000;\n}\n\n</style>\n\n</head>\n\n<body>\n\n<div id="content">\n\n<h1>{heading}</h1>\n\n{content}\n\n<p>{link}</p>\n\n</div>\n\n</body>\n\n</html>'),
(3, 1, 'y', 'admin_notify_reg', 'Notification of new member registration', 'New member registration site: {site_name}\n\nScreen name: {name}\nUser name: {username}\nEmail: {email}\n\nYour control panel URL: {control_panel_url}'),
(4, 1, 'y', 'admin_notify_entry', 'A new channel entry has been posted', 'A new entry has been posted in the following channel:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nPosted by: {name}\nEmail: {email}\n\nTo read the entry please visit: \n{entry_url}\n'),
(5, 1, 'y', 'admin_notify_mailinglist', 'Someone has subscribed to your mailing list', 'A new mailing list subscription has been accepted.\n\nEmail Address: {email}\nMailing List: {mailing_list}'),
(6, 1, 'y', 'admin_notify_comment', 'You have just received a comment', 'You have just received a comment for the following channel:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nLocated at: \n{comment_url}\n\nPosted by: {name}\nEmail: {email}\nURL: {url}\nLocation: {location}\n\n{comment}'),
(7, 1, 'y', 'mbr_activation_instructions', 'Enclosed is your activation code', 'Thank you for your new member registration.\n\nTo activate your new account, please visit the following URL:\n\n{unwrap}{activation_url}{/unwrap}\n\nThank You!\n\n{site_name}\n\n{site_url}'),
(8, 1, 'y', 'forgot_password_instructions', 'Login information', '{name},\n\nTo reset your password, please go to the following page:\n\n{reset_url}\n\nYour password will be automatically reset, and a new password will be emailed to you.\n\nIf you do not wish to reset your password, ignore this message. It will expire in 24 hours.\n\n{site_name}\n{site_url}'),
(9, 1, 'y', 'reset_password_notification', 'New Login Information', '{name},\n\nHere is your new login information:\n\nUsername: {username}\nPassword: {password}\n\n{site_name}\n{site_url}'),
(10, 1, 'y', 'validated_member_notify', 'Your membership account has been activated', '{name},\n\nYour membership account has been activated and is ready for use.\n\nThank You!\n\n{site_name}\n{site_url}'),
(11, 1, 'y', 'decline_member_validation', 'Your membership account has been declined', '{name},\n\nWe''re sorry but our staff has decided not to validate your membership.\n\n{site_name}\n{site_url}'),
(12, 1, 'y', 'mailinglist_activation_instructions', 'Email Confirmation', 'Thank you for joining the "{mailing_list}" mailing list!\n\nPlease click the link below to confirm your email.\n\nIf you do not want to be added to our list, ignore this email.\n\n{unwrap}{activation_url}{/unwrap}\n\nThank You!\n\n{site_name}'),
(13, 1, 'y', 'comment_notification', 'Someone just responded to your comment', '{name_of_commenter} just responded to the entry you subscribed to at:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nYou can see the comment at the following URL:\n{comment_url}\n\n{comment}\n\nTo stop receiving notifications for this comment, click here:\n{notification_removal_url}'),
(14, 1, 'y', 'comments_opened_notification', 'New comments have been added', 'Responses have been added to the entry you subscribed to at:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nYou can see the comments at the following URL:\n{comment_url}\n\n{comments}\n{comment} \n{/comments}\n\nTo stop receiving notifications for this entry, click here:\n{notification_removal_url}'),
(15, 1, 'y', 'private_message_notification', 'Someone has sent you a Private Message', '\n{recipient_name},\n\n{sender_name} has just sent you a Private Message titled ‘{message_subject}’.\n\nYou can see the Private Message by logging in and viewing your inbox at:\n{site_url}\n\nContent:\n\n{message_content}\n\nTo stop receiving notifications of Private Messages, turn the option off in your Email Settings.\n\n{site_name}\n{site_url}'),
(16, 1, 'y', 'pm_inbox_full', 'Your private message mailbox is full', '{recipient_name},\n\n{sender_name} has just attempted to send you a Private Message,\nbut your inbox is full, exceeding the maximum of {pm_storage_limit}.\n\nPlease log in and remove unwanted messages from your inbox at:\n{site_url}');

-- --------------------------------------------------------

--
-- Table structure for table `exp_stats`
--

CREATE TABLE IF NOT EXISTS `exp_stats` (
  `stat_id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `total_members` mediumint(7) NOT NULL default '0',
  `recent_member_id` int(10) NOT NULL default '0',
  `recent_member` varchar(50) NOT NULL,
  `total_entries` mediumint(8) NOT NULL default '0',
  `total_forum_topics` mediumint(8) NOT NULL default '0',
  `total_forum_posts` mediumint(8) NOT NULL default '0',
  `total_comments` mediumint(8) NOT NULL default '0',
  `last_entry_date` int(10) unsigned NOT NULL default '0',
  `last_forum_post_date` int(10) unsigned NOT NULL default '0',
  `last_comment_date` int(10) unsigned NOT NULL default '0',
  `last_visitor_date` int(10) unsigned NOT NULL default '0',
  `most_visitors` mediumint(7) NOT NULL default '0',
  `most_visitor_date` int(10) unsigned NOT NULL default '0',
  `last_cache_clear` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`stat_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_stats`
--

INSERT INTO `exp_stats` (`stat_id`, `site_id`, `total_members`, `recent_member_id`, `recent_member`, `total_entries`, `total_forum_topics`, `total_forum_posts`, `total_comments`, `last_entry_date`, `last_forum_post_date`, `last_comment_date`, `last_visitor_date`, `most_visitors`, `most_visitor_date`, `last_cache_clear`) VALUES
(1, 1, 1, 1, 'Paul Ledbrook', 5, 0, 0, 2, 1281569808, 0, 1282613638, 1317806072, 4, 1317751285, 1318351036);

-- --------------------------------------------------------

--
-- Table structure for table `exp_statuses`
--

CREATE TABLE IF NOT EXISTS `exp_statuses` (
  `status_id` int(6) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_id` int(4) unsigned NOT NULL,
  `status` varchar(50) NOT NULL,
  `status_order` int(3) unsigned NOT NULL,
  `highlight` varchar(30) NOT NULL,
  PRIMARY KEY  (`status_id`),
  KEY `group_id` (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `exp_statuses`
--

INSERT INTO `exp_statuses` (`status_id`, `site_id`, `group_id`, `status`, `status_order`, `highlight`) VALUES
(1, 1, 1, 'open', 1, '009933'),
(2, 1, 1, 'closed', 2, '990000');

-- --------------------------------------------------------

--
-- Table structure for table `exp_status_groups`
--

CREATE TABLE IF NOT EXISTS `exp_status_groups` (
  `group_id` int(4) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_name` varchar(50) NOT NULL,
  PRIMARY KEY  (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_status_groups`
--

INSERT INTO `exp_status_groups` (`group_id`, `site_id`, `group_name`) VALUES
(1, 1, 'Statuses');

-- --------------------------------------------------------

--
-- Table structure for table `exp_status_no_access`
--

CREATE TABLE IF NOT EXISTS `exp_status_no_access` (
  `status_id` int(6) unsigned NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL,
  PRIMARY KEY  (`status_id`,`member_group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_templates`
--

CREATE TABLE IF NOT EXISTS `exp_templates` (
  `template_id` int(10) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_id` int(6) unsigned NOT NULL,
  `template_name` varchar(50) NOT NULL,
  `save_template_file` char(1) NOT NULL default 'n',
  `template_type` varchar(16) NOT NULL default 'webpage',
  `template_data` mediumtext,
  `template_notes` text,
  `edit_date` int(10) NOT NULL default '0',
  `last_author_id` int(10) unsigned NOT NULL default '0',
  `cache` char(1) NOT NULL default 'n',
  `refresh` int(6) unsigned NOT NULL default '0',
  `no_auth_bounce` varchar(50) NOT NULL default '',
  `enable_http_auth` char(1) NOT NULL default 'n',
  `allow_php` char(1) NOT NULL default 'n',
  `php_parse_location` char(1) NOT NULL default 'o',
  `hits` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`template_id`),
  KEY `group_id` (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `exp_templates`
--

INSERT INTO `exp_templates` (`template_id`, `site_id`, `group_id`, `template_name`, `save_template_file`, `template_type`, `template_data`, `template_notes`, `edit_date`, `last_author_id`, `cache`, `refresh`, `no_auth_bounce`, `enable_http_auth`, `allow_php`, `php_parse_location`, `hits`) VALUES
(1, 1, 1, 'index', 'y', 'webpage', '	{embed="includes/head"}\n\n  </head>\n<body>\n	{embed="includes/header"}\n\n\n	{exp:channel:entries channel="frontpagelargepics" sort="asc" orderby="date" disable="trackbacks|member_data|pagination"}\n		<img src="{fp_image}" class="full" alt="{title}">\n	{/exp:channel:entries}\n\n\n\n\n	{exp:channel:entries channel="blog" limit="2" sort="desc" orderby="date" disable="trackbacks|member_data|pagination"}\n			<div class="">\n				<h3>{title}</h3>\n				{exp:trunchtml chars="200" inline="..." ending="<a class=''readmore'' href=''{title_permalink=blog/comments}''>read more...</a>"}\n{exp:tagstripper:tagsToStrip tags="img"}\n{blog_content}{/exp:tagstripper:tagsToStrip}{/exp:trunchtml}\n			</div>\n	{/exp:channel:entries}\n\n\n\n\n{embed="includes/footer"}\n{embed="includes/analytics"}\n</body>\n</html>', '', 1317805304, 1, 'n', 0, '', 'n', 'n', 'o', 73),
(2, 1, 2, 'index', 'y', 'webpage', '	{embed="includes/head"}\n  </head>\n<body>\n	{embed="includes/header"}\n\n\n{if phone}\n			<div class="phonenumber">\n				<h3>Phone Us</h3>\n				<label>Office:</label> {phone}\n			</div>\n{/if}\n{if emailaddress}\n			<div class="emailaddress">\n				<h3>Email Us</h3>\n				<label>Email:</label> <a href="mailto:{emailaddress}">{emailaddress}</a>\n			</div>\n{/if}\n{if fax}\n			<div class="fax">\n				<h3>Fax Us</h3>\n				<label>Fax: </label>{fax}\n			</div>\n{/if}\n			\n			<h3>Contact Form</h3>\n			{exp:freeform:form form_name="default_form" return="contact/thanks" notify="{emailaddress}" template="default_template" required="firstname|lastname|email"}\n				<div id="contactform">\n					<label><span class="requiredfield">*</span>First Name: </label>\n					<input type="text" name="firstname" value="" />\n					<label><span class="requiredfield">*</span>Last Name: </label>\n					<input type="text" name="lastname" value="" />\n					<label><span class="requiredfield">*</span>Email Address:</label>\n					<input type="text" name="email" value="" />\n					<label><span class="requiredfield">*</span>Phone Number:</label>\n					<input type="text" name="phone" value="" />\n					<label><span class="requiredfield">*</span>Message:</label>\n					<textarea rows="5" cols="50" type="text" name="message" value="" /></textarea>\n					{if captcha}\n						<p>Please enter the word you see in the image below:</p>\n						{captcha}\n						<input id="captcha" type="text" name="captcha" value="" maxlength="20" />\n					{/if}\n					<input type="submit" name="submit" value="submit" id="submit" />\n				</div>\n			{/exp:freeform:form} \n\n			<div class="location">\n				<h3>Find us</h3>\n				<center><iframe width="900" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="{google_map}&amp;output=embed"></iframe><br /><small><a href="{google_map}" style="color:#0000FF;text-align:left">View Larger Map</a></small></center>\n			</div>\n\n{embed="includes/footer"}\n{embed="includes/analytics"}\n</body>\n</html>\n\n\n\n', '', 1317805314, 1, 'n', 0, '', 'n', 'n', 'o', 15),
(3, 1, 3, 'index', 'y', 'webpage', '', NULL, 1317805221, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(4, 1, 4, 'index', 'y', 'webpage', '	{embed="includes/head"}\n  </head>\n<body>\n	{embed="includes/header"}\n\n\n\n{exp:search:advanced_form result_page="search/results" cat_style="nested"}\n<div class="searchForm">\n	<fieldset class="fieldset">\n		<legend>{lang:search_by_keyword}</legend>\n		<input type="text" class="input" maxlength="100" size="40" name="keywords" style="width:300px;" />\n		<div class="default">\n			<select name="search_in">\n				<option value="titles" selected="selected">{lang:search_in_titles}</option>\n				<option value="entries">{lang:search_in_entries}</option>\n				<option value="everywhere" >{lang:search_everywhere}</option>\n			</select>\n		</div>\n		<div class="default">\n			<select name="where">\n				<option value="exact" selected="selected">{lang:exact_phrase_match}</option>\n				<option value="any">{lang:search_any_words}</option>\n				<option value="all" >{lang:search_all_words}</option>\n				<option value="word" >{lang:search_exact_word}</option>\n			</select>\n		</div>\n	</fieldset>\n	<div class="grid_3">\n		<div class="defaultBold">{lang:weblogs}</div>\n			<select id="weblog_id" name=''weblog_id[]'' class=''multiselect'' size=''12'' multiple=''multiple'' onchange=''changemenu(this.selectedIndex);''>\n				{weblog_names}\n			</select>\n	</div>\n	<div class="grid_3">\n		<div class="defaultBold">{lang:categories}</div>\n			<select name=''cat_id[]'' size=''12''  class=''multiselect'' multiple=''multiple''>\n				<option value=''all'' selected="selected">{lang:any_category}</option>\n			</select>\n	</div>\n</div>\n\n<div class="grid_6">\n	<fieldset class="fieldset">\n		<legend>{lang:search_by_member_name}</legend>\n			<input type="text" class="input" maxlength="100" size="40" name="member_name" style="width:300px;" />\n		<div class="default"><input type="checkbox" class="checkbox" name="exact_match" value="y"  /> {lang:exact_name_match}</div>\n	</fieldset>\n	<fieldset class="fieldset">\n		<legend>{lang:search_entries_from}</legend>\n			<select name="date" style="width:150px">\n<option value="0" selected="selected">{lang:any_date}</option>\n<option value="1" >{lang:today_and}</option>\n<option value="7" >{lang:this_week_and}</option>\n<option value="30" >{lang:one_month_ago_and}</option>\n<option value="90" >{lang:three_months_ago_and}</option>\n<option value="180" >{lang:six_months_ago_and}</option>\n<option value="365" >{lang:one_year_ago_and}</option>\n</select>\n\n<div class="default">\n<input type=''radio'' name=''date_order'' value=''newer'' class=''radio'' checked="checked" />&nbsp;{lang:newer}\n<input type=''radio'' name=''date_order'' value=''older'' class=''radio'' />&nbsp;{lang:older}\n</div>\n\n</fieldset>\n\n<div class="default"><br /></div>\n\n<fieldset class="fieldset">\n<legend>{lang:sort_results_by}</legend>\n\n<select name="orderby">\n<option value="date" >{lang:date}</option>\n<option value="title" >{lang:title}</option>\n<option value="most_comments" >{lang:most_comments}</option>\n<option value="recent_comment" >{lang:recent_comment}</option>\n</select>\n\n<div class="default">\n<input type=''radio'' name=''sort_order'' class="radio" value=''desc'' checked="checked" /> {lang:descending}\n<input type=''radio'' name=''sort_order'' class="radio" value=''asc'' /> {lang:ascending}\n</div>\n</fieldset>\n\n<div class=''searchSubmit''>\n\n<input type=''submit'' value=''Search'' class=''submit'' />\n\n</div>\n\n</div>\n{/exp:search:advanced_form}\n\n\n\n\n{embed="includes/footer"}\n{embed="includes/analytics"}\n</body>\n</html>\n', '', 1317806097, 1, 'n', 0, '', 'n', 'n', 'o', 3),
(5, 1, 5, 'index', 'y', 'webpage', '	{embed="includes/head"}\n  </head>\n<body>\n	{embed="includes/header"}\n	\n\n\n		{exp:channel:entries channel="about" orderby="date" sort="desc" limit="1" disable="member_data|trackbacks"}\n			<h2>{title}</h2>\n			{about_content}\n		{/exp:channel:entries}\n\n\n{embed="includes/footer"}\n{embed="includes/analytics"}\n</body>\n</html>', '', 1317805282, 1, 'n', 0, '', 'n', 'n', 'o', 53),
(6, 1, 2, 'thanks', 'y', 'webpage', '	{embed="includes/head"}\n  </head>\n<body>\n	{embed="includes/header"}\n\n\n		<h3>Thanks!</h3>\n		<p>Thank you for submitting via our contact form. Someone will be in touch shortly</p>\n	\n{embed="includes/footer"}\n{embed="includes/analytics"}\n</body>\n</html>\n\n\n\n', '', 1317805321, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(7, 1, 6, 'index', 'y', 'webpage', '	{embed="includes/head"}\n  </head>\n<body>\n	{embed="includes/header"}\n\n		{exp:channel:entries channel="blog" orderby="date" sort="desc" limit="15" disable="member_data|trackbacks"}\n			<div class="entry">\n				<a href="{title_permalink=''blog/comments''}"><h2 class="title">{title}</h2></a>\n				{blog_content}\n				<div class="posted">Posted by {author} on {entry_date format=''%m/%d''} at {entry_date format=''%h:%i %A''}\n					<br>\n					{categories}\n						<a href="{path=''blog/index''}">Categories: {category_name}</a> |\n					{/categories}\n\n					{if allow_comments}\n						<a href="{title_permalink=''blog/comments''}">Comments ({comment_total})</a> |\n					{/if}\n					{if allow_trackbacks}\n						({trackback_total}) <a href="{trackback_path=''blog/trackbacks''}">Trackbacks</a> |\n					{/if}\n					<a href="{title_permalink=''blog/index''}">Permalink</a>\n				</div>\n				{paginate}\n				<div class="paginate">\n					<span class="pagecount">Page {current_page} of {total_pages} pages</span>  {pagination_links}\n					</div>\n					{/paginate}\n				</div>\n			{/exp:channel:entries}\n		</div>\n	<div class="sidebarContainer">\n		{embed="includes/blogsidebar"}\n	</div>\n\n\n{embed="includes/footer"}\n{embed="includes/analytics"}\n</body>\n</html>', '', 1317805504, 1, 'n', 0, '', 'n', 'n', 'o', 30),
(8, 1, 4, 'results', 'y', 'webpage', '	{embed="includes/head"}\n  </head>\n<body>\n	{embed="includes/header"}\n\n\n		<table id="searchresults" border="0" cellpadding="6" cellspacing="1" width="100%">\n						<tr>\n							<td class="resultHead">{lang:title}</td>\n							<td class="resultHead">{lang:excerpt}</td>\n							<td class="resultHead">{lang:author}</td>\n							<td class="resultHead">{lang:date}</td>\n							<td class="resultHead">{lang:total_comments}</td>\n							<td class="resultHead">{lang:recent_comments}</td>\n						</tr>\n\n						{exp:search:search_results switch="resultRowOne|resultRowTwo"}\n\n						<tr>\n							<td class="{switch}" width="30%" valign="top"><b><a href="{auto_path}">{title}</a></b></td>\n							<td class="{switch}" width="30%" valign="top">{excerpt}</td>\n							<td class="{switch}" width="10%" valign="top"><a href="{member_path=member/index}">{author}</a></td>\n							<td class="{switch}" width="10%" valign="top">{entry_date format="%m/%d/%y"}</td>\n							<td class="{switch}" width="10%" valign="top">{comment_total}</td>\n							<td class="{switch}" width="10%" valign="top">{recent_comment_date format="%m/%d/%y"}</td>\n						</tr>\n\n						{/exp:search:search_results}\n					</table>\n\n					{if paginate}\n						<div class=''paginate''>\n							<span class=''pagecount''>{page_count}</span>&nbsp; {paginate}	\n						</div>\n					{/if}\n				</td>\n			</tr>\n		</table>\n\n\n{embed="includes/footer"}\n{embed="includes/analytics"}\n</body>\n</html>', '', 1317806108, 1, 'n', 0, '', 'n', 'n', 'o', 3),
(9, 1, 3, 'footer', 'y', 'webpage', '</div>\n    <footer>\n			<div class="footerinner">\n  				<p>{phone} | &copy; 2011 {companyname}</p>\n				<p><a href="mailto:{emailaddress}">{emailaddress}</a></p>\n				<p><a href="{path=''contact''}">Contact</a> | <a href="{twitter}">Twitter</a> | <a href="{path=''search''}">Search</a>  |  <a href="{path=''blog/rss_2.0''}">RSS</a></p>\n			</div>\n    </footer>\n  </div> <!--! end of #container -->\n\n\n  <!-- scripts concatenated and minified via ant build script-->\n  <script defer src="{site_url}js/plugins.js"></script>\n  <script defer src="{site_url}js/script.js"></script>\n  <!-- end scripts-->\n', '', 1317805569, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(10, 1, 3, 'analytics', 'y', 'webpage', '  <!-- Change UA-XXXXX-X to be your site''s ID -->\n  <script>\n    window._gaq = [[''_setAccount'',''UAXXXXXXXX1''],[''_trackPageview''],[''_trackPageLoadTime'']];\n    Modernizr.load({\n      load: (''https:'' == location.protocol ? ''//ssl'' : ''//www'') + ''.google-analytics.com/ga.js''\n    });\n  </script>\n  \n  \n  <!-- Prompt IE 6 users to install Chrome Frame. Remove this if you want to support IE 6.\n       chromium.org/developers/how-tos/chrome-frame-getting-started -->\n  <!--[if lt IE 7 ]>\n    <script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>\n    <script>window.attachEvent(''onload'',function(){CFInstall.check({mode:''overlay''})})</script>\n  <![endif]-->', '', 1317805329, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(11, 1, 3, 'head', 'y', 'webpage', '<!doctype html>\n<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->\n<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->\n<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->\n<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->\n<!-- Consider adding an manifest.appcache: h5bp.com/d/Offline -->\n<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->\n<head>\n  <meta charset="utf-8">\n\n  <!-- Use the .htaccess and remove these lines to avoid edge case issues.\n       More info: h5bp.com/b/378 -->\n  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">\n\n\n  <!-- Grab Google CDN''s jQuery, with a protocol relative URL; fall back to local if offline -->\n  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>\n  <script>window.jQuery || document.write(''<script src="{site_url}js/libs/jquery-1.6.2.min.js"><\\/script>'')</script>\n\n\n\n  <title>{companyname} - {tagline}</title>\n  <meta name="description" content="">\n  <meta name="author" content="">\n\n  <!-- Mobile viewport optimized: j.mp/bplateviewport -->\n  <meta name="viewport" content="width=device-width,initial-scale=1">\n\n  <!-- Place favicon.ico and apple-touch-icon.png in the root directory: mathiasbynens.be/notes/touch-icons -->\n\n  <!-- CSS: implied media=all -->\n  <!-- CSS concatenated and minified via ant build script-->\n  <link rel="stylesheet" href="{site_url}css/style.css">\n  <!-- end CSS-->\n\n  <!-- More ideas for your <head> here: h5bp.com/d/head-Tips -->\n\n  <!-- All JavaScript at the bottom, except for Modernizr / Respond.\n       Modernizr enables HTML5 elements & feature detects; Respond is a polyfill for min/max-width CSS3 Media Queries\n       For optimal performance, use a custom Modernizr build: www.modernizr.com/download/ -->\n  <script src="{site_url}js/libs/modernizr-2.0.6.min.js"></script>', '', 1317806061, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(12, 1, 3, 'header', 'y', 'webpage', '<div id="container">\n    <header>\n		<div class="">\n			<h1><a href="/">{companyname}</a></h1>\n			<h2>{tagline}</h2>\n      	</div>\n      	\n      	<nav>\n			{embed="includes/navigation"}\n	    </nav>\n      	\n      	\n      	<div class="grid_4 search omega">\n			{exp:search:simple_form weblog="news"}\n					<input type="text" name="keywords" id="keywords" class="searchinput" value="" size="18" maxlength="100" />\n					<input type="submit" value="search" class="searchsubmit" />\n			{/exp:search:simple_form}\n		</div>\n    </header>\n    <div id="main" role="main">', '', 1317806134, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(13, 1, 3, 'navigation', 'y', 'webpage', '        	<ul class="mainnav">\n          		<li><a href="{site_url}">Home</a></li>\n			<li><a href="/about/aboutus">About Us</a></li>\n          		<li><a href="/about/services">Services</a></li>\n          		<li><a href="/about/features">Features</a></li>\n          		<li><a href="/blog/index">Blog</a></li>\n	        	<li><a href="/contact/index">Contact</a></li>\n		</ul>\n', '', 1317805606, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(21, 1, 1, '404', 'y', 'webpage', '<!doctype html>\n<html>\n<head>\n  <meta charset="utf-8">\n  <title>Page Not Found :(</title> \n  <style>\n	  body { text-align: center;}\n	  h1 { font-size: 50px; text-align: center }\n	  span[frown] { transform: rotate(90deg); display:inline-block; color: #bbb; }\n	  body { font: 20px Constantia, ''Hoefler Text'',  "Adobe Caslon Pro", Baskerville, Georgia, Times, serif; color: #999; text-shadow: 2px 2px 2px rgba(200, 200, 200, 0.5); }\n	  ::-moz-selection{ background:#FF5E99; color:#fff; }\n	  ::selection { background:#FF5E99; color:#fff; } \n	  article {display:block; text-align: left; width: 500px; margin: 0 auto; }\n	  \n	  a { color: rgb(36, 109, 56); text-decoration:none; }\n	  a:hover { color: rgb(96, 73, 141) ; text-shadow: 2px 2px 2px rgba(36, 109, 56, 0.5); }\n  </style>\n</head>\n<body>\n     <article>\n	  <h1>Not found <span frown>:(</span></h1>\n	   <div>\n	       <p>Sorry, but the page you were trying to view does not exist.</p>\n	       <p>It looks like this was the result of either:</p>\n	       <ul>\n		   <li>a mistyped address</li>\n		   <li>an out-of-date link</li>\n	       </ul>\n	   </div>\n	    \n	    <script>\n	    var GOOG_FIXURL_LANG = (navigator.language || '''').slice(0,2),\n		GOOG_FIXURL_SITE = location.host;\n	    </script>\n	    <script src="http://linkhelp.clients.google.com/tbproxy/lh/wm/fixurl.js"></script>\n     </article>\n</body>\n</html>', '', 1317805296, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(14, 1, 6, 'categories', 'y', 'webpage', '	{embed="includes/head"}\n  </head>\n<body>\n	{embed="includes/header"}\n	\n	\n			<h3 class="sidetitle">Categories</h3>\n			<div class="entry">\n				{exp:channel:category_archive channel="blog"}\n					{categories}<h4>{category_name}</h4>{/categories}\n					{entry_titles}<a href="{path=''blog/comments''}">{title}</a>{/entry_titles}\n				{/exp:channel:category_archive}\n			</div>\n			<p><a href="{homepage}">&lt;&lt; Back to main</a></p>\n		\n		\n		<div class="sidebarContainer">\n			{embed="includes/blogsidebar"}\n		</div>\n\n\n	{embed="includes/footer"}\n	{embed="includes/analytics"}\n</body>\n</html>', '', 1317805478, 1, 'n', 0, '', 'n', 'n', 'o', 3),
(15, 1, 6, 'comments', 'y', 'webpage', '	{embed="includes/head"}\n  </head>\n<body>\n	{embed="includes/header"}\n\n\n			{exp:channel:entries channel="blog" limit="1" disable="member_data|trackbacks"}\n				<div class="entry">\n					<h2 class="title">{title}</h2>\n					{blog_content}\n					<div class="posted">Posted by {author} on {entry_date format=''%m/%d''} at {entry_date format=''%h:%i %A''}\n						<br>\n						{categories}\n						<a href="{path=''blog/index''}">{category_name}</a> &#8226;\n						{/categories}\n\n						<a href="{title_permalink=''blog/index''}">Permalink</a>\n\n					</div>\n\n				</div>\n			{/exp:channel:entries}\n\n{exp:comment:entries channel="blog" limit="25"}\n<div class="comments">\n{comment}\n\n<div class="posted">Posted by {url_or_email_as_author}  &nbsp;on&nbsp; {comment_date format=''%m/%d''} &nbsp;at&nbsp; {comment_date format=''%h:%i %A''}</div>\n\n{paginate}\n<div class="paginate">\n<span class="pagecount">Page {current_page} of {total_pages} pages</span>  {pagination_links}\n</div>\n{/paginate}\n\n</div>\n\n{/exp:comment:entries}\n\n\n<div class="commentform">\n{exp:comment:form preview="blog/comment_preview"}\n\n{if logged_out}\n<p>\nName:<br>\n<input type="text" name="name" value="{name}" size="50" />\n</p>\n<p>\nEmail:<br>\n<input type="text" name="email" value="{email}" size="50" />\n</p>\n<p>\nLocation:<br>\n<input type="text" name="location" value="{location}" size="50" />\n</p>\n<p>\nURL:<br>\n<input type="text" name="url" value="{url}" size="50" />\n</p>\n\n{/if}\n\n<p>\n<a href="{path=blog/smileys}" onclick="window.open(this.href, ''_blank'', ''width=400,height=440'');return false;" onkeypress="this.onclick()">Smileys</a>\n</p>\n\n\n<p>\n<textarea name="comment" cols="50" rows="12">{comment}</textarea>\n</p>\n\n{if logged_out}\n<p><input type="checkbox" name="save_info" value="yes" {save_info} /> Remember my personal information</p>\n{/if}\n\n<p><input type="checkbox" name="notify_me" value="yes" {notify_me} /> Notify me of follow-up comments?</p>\n\n{if captcha}\n<p>Submit the word you see below:</p>\n<p>\n{captcha}\n<br>\n<input type="text" name="captcha" value="" size="20" maxlength="20" style="width:140px;" />\n</p>\n{/if}\n\n<input type="submit" class="submit" name="submit" value="Submit" />\n<input type="submit" class="submit" name="preview" value="Preview" />\n\n\n{/exp:comment:form}\n</div>\n\n<div class="center">\n\n{exp:channel:next_entry channel="blog"}\n<p>Next entry: <a href="{path=blog/comments}">{title}</a></p>\n{/exp:channel:next_entry}\n\n{exp:channel:prev_entry channel="blog"}\n<p>Previous entry: <a href="{path=blog/comments}">{title}</a></p>\n{/exp:channel:prev_entry}\n\n</div>\n\n\n<p><a href="{homepage}">&lt;&lt; Back to main</a></p>\n\n		</div>\n\n	<div class="sidebarContainer">\n		{embed="includes/blogsidebar"}\n	</div>\n\n\n{embed="includes/footer"}\n{embed="includes/analytics"}\n</body>\n</html>\n\n\n', '', 1317805494, 1, 'n', 0, '', 'n', 'n', 'o', 10),
(16, 1, 6, 'rss', 'y', 'feed', '{exp:rss:feed channel="blog"}\n<?xml version="1.0" encoding="{encoding}"?>\n<rss version="2.0"\n    xmlns:dc="http://purl.org/dc/elements/1.1/"\n    xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"\n    xmlns:admin="http://webns.net/mvcb/"\n    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"\n    xmlns:content="http://purl.org/rss/1.0/modules/content/">\n\n    <channel>\n    \n    <title>{exp:xml_encode}{companyname}{/exp:xml_encode}</title>\n    <link>{channel_url}</link>\n    <description>{tagline}</description>\n    <dc:language>{channel_language}</dc:language>\n    <dc:creator>{email}</dc:creator>\n    <dc:rights>Copyright {gmt_date format="%Y"}</dc:rights>\n    <dc:date>{gmt_date format="%Y-%m-%dT%H:%i:%s%Q"}</dc:date>\n    <admin:generatorAgent rdf:resource="http://expressionengine.com/" />\n    \n{exp:channel:entries channel="blog" limit="10" rdf="off" dynamic_start="on" disable="member_data|trackbacks"}\n    <item>\n      <title>{exp:xml_encode}{title}{/exp:xml_encode}</title>\n      <link>{title_permalink=blog/comments}</link>\n      <guid>{title_permalink=blog/comments}#When:{gmt_entry_date format="%H:%i:%sZ"}</guid>\n      <description>{exp:xml_encode}{blog_content}{/exp:xml_encode}</description>\n      <dc:subject>{exp:xml_encode}{categories backspace="1"}{category_name}, {/categories}{/exp:xml_encode}</dc:subject>\n      <dc:date>{gmt_entry_date format="%Y-%m-%dT%H:%i:%s%Q"}</dc:date>\n    </item>\n{/exp:channel:entries}\n    \n    </channel>\n</rss>\n\n{/exp:rss:feed}\n', '', 1317805515, 1, 'n', 0, '', 'n', 'n', 'o', 5),
(17, 1, 6, 'archives', 'y', 'webpage', '	{embed="includes/head"}\n  </head>\n<body>\n	{embed="includes/header"}\n\n\n\n{exp:channel:entries orderby="date" channel="blog" sort="desc" limit="100" disable="pagination|categories|member_data|trackbacks"}\n\n{date_heading display="yearly"}\n<h3 class="title">{entry_date format="%Y"}</h3>\n{/date_heading}\n\n{date_heading display="monthly"}\n<h4 class="date">{entry_date format="%F"}</h4>\n{/date_heading}\n\n<ul>\n<li><a href="{title_permalink="blog/comments"}">{title}</a></li>\n</ul>\n{/exp:channel:entries}\n</div>\n\n	<div class="sidebarContainer">\n		{embed="includes/blogsidebar"}\n	</div>\n\n\n{embed="includes/footer"}\n{embed="includes/analytics"}\n</body>\n</html>', '', 1317805464, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(18, 1, 6, 'smileys', 'y', 'webpage', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"\n"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">\n<head>\n<meta http-equiv="content-type" content="text/html; charset={charset}" />\n<title>Smileys</title>\n\n<style type="text/css">\n\nbody {\n background-color: #ffffff;\n margin-left: 40px;\n margin-right: 40px;\n margin-top: 30px;\n font-size: 11px;\n font-family: verdana,trebuchet,sans-serif;\n}\na:link {\n color: #990000;\n font-size: 11px;\n font-weight: normal;\n text-decoration: underline;\n}\na:visited {\n color: #990000;\n font-size: 11px;\n font-weight: normal;\n text-decoration: underline;\n}\na:active {\n color: #990000;\n font-size: 11px;\n font-weight: normal;\n text-decoration: underline;\n}\na:hover {\n color: #990000;\n font-size: 11px;\n font-weight: normal;\n text-decoration: none;\n}\n\n</style>\n\n<script language="javascript">\n<!--\n\nfunction add_smiley(smiley)\n{\n    opener.document.getElementById(''comment_form'').comment.value += " " + smiley + " ";\n    opener.window.document.getElementById(''comment_form'').comment.focus();\n    window.close();\n}\n//-->\n</script>\n\n</head>\n<body>\n\n<p>Click on an image to add it to your comment</p>\n\n<table border="0" width="100%" cellpadding="6" cellspacing="1">\n\n{exp:emoticon columns="4"}\n<tr>\n<td><div>{smiley}</div></td>\n</tr>\n{/exp:emoticon}\n\n</table>\n\n</body>\n</html>\n', '', 1317805521, 1, 'n', 0, '', 'n', 'n', 'o', 1),
(19, 1, 3, 'blogsidebar', 'y', 'webpage', '<div id="blogsidebar">\n\n<div class="blogsidebar">\n<h4>Members:</h4>\n<p>\n{if logged_in}\n <a href="{path=member/profile}">Your Account</a>  |  <a href="{path=logout}">Logout</a>\n{/if}\n\n{if logged_out}\n <a href="{path=member/login}">Login</a> | <a href="{path=member/register}">Register</a>\n{/if}\n\n | <a href="{path=member/memberlist}">Member List</a>\n</p>\n</div-->\n\n<div class="blogsidebar">\n{exp:search:simple_form search_in="everywhere"}\n<h4 class="sidetitle">Search</h4>\n<p>\n<input type="text" name="keywords" value="" class="input" size="18" maxlength="100" >\n<input type="submit" value="submit"  class="submit" >\n</p>\n\n{/exp:search:simple_form}\n</div>\n<div class="blogsidebar">\n<h4 class="sidetitle">Categories</h4>\n{exp:channel:categories channel="blog" style="nested"}\n<a href="{path=''blog/index''}">{category_name}</a>\n{/exp:channel:categories}\n</div>\n<div class="blogsidebar">\n\n<h4 class="sidetitle">Monthly Archives</h4>\n<ul>\n{exp:channel:month_links weblog="blog"}\n<li><a href="{path=''blog/index''}">{month} {year}</a></li>\n{/exp:channel:month_links}\n\n<li><a href="{path=''blog/categories''}">Category Archives</a></li>\n</ul>\n</div>\n<div class="blogsidebar">\n<h4 class="sidetitle">Most recent entries</h4>\n<ul>\n{exp:channel:entries orderby="date" sort="desc" limit="15" channel="blog" dynamic="off" disable="pagination|custom_fields|categories|member_data|trackbacks"}\n<li><a href="{title_permalink=''blog/comments''}">{title}</a></li>\n{/exp:channel:entries}\n</ul>\n</div>\n<div class="blogsidebar">\n<h4 class="sidetitle">Syndicate</h4>\n<ul>\n<li><a href="{path=''blog/rss''}">RSS</a></li>\n\n</ul>\n\n</div>\n<!--div class="blogsidebar">\n\n<h4 class="sidetitle">Join our Mailing List</h4>\n\n{exp:mailinglist:form}\n\n<p><input type="text" name="email" value="" class="input" size="18" >\n<input type="submit" value="submit"  class="submit" ></p>\n\n{/exp:mailinglist:form}\n\n</div>\n\n\n</div>', '', 1317805367, 1, 'n', 0, '', 'n', 'n', 'o', 0),
(20, 1, 7, 'index', 'y', 'xml', '<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n\n<url>\n<loc>\n{site_url}\n</loc>\n<lastmod>{current_time format="%Y-%d-%m"}</lastmod>\n<changefreq>monthly</changefreq>\n<priority>0.5</priority>\n</url>\n{exp:channel:entries channel="blog"}\n<url>\n<loc>\n{title_permalink=''blog/comments''}\n</loc>\n<lastmod>{entry_date format="%Y-%d-%m"}</lastmod>\n<changefreq>monthly</changefreq>\n<priority>0.5</priority>\n</url>\n{/exp:channel:entries}\n{exp:channel:entries channel="about"}\n<url>\n<loc>\n{title_permalink=''about''}\n</loc>\n<lastmod>{entry_date format="%Y-%d-%m"}</lastmod>\n<changefreq>monthly</changefreq>\n<priority>0.5</priority>\n</url>\n{/exp:channel:entries}\n\n</urlset>', '', 1317805221, 1, 'n', 0, '', 'n', 'n', 'o', 5);

-- --------------------------------------------------------

--
-- Table structure for table `exp_template_groups`
--

CREATE TABLE IF NOT EXISTS `exp_template_groups` (
  `group_id` int(6) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `group_name` varchar(50) NOT NULL,
  `group_order` int(3) unsigned NOT NULL,
  `is_site_default` char(1) NOT NULL default 'n',
  PRIMARY KEY  (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `exp_template_groups`
--

INSERT INTO `exp_template_groups` (`group_id`, `site_id`, `group_name`, `group_order`, `is_site_default`) VALUES
(1, 1, 'site', 1, 'y'),
(2, 1, 'contact', 2, 'n'),
(3, 1, 'includes', 3, 'n'),
(4, 1, 'search', 4, 'n'),
(5, 1, 'about', 5, 'n'),
(6, 1, 'blog', 6, 'n'),
(7, 1, 'sitemap', 7, 'n');

-- --------------------------------------------------------

--
-- Table structure for table `exp_template_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_template_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `template_group_id` mediumint(5) unsigned NOT NULL,
  PRIMARY KEY  (`group_id`,`template_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_template_no_access`
--

CREATE TABLE IF NOT EXISTS `exp_template_no_access` (
  `template_id` int(6) unsigned NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL,
  PRIMARY KEY  (`template_id`,`member_group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_template_no_access`
--

INSERT INTO `exp_template_no_access` (`template_id`, `member_group`) VALUES
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(19, 3),
(19, 4),
(19, 5),
(20, 2);

-- --------------------------------------------------------

--
-- Table structure for table `exp_throttle`
--

CREATE TABLE IF NOT EXISTS `exp_throttle` (
  `throttle_id` int(10) unsigned NOT NULL auto_increment,
  `ip_address` varchar(16) NOT NULL default '0',
  `last_activity` int(10) unsigned NOT NULL default '0',
  `hits` int(10) unsigned NOT NULL,
  `locked_out` char(1) NOT NULL default 'n',
  PRIMARY KEY  (`throttle_id`),
  KEY `ip_address` (`ip_address`),
  KEY `last_activity` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exp_upload_no_access`
--

CREATE TABLE IF NOT EXISTS `exp_upload_no_access` (
  `upload_id` int(6) unsigned NOT NULL,
  `upload_loc` varchar(3) NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL,
  PRIMARY KEY  (`upload_id`,`member_group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exp_upload_prefs`
--

CREATE TABLE IF NOT EXISTS `exp_upload_prefs` (
  `id` int(4) unsigned NOT NULL auto_increment,
  `site_id` int(4) unsigned NOT NULL default '1',
  `name` varchar(50) NOT NULL,
  `server_path` varchar(150) NOT NULL default '',
  `url` varchar(100) NOT NULL,
  `allowed_types` varchar(3) NOT NULL default 'img',
  `max_size` varchar(16) default NULL,
  `max_height` varchar(6) default NULL,
  `max_width` varchar(6) default NULL,
  `properties` varchar(120) default NULL,
  `pre_format` varchar(120) default NULL,
  `post_format` varchar(120) default NULL,
  `file_properties` varchar(120) default NULL,
  `file_pre_format` varchar(120) default NULL,
  `file_post_format` varchar(120) default NULL,
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `exp_upload_prefs`
--

INSERT INTO `exp_upload_prefs` (`id`, `site_id`, `name`, `server_path`, `url`, `allowed_types`, `max_size`, `max_height`, `max_width`, `properties`, `pre_format`, `post_format`, `file_properties`, `file_pre_format`, `file_post_format`) VALUES
(1, 1, 'Main Upload Directory', '/images/uploads/', '/images/uploads/', 'img', '', '', '', 'class="frontpageimg"', '', '', '', '', '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
