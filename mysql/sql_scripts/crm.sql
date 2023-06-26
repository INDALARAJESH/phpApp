-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 09, 2023 at 01:29 PM
-- Server version: 10.5.20-MariaDB-cll-lve-log
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crm`
--

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `attachment_id` int(11) NOT NULL,
  `attachment_uniqiueid` varchar(100) NOT NULL,
  `attachment_created` datetime DEFAULT NULL,
  `attachment_updated` datetime DEFAULT NULL,
  `attachment_creatorid` int(11) NOT NULL,
  `attachment_clientid` int(11) DEFAULT NULL COMMENT 'optional',
  `attachment_directory` varchar(100) NOT NULL,
  `attachment_filename` varchar(250) NOT NULL,
  `attachment_extension` varchar(20) DEFAULT NULL,
  `attachment_type` varchar(20) DEFAULT NULL COMMENT 'image | file',
  `attachment_size` varchar(30) DEFAULT NULL COMMENT 'Human readable file size',
  `attachment_thumbname` varchar(250) DEFAULT NULL COMMENT 'optional for images',
  `attachmentresource_type` varchar(50) NOT NULL COMMENT '[polymorph] task | expense | ticket | ticketreply',
  `attachmentresource_id` int(11) NOT NULL COMMENT '[polymorph] e.g ticket_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `automation_assigned`
--

CREATE TABLE `automation_assigned` (
  `automationassigned_id` int(11) NOT NULL,
  `automationassigned_created` datetime DEFAULT NULL,
  `automationassigned_updated` int(11) DEFAULT NULL,
  `automationassigned_userid` int(11) DEFAULT NULL,
  `automationassigned_resource_type` varchar(150) DEFAULT NULL COMMENT 'estimate|product_task',
  `automationassigned_resource_id` int(11) DEFAULT NULL COMMENT 'use ID 0, for system default users'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL COMMENT '[do not truncate] - only delete where category_system_default = no',
  `category_created` datetime DEFAULT NULL,
  `category_updated` datetime DEFAULT NULL,
  `category_creatorid` int(11) DEFAULT NULL,
  `category_name` varchar(150) DEFAULT NULL,
  `category_description` varchar(150) DEFAULT NULL COMMENT 'optional (mainly used by knowledge base)',
  `category_system_default` varchar(20) DEFAULT 'no' COMMENT 'yes | no (system default cannot be deleted)',
  `category_visibility` varchar(20) DEFAULT 'everyone' COMMENT 'everyone | team | client (mainly used by knowledge base)',
  `category_icon` varchar(100) DEFAULT 'sl-icon-docs' COMMENT 'optional (mainly used by knowledge base)',
  `category_type` varchar(50) NOT NULL COMMENT 'project | client | contract | expense | invoice | lead | ticket | item| estimate | knowledgebase',
  `category_slug` varchar(250) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[do not truncate][system defaults] - 1=project,2=client,3lead,4=invoice,5=estimate,6=contract,7=expense,8=item,9=ticket, 10=knowledgebase, 11=proposal';

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_created`, `category_updated`, `category_creatorid`, `category_name`, `category_description`, `category_system_default`, `category_visibility`, `category_icon`, `category_type`, `category_slug`) VALUES
(1, '2020-09-02 15:41:04', '2022-11-11 12:05:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'project', '1-seo'),
(2, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'client', '2-default'),
(3, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'lead', '3-default'),
(4, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'invoice', '4-default'),
(5, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'estimate', '5-default'),
(6, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'contract', '6-default'),
(7, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'expense', '7-default'),
(8, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'item', '8-default'),
(9, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Support', NULL, 'yes', 'everyone', 'sl-icon-folder', 'ticket', '9-support'),
(10, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Frequently Asked Questions', 'Answers to some of the most frequently asked questions', 'yes', 'everyone', 'sl-icon-call-out', 'knowledgebase', '10-frequently-asked-questions'),
(11, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'proposal', '11-proposal'),
(60, NULL, NULL, 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-docs', 'subscription', 'subscription'),
(21, '2020-09-02 15:41:04', '2020-01-01 00:00:00', 0, 'Uncategorised', NULL, 'yes', 'everyone', 'sl-icon-folder', 'milestones', '1-uncategorised');

-- --------------------------------------------------------

--
-- Table structure for table `category_users`
--

CREATE TABLE `category_users` (
  `categoryuser_id` int(11) NOT NULL,
  `categoryuser_categoryid` int(11) NOT NULL,
  `categoryuser_userid` int(11) NOT NULL,
  `categoryuser_created` datetime NOT NULL,
  `categoryuser_updated` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `checklists`
--

CREATE TABLE `checklists` (
  `checklist_id` int(11) NOT NULL,
  `checklist_position` int(11) NOT NULL,
  `checklist_created` datetime NOT NULL,
  `checklist_updated` datetime NOT NULL,
  `checklist_creatorid` int(11) NOT NULL,
  `checklist_clientid` int(11) DEFAULT NULL,
  `checklist_text` text NOT NULL,
  `checklist_status` varchar(250) NOT NULL DEFAULT 'pending' COMMENT 'pending | completed',
  `checklistresource_type` varchar(50) NOT NULL,
  `checklistresource_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `client_importid` varchar(100) DEFAULT NULL,
  `client_created` datetime DEFAULT NULL,
  `client_updated` datetime DEFAULT NULL,
  `client_creatorid` int(11) NOT NULL,
  `client_created_from_leadid` int(11) NOT NULL COMMENT 'the lead that the customer was created from',
  `client_categoryid` int(11) DEFAULT 2 COMMENT 'default category',
  `client_company_name` varchar(150) NOT NULL,
  `client_description` text DEFAULT NULL,
  `client_phone` varchar(50) DEFAULT NULL,
  `client_logo_folder` varchar(50) DEFAULT NULL,
  `client_logo_filename` varchar(50) DEFAULT NULL,
  `client_website` varchar(250) DEFAULT NULL,
  `client_vat` varchar(50) DEFAULT NULL,
  `client_billing_street` varchar(200) DEFAULT NULL,
  `client_billing_city` varchar(100) DEFAULT NULL,
  `client_billing_state` varchar(100) DEFAULT NULL,
  `client_billing_zip` varchar(50) DEFAULT NULL,
  `client_billing_country` varchar(100) DEFAULT NULL,
  `client_shipping_street` varchar(250) DEFAULT NULL,
  `client_shipping_city` varchar(100) DEFAULT NULL,
  `client_shipping_state` varchar(100) DEFAULT NULL,
  `client_shipping_zip` varchar(50) DEFAULT NULL,
  `client_shipping_country` varchar(100) DEFAULT NULL,
  `client_status` varchar(50) NOT NULL DEFAULT 'active' COMMENT 'active|suspended',
  `client_app_modules` varchar(50) DEFAULT 'system' COMMENT 'system|custom',
  `client_settings_modules_projects` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_invoices` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_payments` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_knowledgebase` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_estimates` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_subscriptions` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_tickets` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_import_first_name` varchar(100) DEFAULT NULL COMMENT 'used during import',
  `client_import_last_name` varchar(100) DEFAULT NULL COMMENT 'used during import',
  `client_import_email` varchar(100) DEFAULT NULL COMMENT 'used during import',
  `client_import_job_title` varchar(100) DEFAULT NULL COMMENT 'used during import',
  `client_custom_field_1` tinytext DEFAULT NULL,
  `client_custom_field_2` tinytext DEFAULT NULL,
  `client_custom_field_3` tinytext DEFAULT NULL,
  `client_custom_field_4` tinytext DEFAULT NULL,
  `client_custom_field_5` tinytext DEFAULT NULL,
  `client_custom_field_6` tinytext DEFAULT NULL,
  `client_custom_field_7` tinytext DEFAULT NULL,
  `client_custom_field_8` tinytext DEFAULT NULL,
  `client_custom_field_9` tinytext DEFAULT NULL,
  `client_custom_field_10` tinytext DEFAULT NULL,
  `client_custom_field_11` datetime DEFAULT NULL,
  `client_custom_field_12` datetime DEFAULT NULL,
  `client_custom_field_13` datetime DEFAULT NULL,
  `client_custom_field_14` datetime DEFAULT NULL,
  `client_custom_field_15` datetime DEFAULT NULL,
  `client_custom_field_16` datetime DEFAULT NULL,
  `client_custom_field_17` datetime DEFAULT NULL,
  `client_custom_field_18` datetime DEFAULT NULL,
  `client_custom_field_19` datetime DEFAULT NULL,
  `client_custom_field_20` datetime DEFAULT NULL,
  `client_custom_field_21` text DEFAULT NULL,
  `client_custom_field_22` text DEFAULT NULL,
  `client_custom_field_23` text DEFAULT NULL,
  `client_custom_field_24` text DEFAULT NULL,
  `client_custom_field_25` text DEFAULT NULL,
  `client_custom_field_26` text DEFAULT NULL,
  `client_custom_field_27` text DEFAULT NULL,
  `client_custom_field_28` text DEFAULT NULL,
  `client_custom_field_29` text DEFAULT NULL,
  `client_custom_field_30` text DEFAULT NULL,
  `client_custom_field_31` varchar(20) DEFAULT NULL,
  `client_custom_field_32` varchar(20) DEFAULT NULL,
  `client_custom_field_33` varchar(20) DEFAULT NULL,
  `client_custom_field_34` varchar(20) DEFAULT NULL,
  `client_custom_field_35` varchar(20) DEFAULT NULL,
  `client_custom_field_36` varchar(20) DEFAULT NULL,
  `client_custom_field_37` varchar(20) DEFAULT NULL,
  `client_custom_field_38` varchar(20) DEFAULT NULL,
  `client_custom_field_39` varchar(20) DEFAULT NULL,
  `client_custom_field_40` varchar(20) DEFAULT NULL,
  `client_custom_field_41` varchar(150) DEFAULT NULL,
  `client_custom_field_42` varchar(150) DEFAULT NULL,
  `client_custom_field_43` varchar(150) DEFAULT NULL,
  `client_custom_field_44` varchar(150) DEFAULT NULL,
  `client_custom_field_45` varchar(150) DEFAULT NULL,
  `client_custom_field_46` varchar(150) DEFAULT NULL,
  `client_custom_field_47` varchar(150) DEFAULT NULL,
  `client_custom_field_48` varchar(150) DEFAULT NULL,
  `client_custom_field_49` varchar(150) DEFAULT NULL,
  `client_custom_field_50` varchar(150) DEFAULT NULL,
  `client_custom_field_51` int(11) DEFAULT NULL,
  `client_custom_field_52` int(11) DEFAULT NULL,
  `client_custom_field_53` int(11) DEFAULT NULL,
  `client_custom_field_54` int(11) DEFAULT NULL,
  `client_custom_field_55` int(11) DEFAULT NULL,
  `client_custom_field_56` int(11) DEFAULT NULL,
  `client_custom_field_57` int(11) DEFAULT NULL,
  `client_custom_field_58` int(11) DEFAULT NULL,
  `client_custom_field_59` int(11) DEFAULT NULL,
  `client_custom_field_60` int(11) DEFAULT NULL,
  `client_custom_field_61` decimal(10,2) DEFAULT NULL,
  `client_custom_field_62` decimal(10,2) DEFAULT NULL,
  `client_custom_field_63` decimal(10,2) DEFAULT NULL,
  `client_custom_field_64` decimal(10,2) DEFAULT NULL,
  `client_custom_field_65` decimal(10,2) DEFAULT NULL,
  `client_custom_field_66` decimal(10,2) DEFAULT NULL,
  `client_custom_field_67` decimal(10,2) DEFAULT NULL,
  `client_custom_field_68` decimal(10,2) DEFAULT NULL,
  `client_custom_field_69` decimal(10,2) DEFAULT NULL,
  `client_custom_field_70` decimal(10,2) DEFAULT NULL,
  `client_billing_invoice_terms` text DEFAULT NULL,
  `client_billing_invoice_due_days` smallint(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`client_id`, `client_importid`, `client_created`, `client_updated`, `client_creatorid`, `client_created_from_leadid`, `client_categoryid`, `client_company_name`, `client_description`, `client_phone`, `client_logo_folder`, `client_logo_filename`, `client_website`, `client_vat`, `client_billing_street`, `client_billing_city`, `client_billing_state`, `client_billing_zip`, `client_billing_country`, `client_shipping_street`, `client_shipping_city`, `client_shipping_state`, `client_shipping_zip`, `client_shipping_country`, `client_status`, `client_app_modules`, `client_settings_modules_projects`, `client_settings_modules_invoices`, `client_settings_modules_payments`, `client_settings_modules_knowledgebase`, `client_settings_modules_estimates`, `client_settings_modules_subscriptions`, `client_settings_modules_tickets`, `client_import_first_name`, `client_import_last_name`, `client_import_email`, `client_import_job_title`, `client_custom_field_1`, `client_custom_field_2`, `client_custom_field_3`, `client_custom_field_4`, `client_custom_field_5`, `client_custom_field_6`, `client_custom_field_7`, `client_custom_field_8`, `client_custom_field_9`, `client_custom_field_10`, `client_custom_field_11`, `client_custom_field_12`, `client_custom_field_13`, `client_custom_field_14`, `client_custom_field_15`, `client_custom_field_16`, `client_custom_field_17`, `client_custom_field_18`, `client_custom_field_19`, `client_custom_field_20`, `client_custom_field_21`, `client_custom_field_22`, `client_custom_field_23`, `client_custom_field_24`, `client_custom_field_25`, `client_custom_field_26`, `client_custom_field_27`, `client_custom_field_28`, `client_custom_field_29`, `client_custom_field_30`, `client_custom_field_31`, `client_custom_field_32`, `client_custom_field_33`, `client_custom_field_34`, `client_custom_field_35`, `client_custom_field_36`, `client_custom_field_37`, `client_custom_field_38`, `client_custom_field_39`, `client_custom_field_40`, `client_custom_field_41`, `client_custom_field_42`, `client_custom_field_43`, `client_custom_field_44`, `client_custom_field_45`, `client_custom_field_46`, `client_custom_field_47`, `client_custom_field_48`, `client_custom_field_49`, `client_custom_field_50`, `client_custom_field_51`, `client_custom_field_52`, `client_custom_field_53`, `client_custom_field_54`, `client_custom_field_55`, `client_custom_field_56`, `client_custom_field_57`, `client_custom_field_58`, `client_custom_field_59`, `client_custom_field_60`, `client_custom_field_61`, `client_custom_field_62`, `client_custom_field_63`, `client_custom_field_64`, `client_custom_field_65`, `client_custom_field_66`, `client_custom_field_67`, `client_custom_field_68`, `client_custom_field_69`, `client_custom_field_70`, `client_billing_invoice_terms`, `client_billing_invoice_due_days`) VALUES
(3, NULL, '2023-06-07 15:59:18', '2023-06-07 15:59:18', 0, 0, 2, 'upskygroup', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'system', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `comment_created` datetime DEFAULT NULL,
  `comment_updated` datetime DEFAULT NULL,
  `comment_creatorid` int(11) NOT NULL,
  `comment_clientid` int(11) DEFAULT NULL COMMENT 'required for client type resources',
  `comment_text` text NOT NULL,
  `commentresource_type` varchar(50) NOT NULL COMMENT '[polymorph] project | ticket | task | lead',
  `commentresource_id` int(11) NOT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
  `doc_id` int(11) NOT NULL,
  `doc_unique_id` varchar(150) DEFAULT NULL,
  `doc_template` varchar(150) DEFAULT NULL COMMENT 'default',
  `doc_created` datetime NOT NULL,
  `doc_updated` int(11) NOT NULL,
  `doc_creatorid` int(11) NOT NULL COMMENT 'use ( -1 ) for logged out user.',
  `doc_categoryid` int(11) DEFAULT 11 COMMENT '11 is the default category',
  `doc_heading` varchar(250) DEFAULT '#7493a9' COMMENT 'e.g. contract',
  `doc_heading_color` varchar(30) DEFAULT '#7493a9',
  `doc_title` varchar(250) DEFAULT NULL,
  `doc_title_color` varchar(30) DEFAULT NULL,
  `doc_hero_direcory` varchar(250) DEFAULT NULL,
  `doc_hero_filename` varchar(250) DEFAULT NULL,
  `doc_hero_updated` varchar(250) DEFAULT 'no' COMMENT 'ys|no (when no, we use default image path)',
  `doc_body` text DEFAULT '',
  `doc_date_start` date DEFAULT NULL COMMENT 'Proposal Issue Date | Contract Start Date',
  `doc_date_end` date DEFAULT NULL COMMENT 'Proposal Expiry Date | Contract End Date',
  `doc_date_published` date DEFAULT NULL,
  `doc_date_last_emailed` datetime DEFAULT NULL,
  `doc_value` decimal(10,2) DEFAULT NULL,
  `doc_client_id` int(11) DEFAULT NULL,
  `doc_project_id` int(11) DEFAULT NULL,
  `doc_lead_id` int(11) DEFAULT NULL,
  `doc_notes` text DEFAULT NULL,
  `doc_viewed` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `doc_type` varchar(150) DEFAULT 'contract',
  `doc_system_type` varchar(150) DEFAULT 'document' COMMENT 'document|template',
  `doc_provider_signed_userid` int(11) DEFAULT NULL,
  `doc_provider_signed_date` datetime DEFAULT NULL,
  `doc_provider_signed_first_name` varchar(150) DEFAULT NULL,
  `doc_provider_signed_last_name` varchar(150) DEFAULT NULL,
  `doc_provider_signed_signature_directory` varchar(150) DEFAULT NULL,
  `doc_provider_signed_signature_filename` varchar(150) DEFAULT NULL,
  `doc_provider_signed_ip_address` varchar(150) DEFAULT NULL,
  `doc_provider_signed_status` varchar(50) DEFAULT 'unsigned' COMMENT 'signed|unsigned',
  `doc_signed_userid` int(11) DEFAULT NULL,
  `doc_signed_date` datetime DEFAULT NULL,
  `doc_signed_first_name` varchar(150) DEFAULT '',
  `doc_signed_last_name` varchar(150) DEFAULT '',
  `doc_signed_signature_directory` varchar(150) DEFAULT '',
  `doc_signed_signature_filename` varchar(150) DEFAULT '',
  `doc_signed_status` varchar(50) DEFAULT 'unsigned' COMMENT 'signed|unsigned',
  `doc_signed_ip_address` varchar(150) DEFAULT NULL,
  `doc_fallback_client_first_name` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_fallback_client_last_name` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_fallback_client_email` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_status` varchar(100) DEFAULT 'draft' COMMENT 'draft|awaiting_signatures|active|expired',
  `docresource_type` varchar(100) DEFAULT NULL COMMENT 'client|lead',
  `docresource_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contract_templates`
--

CREATE TABLE `contract_templates` (
  `contract_template_id` int(11) NOT NULL,
  `contract_template_created` datetime NOT NULL,
  `contract_template_updated` datetime NOT NULL,
  `contract_template_creatorid` int(11) DEFAULT NULL,
  `contract_template_title` varchar(250) DEFAULT NULL,
  `contract_template_heading_color` varchar(30) DEFAULT '#7493a9',
  `contract_template_title_color` varchar(30) DEFAULT '#7493a9',
  `contract_template_body` text DEFAULT NULL,
  `contract_template_system` varchar(20) DEFAULT 'no' COMMENT 'yes|no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `contract_templates`
--

INSERT INTO `contract_templates` (`contract_template_id`, `contract_template_created`, `contract_template_updated`, `contract_template_creatorid`, `contract_template_title`, `contract_template_heading_color`, `contract_template_title_color`, `contract_template_body`, `contract_template_system`) VALUES
(1, '2023-01-07 17:07:29', '2022-05-22 09:15:49', 0, 'Default Template', '#FFFFFF', '#FFFFFF', 'This agreement (the &ldquo;Agreement&rdquo;) is between <strong>{client_company_name}</strong> (the &ldquo;Client&rdquo;) and <strong>{company_name}</strong> (the &ldquo;Service Provider&rdquo;). This Agreement is dated <strong>{contract_date}</strong>.<br /><br />\r\n<h6><span style=\"text-decoration: underline;\"><br />DELIVERABLES</span></h6>\r\n<br />The Client is hiring the Service Provider to do the following: <br /><br />\r\n<ul>\r\n<li>Design a website template.</li>\r\n<li>Convert the template into a WordPress theme.</li>\r\n<li>Install the WordPress theme on the Client\'s website.</li>\r\n</ul>\r\n<h6><span style=\"text-decoration: underline;\"><br /><br />DURATION</span></h6>\r\n<br />The Service Provider will begin work on&nbsp;<strong>{contract_date}</strong> and must complete the work by <strong>{contract_end_date}</strong>.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />PAYMENT</span></h6>\r\n<br />The Client will pay the Service Provider a sum of <strong>{pricing_table_total}</strong>. Of this, the Client will pay the Service Provider a 3<strong>0% deposit</strong>, before work begins.<br /><br /><strong>{pricing_table}</strong><br /><br />The Service Provider will invoice the Client on or after <strong>{contract_end_date}</strong>. <br /><br />The Client agrees to pay the Service Provider in full within <strong>7 days</strong> of receiving the invoice. Payment after that date will incur a late fee of <strong>$500 per month</strong>.<br /><br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br />EXPENSES</span></h6>\r\n<br />The Client will reimburse the Service Provider&rsquo;s expenses. Expenses do not need to be pre-approved by the Client.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />REVISIONS</span></h6>\r\n<br />The Client will incur additional fees for revisions requested which are outside the scope of the Deliverables at the Service Provider&rsquo;s standard hourly rate of <strong>$50/Hour</strong>.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />OWNERSHIP AND AUTHORSHIP</span></h6>\r\n<strong><br />Ownership:</strong> The Client owns all Deliverables (including intellectual property rights) once the Client has paid the Service Provider in full.<br /><br /><strong>Authorship:</strong> The Client agrees the Service Provider may showcase the Deliverables in the Service Provider&rsquo;s portfolio and in websites, printed literature and other media for the purpose of recognition.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />CONFIDENTIALITY AND NON-DISCLOSURE<br /></span></h6>\r\nEach party promises to the other party that it will not share information that is marked confidential and nonpublic with a third party, unless the disclosing party gives written permission first. Each party must continue to follow these obligations, even after the Agreement ends.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />NON-SOLICITATION</span></h6>\r\n<br />Until this Agreement ends, the Service Provider won&rsquo;t encourage Client employees or service providers to stop working for the Client for any reason.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />REPRESENTATIONS</span></h6>\r\n<br />Each party promises to the other party that it has the authority to enter into and perform all of its obligations under this Agreement.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />TERM AND TERMINATION</span></h6>\r\n<br />Either party may end this Agreement at any time and for any reason, by providing <strong>7 days\'</strong> written notice. <br /><br />The Client will pay the Service Provider for all work that has been completed when the Agreement ends and will reimburse the Service Provider for any prior expenses.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />LIMITATION OF LIABILITY</span></h6>\r\n<br />The Service Provider&rsquo;s Deliverables are sold &ldquo;as is&rdquo; and the Service Provider&rsquo;s maximum liability is the total sum paid by the Client to the Service Provider under this Agreement.<br /><span style=\"text-decoration-line: underline; color: #455a64;\"><br /><br />INDEMNITY</span><br /><br />The Client agrees to indemnify, save and hold harmless the Service Provider from any and all damages, liabilities, costs, losses or expenses arising out of any claim, demand, or action by a third party as a result of the work the Service Provider has done under this Agreement.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />GENERAL</span></h6>\r\n<br />Governing Law and Dispute Resolution. The laws of <strong>France</strong> govern the rights and obligations of the Client and the Service Provider under this Agreement, without regard to conflict of law provisions of that state.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />NOTICES</span></h6>\r\n<br />All notices to either party shall be in writing and delivered by email or registered mail. Notices must be delivered to the party&rsquo;s address(es) listed at the end of this Agreement.<br />Severability.&nbsp; If any portion of this Agreement is changed or disregarded because it is unenforceable, the rest of the Agreement is still enforceable.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />ENTIRE AGREEMENT</span></h6>\r\n<br />This Agreement supersedes all other prior Agreements (both written and oral) between the parties.<br /><br /><strong>The undersigned agree to and accept the terms of this Agreement.</strong>', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `cs_affiliate_earnings`
--

CREATE TABLE `cs_affiliate_earnings` (
  `cs_affiliate_earning_id` int(11) NOT NULL,
  `cs_affiliate_earning_created` datetime NOT NULL,
  `cs_affiliate_earning_updated` datetime NOT NULL,
  `cs_affiliate_earning_projectid` int(11) NOT NULL COMMENT '[cs_affiliate_projects] table id',
  `cs_affiliate_earning_invoiceid` int(11) NOT NULL,
  `cs_affiliate_earning_invoice_payment_date` datetime DEFAULT NULL,
  `cs_affiliate_earning_commission_approval_date` datetime DEFAULT NULL,
  `cs_affiliate_earning_affiliateid` int(11) NOT NULL,
  `cs_affiliate_earning_amount` decimal(10,2) NOT NULL,
  `cs_affiliate_earning_commission_rate` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT 'set at the time of invoice payment',
  `cs_affiliate_earning_status` varchar(30) NOT NULL DEFAULT 'pending' COMMENT 'paid|pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cs_affiliate_earnings`
--

INSERT INTO `cs_affiliate_earnings` (`cs_affiliate_earning_id`, `cs_affiliate_earning_created`, `cs_affiliate_earning_updated`, `cs_affiliate_earning_projectid`, `cs_affiliate_earning_invoiceid`, `cs_affiliate_earning_invoice_payment_date`, `cs_affiliate_earning_commission_approval_date`, `cs_affiliate_earning_affiliateid`, `cs_affiliate_earning_amount`, `cs_affiliate_earning_commission_rate`, `cs_affiliate_earning_status`) VALUES
(3, '2022-08-16 18:25:17', '2022-08-16 18:25:50', 5, 137, '2022-08-16 18:25:17', '2022-08-16 18:25:50', 167, '100.00', '10.00', 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `cs_affiliate_projects`
--

CREATE TABLE `cs_affiliate_projects` (
  `cs_affiliate_project_id` int(11) NOT NULL,
  `cs_affiliate_project_created` int(11) NOT NULL,
  `cs_affiliate_project_updated` int(11) NOT NULL,
  `cs_affiliate_project_creatorid` int(11) NOT NULL,
  `cs_affiliate_project_affiliateid` int(11) NOT NULL,
  `cs_affiliate_project_projectid` int(11) NOT NULL,
  `cs_affiliate_project_commission_rate` decimal(10,2) DEFAULT NULL,
  `cs_affiliate_project_status` varchar(100) DEFAULT 'active' COMMENT 'active|suspended'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cs_affiliate_projects`
--

INSERT INTO `cs_affiliate_projects` (`cs_affiliate_project_id`, `cs_affiliate_project_created`, `cs_affiliate_project_updated`, `cs_affiliate_project_creatorid`, `cs_affiliate_project_affiliateid`, `cs_affiliate_project_projectid`, `cs_affiliate_project_commission_rate`, `cs_affiliate_project_status`) VALUES
(7, 2022, 2022, 1, 167, 5, '10.00', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `cs_events`
--

CREATE TABLE `cs_events` (
  `cs_event_id` int(11) NOT NULL,
  `cs_event_created` date NOT NULL,
  `cs_event_updated` date NOT NULL,
  `cs_event_affliateid` int(11) NOT NULL,
  `cs_event_invoiceid` int(11) NOT NULL,
  `cs_event_project_title` varchar(250) DEFAULT NULL,
  `cs_event_amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cs_events`
--

INSERT INTO `cs_events` (`cs_event_id`, `cs_event_created`, `cs_event_updated`, `cs_event_affliateid`, `cs_event_invoiceid`, `cs_event_project_title`, `cs_event_amount`) VALUES
(3, '2022-08-16', '2022-08-16', 167, 137, 'Redesign the layout of our helpdesk', '100.00');

-- --------------------------------------------------------

--
-- Table structure for table `customfields`
--

CREATE TABLE `customfields` (
  `customfields_id` int(11) NOT NULL,
  `customfields_created` datetime NOT NULL,
  `customfields_updated` datetime NOT NULL,
  `customfields_position` int(11) NOT NULL DEFAULT 1,
  `customfields_datatype` varchar(50) DEFAULT 'text' COMMENT 'text|paragraph|number|decima|date|checkbox|dropdown',
  `customfields_datapayload` text DEFAULT NULL COMMENT 'use this to store dropdown lists etc',
  `customfields_type` varchar(50) DEFAULT NULL COMMENT 'clients|projects|leads|tasks|tickets',
  `customfields_name` varchar(250) DEFAULT NULL COMMENT 'e.g. project_custom_field_1',
  `customfields_title` varchar(250) DEFAULT NULL,
  `customfields_required` varchar(5) DEFAULT 'no' COMMENT 'yes|no - standard form',
  `customfields_show_client_page` varchar(100) DEFAULT NULL,
  `customfields_show_project_page` varchar(100) DEFAULT NULL,
  `customfields_show_task_summary` varchar(100) DEFAULT NULL,
  `customfields_show_lead_summary` varchar(100) DEFAULT NULL,
  `customfields_show_invoice` varchar(100) DEFAULT NULL,
  `customfields_show_ticket_page` varchar(100) DEFAULT 'no',
  `customfields_show_filter_panel` varchar(100) DEFAULT 'no' COMMENT 'yes|no',
  `customfields_standard_form_status` varchar(100) DEFAULT 'disabled' COMMENT 'disabled | enabled',
  `customfields_status` varchar(50) DEFAULT 'disabled' COMMENT 'disabled | enabled',
  `customfields_sorting_a_z` varchar(5) DEFAULT 'z' COMMENT 'hack to get sorting right, excluding null title items'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='checkbox fields are stored as ''on'' or null';

--
-- Dumping data for table `customfields`
--

INSERT INTO `customfields` (`customfields_id`, `customfields_created`, `customfields_updated`, `customfields_position`, `customfields_datatype`, `customfields_datapayload`, `customfields_type`, `customfields_name`, `customfields_title`, `customfields_required`, `customfields_show_client_page`, `customfields_show_project_page`, `customfields_show_task_summary`, `customfields_show_lead_summary`, `customfields_show_invoice`, `customfields_show_ticket_page`, `customfields_show_filter_panel`, `customfields_standard_form_status`, `customfields_status`, `customfields_sorting_a_z`) VALUES
(1, '2021-01-09 17:02:59', '2022-10-02 15:07:33', 1, 'text', '', 'projects', 'project_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(2, '2021-01-09 17:03:12', '2021-07-13 15:56:23', 1, 'text', '', 'projects', 'project_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(3, '2021-01-09 17:03:17', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(4, '2021-01-09 17:03:23', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(5, '2021-01-09 17:03:29', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(6, '2021-01-09 17:03:34', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(7, '2021-01-09 17:03:39', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(8, '2021-01-09 17:03:45', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(9, '2021-01-09 17:03:50', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(10, '2021-01-09 17:03:55', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(11, '2021-01-09 17:04:09', '2022-11-24 15:05:02', 1, 'text', '', 'clients', 'client_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(12, '2021-01-09 17:04:15', '2022-04-13 12:14:12', 5, 'text', '', 'clients', 'client_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(13, '2021-01-09 17:04:19', '2021-07-09 16:49:46', 1, 'text', '', 'clients', 'client_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(14, '2021-01-09 17:04:25', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(15, '2021-01-09 17:04:30', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(16, '2021-01-09 17:04:35', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(17, '2021-01-09 17:04:41', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(18, '2021-01-09 17:04:46', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(19, '2021-01-09 17:04:51', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(20, '2021-01-09 17:04:57', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(21, '2021-01-09 17:05:07', '2022-10-02 15:15:24', 2, 'text', '', 'leads', 'lead_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(22, '2021-01-09 17:05:12', '2021-08-04 16:38:49', 1, 'text', '', 'leads', 'lead_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(23, '2021-01-09 17:05:17', '2021-07-10 18:54:38', 1, 'text', '', 'leads', 'lead_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(24, '2021-01-09 17:05:22', '2021-07-10 18:54:38', 1, 'text', '', 'leads', 'lead_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(25, '2021-01-09 17:05:27', '2021-07-10 18:54:38', 1, 'text', '', 'leads', 'lead_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(26, '2021-01-09 17:05:32', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(27, '2021-01-09 17:05:37', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(28, '2021-01-09 17:05:42', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(29, '2021-01-09 17:05:48', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(30, '2021-01-09 17:05:53', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(31, '2021-01-09 17:06:06', '2022-10-02 15:09:51', 1, 'text', '', 'tasks', 'task_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(32, '2021-01-09 17:06:12', '2021-07-10 19:01:51', 1, 'text', '', 'tasks', 'task_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(33, '2021-01-09 17:06:16', '2021-07-10 19:01:51', 1, 'text', '', 'tasks', 'task_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(34, '2021-01-09 17:06:21', '2021-07-10 19:01:51', 1, 'text', '', 'tasks', 'task_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(35, '2021-01-09 17:06:26', '2021-07-10 19:01:51', 1, 'text', '', 'tasks', 'task_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(36, '2021-01-09 17:06:31', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(37, '2021-01-09 17:06:36', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(38, '2021-01-09 17:06:42', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(39, '2021-01-09 17:06:47', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(40, '2021-01-09 17:06:52', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(127, '2021-07-04 18:06:09', '2022-10-02 15:15:41', 6, 'paragraph', '', 'leads', 'lead_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(126, '2021-07-04 18:06:09', '2021-07-10 18:56:29', 1, 'paragraph', '', 'leads', 'lead_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(125, '2021-07-04 18:06:09', '2021-07-10 18:55:43', 1, 'paragraph', '', 'leads', 'lead_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(124, '2021-07-04 18:06:09', '2021-07-10 18:55:43', 1, 'paragraph', '', 'leads', 'lead_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(123, '2021-07-04 18:06:09', '2021-07-10 18:55:43', 1, 'paragraph', '', 'leads', 'lead_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(122, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(121, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(120, '2021-07-04 17:57:57', '2022-10-02 15:15:52', 3, 'date', '', 'leads', 'lead_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(119, '2021-07-04 17:57:57', '2021-07-10 18:56:44', 1, 'date', '', 'leads', 'lead_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(118, '2021-07-04 17:57:57', '2021-07-10 18:56:44', 1, 'date', '', 'leads', 'lead_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(117, '2021-07-04 17:57:57', '2021-07-10 18:56:44', 1, 'date', '', 'leads', 'lead_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(116, '2021-07-04 17:57:57', '2021-07-10 18:56:44', 1, 'date', '', 'leads', 'lead_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(115, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(114, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(113, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(112, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(111, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(110, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(109, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(108, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(107, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(106, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(105, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(104, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(103, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(102, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(101, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(100, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(99, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(98, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(97, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(96, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(95, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(94, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(93, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(92, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(91, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(128, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(129, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(130, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(131, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(132, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(133, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(134, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(135, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(136, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(137, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(138, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(139, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(140, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(141, '2021-07-04 18:27:12', '2022-10-02 15:16:08', 4, 'checkbox', '', 'leads', 'lead_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(142, '2021-07-04 18:27:12', '2021-07-10 18:56:58', 1, 'checkbox', '', 'leads', 'lead_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(143, '2021-07-04 18:27:12', '2021-07-10 18:56:58', 1, 'checkbox', '', 'leads', 'lead_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(144, '2021-07-04 18:27:12', '2021-07-10 18:56:58', 1, 'checkbox', '', 'leads', 'lead_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(145, '2021-07-04 18:27:12', '2021-07-10 18:56:58', 1, 'checkbox', '', 'leads', 'lead_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(146, '2021-07-04 18:27:12', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(147, '2021-07-04 18:27:12', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(148, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(149, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(150, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(151, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_71', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(152, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_72', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(153, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_73', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(154, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_74', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(155, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_75', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(156, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_76', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(157, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_77', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(158, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_78', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(159, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_79', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(160, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_80', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(161, '2021-07-04 18:29:23', '2022-10-02 15:16:29', 5, 'dropdown', '', 'leads', 'lead_custom_field_81', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(162, '2021-07-04 18:29:23', '2021-07-10 18:57:12', 1, 'dropdown', '', 'leads', 'lead_custom_field_82', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(163, '2021-07-04 18:29:23', '2021-07-10 18:57:12', 1, 'dropdown', '', 'leads', 'lead_custom_field_83', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(164, '2021-07-04 18:29:23', '2021-07-10 18:57:12', 1, 'dropdown', '', 'leads', 'lead_custom_field_84', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(165, '2021-07-04 18:29:23', '2021-07-10 18:57:12', 1, 'dropdown', '', 'leads', 'lead_custom_field_85', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(166, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_86', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(167, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_87', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(168, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_88', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(169, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_89', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(170, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_90', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(171, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_91', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(172, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_92', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(173, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_93', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(174, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_94', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(175, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_95', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(176, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_96', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(177, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_97', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(178, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_98', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(179, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_99', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(180, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_100', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(181, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_101', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(182, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_102', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(183, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_103', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(184, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_104', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(185, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_105', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(186, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_106', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(187, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_107', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(188, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_108', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(189, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_109', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(190, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_110', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(191, '2021-07-04 18:30:33', '2022-10-02 15:16:43', 7, 'number', '', 'leads', 'lead_custom_field_111', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(192, '2021-07-04 18:30:33', '2021-07-10 18:57:25', 1, 'number', '', 'leads', 'lead_custom_field_112', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(193, '2021-07-04 18:30:33', '2021-07-10 18:57:25', 1, 'number', '', 'leads', 'lead_custom_field_113', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(194, '2021-07-04 18:30:33', '2021-07-10 18:57:25', 1, 'number', '', 'leads', 'lead_custom_field_114', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(195, '2021-07-04 18:30:34', '2021-07-10 18:57:25', 1, 'number', '', 'leads', 'lead_custom_field_115', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(196, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_116', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(197, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_117', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(198, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_118', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(199, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_119', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(200, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_120', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(201, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_121', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(202, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_122', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(203, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_123', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(204, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_124', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(205, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_125', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(206, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_126', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(207, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_127', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(208, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_128', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(209, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_129', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(210, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_130', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(211, '2021-07-04 18:32:26', '2022-10-02 15:17:00', 8, 'decimal', '', 'leads', 'lead_custom_field_131', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(212, '2021-07-04 18:32:26', '2021-07-10 18:57:38', 1, 'decimal', '', 'leads', 'lead_custom_field_132', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(213, '2021-07-04 18:32:26', '2021-07-10 18:57:38', 1, 'decimal', '', 'leads', 'lead_custom_field_133', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(214, '2021-07-04 18:32:26', '2021-07-10 18:57:38', 1, 'decimal', '', 'leads', 'lead_custom_field_134', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(215, '2021-07-04 18:32:26', '2021-07-10 18:57:38', 1, 'decimal', '', 'leads', 'lead_custom_field_135', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(216, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_136', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(217, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_137', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(218, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_138', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(219, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_139', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(220, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_140', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(221, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_141', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(222, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_142', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(223, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_143', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(224, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_144', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(225, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_145', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(226, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_146', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(227, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_147', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(228, '2021-07-04 18:32:27', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_148', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(229, '2021-07-04 18:32:27', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_149', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(230, '2021-07-04 18:32:27', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_150', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(231, '2021-07-04 18:35:30', '2022-10-02 15:13:34', 1, 'date', '', 'tasks', 'task_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(232, '2021-07-04 18:35:30', '2021-07-10 19:02:34', 1, 'date', '', 'tasks', 'task_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(233, '2021-07-04 18:35:30', '2021-07-10 19:02:34', 1, 'date', '', 'tasks', 'task_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(234, '2021-07-04 18:35:30', '2021-07-10 19:02:34', 1, 'date', '', 'tasks', 'task_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(235, '2021-07-04 18:35:30', '2021-07-10 19:02:34', 1, 'date', '', 'tasks', 'task_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(236, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(237, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(238, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(239, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(240, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(241, '2021-07-04 18:36:41', '2022-11-24 15:05:02', 1, 'date', '', 'clients', 'client_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(242, '2021-07-04 18:36:41', '2021-08-04 14:14:10', 1, 'date', '', 'clients', 'client_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(243, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(244, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(245, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(246, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(247, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(248, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(249, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(250, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(251, '2021-07-04 18:37:11', '2021-08-04 15:27:48', 1, 'date', '', 'projects', 'project_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(252, '2021-07-04 18:37:11', '2022-10-02 15:08:10', 1, 'date', '', 'projects', 'project_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(253, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(254, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(255, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(256, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(257, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(258, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(259, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(260, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(261, '2021-07-04 18:37:35', '2022-10-02 15:13:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(262, '2021-07-04 18:37:35', '2021-07-10 19:02:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(263, '2021-07-04 18:37:35', '2021-07-10 19:02:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(264, '2021-07-04 18:37:35', '2021-07-10 19:02:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(265, '2021-07-04 18:37:35', '2021-07-10 19:02:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(266, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(267, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(268, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(269, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(270, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(271, '2021-07-04 18:37:44', '2022-11-24 15:05:02', 1, 'paragraph', '', 'clients', 'client_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(272, '2021-07-04 18:37:44', '2021-08-04 14:13:00', 1, 'paragraph', '', 'clients', 'client_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(273, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(274, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(275, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(276, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(277, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(278, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(279, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(280, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(281, '2021-07-04 18:37:54', '2021-08-04 15:27:30', 1, 'paragraph', '', 'projects', 'project_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(282, '2021-07-04 18:37:54', '2022-10-02 15:07:53', 1, 'paragraph', '', 'projects', 'project_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(283, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(284, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(285, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(286, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(287, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(288, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(289, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(290, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(291, '2021-07-04 18:38:13', '2022-10-02 15:13:52', 1, 'checkbox', '', 'tasks', 'task_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(292, '2021-07-04 18:38:13', '2021-07-10 19:02:55', 1, 'checkbox', '', 'tasks', 'task_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(293, '2021-07-04 18:38:13', '2021-07-10 19:02:55', 1, 'checkbox', '', 'tasks', 'task_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(294, '2021-07-04 18:38:13', '2021-07-10 19:02:55', 1, 'checkbox', '', 'tasks', 'task_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(295, '2021-07-04 18:38:13', '2021-07-10 19:02:55', 1, 'checkbox', '', 'tasks', 'task_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(296, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(297, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(298, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(299, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(300, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(301, '2021-07-04 18:38:22', '2022-11-24 15:04:51', 6, 'checkbox', '', 'clients', 'client_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(302, '2021-07-04 18:38:22', '2022-04-13 12:24:37', 1, 'checkbox', '', 'clients', 'client_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(303, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(304, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(305, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(306, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(307, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(308, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(309, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(310, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(311, '2021-07-04 18:38:32', '2021-08-04 15:28:44', 1, 'checkbox', '', 'projects', 'project_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(312, '2021-07-04 18:38:32', '2022-10-02 15:08:26', 1, 'checkbox', '', 'projects', 'project_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(313, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(314, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(315, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(316, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(317, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(318, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z');
INSERT INTO `customfields` (`customfields_id`, `customfields_created`, `customfields_updated`, `customfields_position`, `customfields_datatype`, `customfields_datapayload`, `customfields_type`, `customfields_name`, `customfields_title`, `customfields_required`, `customfields_show_client_page`, `customfields_show_project_page`, `customfields_show_task_summary`, `customfields_show_lead_summary`, `customfields_show_invoice`, `customfields_show_ticket_page`, `customfields_show_filter_panel`, `customfields_standard_form_status`, `customfields_status`, `customfields_sorting_a_z`) VALUES
(319, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(320, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(321, '2021-07-04 18:38:50', '2022-10-02 15:14:14', 1, 'dropdown', '', 'tasks', 'task_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(322, '2021-07-04 18:38:50', '2021-07-10 19:03:11', 1, 'dropdown', '', 'tasks', 'task_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(323, '2021-07-04 18:38:50', '2021-07-10 19:03:11', 1, 'dropdown', '', 'tasks', 'task_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(324, '2021-07-04 18:38:50', '2021-07-10 19:03:11', 1, 'dropdown', '', 'tasks', 'task_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(325, '2021-07-04 18:38:50', '2021-07-10 19:03:11', 1, 'dropdown', '', 'tasks', 'task_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(326, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(327, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(328, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(329, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(330, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(331, '2021-07-04 18:38:59', '2022-11-24 15:04:48', 3, 'dropdown', '', 'clients', 'client_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(332, '2021-07-04 18:38:59', '2021-08-04 14:17:27', 4, 'dropdown', '', 'clients', 'client_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(333, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(334, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(335, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(336, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(337, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(338, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(339, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(340, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(341, '2021-07-04 18:39:09', '2022-10-02 15:08:49', 1, 'dropdown', '', 'projects', 'project_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(342, '2021-07-04 18:39:09', '2021-08-04 15:29:16', 1, 'dropdown', '', 'projects', 'project_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(343, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(344, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(345, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(346, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(347, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(348, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(349, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(350, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(351, '2021-07-04 18:39:27', '2022-10-02 15:14:31', 1, 'number', '', 'tasks', 'task_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(352, '2021-07-04 18:39:27', '2021-07-10 19:03:28', 1, 'number', '', 'tasks', 'task_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(353, '2021-07-04 18:39:27', '2021-07-10 19:03:28', 1, 'number', '', 'tasks', 'task_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(354, '2021-07-04 18:39:28', '2021-07-10 19:03:28', 1, 'number', '', 'tasks', 'task_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(355, '2021-07-04 18:39:28', '2021-07-10 19:03:28', 1, 'number', '', 'tasks', 'task_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(356, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(357, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(358, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(359, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(360, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(361, '2021-07-04 18:39:37', '2022-11-24 15:04:41', 1, 'number', '', 'clients', 'client_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(362, '2021-07-04 18:39:37', '2022-04-13 12:24:54', 1, 'number', '', 'clients', 'client_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(363, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(364, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(365, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(366, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(367, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(368, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(369, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(370, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(371, '2021-07-04 18:39:46', '2021-08-04 15:29:25', 1, 'number', '', 'projects', 'project_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(372, '2021-07-04 18:39:46', '2022-10-02 15:09:07', 1, 'number', '', 'projects', 'project_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(373, '2021-07-04 18:39:46', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(374, '2021-07-04 18:39:46', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(375, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(376, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(377, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(378, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(379, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(380, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(381, '2021-07-04 19:18:10', '2022-10-02 15:14:47', 1, 'decimal', '', 'tasks', 'task_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(382, '2021-07-04 19:18:10', '2021-07-10 19:03:47', 1, 'decimal', '', 'tasks', 'task_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(383, '2021-07-04 19:18:10', '2021-07-10 19:03:47', 1, 'decimal', '', 'tasks', 'task_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(384, '2021-07-04 19:18:10', '2021-07-10 19:03:47', 1, 'decimal', '', 'tasks', 'task_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(385, '2021-07-04 19:18:10', '2021-07-10 19:03:47', 1, 'decimal', '', 'tasks', 'task_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(386, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(387, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(388, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(389, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(390, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(391, '2021-07-04 19:18:19', '2022-11-24 15:04:45', 1, 'decimal', '', 'clients', 'client_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(392, '2021-07-04 19:18:19', '2021-08-04 14:20:41', 1, 'decimal', '', 'clients', 'client_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(393, '2021-07-04 19:18:19', '2022-04-13 12:25:02', 2, 'decimal', '', 'clients', 'client_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(394, '2021-07-04 19:18:19', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(395, '2021-07-04 19:18:19', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(396, '2021-07-04 19:18:19', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(397, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(398, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(399, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(400, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(401, '2021-07-04 19:18:29', '2021-07-13 19:32:34', 1, 'decimal', '', 'projects', 'project_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(402, '2021-07-04 19:18:29', '2022-10-02 15:09:22', 1, 'decimal', '', 'projects', 'project_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(403, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(404, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(405, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(406, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(407, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(408, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(409, '2021-07-04 19:18:30', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(410, '2021-07-04 19:18:30', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(411, '2021-01-09 17:04:09', '2022-09-30 13:45:36', 1, 'text', '', 'tickets', 'ticket_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(412, '2021-01-09 17:04:15', '2022-08-28 16:46:11', 5, 'text', '', 'tickets', 'ticket_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(413, '2021-01-09 17:04:19', '2022-08-28 16:46:11', 1, 'text', '', 'tickets', 'ticket_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(414, '2021-01-09 17:04:25', '2022-08-28 16:46:11', 1, 'text', '', 'tickets', 'ticket_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(415, '2021-01-09 17:04:30', '2022-08-28 16:46:11', 1, 'text', '', 'tickets', 'ticket_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(416, '2021-01-09 17:04:35', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(417, '2021-01-09 17:04:41', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(418, '2021-01-09 17:04:46', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(419, '2021-01-09 17:04:51', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(420, '2021-01-09 17:04:57', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(421, '2021-07-04 18:36:41', '2022-09-30 16:05:31', 1, 'date', '', 'tickets', 'ticket_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(422, '2021-07-04 18:36:41', '2022-09-30 16:04:25', 1, 'date', '', 'tickets', 'ticket_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(423, '2021-07-04 18:36:41', '2022-09-30 16:04:25', 1, 'date', '', 'tickets', 'ticket_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(424, '2021-07-04 18:36:41', '2022-09-30 16:04:25', 1, 'date', '', 'tickets', 'ticket_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(425, '2021-07-04 18:36:41', '2022-09-30 16:04:25', 1, 'date', '', 'tickets', 'ticket_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(426, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(427, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(428, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(429, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(430, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(431, '2021-07-04 18:37:44', '2022-09-30 16:05:39', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(432, '2021-07-04 18:37:44', '2022-09-30 16:03:53', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(433, '2021-07-04 18:37:44', '2022-09-30 16:03:53', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(434, '2021-07-04 18:37:44', '2022-09-30 16:03:53', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(435, '2021-07-04 18:37:44', '2022-09-30 16:03:53', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(436, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(437, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(438, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(439, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(440, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(441, '2021-07-04 18:38:22', '2022-09-30 16:05:23', 6, 'checkbox', '', 'tickets', 'ticket_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(442, '2021-07-04 18:38:22', '2022-09-30 16:04:51', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(443, '2021-07-04 18:38:22', '2022-09-30 16:04:51', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(444, '2021-07-04 18:38:22', '2022-09-30 16:04:51', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(445, '2021-07-04 18:38:22', '2022-09-30 16:04:51', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(446, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(447, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(448, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(449, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(450, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(451, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 3, 'dropdown', '', 'tickets', 'ticket_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(452, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 4, 'dropdown', '', 'tickets', 'ticket_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(453, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(454, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(455, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(456, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(457, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(458, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(459, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(460, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(461, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(462, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(463, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(464, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(465, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(466, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(467, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(468, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(469, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(470, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(471, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 1, 'decimal', '', 'tickets', 'ticket_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(472, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 1, 'decimal', '', 'tickets', 'ticket_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(473, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 2, 'decimal', '', 'tickets', 'ticket_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(474, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 1, 'decimal', '', 'tickets', 'ticket_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(475, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 1, 'decimal', '', 'tickets', 'ticket_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(476, '2021-07-04 19:18:19', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(477, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(478, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(479, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(480, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z');

-- --------------------------------------------------------

--
-- Table structure for table `email_log`
--

CREATE TABLE `email_log` (
  `emaillog_id` int(11) NOT NULL,
  `emaillog_created` datetime DEFAULT NULL,
  `emaillog_updated` datetime DEFAULT NULL,
  `emaillog_email` varchar(100) DEFAULT NULL,
  `emaillog_subject` varchar(200) DEFAULT NULL,
  `emaillog_body` text DEFAULT NULL,
  `emaillog_attachment` varchar(250) DEFAULT 'attached file name'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

--
-- Dumping data for table `email_log`
--

INSERT INTO `email_log` (`emaillog_id`, `emaillog_created`, `emaillog_updated`, `emaillog_email`, `emaillog_subject`, `emaillog_body`, `emaillog_attachment`) VALUES
(9, '2023-02-22 22:14:02', '2023-02-22 22:14:02', 'saqibmuhmmad93@gmail.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi Karina,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">saqibmuhmmad93@gmail.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">MVP1u8fkf</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(10, '2023-02-22 22:17:39', '2023-02-22 22:17:39', 'mark.noah@upskygroup.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi Mark,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">mark.noah@upskygroup.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">CEEv0rYzu</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(11, '2023-02-22 22:18:02', '2023-02-22 22:18:02', 'Wisdom.Primus@upskygroup.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi Wisdom,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">Wisdom.Primus@upskygroup.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">DIseUKBoJ</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(12, '2023-02-22 22:19:34', '2023-02-22 22:19:34', 'Esther.dossou@upskygroup.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi Esther,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">Esther.dossou@upskygroup.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">GS8gHIAIt</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(13, '2023-02-22 22:20:32', '2023-02-22 22:20:32', 'peter.ted@upskygroup.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi Peter,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">peter.ted@upskygroup.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">T8E1WbV3Z</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name');
INSERT INTO `email_log` (`emaillog_id`, `emaillog_created`, `emaillog_updated`, `emaillog_email`, `emaillog_subject`, `emaillog_body`, `emaillog_attachment`) VALUES
(14, '2023-02-22 22:25:15', '2023-02-22 22:25:15', 'saqibmuhmmad93@gmail.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi Wesley,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">saqibmuhmmad93@gmail.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">qU0NW5tvn</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(15, '2023-02-24 15:15:21', '2023-02-24 15:15:21', 'zykah@robot-mail.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi John,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">zykah@robot-mail.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">rx0TQOtcr</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(16, '2023-02-24 15:20:40', '2023-02-24 15:20:40', 'gysirole@givmail.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi saqib,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">gysirole@givmail.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">FhzZJw3</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(17, '2023-02-24 15:25:24', '2023-02-24 15:25:24', 'Wisdom.Primus@upskygroup.com', 'New Project Comment', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>New Comment Posted</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi Wisdom,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>A new comment has been posted on this project.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Project Title</strong></td>\r\n<td class=\"td-2\">Test project</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Posted By</strong></td>\r\n<td class=\"td-2\">Upsky</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\" colspan=\"2\"><p>some htere</p></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>You can manage your project via the dashboard.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com/projects/1/comments\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(18, '2023-02-24 15:25:24', '2023-02-24 15:25:24', 'volam@robot-mail.com', 'New Project Comment', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>New Comment Posted</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi saqib,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>A new comment has been posted on this project.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Project Title</strong></td>\r\n<td class=\"td-2\">Test project</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Posted By</strong></td>\r\n<td class=\"td-2\">Upsky</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\" colspan=\"2\"><p>some htere</p></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>You can manage your project via the dashboard.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com/projects/1/comments\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name');
INSERT INTO `email_log` (`emaillog_id`, `emaillog_created`, `emaillog_updated`, `emaillog_email`, `emaillog_subject`, `emaillog_body`, `emaillog_attachment`) VALUES
(19, '2023-02-24 15:25:24', '2023-02-24 15:25:24', 'volam@robot-mail.com', 'New Project Created', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Project Details</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi saqib,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your new project has just been created. Below are the project\'s details.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project ID</strong></td>\n<td class=\"td-2\">1</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">Test project</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Start Date</strong></td>\n<td class=\"td-2\">02-25-2023</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">05-11-2023</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'attached file name'),
(20, '2023-02-24 15:25:24', '2023-02-24 15:25:24', 'volam@robot-mail.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi saqib,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">volam@robot-mail.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">Co5xKKO</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(21, '2023-02-27 16:25:42', '2023-02-27 16:25:42', 'esther.dossou@upskygroup.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi Esther,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">esther.dossou@upskygroup.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">Ty3n8GvxI</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name'),
(22, '2023-06-07 16:00:21', '2023-06-07 16:00:21', 'awsdevops112@gmail.com', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi Sunil,</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">awsdevops112@gmail.com</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">awsdevops@112</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"https://manage.upskygroup.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', 'attached file name');

-- --------------------------------------------------------

--
-- Table structure for table `email_queue`
--

CREATE TABLE `email_queue` (
  `emailqueue_id` int(11) NOT NULL,
  `emailqueue_created` datetime NOT NULL,
  `emailqueue_updated` datetime NOT NULL,
  `emailqueue_to` varchar(150) DEFAULT NULL,
  `emailqueue_from_email` varchar(150) DEFAULT NULL COMMENT 'optional (used in sending client direct email)',
  `emailqueue_from_name` varchar(150) DEFAULT NULL COMMENT 'optional (used in sending client direct email)',
  `emailqueue_subject` varchar(250) DEFAULT NULL,
  `emailqueue_message` text DEFAULT NULL,
  `emailqueue_type` varchar(150) DEFAULT 'general' COMMENT 'general|pdf (used for emails that need to generate a pdf)',
  `emailqueue_attachments` text DEFAULT NULL COMMENT 'json of request(''attachments'')',
  `emailqueue_resourcetype` varchar(10) DEFAULT NULL COMMENT 'e.g. invoice. Used mainly for deleting records, when resource has been deleted',
  `emailqueue_resourceid` int(11) DEFAULT NULL,
  `emailqueue_pdf_resource_type` varchar(50) DEFAULT NULL COMMENT 'estimate|invoice',
  `emailqueue_pdf_resource_id` int(11) DEFAULT NULL COMMENT 'resource id (e.g. estimate id)',
  `emailqueue_started_at` datetime DEFAULT NULL COMMENT 'timestamp of when processing started',
  `emailqueue_status` varchar(20) DEFAULT 'new' COMMENT 'new|processing (set to processing by the cronjob, to avoid duplicate processing)'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `emailtemplate_module_unique_id` varchar(250) DEFAULT NULL,
  `emailtemplate_module_name` varchar(250) DEFAULT NULL,
  `emailtemplate_name` varchar(100) DEFAULT NULL,
  `emailtemplate_lang` varchar(250) DEFAULT NULL COMMENT 'to match to language',
  `emailtemplate_type` varchar(30) DEFAULT NULL COMMENT 'everyone|admin|client',
  `emailtemplate_category` varchar(30) DEFAULT NULL COMMENT 'modules|users|projects|tasks|leads|tickets|billing|estimates|other',
  `emailtemplate_subject` varchar(250) DEFAULT NULL,
  `emailtemplate_body` text DEFAULT NULL,
  `emailtemplate_variables` text DEFAULT NULL,
  `emailtemplate_created` datetime DEFAULT NULL,
  `emailtemplate_updated` datetime DEFAULT NULL,
  `emailtemplate_status` varchar(20) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `emailtemplate_language` varchar(50) DEFAULT NULL,
  `emailtemplate_real_template` varchar(50) DEFAULT 'yes' COMMENT 'yes|no',
  `emailtemplate_show_enabled` varchar(50) DEFAULT 'yes' COMMENT 'yes|no',
  `emailtemplate_id` int(11) NOT NULL COMMENT 'x'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[do not truncate]';

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'New User Welcome', 'template_lang_new_user_welcome', 'everyone', 'users', 'Welcome To UpSky Group', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Welcome</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>Great news! Your account has been successfully created. Please find below your login details, which you can use to access your account:</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Username</strong></td>\r\n<td class=\"td-2\">{username}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Password</strong></td>\r\n<td class=\"td-2\">{password}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>We highly recommend that you keep your login details safe and confidential, and avoid sharing them with anyone. Additionally, it\'s important to create a strong and unique password to secure your account.</em></p>\r\n<p><em>You will be asked to change your password the first time you log in.</em></p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{dashboard_url}\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {username}, {password}', '2019-12-08 17:13:10', '2020-11-12 10:10:48', 'enabled', 'english', 'yes', 'yes', 1),
(NULL, NULL, 'Reset Password Request', 'template_lang_reset_password_request', 'everyone', 'users', 'Reset Password Request', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Reset Your Password</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>To complete your password request, please follow the link below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<p>If you are not the one that has initiated this password request, please contact us.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{password_reset_link}\" target=\"_blank\" rel=\"noopener\">Reset Password</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {password_reset_link}', '2019-12-08 17:13:10', '2020-11-12 12:21:58', 'enabled', 'english', 'yes', 'yes', 2),
(NULL, NULL, 'Email Signature', 'template_lang_email_signature', 'everyone', 'other', '---', '<div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div>', '', '2019-12-08 17:13:10', '2020-08-23 06:58:05', 'disabled', 'english', 'no', 'no', 100),
(NULL, NULL, 'Email Footer', 'template_lang_email_footer', 'everyone', 'other', '---', '<p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p>', '', '2019-12-08 17:13:10', '2020-11-12 20:38:15', 'disabled', 'english', 'no', 'no', 102),
(NULL, NULL, 'New Project Created', 'template_lang_new_project_created', 'client', 'projects', 'New Project Created', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Project Details</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your new project has just been created. Below are the project\'s details.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project ID</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Start Date</strong></td>\n<td class=\"td-2\">{project_start_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{project_due_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{dashboard_url}\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {project_id}, {project_title}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}', '2019-12-08 17:13:10', '2021-01-15 20:00:36', 'enabled', 'english', 'yes', 'yes', 103),
(NULL, NULL, 'Project Status Change', 'template_lang_project_status_change', 'client', 'projects', 'Project Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Project Status Changed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of your project has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project ID</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Status</strong></td>\n<td class=\"td-2\">{project_status}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{project_url}\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {project_id}, {project_title}, {project_description}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}', '2019-12-08 17:13:10', '2020-11-13 08:11:06', 'enabled', 'english', 'yes', 'yes', 105),
(NULL, NULL, 'Project File Uploaded', 'template_lang_project_file_uploaded', 'everyone', 'projects', 'New Project File Uploaded', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New File Uploaded</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new file has been uploaded to the project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project ID</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>File</strong></td>\n<td class=\"td-2\"><a href=\"{file_url}\">{file_name}</a></td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Uploaded By</strong></td>\n<td class=\"td-2\">{uploader_first_name}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{project_files_url}\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {file_name}, {file_size}, {file_extension}, {file_url}, {uploader_first_name}, {uploader_last_name}, {project_id}, {project_description}, {project_title}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}, {project_files_url}', '2019-12-08 17:13:10', '2020-11-12 12:25:45', 'enabled', 'english', 'yes', 'yes', 106);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Project Comment', 'template_lang_project_comment', 'everyone', 'projects', 'New Project Comment', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>New Comment Posted</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>A new comment has been posted on this project.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Project Title</strong></td>\r\n<td class=\"td-2\">{project_title}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Posted By</strong></td>\r\n<td class=\"td-2\">{poster_first_name}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\" colspan=\"2\">{comment}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>You can manage your project via the dashboard.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{project_comments_url}\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {comment}, {poster_first_name}, {poster_last_name}, {project_id}, {project_title}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}, {project_comments_url}', '2019-12-08 17:13:10', '2020-11-21 19:24:33', 'enabled', 'english', 'yes', 'yes', 107),
(NULL, NULL, 'Project Assignment', 'template_lang_project_assignment', 'team', 'projects', 'New Project Assignment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Project Assignment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>You have just been assigned to a new project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project ID</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Start Date</strong></td>\n<td class=\"td-2\">{project_start_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{project_due_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{project_url}\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {assigned_by_first_name}, {assigned_by_last_name}, {project_id}, {project_description}, {project_title}, {project_description}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}', '2019-12-08 17:13:10', '2020-11-12 12:39:45', 'enabled', 'english', 'yes', 'yes', 108),
(NULL, NULL, 'Lead Status Change', 'template_lang_lead_status_change', 'team', 'leads', 'Lead Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Status Update</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of this lead has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead ID</strong></td>\n<td class=\"td-2\">{lead_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">{lead_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">{lead_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Status</strong></td>\n<td class=\"td-2\">{lead_status}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your lead via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{lead_url}\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {lead_id}, {lead_name}, {lead_title}, {lead_description}, {lead_created_date}, {lead_value}, {lead_status}, {lead_category}, {lead_url}', '2019-12-08 17:13:10', '2020-11-12 12:42:09', 'enabled', 'english', 'yes', 'yes', 109),
(NULL, NULL, 'Lead Comment', 'template_lang_lead_comment', 'team', 'leads', 'New Lead Comment', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>New Comment Posted</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>A new comment has been posted on this lead.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Lead Title</strong></td>\r\n<td class=\"td-2\">{lead_title}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Posted By</strong></td>\r\n<td class=\"td-2\">{poster_first_name}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\" colspan=\"2\">{comment}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>You can manage your lead via the dashboard.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{lead_url}\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {lead_id}, {lead_name}, {lead_description}, {comment}, {poster_first_name}, {poster_last_name}, {lead_title}, {lead_created_date}, {lead_value}, {lead_status}, {lead_category}, {lead_url}', '2019-12-08 17:13:10', '2020-11-21 19:22:27', 'enabled', 'english', 'yes', 'yes', 110),
(NULL, NULL, 'Lead Assignment', 'template_lang_lead_assignment', 'team', 'leads', 'New Lead Assignment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Assignment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>You have just been assigned to a lead.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">{lead_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">{lead_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{lead_url}\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {assigned_by_first_name}, {assigned_by_last_name}, {lead_id}, {lead_name}, {lead_description}, {lead_title}, {lead_created_date}, {lead_value}, {lead_status}, {lead_category}, {lead_url}', '2019-12-08 17:13:10', '2020-11-12 12:44:45', 'enabled', 'english', 'yes', 'yes', 111);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Lead File Uploaded', 'template_lang_lead_file_upload', 'team', 'leads', 'New Lead File Uploaded', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New File Added</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new file has just been attached to this lead.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">{lead_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">{lead_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>File</strong></td>\n<td class=\"td-2\"><a href=\"{file_url}\">{file_name}</a></td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Uploaded By</strong></td>\n<td class=\"td-2\">{uploader_first_name}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your lead via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{lead_url}\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {file_name}, {file_size}, {file_extension}, {file_url}, {uploader_first_name}, {uploader_last_name}, {lead_id}, {lead_name}, {lead_description}, {lead_title}, {lead_created_date}, {lead_value}, {lead_status}, {lead_category}, {lead_url}', '2019-12-08 17:13:10', '2020-11-12 12:46:56', 'enabled', 'english', 'yes', 'yes', 112),
(NULL, NULL, 'Task Status Change', 'template_lang_task_status_change', 'everyone', 'tasks', 'Task Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Task Status Update</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of this task has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task Title</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Status</strong></td>\n<td class=\"td-2\">{task_status}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">View Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2020-11-13 08:15:19', 'enabled', 'english', 'yes', 'yes', 113),
(NULL, NULL, 'Task Assignment', 'template_lang_task_assignment', 'everyone', 'tasks', 'New Task Assignment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Task Assignment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>You have just been assigned to a task.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task Title</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{task_date_due}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">Manage Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {assigned_by_first_name}, {assigned_by_last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2020-11-12 12:50:42', 'enabled', 'english', 'yes', 'yes', 115),
(NULL, NULL, 'Task File Uploaded', 'template_lang_task_file_uploaded', 'everyone', 'tasks', 'New Task File Uploaded', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New File Added</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new file has just been attached to this task.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task Title</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>File</strong></td>\n<td class=\"td-2\"><a href=\"{file_url}\">{file_name}</a></td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Uploaded By</strong></td>\n<td class=\"td-2\">{uploader_first_name}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">Manage Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {file_name}, {file_size}, {file_extension}, {file_url}, {uploader_first_name}, {uploader_last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2020-11-12 12:53:03', 'enabled', 'english', 'yes', 'yes', 116),
(NULL, NULL, 'New Invoice', 'template_lang_new_invoice', 'client', 'billing', 'New Invoice - #{invoice_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Invoice</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Please find attached your invoice.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Invoice ID</strong></td>\n<td class=\"td-2\">{invoice_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount</strong></td>\n<td class=\"td-2\">{invoice_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{invoice_date_due}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view your invoice and make any payments using the link below.</p>\n<p>Your invoice is attached.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{invoice_url}\" target=\"_blank\" rel=\"noopener\">View Invoice</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {invoice_id}, {invoice_amount}, {invoice_amount_due}, {invoice_date_created}, {invoice_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {invoice_status}, {invoice_url}', '2019-12-08 17:13:10', '2021-01-25 18:32:01', 'enabled', 'english', 'yes', 'yes', 117);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Invoice Reminder', 'template_lang_invoice_reminder', 'client', 'billing', 'Invoice Reminder - #{invoice_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Invoice Reminder</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>This invoice is now overdue.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Invoice ID</strong></td>\n<td class=\"td-2\">{invoice_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{invoice_date_due}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount</strong></td>\n<td class=\"td-2\">{invoice_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view your invoice and make any payments using the link below.</p>\n<p>Your invoice is attached.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{invoice_url}\" target=\"_blank\" rel=\"noopener\">View Invoice</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {invoice_id}, {invoice_amount}, {invoice_amount_due}, {invoice_created_date}, {invoice_date_created}, {invoice_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {invoice_status}, {client_name}, {client_id},{invoice_url}', '2019-12-08 17:13:10', '2020-11-13 08:23:26', 'enabled', 'english', 'yes', 'yes', 118),
(NULL, NULL, 'Thank You For Payment', 'template_lang_thank_you_payment', 'client', 'billing', 'Thank You For Your Payment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Thank You!</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>We have received your payment and it has been applied to your invoice.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Invoice ID</strong></td>\n<td class=\"td-2\">{invoice_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount Paid</strong></td>\n<td class=\"td-2\">{payment_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Transaction ID</strong></td>\n<td class=\"td-2\">{payment_transaction_id}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view your invoice using the link below.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{invoice_url}\" target=\"_blank\" rel=\"noopener\">View Invoice</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {invoice_id}, {invoice_amount}, {invoice_amount_due}, {invoice_date_created}, {invoice_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {invoice_status}, {payment_gateway}, {payment_amount}, {payment_transaction_id}, {client_id}, {client_name}, {paid_by_name}, {invoice_url}', '2019-12-08 17:13:10', '2020-11-12 13:02:54', 'enabled', 'english', 'yes', 'yes', 119),
(NULL, NULL, 'New Payment', 'template_lang_new_payment', 'team', 'billing', 'New Payment Received', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Payment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new payment has just been made.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Invoice ID</strong></td>\n<td class=\"td-2\">{invoice_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount Due</strong></td>\n<td class=\"td-2\">{invoice_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Transaction ID</strong></td>\n<td class=\"td-2\">{payment_transaction_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Client Name</strong></td>\n<td class=\"td-2\">{client_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Paid By</strong></td>\n<td class=\"td-2\">{paid_by_name}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage payments and invoices via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{invoice_url}\" target=\"_blank\" rel=\"noopener\">Manage Invoices</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {invoice_id}, {invoice_amount}, {invoice_amount_due}, {invoice_date_created}, {invoice_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {invoice_status}, {payment_gateway}, {payment_amount}, {payment_transaction_id}, {client_id}, {client_name}, {paid_by_name}, {invoice_url}', '2019-12-08 17:13:10', '2020-11-12 13:06:24', 'enabled', 'english', 'yes', 'yes', 120),
(NULL, NULL, 'New Estimate', 'template_lang_new_estimate', 'client', 'estimates', 'New Estimate - #{estimate_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>NEW ESTIMATE</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>We have prepared a new cost estimate for your project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Estimate Amount</strong></td>\n<td class=\"td-2\">{estimate_amount}</td>\n</tr>\n</tbody>\n</table>\n<p>You can review this estimate via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{estimate_url}\" target=\"_blank\" rel=\"noopener\">View Estimate</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {estimate_id}, {estimate_amount}, {estimate_date_created}, {estimate_expiry_date}, {project_title}, {project_id}, {client_name}, {client_id}, {estimate_status}, {estimate_url}', '2019-12-08 17:13:10', '2020-11-12 20:09:26', 'enabled', 'english', 'yes', 'yes', 121),
(NULL, NULL, 'New Ticket', 'template_lang_new_ticket', 'everyone', 'tickets', 'New Ticket Opened - #{ticket_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Ticket Opened</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new support ticket has been created.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Title</strong></td>\n<td class=\"td-2\">{ticket_subject}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Created By</strong></td>\n<td class=\"td-2\">{by_first_name}</td>\n</tr>\n<tr>\n<td class=\"td-2\" colspan=\"2\">{ticket_message}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view and respond to this ticket via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{ticket_url}\" target=\"_blank\" rel=\"noopener\">View Ticket</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {ticket_id}, {by_first_name}, {by_last_name}, {ticket_subject}, {ticket_message}, {ticket_date_created}, {project_id}, {project_title}, {client_name}, {client_id}, {ticket_priority}, {ticket_status}, {ticket_url}', '2019-12-08 17:13:10', '2020-11-12 20:29:16', 'enabled', 'english', 'yes', 'yes', 124);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'New Ticket Reply', 'template_lang_new_ticket_reply', 'everyone', 'tickets', 'New Ticket Reply - #{ticket_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Ticket Reply</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new reply has just been posted to this ticket.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Title</strong></td>\n<td class=\"td-2\">{ticket_subject}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Posted By</strong></td>\n<td class=\"td-2\">{by_first_name}</td>\n</tr>\n<tr>\n<td class=\"td-2\" colspan=\"2\">{ticket_reply_message}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view and reply to this ticket via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{ticket_url}\" target=\"_blank\" rel=\"noopener\">View Ticket</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {ticket_id}, {by_first_name}, {by_last_name}, {ticket_subject}, {ticket_message}, {ticket_reply_message}, {ticket_date_created}, {project_id}, {project_title}, {client_name}, {client_id}, {ticket_priority}, {ticket_status}, {ticket_url}', '2019-12-08 17:13:10', '2020-11-12 20:33:27', 'enabled', 'english', 'yes', 'yes', 125),
(NULL, NULL, 'Ticket Closed', 'template_lang_ticket_closed', 'client', 'tickets', 'Ticket Has Been Closed - ID', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Ticket Closed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>This ticket has now been closed.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Ticket ID</strong></td>\n<td class=\"td-2\">{ticket_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Ticket Title</strong></td>\n<td class=\"td-2\">{ticket_subject}</td>\n</tr>\n</tbody>\n</table>\n<p>If you require further assistance you can open a new support ticket.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{ticket_url}\" target=\"_blank\" rel=\"noopener\">View Ticket</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {ticket_id}, {by_first_name}, {by_last_name}, {ticket_subject}, {ticket_message}, {ticket_date_created}, {project_id}, {project_title}, {client_name}, {client_id}, {ticket_status}, {ticket_priority}, {ticket_url}', '2019-12-08 17:13:10', '2021-11-04 15:00:31', 'enabled', 'english', 'yes', 'yes', 126),
(NULL, NULL, 'System Notification', 'template_lang_system_notification', 'admin', 'system', '{notification_subject}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>{notification_title}</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>{notification_message}</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">&nbsp;</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {notification_title}, {notification_subject}, {notification_message}', '2019-12-08 17:13:10', '2020-11-12 20:37:25', 'enabled', 'english', 'yes', 'yes', 127),
(NULL, NULL, 'Task Comment', 'template_lang_task_comment', 'everyone', 'tasks', 'New Task Comment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Comment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new comment has just been posted on this project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Posted By</strong></td>\n<td class=\"td-2\">{poster_first_name}</td>\n</tr>\n<tr>\n<td class=\"td-2\" colspan=\"2\">{comment}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">View Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {comment}, {poster_first_name}, {poster_last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2020-11-13 08:18:31', 'enabled', 'english', 'yes', 'yes', 128),
(NULL, NULL, 'Estimate Accepted', 'template_lang_estimate_accepted', 'team', 'estimates', 'Estimate Accepted - #{estimate_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Estimate Accepted</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Great news, {client_name} has just accepted this Estimate.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Estimate ID</strong></td>\n<td class=\"td-2\">{estimate_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Estimate Amount</strong></td>\n<td class=\"td-2\">{estimate_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage this estimate via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{estimate_url}\" target=\"_blank\" rel=\"noopener\">View Estimate</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {estimate_id}, {estimate_amount}, {estimate_date_created}, {estimate_expiry_date}, {project_id}, {project_title}, {client_name}, {client_id}, {estimate_status}, {estimate_url}', '2019-12-08 17:13:10', '2020-11-12 20:20:09', 'enabled', 'english', 'yes', 'yes', 129);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Estimate Declined', 'template_lang_estimate_declined', 'team', 'estimates', 'Estimate Declined - #{estimate_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Estimate Declined</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Unfortunately,&nbsp;{client_name} has just declined this estimate.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Estimate ID</strong></td>\n<td class=\"td-2\">{estimate_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Estimate Amount</strong></td>\n<td class=\"td-2\">{estimate_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{estimate_url}\" target=\"_blank\" rel=\"noopener\">View Estimate</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {estimate_id}, {estimate_amount}, {estimate_date_created}, {estimate_expiry_date}, {project_id}, {project_title}, {client_name}, {client_id}, {estimate_status}, {estimate_url}', '2019-12-08 17:13:10', '2020-11-13 08:25:00', 'enabled', 'english', 'yes', 'yes', 130),
(NULL, NULL, 'Estimate Revised', 'template_lang_estimate_revised', 'client', 'estimates', 'Estimate Revised - #{estimate_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Estimate Revised</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Great news, we have just revised your estimate. The revised estimate is attached to this email.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Estimate ID</strong></td>\n<td class=\"td-2\">{estimate_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Estimate Amount</strong></td>\n<td class=\"td-2\">{estimate_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can review this estimate via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{estimate_url}\" target=\"_blank\" rel=\"noopener\">View Estimate</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {estimate_id}, {estimate_amount}, {estimate_date_created}, {estimate_expiry_date}, {project_id}, {project_title}, {client_name}, {client_id}, {estimate_status}, {estimate_url}', '2019-12-08 17:13:10', '2020-11-12 20:26:04', 'enabled', 'english', 'yes', 'yes', 131),
(NULL, NULL, 'New Subscription Created', 'template_lang_new_subscription_created', 'client', 'subscriptions', 'New Subscription Created', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Subscription</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your subscription has just been created. You can now log in and complete the payment.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 116px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 373px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 116px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 373px;\">{subscription_amount} /&nbsp;{subscription_cycle}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your subscription via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">Complete Payment</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-16 11:07:26', 'enabled', 'english', 'yes', 'yes', 132),
(NULL, NULL, 'Subscription Renewal Failed', 'template_lang_subscription_renewal_failed', 'client', 'subscriptions', 'Subscription Renewal Has Failed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Has Failed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your subscription renewal payment has failed. You can add or update your payment method and the payment will be processed again.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Plan</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">Manage Your Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-15 19:58:30', 'enabled', 'english', 'yes', 'yes', 133),
(NULL, NULL, 'Subscription Renewal Failed', 'template_lang_subscription_renewal_failed', 'team', 'subscriptions', 'Subscription Renewal Failed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Failed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following subscription\'s renewal payment has failed.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Client</strong></td>\n<td class=\"td-2\">{client_company_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\">{subscription_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Plan</strong></td>\n<td class=\"td-2\">{subscription_plan}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount</strong></td>\n<td class=\"td-2\">{subscription_amount}</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-15 19:53:33', 'enabled', 'english', 'yes', 'yes', 134);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Subscription Renewed', 'template_lang_subscription_renewed', 'team', 'subscriptions', 'Subscription Was Renewed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Renewed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following subscription has been renewed successfully.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Client</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{client_company_name}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_id}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount} /&nbsp;{subscription_cycle}</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-22 15:24:33', 'enabled', 'english', 'yes', 'yes', 135),
(NULL, NULL, 'Subscription Renewed', 'template_lang_subscription_renewed', 'client', 'subscriptions', 'Subscription Was Renewed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Renewed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your subscription has renewed successfully.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_id}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount}</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-22 15:23:50', 'enabled', 'english', 'yes', 'yes', 137),
(NULL, NULL, 'Subscription Started', 'template_lang_subscription_started', 'team', 'subscriptions', 'Subscription Activated', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Activated</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following subscription\'s been paid by the client and has started.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Client</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{client_company_name}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_project_id}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount}</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-02-04 16:36:12', 'enabled', 'english', 'yes', 'yes', 136),
(NULL, NULL, 'Subscription Cancelled', 'template_lang_subscription_renewed', 'everyone', 'subscriptions', 'Subscription Was Cancelled', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 40%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Subscription Cancelled</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>The following subscription has been cancelled.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\r\n<tbody>\r\n<tr style=\"height: 24px;\">\r\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\r\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_id}</td>\r\n</tr>\r\n<tr style=\"height: 24px;\">\r\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\r\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\r\n</tr>\r\n<tr style=\"height: 24px;\">\r\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\r\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>&nbsp;</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_amount},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-23 19:07:24', 'enabled', 'english', 'yes', 'yes', 138),
(NULL, NULL, 'Subscription Started', 'template_lang_subscription_started', 'client', 'subscriptions', 'Your Subscription Has Started', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Started</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" style=\"height: 389px; width: 100%;\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr style=\"height: 56px;\">\n<td class=\"td-1\" style=\"height: 56px;\">\n<p>Your subscription has now started.</p>\n</td>\n</tr>\n<tr style=\"height: 197px;\">\n<td class=\"td-1\" style=\"height: 197px;\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_project_id}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount}</td>\n</tr>\n</tbody>\n</table>\n<p> </p>\n</td>\n</tr>\n<tr style=\"height: 80px;\">\n<td style=\"height: 80px;\" align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr style=\"height: 56px;\">\n<td class=\"signature\" style=\"height: 56px;\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-02-04 16:35:42', 'enabled', 'english', 'yes', 'yes', 139);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Task Overdue', 'template_lang_task_overdue', 'team', 'tasks', 'Task Is Overdue', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Overdue Task</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following task that you are assigned to, is now overdue.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{task_date_due}</td>\n</tr>\n<tr>\n<td class=\"td-2\" colspan=\"2\">{task_description}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">View Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {comment}, {poster_first_name}, {poster_last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2021-06-07 19:20:43', 'enabled', 'english', 'yes', 'yes', 140),
(NULL, NULL, 'New Proposal', 'template_lang_new_proposal', 'client', 'proposals', 'New Proposal - #{proposal_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Proposal</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Please find attached our proposal for your project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Proposal Title</strong></td>\n<td class=\"td-2\">{proposal_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal ID</strong></td>\n<td class=\"td-2\">{proposal_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Value</strong></td>\n<td class=\"td-2\">{proposal_value}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Date</strong></td>\n<td class=\"td-2\">{proposal_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Valid Until Date</strong></td>\n<td class=\"td-2\">{proposal_expiry_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view the proposal using the link below</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{proposal_url}\" target=\"_blank\" rel=\"noopener\">View Proposal</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {proposal_id}, {proposal_title}, {proposal_value}, {proposal_date}, {proposal_expiry_date}, {proposal_url}', '2019-12-08 17:13:10', '2022-05-20 05:04:09', 'enabled', 'english', 'yes', 'yes', 142),
(NULL, NULL, 'Proposal Accepted', 'template_lang_proposal_accepted', 'team', 'proposals', 'Proposal Had Been Accepted - #{proposal_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Proposal Accepted</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The client has accepted the proposal.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Proposal Title</strong></td>\n<td class=\"td-2\">{proposal_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal ID</strong></td>\n<td class=\"td-2\">{proposal_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Value</strong></td>\n<td class=\"td-2\">{proposal_value}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Date</strong></td>\n<td class=\"td-2\">{proposal_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Valid Until Date</strong></td>\n<td class=\"td-2\">{proposal_expiry_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view the proposal using the link below</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{proposal_url}\" target=\"_blank\" rel=\"noopener\">View Proposal</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {proposal_id}, {proposal_title}, {proposal_value}, {proposal_date}, {proposal_expiry_date}, {proposal_url}', '2019-12-08 17:13:10', '2022-05-20 05:05:09', 'enabled', 'english', 'yes', 'yes', 143),
(NULL, NULL, 'Proposal Declined', 'template_lang_proposal_declined', 'team', 'proposals', 'Proposal Had Been Declined - #{proposal_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Proposal Declined</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The client has declined the proposal.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Proposal Title</strong></td>\n<td class=\"td-2\">{proposal_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal ID</strong></td>\n<td class=\"td-2\">{proposal_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Value</strong></td>\n<td class=\"td-2\">{proposal_value}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Date</strong></td>\n<td class=\"td-2\">{proposal_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Valid Until Date</strong></td>\n<td class=\"td-2\">{proposal_expiry_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view the proposal using the link below</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{proposal_url}\" target=\"_blank\" rel=\"noopener\">View Proposal</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {proposal_id}, {proposal_title}, {proposal_value}, {proposal_date}, {proposal_expiry_date}, {proposal_url}', '2019-12-08 17:13:10', '2022-05-20 05:05:44', 'enabled', 'english', 'yes', 'yes', 144),
(NULL, NULL, 'New Contract', 'template_lang_new_contract', 'client', 'contracts', 'New Contract - #{contract_id}', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>New Contract</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>We have prepared a contract for you to review and sign.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Contract Title</strong></td>\r\n<td class=\"td-2\">{contract_title}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Contract ID</strong></td>\r\n<td class=\"td-2\">{contract_id}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Value</strong></td>\r\n<td class=\"td-2\">{contract_value}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Date</strong></td>\r\n<td class=\"td-2\">{contract_date}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>End Date</strong></td>\r\n<td class=\"td-2\">{contract_end_date}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>You can view the contract using the link below</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{contract_url}\" target=\"_blank\" rel=\"noopener\">View Contract</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {contract_id}, {contract_title}, {contract_date}, {contract_end_date}, {contract_value}, {contract_url}', '2019-12-08 17:13:10', '2023-01-06 04:28:11', 'enabled', 'english', 'yes', 'yes', 151);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Contract Signed', 'template_lang_contract_signed', 'team', 'contracts', 'Contract Has Been Signed - #{contract_id}', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Contract Accepted</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>The client has signed the contract.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Contract Title</strong></td>\r\n<td class=\"td-2\">{contract_title}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Contract ID</strong></td>\r\n<td class=\"td-2\">{contract_id}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Value</strong></td>\r\n<td class=\"td-2\">{contract_value}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Date</strong></td>\r\n<td class=\"td-2\">{contract_date}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>End Date</strong></td>\r\n<td class=\"td-2\">{contract_end_date}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>You can view the contract using the link below</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{contract_url}\" target=\"_blank\" rel=\"noopener\">View Contract</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {contract_id}, {contract_title}, {contract_date}, {contract_end_date}, {contract_value}, {contract_url}', '2019-12-08 17:13:10', '2023-01-06 04:28:52', 'enabled', 'english', 'yes', 'yes', 152),
(NULL, NULL, 'Proposal Revised', 'template_lang_proposal_revised', 'client', 'proposals', 'Proposal Revised - #{proposal_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Revised Proposal</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Please find attached our revised proposal for your project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Proposal Title</strong></td>\n<td class=\"td-2\">{proposal_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal ID</strong></td>\n<td class=\"td-2\">{proposal_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Value</strong></td>\n<td class=\"td-2\">{proposal_value}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Date</strong></td>\n<td class=\"td-2\">{proposal_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Valid Until Date</strong></td>\n<td class=\"td-2\">{proposal_expiry_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view the proposal using the link below</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{proposal_url}\" target=\"_blank\" rel=\"noopener\">View Proposal</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {proposal_id}, {proposal_title}, {proposal_value}, {proposal_date}, {proposal_expiry_date}, {proposal_url}', '2019-12-08 17:13:10', '2022-05-29 08:05:02', 'enabled', 'english', 'yes', 'yes', 148),
(NULL, NULL, 'Reminder', 'reminder', 'everyone', 'other', 'Due Reminder - {reminder_title}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Reminder</h1>\n<h2>({linked_item_type})</h2>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following reminder is now due.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Reminder Title</strong></td>\n<td class=\"td-2\">{reminder_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Reminder Item Title</strong></td>\n<td class=\"td-2\">{linked_item_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{reminder_date}&nbsp;{reminder_time}&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{linked_item_url}\" target=\"_blank\" rel=\"noopener\">View Reminder Item</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {reminder_title}, {reminder_date}, {reminder_time}, {reminder_notes}, {linked_item_type}, {linked_item_name}, {linked_item_title}, {linked_item_id}, {linked_item_url}', '2019-12-08 17:13:10', '2022-08-18 15:59:04', 'enabled', 'english', 'yes', 'yes', 150);

-- --------------------------------------------------------

--
-- Table structure for table `estimates`
--

CREATE TABLE `estimates` (
  `bill_estimateid` int(11) NOT NULL,
  `bill_created` datetime DEFAULT NULL,
  `bill_updated` datetime DEFAULT NULL,
  `bill_date_sent_to_customer` datetime DEFAULT NULL,
  `bill_clientid` int(11) DEFAULT NULL,
  `bill_projectid` int(11) DEFAULT NULL,
  `bill_proposalid` int(11) DEFAULT NULL,
  `bill_contractid` int(11) DEFAULT NULL,
  `bill_creatorid` int(11) NOT NULL,
  `bill_categoryid` int(11) NOT NULL DEFAULT 4,
  `bill_date` date NOT NULL,
  `bill_expiry_date` date DEFAULT NULL,
  `bill_subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `bill_discount_type` varchar(30) DEFAULT 'none' COMMENT 'amount | percentage | none',
  `bill_discount_percentage` decimal(10,2) DEFAULT 0.00 COMMENT 'actual amount or percentage',
  `bill_discount_amount` decimal(10,2) DEFAULT 0.00,
  `bill_amount_before_tax` decimal(10,2) DEFAULT 0.00,
  `bill_tax_type` varchar(20) DEFAULT 'summary' COMMENT 'summary|inline|none',
  `bill_tax_total_percentage` decimal(10,2) DEFAULT 0.00 COMMENT 'percentage',
  `bill_tax_total_amount` decimal(10,2) DEFAULT 0.00 COMMENT 'amount',
  `bill_adjustment_description` varchar(250) DEFAULT NULL,
  `bill_adjustment_amount` decimal(10,2) DEFAULT 0.00,
  `bill_final_amount` decimal(10,2) DEFAULT 0.00,
  `bill_notes` text DEFAULT NULL,
  `bill_terms` text DEFAULT NULL,
  `bill_status` varchar(50) NOT NULL DEFAULT 'draft' COMMENT 'draft | new | accepted | revised | declined | expired',
  `bill_type` varchar(150) NOT NULL DEFAULT 'estimate' COMMENT 'estimate|invoice',
  `bill_estimate_type` varchar(150) NOT NULL DEFAULT 'estimate' COMMENT 'estimate|document',
  `bill_visibility` varchar(150) NOT NULL DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent estimates that are still being cloned from showing in estimates list)',
  `bill_viewed_by_client` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `bill_system` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `bill_converted_to_invoice` varchar(20) DEFAULT 'no' COMMENT 'Added as of V1.10',
  `bill_converted_to_invoice_invoiceid` int(11) DEFAULT NULL COMMENT 'Added as of V1.10',
  `estimate_automation_status` varchar(100) DEFAULT 'disabled' COMMENT 'disabled|enabled',
  `estimate_automation_create_project` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_project_title` varchar(250) DEFAULT NULL,
  `estimate_automation_project_status` varchar(100) DEFAULT 'in_progress' COMMENT 'not_started | in_progress | on_hold',
  `estimate_automation_create_tasks` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_project_email_client` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_create_invoice` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_invoice_due_date` int(11) DEFAULT 7,
  `estimate_automation_invoice_email_client` varchar(50) DEFAULT 'no',
  `estimate_automation_copy_attachments` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_log_created_project_id` int(11) DEFAULT NULL,
  `estimate_automation_log_created_invoice_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

--
-- Dumping data for table `estimates`
--

INSERT INTO `estimates` (`bill_estimateid`, `bill_created`, `bill_updated`, `bill_date_sent_to_customer`, `bill_clientid`, `bill_projectid`, `bill_proposalid`, `bill_contractid`, `bill_creatorid`, `bill_categoryid`, `bill_date`, `bill_expiry_date`, `bill_subtotal`, `bill_discount_type`, `bill_discount_percentage`, `bill_discount_amount`, `bill_amount_before_tax`, `bill_tax_type`, `bill_tax_total_percentage`, `bill_tax_total_amount`, `bill_adjustment_description`, `bill_adjustment_amount`, `bill_final_amount`, `bill_notes`, `bill_terms`, `bill_status`, `bill_type`, `bill_estimate_type`, `bill_visibility`, `bill_viewed_by_client`, `bill_system`, `bill_converted_to_invoice`, `bill_converted_to_invoice_invoiceid`, `estimate_automation_status`, `estimate_automation_create_project`, `estimate_automation_project_title`, `estimate_automation_project_status`, `estimate_automation_create_tasks`, `estimate_automation_project_email_client`, `estimate_automation_create_invoice`, `estimate_automation_invoice_due_date`, `estimate_automation_invoice_email_client`, `estimate_automation_copy_attachments`, `estimate_automation_log_created_project_id`, `estimate_automation_log_created_invoice_id`) VALUES
(-100, '2022-05-22 11:46:15', '2022-05-22 11:46:15', NULL, 0, 0, NULL, NULL, 0, 5, '2022-05-22', NULL, '0.00', 'none', '0.00', '0.00', '0.00', 'summary', '0.00', '0.00', NULL, '0.00', '0.00', NULL, '<p>Thank you for your business. We look forward to working with you on this project.</p>', 'draft', 'estimate', 'document', 'visible', 'no', 'yes', 'no', NULL, 'disabled', 'no', NULL, 'in_progress', 'no', 'no', 'no', 7, 'no', 'no', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `event_created` datetime DEFAULT NULL COMMENT '[notes] Events record the event, whilst timelines determine where the event is displayed',
  `event_updated` datetime DEFAULT NULL,
  `event_creatorid` int(11) NOT NULL COMMENT 'use ( -1 ) for logged out user.',
  `event_clientid` int(11) DEFAULT NULL COMMENT 'for client type resources',
  `event_creator_name` varchar(150) DEFAULT NULL COMMENT 'for events created by users who are not registered (e.g. accepting a proposal)',
  `event_item` varchar(150) DEFAULT NULL COMMENT 'status | project | task | lead | expense | estimate| comment | attachment | file | invoice | payment | assigned',
  `event_item_id` int(11) DEFAULT NULL COMMENT 'e.g. invoice_id (used in the link shown in the even)',
  `event_item_content` text DEFAULT NULL COMMENT 'e.g. #INV-029200 (used in the text if the event, also in the link text)',
  `event_item_content2` text DEFAULT NULL COMMENT 'extra content',
  `event_item_content3` text DEFAULT NULL COMMENT 'extra content',
  `event_item_content4` text DEFAULT NULL COMMENT 'extra content',
  `event_item_lang` varchar(150) DEFAULT NULL COMMENT '(e.g. - event_created_invoice found in the lang file )',
  `event_item_lang_alt` varchar(150) DEFAULT NULL COMMENT 'Example: Fred posted a comment (as opposed to) You posed a comment',
  `event_parent_type` varchar(150) DEFAULT NULL COMMENT 'used to identify the parent up the tree (e.g. for a task, parent is project) (.e.g. for a task comment, parent is task)',
  `event_parent_id` varchar(150) DEFAULT NULL COMMENT 'id of the parent item (e.g project_id)',
  `event_parent_title` varchar(150) DEFAULT NULL COMMENT 'e.g. task title',
  `event_show_item` varchar(150) DEFAULT 'yes' COMMENT 'yes|no (if the item should be shown in the notifications dopdown)',
  `event_show_in_timeline` varchar(150) DEFAULT 'yes' COMMENT 'yes|no (if this should show the project timeline)',
  `event_notification_category` varchar(150) DEFAULT NULL COMMENT '(e.g. notifications_new_invoice) This determins if a user will get a web notification, an email, both, or none. As per the settings in the [user] table and the login in the [eventTrackingRepo)',
  `eventresource_type` varchar(50) DEFAULT NULL COMMENT '[polymorph] project | ticket | lead (e.g. if you want the event to show in the project timeline, then eventresource_type  must be set to project)',
  `eventresource_id` int(11) DEFAULT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `events_tracking`
--

CREATE TABLE `events_tracking` (
  `eventtracking_id` int(11) NOT NULL,
  `eventtracking_created` datetime NOT NULL,
  `eventtracking_updated` datetime NOT NULL,
  `eventtracking_eventid` int(11) NOT NULL,
  `eventtracking_userid` int(11) NOT NULL,
  `eventtracking_status` varchar(30) DEFAULT 'unread' COMMENT 'read|unread',
  `eventtracking_email` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `eventtracking_source` varchar(50) DEFAULT NULL COMMENT 'the actual item (e.g. file | comment | invoice)',
  `eventtracking_source_id` varchar(50) DEFAULT NULL COMMENT 'the id of the actual item',
  `parent_type` varchar(50) DEFAULT NULL COMMENT 'used to locate the main event in the events table. Also used for marking the event as read, once the parent has been viewed. (e.g. for invoice, parent is invoice. For comment task, parent is task)',
  `parent_id` int(11) DEFAULT NULL,
  `resource_type` varchar(50) DEFAULT NULL COMMENT 'Also used for marking events as read, for ancillary items like (project comments, project file) where just viewing a project is enough',
  `resource_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expense_id` int(11) NOT NULL,
  `expense_importid` varchar(100) DEFAULT NULL,
  `expense_created` date DEFAULT NULL,
  `expense_updated` date DEFAULT NULL,
  `expense_date` date DEFAULT NULL,
  `expense_clientid` int(11) DEFAULT NULL,
  `expense_projectid` int(11) DEFAULT NULL,
  `expense_creatorid` int(11) NOT NULL,
  `expense_categoryid` int(11) NOT NULL DEFAULT 7,
  `expense_amount` decimal(10,2) NOT NULL,
  `expense_description` text DEFAULT NULL,
  `expense_type` text DEFAULT NULL COMMENT 'business|client',
  `expense_billable` varchar(30) DEFAULT 'not_billable' COMMENT 'billable | not_billable',
  `expense_billing_status` varchar(30) DEFAULT 'not_invoiced' COMMENT 'invoiced | not_invoiced',
  `expense_billable_invoiceid` int(11) DEFAULT NULL COMMENT 'id of the invoice that it has been billed to'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `file_id` int(11) NOT NULL,
  `file_uniqueid` varchar(100) DEFAULT NULL,
  `file_upload_unique_key` varchar(100) DEFAULT NULL COMMENT 'used to idetify files that were uploaded in one go',
  `file_created` datetime DEFAULT NULL,
  `file_updated` datetime DEFAULT NULL,
  `file_creatorid` int(11) DEFAULT NULL,
  `file_clientid` int(11) DEFAULT NULL COMMENT 'optional',
  `file_folderid` int(11) DEFAULT NULL,
  `file_filename` varchar(250) DEFAULT NULL,
  `file_directory` varchar(100) DEFAULT NULL,
  `file_extension` varchar(10) DEFAULT NULL,
  `file_size` varchar(40) DEFAULT NULL COMMENT 'human readable file size',
  `file_type` varchar(20) DEFAULT NULL COMMENT 'image|file',
  `file_thumbname` varchar(250) DEFAULT NULL COMMENT 'optional',
  `file_visibility_client` varchar(5) DEFAULT 'yes' COMMENT 'yes | no',
  `fileresource_type` varchar(50) DEFAULT NULL COMMENT '[polymorph] project',
  `fileresource_id` int(11) DEFAULT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `file_folders`
--

CREATE TABLE `file_folders` (
  `filefolder_id` int(11) NOT NULL,
  `filefolder_created` datetime NOT NULL,
  `filefolder_updated` datetime NOT NULL,
  `filefolder_creatorid` int(11) DEFAULT NULL,
  `filefolder_projectid` int(11) DEFAULT NULL,
  `filefolder_name` varchar(250) DEFAULT NULL,
  `filefolder_default` varchar(100) DEFAULT 'no' COMMENT 'yes|no',
  `filefolder_system` varchar(100) DEFAULT 'no' COMMENT 'yes|no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `file_folders`
--

INSERT INTO `file_folders` (`filefolder_id`, `filefolder_created`, `filefolder_updated`, `filefolder_creatorid`, `filefolder_projectid`, `filefolder_name`, `filefolder_default`, `filefolder_system`) VALUES
(1, '2023-01-19 22:02:01', '2023-01-19 22:02:01', 0, NULL, 'Default', 'yes', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `bill_invoiceid` int(11) NOT NULL,
  `bill_created` datetime DEFAULT NULL,
  `bill_updated` datetime DEFAULT NULL,
  `bill_date_sent_to_customer` date DEFAULT NULL COMMENT 'the date an invoice was published or lasts emailed to the customer',
  `bill_clientid` int(11) NOT NULL,
  `bill_projectid` int(11) DEFAULT NULL COMMENT 'optional',
  `bill_subscriptionid` int(11) DEFAULT NULL COMMENT 'optional',
  `bill_creatorid` int(11) NOT NULL,
  `bill_categoryid` int(11) NOT NULL DEFAULT 4,
  `bill_date` date NOT NULL,
  `bill_due_date` date DEFAULT NULL,
  `bill_subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `bill_discount_type` varchar(30) DEFAULT 'none' COMMENT 'amount | percentage | none',
  `bill_discount_percentage` decimal(10,2) DEFAULT 0.00 COMMENT 'actual amount or percentage',
  `bill_discount_amount` decimal(10,2) DEFAULT 0.00,
  `bill_amount_before_tax` decimal(10,2) DEFAULT 0.00,
  `bill_tax_type` varchar(20) DEFAULT 'summary' COMMENT 'summary|inline|none',
  `bill_tax_total_percentage` decimal(10,2) DEFAULT 0.00 COMMENT 'percentage',
  `bill_tax_total_amount` decimal(10,2) DEFAULT 0.00 COMMENT 'amount',
  `bill_adjustment_description` varchar(250) DEFAULT NULL,
  `bill_adjustment_amount` decimal(10,2) DEFAULT 0.00,
  `bill_final_amount` decimal(10,2) DEFAULT 0.00,
  `bill_notes` text DEFAULT NULL,
  `bill_terms` text DEFAULT NULL,
  `bill_status` varchar(50) NOT NULL DEFAULT 'draft' COMMENT 'draft | due | overdue | paid | part_paid',
  `bill_recurring` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `bill_recurring_duration` int(11) DEFAULT NULL COMMENT 'e.g. 20 (for 20 days)',
  `bill_recurring_period` varchar(30) DEFAULT NULL COMMENT 'day | week | month | year',
  `bill_recurring_cycles` int(11) DEFAULT NULL COMMENT '0 for infinity',
  `bill_recurring_cycles_counter` int(11) DEFAULT NULL COMMENT 'number of times it has been renewed',
  `bill_recurring_last` date DEFAULT NULL COMMENT 'date when it was last renewed',
  `bill_recurring_next` date DEFAULT NULL COMMENT 'date when it will next be renewed',
  `bill_recurring_child` varchar(5) DEFAULT 'no' COMMENT 'yes|no',
  `bill_recurring_parent_id` int(11) DEFAULT NULL COMMENT 'if it was generated from a recurring invoice, the id of parent invoice',
  `bill_overdue_reminder_sent` varchar(5) DEFAULT 'no' COMMENT 'yes | no',
  `bill_invoice_type` varchar(30) DEFAULT 'onetime' COMMENT 'onetime | subscription',
  `bill_type` varchar(20) DEFAULT 'invoice' COMMENT 'invoice|estimate',
  `bill_visibility` varchar(20) DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent invoices that are still being cloned from showing in invoices list)',
  `bill_cron_status` varchar(20) DEFAULT 'none' COMMENT 'none|processing|completed|error  (used to prevent collisions when recurring invoiced)',
  `bill_cron_date` datetime DEFAULT NULL COMMENT 'date when cron was run',
  `bill_viewed_by_client` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `bill_system` varchar(20) DEFAULT 'no' COMMENT 'yes|no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `item_created` datetime DEFAULT NULL,
  `item_updated` datetime DEFAULT NULL,
  `item_categoryid` int(11) NOT NULL DEFAULT 8,
  `item_creatorid` int(11) NOT NULL,
  `item_type` varchar(100) NOT NULL DEFAULT 'standard' COMMENT 'standard|dimensions',
  `item_description` text DEFAULT NULL,
  `item_unit` varchar(50) DEFAULT NULL,
  `item_rate` decimal(10,2) NOT NULL,
  `item_tax_status` varchar(100) NOT NULL DEFAULT 'taxable' COMMENT 'taxable|exempt',
  `item_dimensions_length` decimal(10,2) DEFAULT NULL,
  `item_dimensions_width` decimal(10,2) DEFAULT NULL,
  `item_notes_estimatation` text DEFAULT NULL,
  `item_notes_production` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `kb_categories`
--

CREATE TABLE `kb_categories` (
  `kbcategory_id` int(11) NOT NULL,
  `kbcategory_created` datetime NOT NULL,
  `kbcategory_updated` datetime NOT NULL,
  `kbcategory_creatorid` int(11) NOT NULL,
  `kbcategory_title` varchar(250) NOT NULL,
  `kbcategory_description` text DEFAULT NULL,
  `kbcategory_position` int(11) DEFAULT NULL,
  `kbcategory_visibility` varchar(50) DEFAULT 'everyone' COMMENT 'everyone | team | client',
  `kbcategory_slug` varchar(250) DEFAULT NULL,
  `kbcategory_icon` varchar(250) DEFAULT NULL,
  `kbcategory_type` varchar(50) DEFAULT 'text' COMMENT 'text|video',
  `kbcategory_system_default` varchar(250) DEFAULT 'no' COMMENT 'yes | no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

--
-- Dumping data for table `kb_categories`
--

INSERT INTO `kb_categories` (`kbcategory_id`, `kbcategory_created`, `kbcategory_updated`, `kbcategory_creatorid`, `kbcategory_title`, `kbcategory_description`, `kbcategory_position`, `kbcategory_visibility`, `kbcategory_slug`, `kbcategory_icon`, `kbcategory_type`, `kbcategory_system_default`) VALUES
(1, '2023-01-19 22:02:01', '2023-01-19 22:02:01', 0, 'Frequently Asked Questions', 'Answers to some of the most frequently asked questions', 1, 'everyone', '1-frequently-asked-questions', 'sl-icon-call-out', 'text', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `knowledgebase`
--

CREATE TABLE `knowledgebase` (
  `knowledgebase_id` int(11) NOT NULL,
  `knowledgebase_created` datetime NOT NULL,
  `knowledgebase_updated` datetime NOT NULL,
  `knowledgebase_creatorid` int(11) NOT NULL,
  `knowledgebase_categoryid` int(11) NOT NULL,
  `knowledgebase_title` varchar(250) NOT NULL,
  `knowledgebase_slug` varchar(250) DEFAULT NULL,
  `knowledgebase_text` text DEFAULT NULL,
  `knowledgebase_embed_video_id` varchar(50) DEFAULT NULL,
  `knowledgebase_embed_code` text DEFAULT NULL,
  `knowledgebase_embed_thumb` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `lead_id` int(11) NOT NULL,
  `lead_importid` varchar(100) DEFAULT NULL,
  `lead_position` double NOT NULL,
  `lead_created` datetime DEFAULT NULL,
  `lead_updated` datetime DEFAULT NULL,
  `lead_creatorid` int(11) DEFAULT NULL,
  `lead_updatorid` int(11) DEFAULT NULL,
  `lead_categoryid` int(11) DEFAULT 3,
  `lead_firstname` varchar(100) DEFAULT NULL,
  `lead_lastname` varchar(100) DEFAULT NULL,
  `lead_email` varchar(150) DEFAULT NULL,
  `lead_phone` varchar(150) DEFAULT NULL,
  `lead_job_position` varchar(150) DEFAULT NULL,
  `lead_company_name` varchar(150) DEFAULT NULL,
  `lead_website` varchar(150) DEFAULT NULL,
  `lead_street` varchar(150) DEFAULT NULL,
  `lead_city` varchar(150) DEFAULT NULL,
  `lead_state` varchar(150) DEFAULT NULL,
  `lead_zip` varchar(150) DEFAULT NULL,
  `lead_country` varchar(150) DEFAULT NULL,
  `lead_source` varchar(150) DEFAULT NULL,
  `lead_title` varchar(250) DEFAULT NULL,
  `lead_description` text DEFAULT NULL,
  `lead_value` decimal(10,2) DEFAULT NULL,
  `lead_last_contacted` date DEFAULT NULL,
  `lead_converted` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `lead_converted_by_userid` int(11) DEFAULT NULL COMMENT 'id of user who converted',
  `lead_converted_date` datetime DEFAULT NULL COMMENT 'date lead converted',
  `lead_converted_clientid` int(11) DEFAULT NULL COMMENT 'if the lead has previously been converted to a client',
  `lead_status` tinyint(4) DEFAULT 1 COMMENT 'Deafult is id: 1 (leads_status) table',
  `lead_active_state` varchar(10) DEFAULT 'active' COMMENT 'active|archived',
  `lead_visibility` varchar(40) DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent tasks that are still being cloned from showing in tasks list)',
  `lead_custom_field_1` tinytext DEFAULT NULL,
  `lead_custom_field_2` tinytext DEFAULT NULL,
  `lead_custom_field_3` tinytext DEFAULT NULL,
  `lead_custom_field_4` tinytext DEFAULT NULL,
  `lead_custom_field_5` tinytext DEFAULT NULL,
  `lead_custom_field_6` tinytext DEFAULT NULL,
  `lead_custom_field_7` tinytext DEFAULT NULL,
  `lead_custom_field_8` tinytext DEFAULT NULL,
  `lead_custom_field_9` tinytext DEFAULT NULL,
  `lead_custom_field_10` tinytext DEFAULT NULL,
  `lead_custom_field_11` tinytext DEFAULT NULL,
  `lead_custom_field_12` tinytext DEFAULT NULL,
  `lead_custom_field_13` tinytext DEFAULT NULL,
  `lead_custom_field_14` tinytext DEFAULT NULL,
  `lead_custom_field_15` tinytext DEFAULT NULL,
  `lead_custom_field_16` tinytext DEFAULT NULL,
  `lead_custom_field_17` tinytext DEFAULT NULL,
  `lead_custom_field_18` tinytext DEFAULT NULL,
  `lead_custom_field_19` tinytext DEFAULT NULL,
  `lead_custom_field_20` tinytext DEFAULT NULL,
  `lead_custom_field_21` tinytext DEFAULT NULL,
  `lead_custom_field_22` tinytext DEFAULT NULL,
  `lead_custom_field_23` tinytext DEFAULT NULL,
  `lead_custom_field_24` tinytext DEFAULT NULL,
  `lead_custom_field_25` tinytext DEFAULT NULL,
  `lead_custom_field_26` tinytext DEFAULT NULL,
  `lead_custom_field_27` tinytext DEFAULT NULL,
  `lead_custom_field_28` tinytext DEFAULT NULL,
  `lead_custom_field_29` tinytext DEFAULT NULL,
  `lead_custom_field_30` tinytext DEFAULT NULL,
  `lead_custom_field_31` datetime DEFAULT NULL,
  `lead_custom_field_32` datetime DEFAULT NULL,
  `lead_custom_field_33` datetime DEFAULT NULL,
  `lead_custom_field_34` datetime DEFAULT NULL,
  `lead_custom_field_35` datetime DEFAULT NULL,
  `lead_custom_field_36` datetime DEFAULT NULL,
  `lead_custom_field_37` datetime DEFAULT NULL,
  `lead_custom_field_38` datetime DEFAULT NULL,
  `lead_custom_field_39` datetime DEFAULT NULL,
  `lead_custom_field_40` datetime DEFAULT NULL,
  `lead_custom_field_41` text DEFAULT NULL,
  `lead_custom_field_42` text DEFAULT NULL,
  `lead_custom_field_43` text DEFAULT NULL,
  `lead_custom_field_44` text DEFAULT NULL,
  `lead_custom_field_45` text DEFAULT NULL,
  `lead_custom_field_46` text DEFAULT NULL,
  `lead_custom_field_47` text DEFAULT NULL,
  `lead_custom_field_48` text DEFAULT NULL,
  `lead_custom_field_49` text DEFAULT NULL,
  `lead_custom_field_50` text DEFAULT NULL,
  `lead_custom_field_51` text DEFAULT NULL,
  `lead_custom_field_52` text DEFAULT NULL,
  `lead_custom_field_53` text DEFAULT NULL,
  `lead_custom_field_54` text DEFAULT NULL,
  `lead_custom_field_55` text DEFAULT NULL,
  `lead_custom_field_56` text DEFAULT NULL,
  `lead_custom_field_57` text DEFAULT NULL,
  `lead_custom_field_58` text DEFAULT NULL,
  `lead_custom_field_59` text DEFAULT NULL,
  `lead_custom_field_60` text DEFAULT NULL,
  `lead_custom_field_61` varchar(20) DEFAULT NULL,
  `lead_custom_field_62` varchar(20) DEFAULT NULL,
  `lead_custom_field_63` varchar(20) DEFAULT NULL,
  `lead_custom_field_64` varchar(20) DEFAULT NULL,
  `lead_custom_field_65` varchar(20) DEFAULT NULL,
  `lead_custom_field_66` varchar(20) DEFAULT NULL,
  `lead_custom_field_67` varchar(20) DEFAULT NULL,
  `lead_custom_field_68` varchar(20) DEFAULT NULL,
  `lead_custom_field_69` varchar(20) DEFAULT NULL,
  `lead_custom_field_70` varchar(20) DEFAULT NULL,
  `lead_custom_field_71` varchar(20) DEFAULT NULL,
  `lead_custom_field_72` varchar(20) DEFAULT NULL,
  `lead_custom_field_73` varchar(20) DEFAULT NULL,
  `lead_custom_field_74` varchar(20) DEFAULT NULL,
  `lead_custom_field_75` varchar(20) DEFAULT NULL,
  `lead_custom_field_76` varchar(20) DEFAULT NULL,
  `lead_custom_field_77` varchar(20) DEFAULT NULL,
  `lead_custom_field_78` varchar(20) DEFAULT NULL,
  `lead_custom_field_79` varchar(20) DEFAULT NULL,
  `lead_custom_field_80` varchar(20) DEFAULT NULL,
  `lead_custom_field_81` varchar(150) DEFAULT NULL,
  `lead_custom_field_82` varchar(150) DEFAULT NULL,
  `lead_custom_field_83` varchar(150) DEFAULT NULL,
  `lead_custom_field_84` varchar(150) DEFAULT NULL,
  `lead_custom_field_85` varchar(150) DEFAULT NULL,
  `lead_custom_field_86` varchar(150) DEFAULT NULL,
  `lead_custom_field_87` varchar(150) DEFAULT NULL,
  `lead_custom_field_88` varchar(150) DEFAULT NULL,
  `lead_custom_field_89` varchar(150) DEFAULT NULL,
  `lead_custom_field_90` varchar(150) DEFAULT NULL,
  `lead_custom_field_91` varchar(150) DEFAULT NULL,
  `lead_custom_field_92` varchar(150) DEFAULT NULL,
  `lead_custom_field_93` varchar(150) DEFAULT NULL,
  `lead_custom_field_94` varchar(150) DEFAULT NULL,
  `lead_custom_field_95` varchar(150) DEFAULT NULL,
  `lead_custom_field_96` varchar(150) DEFAULT NULL,
  `lead_custom_field_97` varchar(150) DEFAULT NULL,
  `lead_custom_field_98` varchar(150) DEFAULT NULL,
  `lead_custom_field_99` varchar(150) DEFAULT NULL,
  `lead_custom_field_100` varchar(150) DEFAULT NULL,
  `lead_custom_field_101` varchar(150) DEFAULT NULL,
  `lead_custom_field_102` varchar(150) DEFAULT NULL,
  `lead_custom_field_103` varchar(150) DEFAULT NULL,
  `lead_custom_field_104` varchar(150) DEFAULT NULL,
  `lead_custom_field_105` varchar(150) DEFAULT NULL,
  `lead_custom_field_106` varchar(150) DEFAULT NULL,
  `lead_custom_field_107` varchar(150) DEFAULT NULL,
  `lead_custom_field_108` varchar(150) DEFAULT NULL,
  `lead_custom_field_109` varchar(150) DEFAULT NULL,
  `lead_custom_field_110` varchar(150) DEFAULT NULL,
  `lead_custom_field_111` int(11) DEFAULT NULL,
  `lead_custom_field_112` int(11) DEFAULT NULL,
  `lead_custom_field_113` int(11) DEFAULT NULL,
  `lead_custom_field_114` int(11) DEFAULT NULL,
  `lead_custom_field_115` int(11) DEFAULT NULL,
  `lead_custom_field_116` int(11) DEFAULT NULL,
  `lead_custom_field_117` int(11) DEFAULT NULL,
  `lead_custom_field_118` int(11) DEFAULT NULL,
  `lead_custom_field_119` int(11) DEFAULT NULL,
  `lead_custom_field_120` int(11) DEFAULT NULL,
  `lead_custom_field_121` int(11) DEFAULT NULL,
  `lead_custom_field_122` int(11) DEFAULT NULL,
  `lead_custom_field_123` int(11) DEFAULT NULL,
  `lead_custom_field_124` int(11) DEFAULT NULL,
  `lead_custom_field_125` int(11) DEFAULT NULL,
  `lead_custom_field_126` int(11) DEFAULT NULL,
  `lead_custom_field_127` int(11) DEFAULT NULL,
  `lead_custom_field_128` int(11) DEFAULT NULL,
  `lead_custom_field_129` int(11) DEFAULT NULL,
  `lead_custom_field_130` int(11) DEFAULT NULL,
  `lead_custom_field_131` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_132` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_133` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_134` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_135` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_136` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_137` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_138` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_139` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_140` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_141` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_142` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_143` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_144` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_145` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_146` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_147` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_148` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_149` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_150` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `leads_assigned`
--

CREATE TABLE `leads_assigned` (
  `leadsassigned_id` int(11) NOT NULL,
  `leadsassigned_leadid` int(11) DEFAULT NULL,
  `leadsassigned_userid` int(11) DEFAULT NULL,
  `leadsassigned_created` datetime NOT NULL,
  `leadsassigned_updated` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `leads_sources`
--

CREATE TABLE `leads_sources` (
  `leadsources_id` int(11) NOT NULL,
  `leadsources_created` datetime NOT NULL,
  `leadsources_updated` datetime NOT NULL,
  `leadsources_creatorid` int(11) NOT NULL,
  `leadsources_title` varchar(200) NOT NULL COMMENT '[do not truncate] - good to have example sources like google'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `leads_status`
--

CREATE TABLE `leads_status` (
  `leadstatus_id` int(11) NOT NULL,
  `leadstatus_created` datetime DEFAULT NULL,
  `leadstatus_creatorid` int(11) DEFAULT NULL,
  `leadstatus_updated` datetime DEFAULT NULL,
  `leadstatus_title` varchar(200) NOT NULL,
  `leadstatus_position` int(11) NOT NULL,
  `leadstatus_color` varchar(100) NOT NULL DEFAULT 'default' COMMENT 'default|primary|success|info|warning|danger|lime|brown',
  `leadstatus_system_default` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[do not truncate]  expected to have 2 system default statuses (ID: 1 & 2) ''new'' & ''converted'' statuses ';

--
-- Dumping data for table `leads_status`
--

INSERT INTO `leads_status` (`leadstatus_id`, `leadstatus_created`, `leadstatus_creatorid`, `leadstatus_updated`, `leadstatus_title`, `leadstatus_position`, `leadstatus_color`, `leadstatus_system_default`) VALUES
(1, '2023-01-19 22:02:01', 0, '2023-01-19 22:02:01', 'New', 1, 'default', 'yes'),
(2, '2023-01-19 22:02:01', 0, '2023-01-19 22:02:01', 'Converted', 6, 'success', 'yes'),
(3, '2023-01-19 22:02:01', 0, '2023-01-19 22:02:01', 'Qualified', 3, 'info', 'no'),
(4, '2023-01-19 22:02:01', 0, '2023-01-19 22:02:01', 'Proposal Sent', 5, 'lime', 'no'),
(5, '2023-01-19 22:02:01', 0, '2023-01-19 22:02:01', 'Contacted', 2, 'warning', 'no'),
(7, '2023-01-19 22:02:01', 0, '2023-01-19 22:02:01', 'Disqualified', 4, 'danger', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `lineitems`
--

CREATE TABLE `lineitems` (
  `lineitem_id` int(11) NOT NULL,
  `lineitem_position` int(11) DEFAULT NULL,
  `lineitem_created` datetime DEFAULT NULL,
  `lineitem_updated` datetime DEFAULT NULL,
  `lineitem_description` text DEFAULT NULL,
  `lineitem_rate` varchar(250) DEFAULT NULL,
  `lineitem_unit` varchar(100) DEFAULT NULL,
  `lineitem_quantity` float DEFAULT NULL,
  `lineitem_total` decimal(10,2) DEFAULT NULL,
  `lineitemresource_linked_type` varchar(30) DEFAULT NULL COMMENT 'task | expense',
  `lineitemresource_linked_id` int(11) DEFAULT NULL COMMENT 'e.g. task id',
  `lineitemresource_type` varchar(50) DEFAULT NULL COMMENT '[polymorph] invoice | estimate',
  `lineitemresource_id` int(11) DEFAULT NULL COMMENT '[polymorph] e.g invoice_id',
  `lineitem_type` varchar(10) DEFAULT 'plain' COMMENT 'plain|time|dimensions',
  `lineitem_time_hours` int(11) DEFAULT NULL,
  `lineitem_time_minutes` int(11) DEFAULT NULL,
  `lineitem_time_timers_list` text DEFAULT NULL COMMENT 'comma separated list of timers',
  `lineitem_dimensions_length` float DEFAULT NULL,
  `lineitem_dimensions_width` float DEFAULT NULL,
  `lineitem_tax_status` varchar(100) DEFAULT 'taxable' COMMENT 'taxable|exempt  - this is inherited from the product/item setting',
  `lineitem_linked_product_id` int(11) DEFAULT NULL COMMENT 'the original product that created this line item'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `log_id` int(11) NOT NULL,
  `log_uniqueid` varchar(100) DEFAULT NULL COMMENT 'optional',
  `log_created` datetime NOT NULL,
  `log_updated` datetime NOT NULL,
  `log_creatorid` int(11) DEFAULT NULL,
  `log_text` text DEFAULT NULL COMMENT 'either free text or a (lang) string',
  `log_text_type` varchar(20) DEFAULT 'text' COMMENT 'text|lang',
  `log_data_1` varchar(250) DEFAULT NULL COMMENT 'optional data',
  `log_data_2` varchar(250) DEFAULT NULL COMMENT 'optional data',
  `log_data_3` varchar(250) DEFAULT NULL COMMENT 'optional data',
  `log_payload` text DEFAULT NULL COMMENT 'optional',
  `logresource_type` varchar(60) DEFAULT NULL COMMENT 'debug|subscription|invoice|etc',
  `logresource_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `message_unique_id` varchar(100) NOT NULL,
  `message_created` datetime NOT NULL,
  `message_updated` datetime NOT NULL,
  `message_timestamp` int(11) NOT NULL,
  `message_creatorid` int(11) NOT NULL,
  `message_source` varchar(150) NOT NULL COMMENT 'sender unique id',
  `message_target` varchar(150) NOT NULL COMMENT 'receivers unique id',
  `message_creator_uniqueid` varchar(150) DEFAULT NULL,
  `message_target_uniqueid` varchar(150) DEFAULT NULL,
  `message_text` text DEFAULT NULL,
  `message_file_name` varchar(250) DEFAULT NULL,
  `message_file_directory` varchar(150) DEFAULT NULL,
  `message_file_thumb_name` varchar(150) DEFAULT NULL,
  `message_file_type` varchar(50) DEFAULT NULL COMMENT 'file | image',
  `message_type` varchar(150) DEFAULT 'file' COMMENT 'text | file',
  `message_status` varchar(150) DEFAULT 'unread' COMMENT 'read | unread'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `message_unique_id`, `message_created`, `message_updated`, `message_timestamp`, `message_creatorid`, `message_source`, `message_target`, `message_creator_uniqueid`, `message_target_uniqueid`, `message_text`, `message_file_name`, `message_file_directory`, `message_file_thumb_name`, `message_file_type`, `message_type`, `message_status`) VALUES
(8, '63f68a754adb46.29017780', '2023-02-22 22:34:45', '2023-02-22 22:34:45', 1677101685, 1, '63f530a8217904.02016488', '63f68680df9651.05213537', '63f530a8217904.02016488', NULL, 'I\'m waiting for you in zoom meeting.&nbsp;<span class=\"cqiun4t2 khvhiq1o r5qsrrlp i5tg98hk iqx13udk przvwfww qiohso4h gfz4du6o r7fjleex nz2484kf svot0ezm dcnh1tix sxl192xd t3g6t33p\"><span class=\"\">?</span></span>', NULL, NULL, NULL, NULL, 'text', 'unread'),
(9, '63f68e0ae45ac7.30372195', '2023-02-22 22:50:02', '2023-02-22 22:50:02', 1677102602, 9, '63f68680df9651.05213537', '63f530a8217904.02016488', '63f68680df9651.05213537', NULL, 'ok i am in', NULL, NULL, NULL, NULL, 'text', 'unread'),
(10, '63f7755b2d7812.03366911', '2023-02-23 15:16:59', '2023-02-23 15:16:59', 1677161819, 9, '63f68680df9651.05213537', '63f687000a9e35.13906696', '63f68680df9651.05213537', NULL, 'Hello Sir Peter', NULL, NULL, NULL, NULL, 'text', 'unread'),
(11, '63f7757d3784f6.66836250', '2023-02-23 15:17:33', '2023-02-23 15:17:33', 1677161853, 11, '63f687000a9e35.13906696', '63f68680df9651.05213537', '63f687000a9e35.13906696', NULL, 'yes sir', NULL, NULL, NULL, NULL, 'text', 'unread'),
(12, '63fcd0cc46fc25.53699399', '2023-02-27 16:48:28', '2023-02-27 16:48:28', 1677512908, 9, '63f68680df9651.05213537', '63fcca400a3b52.21203204', '63f68680df9651.05213537', NULL, 'hi', NULL, NULL, NULL, NULL, 'text', 'unread'),
(13, '647f4d8839b112.68923255', '2023-06-06 17:15:20', '2023-06-06 17:15:20', 1686064520, 9, '63f68680df9651.05213537', '63f687000a9e35.13906696', '63f68680df9651.05213537', NULL, 'hello&nbsp;', NULL, NULL, NULL, NULL, 'text', 'unread');

-- --------------------------------------------------------

--
-- Table structure for table `messages_tracking`
--

CREATE TABLE `messages_tracking` (
  `messagestracking_id` int(11) NOT NULL,
  `messagestracking_created` datetime NOT NULL,
  `messagestracking_update` datetime NOT NULL,
  `messagestracking_massage_unique_id` varchar(120) NOT NULL,
  `messagestracking_target` varchar(120) DEFAULT NULL,
  `messagestracking_user_unique_id` varchar(120) DEFAULT NULL,
  `messagestracking_type` varchar(50) DEFAULT NULL COMMENT 'read|delete'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `messages_tracking`
--

INSERT INTO `messages_tracking` (`messagestracking_id`, `messagestracking_created`, `messagestracking_update`, `messagestracking_massage_unique_id`, `messagestracking_target`, `messagestracking_user_unique_id`, `messagestracking_type`) VALUES
(19, '2023-02-27 16:48:28', '2023-02-27 16:48:28', '63fcd0cc46fc25.53699399', '63f68680df9651.05213537', '63fcca400a3b52.21203204', 'read'),
(20, '2023-06-06 17:15:20', '2023-06-06 17:15:20', '647f4d8839b112.68923255', '63f68680df9651.05213537', '63f687000a9e35.13906696', 'read');

-- --------------------------------------------------------

--
-- Table structure for table `milestones`
--

CREATE TABLE `milestones` (
  `milestone_id` int(11) NOT NULL,
  `milestone_created` datetime NOT NULL,
  `milestone_updated` datetime NOT NULL,
  `milestone_creatorid` int(11) NOT NULL,
  `milestone_title` varchar(250) NOT NULL DEFAULT 'uncategorised',
  `milestone_projectid` int(11) DEFAULT NULL,
  `milestone_position` int(11) NOT NULL DEFAULT 1,
  `milestone_type` varchar(50) NOT NULL DEFAULT 'categorised' COMMENT 'categorised|uncategorised [1 uncategorised milestone if automatically created when a new project is created]'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `milestone_categories`
--

CREATE TABLE `milestone_categories` (
  `milestonecategory_id` int(11) NOT NULL,
  `milestonecategory_created` datetime NOT NULL,
  `milestonecategory_updated` datetime NOT NULL,
  `milestonecategory_creatorid` int(11) NOT NULL,
  `milestonecategory_title` varchar(250) NOT NULL,
  `milestonecategory_position` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `milestone_categories`
--

INSERT INTO `milestone_categories` (`milestonecategory_id`, `milestonecategory_created`, `milestonecategory_updated`, `milestonecategory_creatorid`, `milestonecategory_title`, `milestonecategory_position`) VALUES
(1, '2023-01-19 22:02:01', '2023-01-19 22:02:01', 0, 'Planning', 1),
(2, '2023-01-19 22:02:01', '2023-01-19 22:02:01', 0, 'Design', 2),
(3, '2023-01-19 22:02:01', '2023-01-19 22:02:01', 0, 'Development', 3),
(4, '2023-01-19 22:02:01', '2023-01-19 22:02:01', 0, 'Testing', 4);

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `note_id` int(11) NOT NULL,
  `note_created` datetime DEFAULT NULL COMMENT 'always now()',
  `note_updated` datetime DEFAULT NULL,
  `note_creatorid` int(11) DEFAULT NULL,
  `note_title` varchar(250) DEFAULT NULL,
  `note_description` text DEFAULT NULL,
  `note_visibility` varchar(30) DEFAULT 'public' COMMENT 'private|public',
  `noteresource_type` varchar(50) DEFAULT NULL COMMENT '[polymorph] client | project | user | lead',
  `noteresource_id` int(11) DEFAULT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]. Notes are always private to the user who created them. They are never visible to anyone else';

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL COMMENT '[truncate]',
  `payment_created` datetime DEFAULT NULL,
  `payment_updated` datetime DEFAULT NULL,
  `payment_creatorid` int(11) DEFAULT NULL COMMENT '''0'' for system',
  `payment_date` date DEFAULT NULL,
  `payment_invoiceid` int(11) DEFAULT NULL COMMENT 'invoice id',
  `payment_subscriptionid` int(11) DEFAULT NULL COMMENT 'subscription id',
  `payment_clientid` int(11) DEFAULT NULL,
  `payment_projectid` int(11) DEFAULT NULL,
  `payment_amount` decimal(10,2) NOT NULL,
  `payment_transaction_id` varchar(100) DEFAULT NULL,
  `payment_gateway` varchar(100) DEFAULT NULL COMMENT 'paypal | stripe | cash | bank',
  `payment_notes` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `payment_sessions`
--

CREATE TABLE `payment_sessions` (
  `session_id` int(11) NOT NULL,
  `session_created` datetime DEFAULT NULL,
  `session_updated` datetime DEFAULT NULL,
  `session_creatorid` int(11) DEFAULT NULL COMMENT 'user making the payment',
  `session_creator_fullname` varchar(150) DEFAULT NULL,
  `session_creator_email` varchar(150) DEFAULT NULL,
  `session_gateway_name` varchar(150) DEFAULT NULL COMMENT 'stripe | paypal | etc',
  `session_gateway_ref` varchar(150) DEFAULT NULL COMMENT 'Stripe - The checkout_session_id | Paypal -',
  `session_amount` decimal(10,2) DEFAULT NULL COMMENT 'amount of the payment',
  `session_invoices` varchar(250) DEFAULT NULL COMMENT '[currently] - single invoice id | [future] - comma seperated list of invoice id''s that are for this payment',
  `session_subscription` int(11) DEFAULT NULL COMMENT 'subscription id',
  `session_payload` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Track payment sessions so that IPN/Webhook calls can be linked to the correct invoice. Cronjob can be used to cleanup this table for any records older than 72hrs';

-- --------------------------------------------------------

--
-- Table structure for table `product_tasks`
--

CREATE TABLE `product_tasks` (
  `product_task_id` int(11) NOT NULL,
  `product_task_created` date NOT NULL,
  `product_task_updated` date NOT NULL,
  `product_task_creatorid` int(11) DEFAULT NULL,
  `product_task_itemid` int(11) DEFAULT NULL,
  `product_task_title` varchar(250) DEFAULT NULL,
  `product_task_description` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_tasks_dependencies`
--

CREATE TABLE `product_tasks_dependencies` (
  `product_task_dependency_id` int(11) NOT NULL,
  `product_task_dependency_created` date NOT NULL,
  `product_task_dependency_updated` date NOT NULL,
  `product_task_dependency_taskid` int(11) DEFAULT NULL,
  `product_task_dependency_blockerid` int(11) DEFAULT NULL,
  `product_task_dependency_type` varchar(100) DEFAULT NULL COMMENT 'cannot_complete|cannot_start'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `project_id` int(11) NOT NULL,
  `project_uniqueid` varchar(100) DEFAULT NULL COMMENT 'optional',
  `project_type` varchar(30) NOT NULL DEFAULT 'project' COMMENT 'project|template|space',
  `project_reference` varchar(250) DEFAULT NULL COMMENT '[optiona] additional data for identifying a project',
  `project_importid` varchar(100) DEFAULT NULL,
  `project_created` datetime DEFAULT NULL,
  `project_updated` datetime DEFAULT NULL,
  `project_timestamp_created` int(11) DEFAULT NULL,
  `project_timestamp_updated` int(11) DEFAULT NULL,
  `project_clientid` int(11) DEFAULT NULL,
  `project_creatorid` int(11) NOT NULL COMMENT 'creator of the project',
  `project_categoryid` int(11) DEFAULT 1 COMMENT 'default category',
  `project_cover_directory` varchar(100) DEFAULT NULL,
  `project_cover_filename` varchar(100) DEFAULT NULL,
  `project_cover_file_id` int(11) DEFAULT NULL COMMENT 'if this cover was made from an existing file',
  `project_title` varchar(250) NOT NULL,
  `project_date_start` date DEFAULT NULL,
  `project_date_due` date DEFAULT NULL,
  `project_description` text DEFAULT NULL,
  `project_status` varchar(50) DEFAULT 'not_started' COMMENT 'not_started | in_progress | on_hold | cancelled | completed',
  `project_active_state` varchar(10) DEFAULT 'active' COMMENT 'active|archive',
  `project_progress` tinyint(3) DEFAULT 0,
  `project_billing_rate` decimal(10,2) DEFAULT 0.00,
  `project_billing_type` varchar(40) DEFAULT 'hourly' COMMENT 'hourly | fixed',
  `project_billing_estimated_hours` int(11) DEFAULT 0 COMMENT 'estimated hours',
  `project_billing_costs_estimate` decimal(10,2) DEFAULT 0.00,
  `project_progress_manually` varchar(10) DEFAULT 'no' COMMENT 'yes | no',
  `clientperm_tasks_view` varchar(10) DEFAULT 'yes' COMMENT 'yes | no',
  `clientperm_tasks_collaborate` varchar(40) DEFAULT 'yes' COMMENT 'yes | no',
  `clientperm_tasks_create` varchar(40) DEFAULT 'yes' COMMENT 'yes | no',
  `clientperm_timesheets_view` varchar(40) DEFAULT 'yes' COMMENT 'yes | no',
  `clientperm_expenses_view` varchar(40) DEFAULT 'no' COMMENT 'yes | no',
  `assignedperm_milestone_manage` varchar(40) DEFAULT 'yes' COMMENT 'yes | no',
  `assignedperm_tasks_collaborate` varchar(40) DEFAULT NULL COMMENT 'yes | no',
  `project_visibility` varchar(40) DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent projects that are still being cloned from showing in projects list)',
  `project_custom_field_1` tinytext DEFAULT NULL,
  `project_custom_field_2` tinytext DEFAULT NULL,
  `project_custom_field_3` tinytext DEFAULT NULL,
  `project_custom_field_4` tinytext DEFAULT NULL,
  `project_custom_field_5` tinytext DEFAULT NULL,
  `project_custom_field_6` tinytext DEFAULT NULL,
  `project_custom_field_7` tinytext DEFAULT NULL,
  `project_custom_field_8` tinytext DEFAULT NULL,
  `project_custom_field_9` tinytext DEFAULT NULL,
  `project_custom_field_10` tinytext DEFAULT NULL,
  `project_custom_field_11` datetime DEFAULT NULL,
  `project_custom_field_12` datetime DEFAULT NULL,
  `project_custom_field_13` datetime DEFAULT NULL,
  `project_custom_field_14` datetime DEFAULT NULL,
  `project_custom_field_15` datetime DEFAULT NULL,
  `project_custom_field_16` datetime DEFAULT NULL,
  `project_custom_field_17` datetime DEFAULT NULL,
  `project_custom_field_18` datetime DEFAULT NULL,
  `project_custom_field_19` datetime DEFAULT NULL,
  `project_custom_field_20` datetime DEFAULT NULL,
  `project_custom_field_21` text DEFAULT NULL,
  `project_custom_field_22` text DEFAULT NULL,
  `project_custom_field_23` text DEFAULT NULL,
  `project_custom_field_24` text DEFAULT NULL,
  `project_custom_field_25` text DEFAULT NULL,
  `project_custom_field_26` text DEFAULT NULL,
  `project_custom_field_27` text DEFAULT NULL,
  `project_custom_field_28` text DEFAULT NULL,
  `project_custom_field_29` text DEFAULT NULL,
  `project_custom_field_30` text DEFAULT NULL,
  `project_custom_field_31` varchar(20) DEFAULT NULL,
  `project_custom_field_32` varchar(20) DEFAULT NULL,
  `project_custom_field_33` varchar(20) DEFAULT NULL,
  `project_custom_field_34` varchar(20) DEFAULT NULL,
  `project_custom_field_35` varchar(20) DEFAULT NULL,
  `project_custom_field_36` varchar(20) DEFAULT NULL,
  `project_custom_field_37` varchar(20) DEFAULT NULL,
  `project_custom_field_38` varchar(20) DEFAULT NULL,
  `project_custom_field_39` varchar(20) DEFAULT NULL,
  `project_custom_field_40` varchar(20) DEFAULT NULL,
  `project_custom_field_41` varchar(150) DEFAULT NULL,
  `project_custom_field_42` varchar(150) DEFAULT NULL,
  `project_custom_field_43` varchar(150) DEFAULT NULL,
  `project_custom_field_44` varchar(150) DEFAULT NULL,
  `project_custom_field_45` varchar(150) DEFAULT NULL,
  `project_custom_field_46` varchar(150) DEFAULT NULL,
  `project_custom_field_47` varchar(150) DEFAULT NULL,
  `project_custom_field_48` varchar(150) DEFAULT NULL,
  `project_custom_field_49` varchar(150) DEFAULT NULL,
  `project_custom_field_50` varchar(150) DEFAULT NULL,
  `project_custom_field_51` int(11) DEFAULT NULL,
  `project_custom_field_52` int(11) DEFAULT NULL,
  `project_custom_field_53` int(11) DEFAULT NULL,
  `project_custom_field_54` int(11) DEFAULT NULL,
  `project_custom_field_55` int(11) DEFAULT NULL,
  `project_custom_field_56` int(11) DEFAULT NULL,
  `project_custom_field_57` int(11) DEFAULT NULL,
  `project_custom_field_58` int(11) DEFAULT NULL,
  `project_custom_field_59` int(11) DEFAULT NULL,
  `project_custom_field_60` int(11) DEFAULT NULL,
  `project_custom_field_61` decimal(10,2) DEFAULT NULL,
  `project_custom_field_62` decimal(10,2) DEFAULT NULL,
  `project_custom_field_63` decimal(10,2) DEFAULT NULL,
  `project_custom_field_64` decimal(10,2) DEFAULT NULL,
  `project_custom_field_65` decimal(10,2) DEFAULT NULL,
  `project_custom_field_66` decimal(10,2) DEFAULT NULL,
  `project_custom_field_67` decimal(10,2) DEFAULT NULL,
  `project_custom_field_68` decimal(10,2) DEFAULT NULL,
  `project_custom_field_69` decimal(10,2) DEFAULT NULL,
  `project_custom_field_70` decimal(10,2) DEFAULT NULL,
  `project_automation_status` varchar(30) DEFAULT 'disabled' COMMENT 'disabled|enabled',
  `project_automation_create_invoices` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `project_automation_convert_estimates_to_invoices` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `project_automation_invoice_unbilled_hours` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `project_automation_invoice_hourly_rate` decimal(10,2) DEFAULT NULL,
  `project_automation_invoice_hourly_tax_1` int(11) DEFAULT NULL,
  `project_automation_invoice_email_client` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `project_automation_invoice_due_date` int(11) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `project_uniqueid`, `project_type`, `project_reference`, `project_importid`, `project_created`, `project_updated`, `project_timestamp_created`, `project_timestamp_updated`, `project_clientid`, `project_creatorid`, `project_categoryid`, `project_cover_directory`, `project_cover_filename`, `project_cover_file_id`, `project_title`, `project_date_start`, `project_date_due`, `project_description`, `project_status`, `project_active_state`, `project_progress`, `project_billing_rate`, `project_billing_type`, `project_billing_estimated_hours`, `project_billing_costs_estimate`, `project_progress_manually`, `clientperm_tasks_view`, `clientperm_tasks_collaborate`, `clientperm_tasks_create`, `clientperm_timesheets_view`, `clientperm_expenses_view`, `assignedperm_milestone_manage`, `assignedperm_tasks_collaborate`, `project_visibility`, `project_custom_field_1`, `project_custom_field_2`, `project_custom_field_3`, `project_custom_field_4`, `project_custom_field_5`, `project_custom_field_6`, `project_custom_field_7`, `project_custom_field_8`, `project_custom_field_9`, `project_custom_field_10`, `project_custom_field_11`, `project_custom_field_12`, `project_custom_field_13`, `project_custom_field_14`, `project_custom_field_15`, `project_custom_field_16`, `project_custom_field_17`, `project_custom_field_18`, `project_custom_field_19`, `project_custom_field_20`, `project_custom_field_21`, `project_custom_field_22`, `project_custom_field_23`, `project_custom_field_24`, `project_custom_field_25`, `project_custom_field_26`, `project_custom_field_27`, `project_custom_field_28`, `project_custom_field_29`, `project_custom_field_30`, `project_custom_field_31`, `project_custom_field_32`, `project_custom_field_33`, `project_custom_field_34`, `project_custom_field_35`, `project_custom_field_36`, `project_custom_field_37`, `project_custom_field_38`, `project_custom_field_39`, `project_custom_field_40`, `project_custom_field_41`, `project_custom_field_42`, `project_custom_field_43`, `project_custom_field_44`, `project_custom_field_45`, `project_custom_field_46`, `project_custom_field_47`, `project_custom_field_48`, `project_custom_field_49`, `project_custom_field_50`, `project_custom_field_51`, `project_custom_field_52`, `project_custom_field_53`, `project_custom_field_54`, `project_custom_field_55`, `project_custom_field_56`, `project_custom_field_57`, `project_custom_field_58`, `project_custom_field_59`, `project_custom_field_60`, `project_custom_field_61`, `project_custom_field_62`, `project_custom_field_63`, `project_custom_field_64`, `project_custom_field_65`, `project_custom_field_66`, `project_custom_field_67`, `project_custom_field_68`, `project_custom_field_69`, `project_custom_field_70`, `project_automation_status`, `project_automation_create_invoices`, `project_automation_convert_estimates_to_invoices`, `project_automation_invoice_unbilled_hours`, `project_automation_invoice_hourly_rate`, `project_automation_invoice_hourly_tax_1`, `project_automation_invoice_email_client`, `project_automation_invoice_due_date`) VALUES
(-1677013160, '63f530a8231364.66357204', 'space', 'default-team-space', NULL, '2023-02-21 21:59:20', '2023-02-21 21:59:20', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677013529, '63f53219158b19.52356059', 'space', 'default-team-space', NULL, '2023-02-21 22:05:29', '2023-02-21 22:05:29', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677088405, '63f65695674b78.36819161', 'space', 'default-team-space', NULL, '2023-02-22 18:53:25', '2023-02-22 18:53:25', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677093255, '63f66987ee0fd9.65354187', 'space', 'default-team-space', NULL, '2023-02-22 20:14:15', '2023-02-22 20:14:15', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677093891, '63f66c03453ff0.38874295', 'space', 'default-team-space', NULL, '2023-02-22 20:24:51', '2023-02-22 20:24:51', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677100424, '63f6858884e0b1.71664430', 'space', 'default-team-space', NULL, '2023-02-22 22:13:44', '2023-02-22 22:13:44', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677100615, '63f686476d6908.52433543', 'space', 'default-team-space', NULL, '2023-02-22 22:16:55', '2023-02-22 22:16:55', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677100672, '63f68680e13ed8.37002034', 'space', 'default-team-space', NULL, '2023-02-22 22:17:52', '2023-02-22 22:17:52', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677100721, '63f686b1c3a502.52781074', 'space', 'default-team-space', NULL, '2023-02-22 22:18:41', '2023-02-22 22:18:41', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677100800, '63f687000c5cc0.00098754', 'space', 'default-team-space', NULL, '2023-02-22 22:20:00', '2023-02-22 22:20:00', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677101073, '63f68811794b19.37119624', 'space', 'default-team-space', NULL, '2023-02-22 22:24:33', '2023-02-22 22:24:33', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677247893, '63f8c5950bc546.10901023', 'space', 'default-team-space', NULL, '2023-02-24 15:11:33', '2023-02-24 15:11:33', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0),
(-1677511232, '63fcca400cbe10.70721553', 'space', 'default-team-space', NULL, '2023-02-27 16:20:32', '2023-02-27 16:20:32', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, '0.00', 'hourly', 0, '0.00', 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0);

-- --------------------------------------------------------

--
-- Table structure for table `projects_assigned`
--

CREATE TABLE `projects_assigned` (
  `projectsassigned_id` int(11) NOT NULL COMMENT '[truncate]',
  `projectsassigned_projectid` int(11) DEFAULT NULL,
  `projectsassigned_userid` int(11) DEFAULT NULL,
  `projectsassigned_created` datetime DEFAULT NULL,
  `projectsassigned_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `projects_manager`
--

CREATE TABLE `projects_manager` (
  `projectsmanager_id` int(11) NOT NULL,
  `projectsmanager_created` datetime NOT NULL,
  `projectsmanager_updated` datetime NOT NULL,
  `projectsmanager_projectid` int(11) DEFAULT NULL,
  `projectsmanager_userid` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `proposals`
--

CREATE TABLE `proposals` (
  `doc_id` int(11) NOT NULL,
  `doc_unique_id` varchar(150) DEFAULT NULL,
  `doc_template` varchar(150) DEFAULT NULL COMMENT 'default',
  `doc_created` datetime NOT NULL,
  `doc_updated` int(11) NOT NULL,
  `doc_creatorid` int(11) NOT NULL COMMENT 'use ( -1 ) for logged out user.',
  `doc_categoryid` int(11) DEFAULT 11 COMMENT '11 is the default category',
  `doc_heading` varchar(250) DEFAULT NULL COMMENT 'e.g. proposal',
  `doc_heading_color` varchar(30) DEFAULT NULL,
  `doc_title` varchar(250) DEFAULT NULL,
  `doc_title_color` varchar(30) DEFAULT NULL,
  `doc_hero_direcory` varchar(250) DEFAULT NULL,
  `doc_hero_filename` varchar(250) DEFAULT NULL,
  `doc_hero_updated` varchar(250) DEFAULT 'no' COMMENT 'ys|no (when no, we use default image path)',
  `doc_body` text DEFAULT '',
  `doc_date_start` date DEFAULT NULL COMMENT 'Proposal Issue Date | Contract Start Date',
  `doc_date_end` date DEFAULT NULL COMMENT 'Proposal Expiry Date | Contract End Date',
  `doc_date_published` date DEFAULT NULL,
  `doc_date_last_emailed` datetime DEFAULT NULL,
  `doc_client_id` int(11) DEFAULT NULL,
  `doc_project_id` int(11) DEFAULT NULL,
  `doc_lead_id` int(11) DEFAULT NULL,
  `doc_notes` text DEFAULT NULL,
  `doc_viewed` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `doc_type` varchar(150) DEFAULT NULL COMMENT 'proposal|contract',
  `doc_system_type` varchar(150) DEFAULT 'document' COMMENT 'document|template',
  `doc_signed_date` datetime DEFAULT NULL,
  `doc_signed_first_name` varchar(150) DEFAULT '',
  `doc_signed_last_name` varchar(150) DEFAULT '',
  `doc_signed_signature_directory` varchar(150) DEFAULT '',
  `doc_signed_signature_filename` varchar(150) DEFAULT '',
  `doc_signed_ip_address` varchar(150) DEFAULT NULL,
  `doc_fallback_client_first_name` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_fallback_client_last_name` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_fallback_client_email` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_status` varchar(100) DEFAULT 'draft' COMMENT 'draft|new|accepted|declined|revised|expired',
  `docresource_type` varchar(100) DEFAULT NULL COMMENT 'client|lead',
  `docresource_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proposal_templates`
--

CREATE TABLE `proposal_templates` (
  `proposal_template_id` int(11) NOT NULL,
  `proposal_template_created` datetime NOT NULL,
  `proposal_template_updated` datetime NOT NULL,
  `proposal_template_creatorid` int(11) DEFAULT NULL,
  `proposal_template_title` varchar(250) DEFAULT NULL,
  `proposal_template_heading_color` varchar(30) DEFAULT '#FFFFFF',
  `proposal_template_title_color` varchar(30) DEFAULT '#FFFFFF',
  `proposal_template_body` text DEFAULT NULL,
  `proposal_template_estimate_id` int(11) DEFAULT NULL,
  `proposal_template_system` varchar(20) DEFAULT 'no' COMMENT 'yes|no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `proposal_templates`
--

INSERT INTO `proposal_templates` (`proposal_template_id`, `proposal_template_created`, `proposal_template_updated`, `proposal_template_creatorid`, `proposal_template_title`, `proposal_template_heading_color`, `proposal_template_title_color`, `proposal_template_body`, `proposal_template_estimate_id`, `proposal_template_system`) VALUES
(1, '2023-01-07 17:07:29', '2022-05-22 09:15:49', 1, 'Default Template', '#FFFFFF', '#FFFFFF', '<h2 style=\"font-family: Montserrat;\"><span style=\"color: #67757c; font-size: 14px;\">Thank you, on behalf of the entire </span><strong style=\"color: #67757c; font-size: 14px;\">{company_name}</strong><span style=\"color: #67757c; font-size: 14px;\"> team, for reaching out to us and giving us the opportunity to collaborate with you on your project. We are ready to provide you with the experience and expertise needed to complete your project on time and on budget.</span></h2>\r\n<br /><strong>Once again, thank you for the opportunity to earn your business.<br /></strong><br /><br /><br />\r\n<table style=\"border-collapse: collapse; width: 100%;\" border=\"1\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 50%; border-color: #ffffff; text-align: left; vertical-align: top;\"><img src=\"public/documents/images/sample-1.jpg\" alt=\"\" width=\"389\" height=\"466\" /></td>\r\n<td style=\"width: 50%; border-color: #ffffff; vertical-align: top;\">\r\n<h3 style=\"font-family: Montserrat;\"><span style=\"text-decoration: underline;\">About Us</span></h3>\r\n<span style=\"font-family: Montserrat;\">We believe in creating websites that not only&nbsp;</span><span style=\"font-family: Montserrat;\">look amazing</span><span style=\"font-family: Montserrat;\">&nbsp;but also provide a fantastic user experience and are&nbsp;</span><span style=\"font-family: Montserrat;\">highly optimized</span><span style=\"font-family: Montserrat;\">&nbsp;to provide you with the best</span><span style=\"font-family: Montserrat;\">&nbsp;search ranking</span><span style=\"font-family: Montserrat;\">&nbsp;benefits possible. <br /><br /><strong>We are a full-stack development firm with experience in the following areas:</strong></span><br style=\"font-family: Montserrat;\" /><br style=\"font-family: Montserrat;\" />\r\n<ul>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n</ul>\r\n<br /><span style=\"font-family: Montserrat;\">We have over&nbsp;</span><span style=\"font-weight: 600; font-family: Montserrat;\">10 years</span><span style=\"font-family: Montserrat;\">&nbsp;of experience working with outstanding brands like yours. <br /><br />We are happy to provide you with references upon request.</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3><span style=\"text-decoration: underline;\"><br /><br />Your Needs</span></h3>\r\nAfter reviewing your requirements and discussing with you at length about them, we\'ve created a vision for your website that we believe will improve your overall brand presence, resulting in more leads and conversions for your business.<br /><br />\r\n<ul>\r\n<li>\r\n<h5>Example Item</h5>\r\n</li>\r\n<li>\r\n<h5>Example Item</h5>\r\n</li>\r\n<li>\r\n<h5>Example Item</h5>\r\n</li>\r\n<li>\r\n<h5>Example Item</h5>\r\n</li>\r\n</ul>\r\n<br />\r\n<table style=\"border-collapse: collapse; width: 100%; height: 337px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height: 337px;\">\r\n<td style=\"width: 50%; border-color: #ffffff; vertical-align: top; height: 337px;\">\r\n<h3><span style=\"text-decoration: underline;\"><br />Our Process</span></h3>\r\n<span style=\"font-family: Montserrat;\">We have devised a process that ensures a robust, yet fluid approach to completing your project on time, on budget, and beyond your expectation.</span><br style=\"font-family: Montserrat;\" /><br style=\"font-family: Montserrat;\" /><span style=\"text-decoration: underline;\"><span style=\"font-weight: 600;\">Here\'s what you can expect once your project begins.</span></span><br style=\"font-family: Montserrat;\" /><br style=\"font-family: Montserrat;\" />\r\n<ul style=\"font-family: Montserrat;\">\r\n<li>\r\n<h5>Example Process Step</h5>\r\n</li>\r\n<li>\r\n<h5>Example Process Step</h5>\r\n</li>\r\n<li>\r\n<h5>Example Process Step</h5>\r\n</li>\r\n<li>\r\n<h5>Example Process Step</h5>\r\n</li>\r\n</ul>\r\n</td>\r\n<td style=\"width: 50%; border-color: #ffffff; height: 337px; text-align: right;\"><img src=\"public/documents/images/sample-2.png\" alt=\"\" width=\"401\" height=\"266\" /></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3><span style=\"text-decoration: underline;\"><br /><br />Project Milestones</span></h3>\r\nOur estimated timeline for your project is shown in the table below.<br /><br />\r\n<table style=\"border-collapse: collapse; width: 100%; height: 240px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height: 48px;\">\r\n<th style=\"width: 50%; background-color: #efeeee; height: 48px;\"><strong>Milestone</strong></th>\r\n<th style=\"width: 50%; background-color: #efeeee; height: 48px;\"><strong>Target Date</strong></th>\r\n</tr>\r\n<tr style=\"height: 48px;\">\r\n<td style=\"width: 50%; height: 48px;\">Example milestone 1</td>\r\n<td style=\"width: 50%; height: 48px;\">01-10-2022</td>\r\n</tr>\r\n<tr style=\"height: 48px;\">\r\n<td style=\"width: 50%; height: 48px;\">Example milestone 2</td>\r\n<td style=\"width: 50%; height: 48px;\">01-23-2022</td>\r\n</tr>\r\n<tr style=\"height: 48px;\">\r\n<td style=\"width: 50%; height: 48px;\">Example milestone 3</td>\r\n<td style=\"width: 50%; height: 48px;\">02-15-2022</td>\r\n</tr>\r\n<tr style=\"height: 48px;\">\r\n<td style=\"width: 50%; height: 48px;\">Example milestone 4</td>\r\n<td style=\"width: 50%; height: 48px;\">03-12-2022</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3><span style=\"text-decoration: underline;\"><br /><br />Project Pricing</span></h3>\r\nThe costs for your design project are listed in the table below.<br /><br />{pricing_table}<br />\r\n<h3><span style=\"text-decoration: underline;\"><br /><br />Meet The Team</span></h3>\r\n<p>We are a team of 8 and below are the people that will be working directly on your project.<br /><!--MEET THE TEACM [START]--></p>\r\n<table class=\"doc-meet-the-team\" style=\"height: autho;\" width=\"100%\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 50%; background-color: #fbfcfd;\">\r\n<div class=\"row\">\r\n<div class=\"col-sm-12 col-md-4\"><img src=\"public/documents/images/sample-3.jpg\" alt=\"\" width=\"600\" height=\"600\" /></div>\r\n<div class=\"col-sm-6 col-md-8\">\r\n<h4>Jonathan Reed</h4>\r\n<strong>Project Lead</strong><br />75 Reed Street, London, U.K.<br /><strong>Tel:</strong> +44 123 456 7890<br /><strong>Email:</strong> john@example.com</div>\r\n</div>\r\n</td>\r\n<td class=\"spacer\">&nbsp;</td>\r\n<td style=\"width: 50%; background-color: #fbfcfd;\">\r\n<div class=\"row\">\r\n<div class=\"col-sm-12 col-md-4\"><img src=\"public/documents/images/sample-4.jpg\" alt=\"\" width=\"600\" height=\"600\" /></div>\r\n<div class=\"col-sm-6 col-md-8\">\r\n<h4>Jane Doney</h4>\r\n<strong>Web Designer</strong><br />75 Reed Street, London, U.K.<br /><strong>Tel:</strong> +44 123 456 7890<br /><strong>Email:</strong> jane@example.com</div>\r\n</div>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<br /><!--MEET THE TEACM [END]--> <!--MEET THE TEACM [START]-->\r\n<table class=\"doc-meet-the-team\" style=\"height: autho;\" width=\"100%\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 50%; background-color: #fbfcfd;\">\r\n<div class=\"row\">\r\n<div class=\"col-sm-12 col-md-4\"><img src=\"public/documents/images/sample-5.jpg\" alt=\"\" width=\"600\" height=\"600\" /></div>\r\n<div class=\"col-sm-6 col-md-8\">\r\n<h4>David Patterson</h4>\r\n<strong>UX &amp; UI Designer</strong><br />75 Reed Street, London, U.K.<br /><strong>Tel:</strong> +44 123 456 7890<br /><strong>Email:</strong> david@example.com</div>\r\n</div>\r\n</td>\r\n<td class=\"spacer\">&nbsp;</td>\r\n<td style=\"width: 50%; background-color: #fbfcfd;\">\r\n<div class=\"row\">\r\n<div class=\"col-sm-12 col-md-4\"><img src=\"public/documents/images/sample-6.jpg\" alt=\"\" width=\"150\" height=\"150\" /></div>\r\n<div class=\"col-sm-6 col-md-8\">\r\n<h4>Amanda Lewis</h4>\r\n<strong>Full-Stack Developer</strong><br />75 Reed Street, London, U.K.<br /><strong>Tel:</strong> +44 123 456 7890<br /><strong>Email:</strong>&nbsp;amanda@example.com</div>\r\n</div>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>', NULL, 'no');

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

CREATE TABLE `reminders` (
  `reminder_id` int(11) NOT NULL,
  `reminder_created` datetime NOT NULL,
  `reminder_updated` datetime NOT NULL,
  `reminder_userid` int(11) DEFAULT NULL,
  `reminder_datetime` datetime DEFAULT NULL,
  `reminder_timestamp` timestamp NULL DEFAULT NULL,
  `reminder_title` varchar(250) DEFAULT NULL,
  `reminder_meta` varchar(250) DEFAULT NULL,
  `reminder_notes` text DEFAULT NULL,
  `reminder_status` varchar(10) DEFAULT 'new' COMMENT 'active|due',
  `reminder_sent` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `reminderresource_type` varchar(50) DEFAULT NULL COMMENT 'project|client|estimate|lead|task|invoice|ticket',
  `reminderresource_id` int(11) DEFAULT NULL COMMENT 'linked resoucre id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_created` datetime DEFAULT NULL,
  `role_updated` datetime DEFAULT NULL,
  `role_system` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no (system roles cannot be deleted)',
  `role_type` varchar(10) NOT NULL COMMENT 'client|team',
  `role_name` varchar(100) NOT NULL,
  `role_clients` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_contacts` tinyint(4) NOT NULL COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_contracts` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_invoices` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_estimates` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_proposals` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_payments` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_items` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_tasks` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_tasks_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_projects` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_projects_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_projects_billing` varchar(20) NOT NULL DEFAULT '0' COMMENT 'none (0) | view (1) | view-add-edit (2)',
  `role_leads` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_leads_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_expenses` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_expenses_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_timesheets` int(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-delete (2)',
  `role_timesheets_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_team` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_team_scope` varchar(20) NOT NULL DEFAULT 'global' COMMENT 'own | global',
  `role_tickets` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_knowledgebase` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_manage_knowledgebase_categories` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_reports` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_assign_projects` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_assign_leads` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_assign_tasks` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_set_project_permissions` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_subscriptions` varchar(20) NOT NULL DEFAULT '0' COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_templates_projects` varchar(20) NOT NULL DEFAULT '1' COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_templates_contracts` varchar(20) NOT NULL DEFAULT '1' COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_templates_proposals` varchar(20) NOT NULL DEFAULT '1' COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_content_import` varchar(20) NOT NULL DEFAULT 'yes' COMMENT 'yes|no',
  `role_content_export` varchar(20) NOT NULL DEFAULT 'yes' COMMENT 'yes|no',
  `role_module_cs_affiliate` varchar(20) NOT NULL DEFAULT '3' COMMENT 'global',
  `role_homepage` varchar(100) NOT NULL DEFAULT 'dashboard',
  `role_messages` varchar(20) NOT NULL DEFAULT 'yes' COMMENT 'yes|no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[do not truncate] [roles 1,2,3 required] [role 1 = admin] [role 2 = client] [role 3 = staff]';

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_created`, `role_updated`, `role_system`, `role_type`, `role_name`, `role_clients`, `role_contacts`, `role_contracts`, `role_invoices`, `role_estimates`, `role_proposals`, `role_payments`, `role_items`, `role_tasks`, `role_tasks_scope`, `role_projects`, `role_projects_scope`, `role_projects_billing`, `role_leads`, `role_leads_scope`, `role_expenses`, `role_expenses_scope`, `role_timesheets`, `role_timesheets_scope`, `role_team`, `role_team_scope`, `role_tickets`, `role_knowledgebase`, `role_manage_knowledgebase_categories`, `role_reports`, `role_assign_projects`, `role_assign_leads`, `role_assign_tasks`, `role_set_project_permissions`, `role_subscriptions`, `role_templates_projects`, `role_templates_contracts`, `role_templates_proposals`, `role_content_import`, `role_content_export`, `role_module_cs_affiliate`, `role_homepage`, `role_messages`) VALUES
(1, '2018-09-07 14:49:41', '2018-09-07 14:49:41', 'yes', 'team', 'Administrator', 3, 4, 3, 3, 3, 4, 3, 3, 3, 'global', 3, 'global', '2', 3, 'global', 3, 'global', 3, 'global', 3, 'global', 3, 3, 'yes', 3, 'yes', 'yes', 'yes', 'yes', '3', '3', '3', '3', 'yes', 'yes', '3', 'dashboard', 'yes'),
(3, '2018-09-07 14:49:41', '2023-02-21 22:21:12', 'no', 'team', 'Staff', 0, 0, 0, 0, 0, 0, 0, 0, 2, 'own', 1, 'own', '0', 0, 'own', 0, 'own', 1, 'own', 1, 'global', 3, 1, 'no', 0, 'no', 'no', 'no', 'no', '0', '1', '0', '1', 'yes', 'yes', '3', 'dashboard', 'yes'),
(2, '2018-09-07 14:49:41', '2018-09-07 14:49:41', 'yes', 'client', 'Client', 0, 3, 1, 1, 1, 0, 1, 0, 1, 'own', 1, 'own', '0', 0, 'own', 0, 'own', 1, 'own', 1, 'global', 2, 1, 'no', 0, 'no', 'no', 'no', 'no', '1', '0', '0', '0', 'no', 'no', '3', 'dashboard', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(250) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `created_at`, `updated_at`, `last_activity`) VALUES
('ZbB6t8huWERKjYc0agxocKaV6EGcFidjc7uqxQhL', NULL, '174.228.231.24', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidkFXblRrMlpPc0l0RGJ6eTN1QTJRdWRqaHF1WG1aVDJJdk9maThFZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNDoiaHR0cHM6Ly9tYW5hZ2UudXBza3lncm91cC5jb20vaG9tZSI7fX0=', NULL, NULL, 1686331688),
('HrUIv0kFuqcZE7i305r5LzosXBGPK4eORr3hDDwO', 17, '49.207.220.93', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36 Edg/113.0.1774.50', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiRlpZcEdqY3lhVHZpaU1Nd2RFeDBQYUx5dnF1c2E0amJEWnpTQ0VTZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjM0OiJodHRwczovL21hbmFnZS51cHNreWdyb3VwLmNvbS9ob21lIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTc7fQ==', NULL, NULL, 1686147659),
('8wFjuPw5niM9hi8sf0ENyrUlwKtf3cYa5xLEt9jb', NULL, '174.199.45.176', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQjFxR2U3bkFnTzFlaU0xa2hzbEN5YnRDaGNBM0RXWjlpWXlyS1RYayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNDoiaHR0cHM6Ly9tYW5hZ2UudXBza3lncm91cC5jb20vaG9tZSI7fX0=', NULL, NULL, 1686146730),
('ldOWkbL7wc8greSR8agmYdM4B6f16tislr1jxISf', NULL, '24.220.112.133', 'Mozilla/5.0 (Linux; Android 13; SAMSUNG SM-S908U) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/21.0 Chrome/110.0.5481.154 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSkhoSHYwSDdNTExaYmdYejZBcXRRU2llclN1d3E4bWZ4a1NlOWRWUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1686146625),
('o1VCMl9lTcvAStyYq27CUDEIWF9RUpeQhC63efgV', NULL, '49.44.83.103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoia2NBTHlQc2xZeFFNcnpYRGVXWXB4YlM1ODY0ZlJPanprUFI1ZUREYyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MDoiaHR0cHM6Ly9tYW5hZ2UudXBza3lncm91cC5jb20vdGltZXNoZWV0cyI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM1OiJodHRwczovL21hbmFnZS51cHNreWdyb3VwLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1686148134),
('HavHIKy7xxdq0XOC7D5izVOo2qDtWpCv325Y1OrZ', NULL, '182.79.221.206', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiV0h4R2pBRUZTS3lTYXFnNGZMTFZzZUNadXJ3MU9tRHQ1TURRMmZVeCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozODoiaHR0cHM6Ly9tYW5hZ2UudXBza3lncm91cC5jb20vaW52b2ljZXMiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cHM6Ly9tYW5hZ2UudXBza3lncm91cC5jb20vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', NULL, NULL, 1686314217),
('Ji5jysX0dMHm0Y4XnczLZo9f4eCfAuONyQOHDFNj', NULL, '49.44.82.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMVpCdzJRNFEwMmJMTWhzVGxYMHRxUW9ZaXdXTXhoMHFaUjJMT2xrZSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozOToiaHR0cHM6Ly9tYW5hZ2UudXBza3lncm91cC5jb20vZXN0aW1hdGVzIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1686314220),
('KYPphNPVmWrRavJ0cEa9wg1rZ2mR4Sk7SxT0iM3H', NULL, '49.205.252.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36 OPR/99.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidkROUkhKSEM3VWxLc1BDVXU4NHE1VlZMU1ZCTDZLdEJNUDNZYkdqbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjM0OiJodHRwczovL21hbmFnZS51cHNreWdyb3VwLmNvbS9ob21lIjt9fQ==', NULL, NULL, 1686312873),
('eAnxcbht4SZ6FDejbDTINS0Ro4abR0zONQvqjEgo', 9, '120.138.13.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoibWwwWUg4bTBDRUlIUVJzS1ZSdTF4YWdRNjhybEw5RGhtOFY0ZFRrVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjM0OiJodHRwczovL21hbmFnZS51cHNreWdyb3VwLmNvbS9ob21lIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6OTt9', NULL, NULL, 1686315388),
('sdavKcl4jla4vLviN4WOVWw0NIsBdAUtjubwfKDa', NULL, '49.205.252.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36 OPR/99.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieW1WeXVGUDNOTGQzbjRhOVJNN1FuZTR5YTZvaWdDMGl6Z25RUE04TyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNDoiaHR0cHM6Ly9tYW5hZ2UudXBza3lncm91cC5jb20vaG9tZSI7fX0=', NULL, NULL, 1686312873),
('ADbt5I5gf71XLPb0dHzbgGfcOEYmqt0LifheGT8k', 9, '209.107.179.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZW1NbHdnSjYwOWQxWnhIQnJNaE0xU3FHWnlnS3JydmhpZnBsTTNaOCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNDoiaHR0cHM6Ly9tYW5hZ2UudXBza3lncm91cC5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM4OiJodHRwczovL21hbmFnZS51cHNreWdyb3VwLmNvbS9zZXR0aW5ncyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjk7fQ==', NULL, NULL, 1686331713),
('TFkhmZoyg3XgniIaWfCm6A4HlBRMTDRn1LtuMCuq', 9, '49.207.220.93', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoicjBzV3Fybk1EZk9MS1pvcDdxWVdxOW9yQU5RMmh3STVrUm5IekwwNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjM0OiJodHRwczovL21hbmFnZS51cHNreWdyb3VwLmNvbS9ob21lIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6OTt9', NULL, NULL, 1686148980),
('jJ9Imz6GaQisGV1CMMfUfzRogDk3SUAifgcjaHDq', 11, '172.56.90.166', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRUc0NXlKeWVvelUzeGpaYkxOcE53TzlPQklKMUhzR3FFV08zV2tYYiI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTE7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vbWFuYWdlLnVwc2t5Z3JvdXAuY29tL2tub3dsZWRnZWJhc2UiO319', NULL, NULL, 1686220632);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `settings_id` int(11) NOT NULL,
  `settings_created` datetime NOT NULL,
  `settings_updated` datetime NOT NULL,
  `settings_type` varchar(50) DEFAULT 'standalone' COMMENT 'standalone|saas',
  `settings_saas_tenant_id` int(11) DEFAULT NULL,
  `settings_saas_status` varchar(100) DEFAULT NULL COMMENT 'unsubscribed|free-trial|awaiting-payment|failed|active|cancelled',
  `settings_saas_package_id` int(11) DEFAULT NULL,
  `settings_saas_onetimelogin_key` varchar(100) DEFAULT NULL,
  `settings_saas_onetimelogin_destination` varchar(100) DEFAULT NULL COMMENT 'home|payment',
  `settings_saas_package_limits_clients` int(11) DEFAULT NULL,
  `settings_saas_package_limits_team` int(11) DEFAULT NULL,
  `settings_saas_package_limits_projects` int(11) DEFAULT NULL,
  `settings_saas_notification_uniqueid` text DEFAULT NULL COMMENT '(optional) unique identifier',
  `settings_saas_notification_body` text DEFAULT NULL COMMENT 'html body of promotion etc',
  `settings_saas_notification_read` text DEFAULT NULL COMMENT 'yes|no',
  `settings_saas_notification_action` text DEFAULT NULL COMMENT 'none|external-link|internal-link',
  `settings_saas_notification_action_url` text DEFAULT NULL,
  `settings_installation_date` datetime NOT NULL COMMENT 'date the system was setup',
  `settings_version` text NOT NULL,
  `settings_purchase_code` text DEFAULT NULL COMMENT 'codecanyon code',
  `settings_company_name` text DEFAULT NULL,
  `settings_company_address_line_1` text DEFAULT NULL,
  `settings_company_state` text DEFAULT NULL,
  `settings_company_city` text DEFAULT NULL,
  `settings_company_zipcode` text DEFAULT NULL,
  `settings_company_country` text DEFAULT NULL,
  `settings_company_telephone` text DEFAULT NULL,
  `settings_company_customfield_1` text DEFAULT NULL,
  `settings_company_customfield_2` text DEFAULT NULL,
  `settings_company_customfield_3` text DEFAULT NULL,
  `settings_company_customfield_4` text DEFAULT NULL,
  `settings_clients_registration` text DEFAULT NULL COMMENT 'enabled | disabled',
  `settings_clients_shipping_address` text DEFAULT NULL COMMENT 'enabled | disabled',
  `settings_clients_disable_email_delivery` varchar(40) DEFAULT 'disabled' COMMENT 'enabled | disabled',
  `settings_clients_app_login` varchar(40) DEFAULT 'enabled' COMMENT 'enabled | disabled',
  `settings_customfields_display_leads` varchar(40) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_customfields_display_clients` varchar(40) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_customfields_display_projects` varchar(40) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_customfields_display_tasks` varchar(40) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_customfields_display_tickets` varchar(40) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_email_general_variables` text DEFAULT NULL COMMENT 'common variable displayed available in templates',
  `settings_email_from_address` text DEFAULT NULL,
  `settings_email_from_name` text DEFAULT NULL,
  `settings_email_server_type` text DEFAULT NULL COMMENT 'smtp|sendmail',
  `settings_email_smtp_host` text DEFAULT NULL,
  `settings_email_smtp_port` text DEFAULT NULL,
  `settings_email_smtp_username` text DEFAULT NULL,
  `settings_email_smtp_password` text DEFAULT NULL,
  `settings_email_smtp_encryption` text DEFAULT NULL COMMENT 'tls|ssl|starttls',
  `settings_estimates_default_terms_conditions` text DEFAULT NULL,
  `settings_estimates_prefix` text DEFAULT NULL,
  `settings_estimates_show_view_status` varchar(40) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_modules_projects` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_tasks` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_invoices` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled (invoice, payments, products)',
  `settings_modules_payments` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_leads` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_knowledgebase` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_estimates` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_expenses` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_notes` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_subscriptions` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_contracts` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_proposals` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_tickets` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_timetracking` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_reminders` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_spaces` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_messages` varchar(40) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_files_max_size_mb` int(11) DEFAULT 300 COMMENT 'maximum size in MB',
  `settings_knowledgebase_article_ordering` varchar(40) DEFAULT 'name' COMMENT 'name-asc|name-desc|date-asc|date-desc',
  `settings_knowledgebase_allow_guest_viewing` varchar(40) DEFAULT 'no' COMMENT 'yes | no',
  `settings_knowledgebase_external_pre_body` text DEFAULT NULL COMMENT 'for use when viewing externally, as guest',
  `settings_knowledgebase_external_post_body` text DEFAULT NULL COMMENT 'for use when viewing externally, as guest',
  `settings_knowledgebase_external_header` text DEFAULT NULL COMMENT 'for use when viewing externally, as guest',
  `settings_system_timezone` text DEFAULT NULL,
  `settings_system_date_format` text DEFAULT NULL COMMENT 'd-m-Y | d/m/Y | m-d-Y | m/d/Y | Y-m-d | Y/m/d | Y-d-m | Y/d/m',
  `settings_system_datepicker_format` text DEFAULT NULL COMMENT 'dd-mm-yyyy | mm-dd-yyyy',
  `settings_system_default_leftmenu` text DEFAULT NULL COMMENT 'collapsed | open',
  `settings_system_default_statspanel` text DEFAULT NULL COMMENT 'collapsed | open',
  `settings_system_pagination_limits` tinyint(4) DEFAULT NULL,
  `settings_system_kanban_pagination_limits` tinyint(4) DEFAULT NULL,
  `settings_system_currency_code` text DEFAULT NULL,
  `settings_system_currency_symbol` text DEFAULT NULL,
  `settings_system_currency_position` text DEFAULT NULL COMMENT 'left|right',
  `settings_system_decimal_separator` text DEFAULT NULL,
  `settings_system_thousand_separator` text DEFAULT NULL,
  `settings_system_close_modals_body_click` varchar(40) DEFAULT 'no' COMMENT 'yes|no',
  `settings_system_language_default` varchar(40) DEFAULT 'en' COMMENT 'english|french|etc',
  `settings_system_language_allow_users_to_change` varchar(40) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_system_logo_large_name` varchar(40) DEFAULT 'logo.jpg',
  `settings_system_logo_small_name` varchar(40) DEFAULT 'logo-small.jpg',
  `settings_system_logo_versioning` varchar(40) DEFAULT '1' COMMENT 'used to refresh logo when updated',
  `settings_system_session_login_popup` varchar(40) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings_system_javascript_versioning` date DEFAULT NULL,
  `settings_system_exporting_strip_html` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_tags_allow_users_create` varchar(40) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_leads_allow_private` varchar(40) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_leads_allow_new_sources` varchar(40) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_leads_kanban_value` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_date_created` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_category` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_date_contacted` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_telephone` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_source` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_email` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_client_visibility` text DEFAULT NULL COMMENT 'visible|invisible - used in create new task form on the checkbox ',
  `settings_tasks_billable` text DEFAULT NULL COMMENT 'billable|not-billable - used in create new task form on the checkbox ',
  `settings_tasks_kanban_date_created` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_date_due` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_date_start` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_priority` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_client_visibility` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_project_title` varchar(40) DEFAULT 'show' COMMENT 'show|hide',
  `settings_tasks_kanban_client_name` varchar(40) DEFAULT 'show' COMMENT 'show|hide',
  `settings_tasks_send_overdue_reminder` varchar(40) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_invoices_prefix` text DEFAULT NULL,
  `settings_invoices_recurring_grace_period` smallint(6) DEFAULT NULL COMMENT 'Number of days for due date on recurring invoices. If set to zero, invoices will be given due date same as invoice date',
  `settings_invoices_default_terms_conditions` text DEFAULT NULL,
  `settings_invoices_show_view_status` text NOT NULL,
  `settings_projects_cover_images` varchar(40) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings_projects_permissions_basis` varchar(40) DEFAULT 'user_roles' COMMENT 'user_roles|category_based',
  `settings_projects_categories_main_menu` varchar(40) DEFAULT 'no' COMMENT 'yes|no',
  `settings_projects_default_hourly_rate` decimal(10,2) DEFAULT 0.00 COMMENT 'default hourly rate for new projects',
  `settings_projects_allow_setting_permission_on_project_creation` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_files_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_files_upload` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_comments_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_comments_post` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_tasks_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_tasks_collaborate` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_tasks_create` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_timesheets_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_expenses_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_milestones_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_assigned_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_assignedperm_milestone_manage` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_assignedperm_tasks_collaborate` text DEFAULT NULL COMMENT 'yes|no',
  `settings_stripe_secret_key` text DEFAULT NULL,
  `settings_stripe_public_key` text DEFAULT NULL,
  `settings_stripe_webhooks_key` text DEFAULT NULL COMMENT 'from strip dashboard',
  `settings_stripe_default_subscription_plan_id` text DEFAULT NULL,
  `settings_stripe_currency` text DEFAULT NULL,
  `settings_stripe_display_name` text DEFAULT NULL COMMENT 'what customer will see on payment screen',
  `settings_stripe_status` text DEFAULT NULL COMMENT 'enabled|disabled',
  `settings_subscriptions_prefix` varchar(40) DEFAULT 'SUB-',
  `settings_paypal_email` text DEFAULT NULL,
  `settings_paypal_currency` text DEFAULT NULL,
  `settings_paypal_display_name` text DEFAULT NULL COMMENT 'what customer will see on payment screen',
  `settings_paypal_mode` text DEFAULT NULL COMMENT 'sandbox | live',
  `settings_paypal_status` text DEFAULT NULL COMMENT 'enabled|disabled',
  `settings_mollie_live_api_key` text DEFAULT NULL,
  `settings_mollie_test_api_key` text DEFAULT NULL,
  `settings_mollie_display_name` text DEFAULT NULL,
  `settings_mollie_mode` varchar(40) DEFAULT 'live',
  `settings_mollie_currency` text DEFAULT NULL,
  `settings_mollie_status` varchar(40) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings_bank_details` text DEFAULT NULL,
  `settings_bank_display_name` text DEFAULT NULL COMMENT 'what customer will see on payment screen',
  `settings_bank_status` text DEFAULT NULL COMMENT 'enabled|disabled',
  `settings_razorpay_keyid` text DEFAULT NULL,
  `settings_razorpay_secretkey` text DEFAULT NULL,
  `settings_razorpay_currency` text DEFAULT NULL,
  `settings_razorpay_display_name` text DEFAULT NULL,
  `settings_razorpay_status` varchar(40) DEFAULT 'disabled',
  `settings_completed_check_email` varchar(40) DEFAULT 'no' COMMENT 'yes|no',
  `settings_expenses_billable_by_default` varchar(40) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_tickets_edit_subject` text DEFAULT NULL COMMENT 'yes|no',
  `settings_tickets_edit_body` text DEFAULT NULL COMMENT 'yes|no',
  `settings_theme_name` varchar(40) DEFAULT 'default' COMMENT 'default|darktheme',
  `settings_theme_head` text DEFAULT NULL,
  `settings_theme_body` text DEFAULT NULL,
  `settings_track_thankyou_session_id` text DEFAULT NULL COMMENT 'used to ensure we show thank you page just once',
  `settings_proposals_prefix` varchar(30) DEFAULT 'PROP-',
  `settings_proposals_show_view_status` varchar(30) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_contracts_prefix` varchar(30) DEFAULT 'CONT-',
  `settings_contracts_show_view_status` varchar(30) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_cronjob_has_run` varchar(40) DEFAULT 'no' COMMENT 'yes|no',
  `settings_cronjob_last_run` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`settings_id`, `settings_created`, `settings_updated`, `settings_type`, `settings_saas_tenant_id`, `settings_saas_status`, `settings_saas_package_id`, `settings_saas_onetimelogin_key`, `settings_saas_onetimelogin_destination`, `settings_saas_package_limits_clients`, `settings_saas_package_limits_team`, `settings_saas_package_limits_projects`, `settings_saas_notification_uniqueid`, `settings_saas_notification_body`, `settings_saas_notification_read`, `settings_saas_notification_action`, `settings_saas_notification_action_url`, `settings_installation_date`, `settings_version`, `settings_purchase_code`, `settings_company_name`, `settings_company_address_line_1`, `settings_company_state`, `settings_company_city`, `settings_company_zipcode`, `settings_company_country`, `settings_company_telephone`, `settings_company_customfield_1`, `settings_company_customfield_2`, `settings_company_customfield_3`, `settings_company_customfield_4`, `settings_clients_registration`, `settings_clients_shipping_address`, `settings_clients_disable_email_delivery`, `settings_clients_app_login`, `settings_customfields_display_leads`, `settings_customfields_display_clients`, `settings_customfields_display_projects`, `settings_customfields_display_tasks`, `settings_customfields_display_tickets`, `settings_email_general_variables`, `settings_email_from_address`, `settings_email_from_name`, `settings_email_server_type`, `settings_email_smtp_host`, `settings_email_smtp_port`, `settings_email_smtp_username`, `settings_email_smtp_password`, `settings_email_smtp_encryption`, `settings_estimates_default_terms_conditions`, `settings_estimates_prefix`, `settings_estimates_show_view_status`, `settings_modules_projects`, `settings_modules_tasks`, `settings_modules_invoices`, `settings_modules_payments`, `settings_modules_leads`, `settings_modules_knowledgebase`, `settings_modules_estimates`, `settings_modules_expenses`, `settings_modules_notes`, `settings_modules_subscriptions`, `settings_modules_contracts`, `settings_modules_proposals`, `settings_modules_tickets`, `settings_modules_timetracking`, `settings_modules_reminders`, `settings_modules_spaces`, `settings_modules_messages`, `settings_files_max_size_mb`, `settings_knowledgebase_article_ordering`, `settings_knowledgebase_allow_guest_viewing`, `settings_knowledgebase_external_pre_body`, `settings_knowledgebase_external_post_body`, `settings_knowledgebase_external_header`, `settings_system_timezone`, `settings_system_date_format`, `settings_system_datepicker_format`, `settings_system_default_leftmenu`, `settings_system_default_statspanel`, `settings_system_pagination_limits`, `settings_system_kanban_pagination_limits`, `settings_system_currency_code`, `settings_system_currency_symbol`, `settings_system_currency_position`, `settings_system_decimal_separator`, `settings_system_thousand_separator`, `settings_system_close_modals_body_click`, `settings_system_language_default`, `settings_system_language_allow_users_to_change`, `settings_system_logo_large_name`, `settings_system_logo_small_name`, `settings_system_logo_versioning`, `settings_system_session_login_popup`, `settings_system_javascript_versioning`, `settings_system_exporting_strip_html`, `settings_tags_allow_users_create`, `settings_leads_allow_private`, `settings_leads_allow_new_sources`, `settings_leads_kanban_value`, `settings_leads_kanban_date_created`, `settings_leads_kanban_category`, `settings_leads_kanban_date_contacted`, `settings_leads_kanban_telephone`, `settings_leads_kanban_source`, `settings_leads_kanban_email`, `settings_tasks_client_visibility`, `settings_tasks_billable`, `settings_tasks_kanban_date_created`, `settings_tasks_kanban_date_due`, `settings_tasks_kanban_date_start`, `settings_tasks_kanban_priority`, `settings_tasks_kanban_client_visibility`, `settings_tasks_kanban_project_title`, `settings_tasks_kanban_client_name`, `settings_tasks_send_overdue_reminder`, `settings_invoices_prefix`, `settings_invoices_recurring_grace_period`, `settings_invoices_default_terms_conditions`, `settings_invoices_show_view_status`, `settings_projects_cover_images`, `settings_projects_permissions_basis`, `settings_projects_categories_main_menu`, `settings_projects_default_hourly_rate`, `settings_projects_allow_setting_permission_on_project_creation`, `settings_projects_clientperm_files_view`, `settings_projects_clientperm_files_upload`, `settings_projects_clientperm_comments_view`, `settings_projects_clientperm_comments_post`, `settings_projects_clientperm_tasks_view`, `settings_projects_clientperm_tasks_collaborate`, `settings_projects_clientperm_tasks_create`, `settings_projects_clientperm_timesheets_view`, `settings_projects_clientperm_expenses_view`, `settings_projects_clientperm_milestones_view`, `settings_projects_clientperm_assigned_view`, `settings_projects_assignedperm_milestone_manage`, `settings_projects_assignedperm_tasks_collaborate`, `settings_stripe_secret_key`, `settings_stripe_public_key`, `settings_stripe_webhooks_key`, `settings_stripe_default_subscription_plan_id`, `settings_stripe_currency`, `settings_stripe_display_name`, `settings_stripe_status`, `settings_subscriptions_prefix`, `settings_paypal_email`, `settings_paypal_currency`, `settings_paypal_display_name`, `settings_paypal_mode`, `settings_paypal_status`, `settings_mollie_live_api_key`, `settings_mollie_test_api_key`, `settings_mollie_display_name`, `settings_mollie_mode`, `settings_mollie_currency`, `settings_mollie_status`, `settings_bank_details`, `settings_bank_display_name`, `settings_bank_status`, `settings_razorpay_keyid`, `settings_razorpay_secretkey`, `settings_razorpay_currency`, `settings_razorpay_display_name`, `settings_razorpay_status`, `settings_completed_check_email`, `settings_expenses_billable_by_default`, `settings_tickets_edit_subject`, `settings_tickets_edit_body`, `settings_theme_name`, `settings_theme_head`, `settings_theme_body`, `settings_track_thankyou_session_id`, `settings_proposals_prefix`, `settings_proposals_show_view_status`, `settings_contracts_prefix`, `settings_contracts_show_view_status`, `settings_cronjob_has_run`, `settings_cronjob_last_run`) VALUES
(1, '2023-01-19 22:02:01', '2023-06-09 19:25:27', 'standalone', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-19 22:02:01', '2.0', NULL, 'UpSky Group', 'Address needs to be changed............', 'needs to chagne', 'needs to chagne', 'needs to chagne', 'United Kingdom', 'needs to chagne', NULL, NULL, NULL, NULL, 'enabled', 'enabled', 'disabled', 'enabled', 'toggled', 'toggled', 'toggled', 'toggled', 'toggled', '{our_company_name}, {todays_date}, {email_signature}, {email_footer}, {dashboard_url}', 'noreply@manage.upskygroup.com', 'UpSky Group', 'smtp', 'manage.upskygroup.com', '465', 'noreply@manage.upskygroup.com', '$JHC3PTL2Ko*', 'ssl', '<p>Thank you for your business. We look forward to working with you on this project.</p>', 'EST-', 'yes', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'disabled', 'enabled', 5000, 'name-asc', 'no', NULL, NULL, NULL, 'Europe/Amsterdam', 'm-d-Y', 'mm-dd-yyyy', 'collapsed', 'collapsed', 35, 35, 'USD', '$', 'left', 'fullstop', 'comma', 'no', 'english', 'yes', 'logo.png', 'logo-small.png', '1677101602', 'enabled', '2023-01-19', 'yes', 'yes', 'yes', 'yes', 'show', 'show', 'hide', 'show', 'show', 'hide', 'show', 'visible', 'billable', 'show', 'show', 'hide', 'show', 'hide', 'show', 'show', 'yes', 'INV-', 3, '<p>Thank you for your business.</p>', 'no', 'enabled', 'user_roles', 'no', NULL, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', 'yes', '', '', '', NULL, 'USD', 'Credit Card', 'disabled', 'SUB-', 'info@example.com', 'USD', 'Paypal', 'sandbox', 'disabled', '', '', 'Mollie', 'sandbox', 'USD', 'disabled', '<p><strong>This is just an example:</strong></p>\r\n<p><strong>Bank Name:</strong>&nbsp;ABCD</p>\r\n<p><strong>Account Name:</strong>&nbsp;ABCD</p>\r\n<p><strong>Account Number:</strong>&nbsp;ABCD</p>', 'Bank Transfer', 'enabled', '', '', 'USD', 'RazorPay', 'disabled', 'yes', 'yes', 'yes', 'yes', 'default', NULL, NULL, '', 'PROP-', 'yes', 'CO-', 'yes', 'yes', '2023-06-09 19:25:27');

-- --------------------------------------------------------

--
-- Table structure for table `settings2`
--

CREATE TABLE `settings2` (
  `settings2_id` int(11) NOT NULL,
  `settings2_created` datetime NOT NULL,
  `settings2_updated` datetime NOT NULL,
  `settings2_estimates_automation_default_status` varchar(30) DEFAULT 'disabled' COMMENT 'disabled|enabled',
  `settings2_estimates_automation_create_project` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_project_status` varchar(50) DEFAULT 'in_progress' COMMENT 'not_started | in_progress | on_hold',
  `settings2_estimates_automation_project_title` varchar(50) DEFAULT NULL COMMENT 'default project title',
  `settings2_estimates_automation_project_email_client` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_create_invoice` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_invoice_email_client` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_invoice_due_date` int(11) DEFAULT 7,
  `settings2_estimates_automation_create_tasks` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_copy_attachments` varchar(30) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_extras_dimensions_billing` varchar(30) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings2_extras_dimensions_default_unit` varchar(30) DEFAULT 'm2',
  `settings2_extras_dimensions_show_measurements` varchar(30) DEFAULT 'no' COMMENT 'show on the pd,web etc',
  `settings2_projects_automation_default_status` varchar(30) DEFAULT 'disabled' COMMENT 'disabled|enabled',
  `settings2_projects_automation_create_invoices` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_projects_automation_convert_estimates_to_invoices` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_projects_automation_skip_draft_estimates` varchar(30) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_projects_automation_skip_declined_estimates` varchar(30) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_projects_automation_invoice_unbilled_hours` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_projects_automation_invoice_hourly_rate` decimal(10,2) DEFAULT NULL,
  `settings2_projects_automation_invoice_hourly_tax_1` int(11) DEFAULT NULL,
  `settings2_projects_automation_invoice_email_client` varchar(30) DEFAULT 'no',
  `settings2_projects_automation_invoice_due_date` int(20) DEFAULT 7,
  `settings2_tasks_manage_dependencies` varchar(100) DEFAULT 'super-users' COMMENT 'admin-users | super-users | all-task-users',
  `settings2_tap_secret_key` varchar(200) DEFAULT NULL,
  `settings2_tap_publishable_key` varchar(200) DEFAULT NULL,
  `settings2_tap_currency_code` varchar(10) DEFAULT NULL,
  `settings2_tap_language` varchar(10) DEFAULT 'en' COMMENT 'arabic (ar) | english (en)',
  `settings2_tap_display_name` varchar(200) DEFAULT NULL,
  `settings2_tap_status` varchar(10) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings2_file_folders_status` varchar(100) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_file_folders_manage_assigned` varchar(100) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_file_folders_manage_project_manager` varchar(100) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_file_folders_manage_client` varchar(100) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_file_bulk_download` varchar(100) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_team_space_id` varchar(100) DEFAULT NULL,
  `settings2_spaces_team_space_status` varchar(100) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_user_space_status` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_team_space_title` varchar(250) DEFAULT 'Team Space',
  `settings2_spaces_user_space_title` varchar(250) DEFAULT 'My Space',
  `settings2_spaces_team_space_menu_name` varchar(150) DEFAULT 'Team Space',
  `settings2_spaces_user_space_menu_name` varchar(150) DEFAULT 'Space',
  `settings2_spaces_features_files` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_notes` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_comments` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_tasks` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_whiteboard` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_checklists` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_todos` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_reminders` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_projects_cover_images_show_on_project` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_onboarding_status` varchar(50) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings2_onboarding_content` text DEFAULT NULL,
  `settings2_onboarding_view_status` varchar(50) DEFAULT 'unseen' COMMENT 'seen|unseen'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `settings2`
--

INSERT INTO `settings2` (`settings2_id`, `settings2_created`, `settings2_updated`, `settings2_estimates_automation_default_status`, `settings2_estimates_automation_create_project`, `settings2_estimates_automation_project_status`, `settings2_estimates_automation_project_title`, `settings2_estimates_automation_project_email_client`, `settings2_estimates_automation_create_invoice`, `settings2_estimates_automation_invoice_email_client`, `settings2_estimates_automation_invoice_due_date`, `settings2_estimates_automation_create_tasks`, `settings2_estimates_automation_copy_attachments`, `settings2_extras_dimensions_billing`, `settings2_extras_dimensions_default_unit`, `settings2_extras_dimensions_show_measurements`, `settings2_projects_automation_default_status`, `settings2_projects_automation_create_invoices`, `settings2_projects_automation_convert_estimates_to_invoices`, `settings2_projects_automation_skip_draft_estimates`, `settings2_projects_automation_skip_declined_estimates`, `settings2_projects_automation_invoice_unbilled_hours`, `settings2_projects_automation_invoice_hourly_rate`, `settings2_projects_automation_invoice_hourly_tax_1`, `settings2_projects_automation_invoice_email_client`, `settings2_projects_automation_invoice_due_date`, `settings2_tasks_manage_dependencies`, `settings2_tap_secret_key`, `settings2_tap_publishable_key`, `settings2_tap_currency_code`, `settings2_tap_language`, `settings2_tap_display_name`, `settings2_tap_status`, `settings2_file_folders_status`, `settings2_file_folders_manage_assigned`, `settings2_file_folders_manage_project_manager`, `settings2_file_folders_manage_client`, `settings2_file_bulk_download`, `settings2_spaces_team_space_id`, `settings2_spaces_team_space_status`, `settings2_spaces_user_space_status`, `settings2_spaces_team_space_title`, `settings2_spaces_user_space_title`, `settings2_spaces_team_space_menu_name`, `settings2_spaces_user_space_menu_name`, `settings2_spaces_features_files`, `settings2_spaces_features_notes`, `settings2_spaces_features_comments`, `settings2_spaces_features_tasks`, `settings2_spaces_features_whiteboard`, `settings2_spaces_features_checklists`, `settings2_spaces_features_todos`, `settings2_spaces_features_reminders`, `settings2_projects_cover_images_show_on_project`, `settings2_onboarding_status`, `settings2_onboarding_content`, `settings2_onboarding_view_status`) VALUES
(1, '2023-01-19 22:02:01', '2023-01-19 22:02:01', 'disabled', 'yes', 'on_hold', 'New Project', 'yes', 'yes', 'yes', 7, 'yes', 'yes', 'disabled', 'm2', 'no', 'disabled', 'yes', 'yes', 'yes', 'yes', 'yes', NULL, NULL, 'yes', 7, 'super-users', '', '', '', 'en', '', 'disabled', 'enabled', 'yes', 'yes', 'yes', 'enabled', NULL, 'enabled', 'enabled', 'Team Workspace', 'My Workspace', 'Team Workspace', 'My Workspace', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'no', 'disabled', '', 'seen');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `subscription_id` int(11) NOT NULL,
  `subscription_gateway_id` varchar(250) DEFAULT NULL,
  `subscription_created` datetime DEFAULT NULL,
  `subscription_updated` datetime DEFAULT NULL,
  `subscription_creatorid` int(11) NOT NULL,
  `subscription_clientid` int(11) NOT NULL,
  `subscription_categoryid` int(11) NOT NULL DEFAULT 4,
  `subscription_projectid` int(11) DEFAULT NULL COMMENT 'optional',
  `subscription_gateway_product` varchar(250) DEFAULT NULL COMMENT 'stripe product id',
  `subscription_gateway_price` varchar(250) DEFAULT NULL COMMENT 'stripe price id',
  `subscription_gateway_product_name` varchar(250) DEFAULT NULL COMMENT 'e.g. Glod Plan',
  `subscription_gateway_interval` int(11) DEFAULT NULL COMMENT 'e.g. 2',
  `subscription_gateway_period` varchar(50) DEFAULT NULL COMMENT 'e.g. months',
  `subscription_date_started` datetime DEFAULT NULL,
  `subscription_date_ended` datetime DEFAULT NULL,
  `subscription_date_renewed` date DEFAULT NULL COMMENT 'from stripe',
  `subscription_date_next_renewal` date DEFAULT NULL COMMENT 'from stripe',
  `subscription_gateway_last_message` text DEFAULT NULL COMMENT 'from stripe',
  `subscription_gateway_last_message_date` datetime DEFAULT NULL,
  `subscription_subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `subscription_amount_before_tax` decimal(10,2) DEFAULT 0.00,
  `subscription_tax_percentage` decimal(10,2) DEFAULT 0.00 COMMENT 'percentage',
  `subscription_tax_amount` decimal(10,2) DEFAULT 0.00 COMMENT 'amount',
  `subscription_final_amount` decimal(10,2) DEFAULT 0.00,
  `subscription_notes` text DEFAULT NULL,
  `subscription_status` varchar(50) DEFAULT 'pending' COMMENT 'pending | active | failed | paused | cancelled',
  `subscription_visibility` varchar(50) DEFAULT 'visible' COMMENT 'visible | invisible',
  `subscription_cron_status` varchar(20) DEFAULT 'none' COMMENT 'none|processing|completed|error  (used to prevent collisions when recurring invoiced)',
  `subscription_cron_date` datetime DEFAULT NULL COMMENT 'date when cron was run'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `tag_id` int(11) NOT NULL,
  `tag_created` datetime DEFAULT NULL,
  `tag_updated` datetime DEFAULT NULL,
  `tag_creatorid` int(11) DEFAULT NULL,
  `tag_title` varchar(100) NOT NULL,
  `tag_visibility` varchar(50) NOT NULL DEFAULT 'user' COMMENT 'public | user  (public tags are only created via admin settings)',
  `tagresource_type` varchar(50) NOT NULL COMMENT '[polymorph] invoice | project | client | lead | task | estimate | ticket | contract | note | subscription | contract | proposal',
  `tagresource_id` int(11) NOT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `task_id` int(11) NOT NULL,
  `task_importid` varchar(100) DEFAULT NULL,
  `task_position` double NOT NULL COMMENT 'increment by 16384',
  `task_created` datetime DEFAULT NULL COMMENT 'always now()',
  `task_updated` datetime DEFAULT NULL,
  `task_creatorid` int(11) DEFAULT NULL,
  `task_clientid` int(11) DEFAULT NULL COMMENT 'optional',
  `task_projectid` int(11) DEFAULT NULL COMMENT 'project_id',
  `task_date_start` date DEFAULT NULL,
  `task_date_due` date DEFAULT NULL,
  `task_title` varchar(250) DEFAULT NULL,
  `task_description` text DEFAULT NULL,
  `task_client_visibility` varchar(100) DEFAULT 'yes',
  `task_milestoneid` int(11) DEFAULT NULL COMMENT 'new tasks must be set to the [uncategorised] milestone',
  `task_previous_status` varchar(100) DEFAULT 'new',
  `task_priority` varchar(100) NOT NULL DEFAULT 'normal' COMMENT 'normal | high | urgent',
  `task_status` int(11) DEFAULT 1,
  `task_active_state` varchar(100) DEFAULT 'active' COMMENT 'active|archived',
  `task_billable` varchar(5) DEFAULT 'yes' COMMENT 'yes | no',
  `task_billable_status` varchar(20) DEFAULT 'not_invoiced' COMMENT 'invoiced | not_invoiced',
  `task_billable_invoiceid` int(11) DEFAULT NULL COMMENT 'id of the invoice that it has been billed to',
  `task_billable_lineitemid` int(11) DEFAULT NULL COMMENT 'id of line item that was billed',
  `task_visibility` varchar(40) DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent tasks that are still being cloned from showing in tasks list)',
  `task_overdue_notification_sent` varchar(40) DEFAULT 'no' COMMENT 'yes|no',
  `task_recurring` varchar(40) DEFAULT 'no' COMMENT 'yes|no',
  `task_recurring_duration` int(11) DEFAULT NULL COMMENT 'e.g. 20 (for 20 days)',
  `task_recurring_period` varchar(30) DEFAULT NULL COMMENT 'day | week | month | year',
  `task_recurring_cycles` int(11) DEFAULT NULL COMMENT '0 for infinity',
  `task_recurring_cycles_counter` int(11) DEFAULT 0 COMMENT 'number of times it has been renewed',
  `task_recurring_last` date DEFAULT NULL COMMENT 'date when it was last renewed',
  `task_recurring_next` date DEFAULT NULL COMMENT 'date when it will next be renewed',
  `task_recurring_child` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `task_recurring_parent_id` datetime DEFAULT NULL COMMENT 'if it was generated from a recurring invoice, the id of parent invoice',
  `task_recurring_copy_checklists` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `task_recurring_copy_files` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `task_recurring_automatically_assign` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `task_recurring_finished` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `task_custom_field_1` tinytext DEFAULT NULL,
  `task_custom_field_2` tinytext DEFAULT NULL,
  `task_custom_field_3` tinytext DEFAULT NULL,
  `task_custom_field_4` tinytext DEFAULT NULL,
  `task_custom_field_5` tinytext DEFAULT NULL,
  `task_custom_field_6` tinytext DEFAULT NULL,
  `task_custom_field_7` tinytext DEFAULT NULL,
  `task_custom_field_8` tinytext DEFAULT NULL,
  `task_custom_field_9` tinytext DEFAULT NULL,
  `task_custom_field_10` tinytext DEFAULT NULL,
  `task_custom_field_11` datetime DEFAULT NULL,
  `task_custom_field_12` datetime DEFAULT NULL,
  `task_custom_field_13` datetime DEFAULT NULL,
  `task_custom_field_14` datetime DEFAULT NULL,
  `task_custom_field_15` datetime DEFAULT NULL,
  `task_custom_field_16` datetime DEFAULT NULL,
  `task_custom_field_17` datetime DEFAULT NULL,
  `task_custom_field_18` datetime DEFAULT NULL,
  `task_custom_field_19` datetime DEFAULT NULL,
  `task_custom_field_20` datetime DEFAULT NULL,
  `task_custom_field_21` text DEFAULT NULL,
  `task_custom_field_22` text DEFAULT NULL,
  `task_custom_field_23` text DEFAULT NULL,
  `task_custom_field_24` text DEFAULT NULL,
  `task_custom_field_25` text DEFAULT NULL,
  `task_custom_field_26` text DEFAULT NULL,
  `task_custom_field_27` text DEFAULT NULL,
  `task_custom_field_28` text DEFAULT NULL,
  `task_custom_field_29` text DEFAULT NULL,
  `task_custom_field_30` text DEFAULT NULL,
  `task_custom_field_31` varchar(20) DEFAULT NULL,
  `task_custom_field_32` varchar(20) DEFAULT NULL,
  `task_custom_field_33` varchar(20) DEFAULT NULL,
  `task_custom_field_34` varchar(20) DEFAULT NULL,
  `task_custom_field_35` varchar(20) DEFAULT NULL,
  `task_custom_field_36` varchar(20) DEFAULT NULL,
  `task_custom_field_37` varchar(20) DEFAULT NULL,
  `task_custom_field_38` varchar(20) DEFAULT NULL,
  `task_custom_field_39` varchar(20) DEFAULT NULL,
  `task_custom_field_40` varchar(20) DEFAULT NULL,
  `task_custom_field_41` varchar(150) DEFAULT NULL,
  `task_custom_field_42` varchar(150) DEFAULT NULL,
  `task_custom_field_43` varchar(150) DEFAULT NULL,
  `task_custom_field_44` varchar(150) DEFAULT NULL,
  `task_custom_field_45` varchar(150) DEFAULT NULL,
  `task_custom_field_46` varchar(150) DEFAULT NULL,
  `task_custom_field_47` varchar(150) DEFAULT NULL,
  `task_custom_field_48` varchar(150) DEFAULT NULL,
  `task_custom_field_49` varchar(150) DEFAULT NULL,
  `task_custom_field_50` varchar(150) DEFAULT NULL,
  `task_custom_field_51` int(11) DEFAULT NULL,
  `task_custom_field_52` int(11) DEFAULT NULL,
  `task_custom_field_53` int(11) DEFAULT NULL,
  `task_custom_field_54` int(11) DEFAULT NULL,
  `task_custom_field_55` int(11) DEFAULT NULL,
  `task_custom_field_56` int(11) DEFAULT NULL,
  `task_custom_field_57` int(11) DEFAULT NULL,
  `task_custom_field_58` int(11) DEFAULT NULL,
  `task_custom_field_59` int(11) DEFAULT NULL,
  `task_custom_field_60` int(11) DEFAULT NULL,
  `task_custom_field_61` decimal(10,2) DEFAULT NULL,
  `task_custom_field_62` decimal(10,2) DEFAULT NULL,
  `task_custom_field_63` decimal(10,2) DEFAULT NULL,
  `task_custom_field_64` decimal(10,2) DEFAULT NULL,
  `task_custom_field_65` decimal(10,2) DEFAULT NULL,
  `task_custom_field_66` decimal(10,2) DEFAULT NULL,
  `task_custom_field_67` decimal(10,2) DEFAULT NULL,
  `task_custom_field_68` decimal(10,2) DEFAULT NULL,
  `task_custom_field_69` decimal(10,2) DEFAULT NULL,
  `task_custom_field_70` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `tasks_assigned`
--

CREATE TABLE `tasks_assigned` (
  `tasksassigned_id` int(11) NOT NULL COMMENT '[truncate]',
  `tasksassigned_taskid` int(11) NOT NULL,
  `tasksassigned_userid` int(11) DEFAULT NULL,
  `tasksassigned_created` datetime DEFAULT NULL,
  `tasksassigned_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `tasks_dependencies`
--

CREATE TABLE `tasks_dependencies` (
  `tasksdependency_id` int(11) NOT NULL,
  `tasksdependency_created` int(11) NOT NULL,
  `tasksdependency_updated` int(11) NOT NULL,
  `tasksdependency_creatorid` int(11) DEFAULT NULL,
  `tasksdependency_projectid` int(11) DEFAULT NULL,
  `tasksdependency_clientid` int(11) DEFAULT NULL,
  `tasksdependency_taskid` int(11) DEFAULT NULL,
  `tasksdependency_blockerid` int(11) DEFAULT NULL,
  `tasksdependency_type` varchar(100) DEFAULT NULL COMMENT 'cannot_complete|cannot_start',
  `tasksdependency_status` varchar(100) DEFAULT 'active' COMMENT 'active|fulfilled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tasks_status`
--

CREATE TABLE `tasks_status` (
  `taskstatus_id` int(11) NOT NULL,
  `taskstatus_created` datetime DEFAULT NULL,
  `taskstatus_creatorid` int(11) DEFAULT NULL,
  `taskstatus_updated` datetime DEFAULT NULL,
  `taskstatus_title` varchar(200) NOT NULL,
  `taskstatus_position` int(11) NOT NULL,
  `taskstatus_color` varchar(100) NOT NULL DEFAULT 'default' COMMENT 'default|primary|success|info|warning|danger|lime|brown',
  `taskstatus_system_default` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[do not truncate]  expected to have 2 system default statuses (ID: 1 & 2) ''new'' & ''converted'' statuses ';

--
-- Dumping data for table `tasks_status`
--

INSERT INTO `tasks_status` (`taskstatus_id`, `taskstatus_created`, `taskstatus_creatorid`, `taskstatus_updated`, `taskstatus_title`, `taskstatus_position`, `taskstatus_color`, `taskstatus_system_default`) VALUES
(1, NULL, 0, '2021-09-26 11:13:40', 'New', 1, 'default', 'yes'),
(2, NULL, 0, '2021-09-26 11:13:40', 'Completed', 4, 'success', 'yes'),
(3, NULL, 0, '2021-09-26 11:13:40', 'In Progress', 2, 'info', 'no'),
(4, NULL, 0, '2021-09-26 11:13:40', 'Awaiting Feedback', 3, 'warning', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `tax`
--

CREATE TABLE `tax` (
  `tax_id` int(11) NOT NULL,
  `tax_taxrateid` int(11) NOT NULL COMMENT 'Reference to tax rates table',
  `tax_created` datetime NOT NULL,
  `tax_updated` datetime NOT NULL,
  `tax_name` varchar(100) DEFAULT NULL,
  `tax_rate` decimal(10,2) DEFAULT NULL,
  `tax_type` varchar(50) DEFAULT 'summary' COMMENT 'summary|inline',
  `tax_lineitem_id` int(11) DEFAULT NULL COMMENT 'for inline taxes',
  `taxresource_type` varchar(50) DEFAULT NULL COMMENT 'invoice|estimate|lineitem',
  `taxresource_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `taxrates`
--

CREATE TABLE `taxrates` (
  `taxrate_id` int(11) NOT NULL,
  `taxrate_uniqueid` varchar(200) NOT NULL COMMENT 'Used in <js> for identification',
  `taxrate_created` datetime NOT NULL,
  `taxrate_updated` datetime NOT NULL,
  `taxrate_creatorid` int(11) NOT NULL,
  `taxrate_name` varchar(100) NOT NULL,
  `taxrate_value` decimal(10,2) NOT NULL,
  `taxrate_type` varchar(100) NOT NULL DEFAULT 'user' COMMENT 'system|user|temp|client',
  `taxrate_clientid` int(11) DEFAULT NULL,
  `taxrate_estimateid` int(11) DEFAULT NULL,
  `taxrate_invoiceid` int(11) DEFAULT NULL,
  `taxrate_status` varchar(20) NOT NULL DEFAULT 'enabled' COMMENT 'enabled|disabled'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

--
-- Dumping data for table `taxrates`
--

INSERT INTO `taxrates` (`taxrate_id`, `taxrate_uniqueid`, `taxrate_created`, `taxrate_updated`, `taxrate_creatorid`, `taxrate_name`, `taxrate_value`, `taxrate_type`, `taxrate_clientid`, `taxrate_estimateid`, `taxrate_invoiceid`, `taxrate_status`) VALUES
(1, 'zero-rated-tax-rate', '2023-01-19 22:02:01', '2023-01-19 22:02:01', 0, 'No Tax', '0.00', 'system', NULL, NULL, NULL, 'enabled');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int(11) NOT NULL,
  `ticket_created` datetime DEFAULT NULL,
  `ticket_updated` datetime DEFAULT NULL,
  `ticket_creatorid` int(11) NOT NULL,
  `ticket_categoryid` int(11) NOT NULL DEFAULT 9,
  `ticket_clientid` int(11) DEFAULT NULL,
  `ticket_projectid` int(11) DEFAULT NULL,
  `ticket_subject` varchar(250) DEFAULT NULL,
  `ticket_message` text DEFAULT NULL,
  `ticket_priority` varchar(50) NOT NULL DEFAULT 'normal' COMMENT 'normal | high | urgent',
  `ticket_last_updated` datetime DEFAULT NULL,
  `ticket_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'numeric status id',
  `ticket_custom_field_1` tinytext DEFAULT NULL,
  `ticket_custom_field_2` tinytext DEFAULT NULL,
  `ticket_custom_field_3` tinytext DEFAULT NULL,
  `ticket_custom_field_4` tinytext DEFAULT NULL,
  `ticket_custom_field_5` tinytext DEFAULT NULL,
  `ticket_custom_field_6` tinytext DEFAULT NULL,
  `ticket_custom_field_7` tinytext DEFAULT NULL,
  `ticket_custom_field_8` tinytext DEFAULT NULL,
  `ticket_custom_field_9` tinytext DEFAULT NULL,
  `ticket_custom_field_10` tinytext DEFAULT NULL,
  `ticket_custom_field_11` tinytext DEFAULT NULL,
  `ticket_custom_field_12` tinytext DEFAULT NULL,
  `ticket_custom_field_13` tinytext DEFAULT NULL,
  `ticket_custom_field_14` tinytext DEFAULT NULL,
  `ticket_custom_field_15` tinytext DEFAULT NULL,
  `ticket_custom_field_16` tinytext DEFAULT NULL,
  `ticket_custom_field_17` tinytext DEFAULT NULL,
  `ticket_custom_field_18` tinytext DEFAULT NULL,
  `ticket_custom_field_19` tinytext DEFAULT NULL,
  `ticket_custom_field_20` tinytext DEFAULT NULL,
  `ticket_custom_field_21` tinytext DEFAULT NULL,
  `ticket_custom_field_22` tinytext DEFAULT NULL,
  `ticket_custom_field_23` tinytext DEFAULT NULL,
  `ticket_custom_field_24` tinytext DEFAULT NULL,
  `ticket_custom_field_25` tinytext DEFAULT NULL,
  `ticket_custom_field_26` tinytext DEFAULT NULL,
  `ticket_custom_field_27` tinytext DEFAULT NULL,
  `ticket_custom_field_28` tinytext DEFAULT NULL,
  `ticket_custom_field_29` tinytext DEFAULT NULL,
  `ticket_custom_field_30` tinytext DEFAULT NULL,
  `ticket_custom_field_31` tinytext DEFAULT NULL,
  `ticket_custom_field_32` tinytext DEFAULT NULL,
  `ticket_custom_field_33` tinytext DEFAULT NULL,
  `ticket_custom_field_34` tinytext DEFAULT NULL,
  `ticket_custom_field_35` tinytext DEFAULT NULL,
  `ticket_custom_field_36` tinytext DEFAULT NULL,
  `ticket_custom_field_37` tinytext DEFAULT NULL,
  `ticket_custom_field_38` tinytext DEFAULT NULL,
  `ticket_custom_field_39` tinytext DEFAULT NULL,
  `ticket_custom_field_40` tinytext DEFAULT NULL,
  `ticket_custom_field_41` tinytext DEFAULT NULL,
  `ticket_custom_field_42` tinytext DEFAULT NULL,
  `ticket_custom_field_43` tinytext DEFAULT NULL,
  `ticket_custom_field_44` tinytext DEFAULT NULL,
  `ticket_custom_field_45` tinytext DEFAULT NULL,
  `ticket_custom_field_46` tinytext DEFAULT NULL,
  `ticket_custom_field_47` tinytext DEFAULT NULL,
  `ticket_custom_field_48` tinytext DEFAULT NULL,
  `ticket_custom_field_49` tinytext DEFAULT NULL,
  `ticket_custom_field_50` tinytext DEFAULT NULL,
  `ticket_custom_field_51` tinytext DEFAULT NULL,
  `ticket_custom_field_52` tinytext DEFAULT NULL,
  `ticket_custom_field_53` tinytext DEFAULT NULL,
  `ticket_custom_field_54` tinytext DEFAULT NULL,
  `ticket_custom_field_55` tinytext DEFAULT NULL,
  `ticket_custom_field_56` tinytext DEFAULT NULL,
  `ticket_custom_field_57` tinytext DEFAULT NULL,
  `ticket_custom_field_58` tinytext DEFAULT NULL,
  `ticket_custom_field_59` tinytext DEFAULT NULL,
  `ticket_custom_field_60` tinytext DEFAULT NULL,
  `ticket_custom_field_61` tinytext DEFAULT NULL,
  `ticket_custom_field_62` tinytext DEFAULT NULL,
  `ticket_custom_field_63` tinytext DEFAULT NULL,
  `ticket_custom_field_64` tinytext DEFAULT NULL,
  `ticket_custom_field_65` tinytext DEFAULT NULL,
  `ticket_custom_field_66` tinytext DEFAULT NULL,
  `ticket_custom_field_67` tinytext DEFAULT NULL,
  `ticket_custom_field_68` tinytext DEFAULT NULL,
  `ticket_custom_field_69` tinytext DEFAULT NULL,
  `ticket_custom_field_70` tinytext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `tickets_status`
--

CREATE TABLE `tickets_status` (
  `ticketstatus_id` int(11) NOT NULL,
  `ticketstatus_created` datetime DEFAULT NULL,
  `ticketstatus_creatorid` int(11) DEFAULT NULL,
  `ticketstatus_updated` datetime DEFAULT NULL,
  `ticketstatus_title` varchar(200) NOT NULL,
  `ticketstatus_position` int(11) NOT NULL,
  `ticketstatus_color` varchar(100) NOT NULL DEFAULT 'default' COMMENT 'default|primary|success|info|warning|danger|lime|brown',
  `ticketstatus_use_for_client_replied` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no',
  `ticketstatus_use_for_team_replied` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no',
  `ticketstatus_system_default` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[do not truncate]  expected to have 2 system default statuses (ID: 1 & 2) ''new'' & ''converted'' statuses ';

--
-- Dumping data for table `tickets_status`
--

INSERT INTO `tickets_status` (`ticketstatus_id`, `ticketstatus_created`, `ticketstatus_creatorid`, `ticketstatus_updated`, `ticketstatus_title`, `ticketstatus_position`, `ticketstatus_color`, `ticketstatus_use_for_client_replied`, `ticketstatus_use_for_team_replied`, `ticketstatus_system_default`) VALUES
(1, '2022-12-11 12:20:22', 0, '2022-12-14 16:22:30', 'Open', 1, 'info', 'yes', 'no', 'yes'),
(2, '2022-12-11 12:21:19', 0, '2022-12-14 14:31:03', 'Closed', 4, 'default', 'no', 'no', 'yes'),
(3, '2022-12-11 12:23:56', 0, '2022-12-14 14:23:53', 'On Hold', 2, 'warning', 'no', 'no', 'no'),
(4, '2022-12-11 12:24:30', 0, '2022-12-14 14:24:40', 'Answered', 3, 'success', 'no', 'yes', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_replies`
--

CREATE TABLE `ticket_replies` (
  `ticketreply_id` int(11) NOT NULL,
  `ticketreply_created` datetime NOT NULL,
  `ticketreply_updated` datetime NOT NULL,
  `ticketreply_creatorid` int(11) NOT NULL,
  `ticketreply_clientid` int(11) DEFAULT NULL,
  `ticketreply_ticketid` int(11) NOT NULL,
  `ticketreply_text` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `timelines`
--

CREATE TABLE `timelines` (
  `timeline_id` int(11) NOT NULL,
  `timeline_eventid` int(11) NOT NULL,
  `timeline_resourcetype` varchar(50) DEFAULT NULL COMMENT 'invoices | projects | estimates | etc',
  `timeline_resourceid` int(11) DEFAULT NULL COMMENT 'the id of the item affected'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `timers`
--

CREATE TABLE `timers` (
  `timer_id` int(11) NOT NULL,
  `timer_created` datetime DEFAULT NULL,
  `timer_updated` datetime DEFAULT NULL,
  `timer_creatorid` int(11) DEFAULT NULL,
  `timer_started` int(11) DEFAULT NULL COMMENT 'unix time stam for when the timer was started',
  `timer_stopped` int(11) DEFAULT 0 COMMENT 'unix timestamp for when the timer was stopped',
  `timer_time` int(11) DEFAULT 0 COMMENT 'seconds',
  `timer_taskid` int(11) DEFAULT NULL,
  `timer_projectid` int(11) DEFAULT 0 COMMENT 'needed for repository filtering',
  `timer_clientid` int(11) DEFAULT 0 COMMENT 'needed for repository filtering',
  `timer_status` varchar(20) DEFAULT 'running' COMMENT 'running | stopped',
  `timer_billing_status` varchar(50) DEFAULT 'not_invoiced' COMMENT 'invoiced | not_invoiced',
  `timer_billing_invoiceid` int(11) DEFAULT NULL COMMENT 'invoice id, if billed'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `unit_id` int(11) NOT NULL,
  `unit_created` datetime DEFAULT NULL,
  `unit_update` datetime DEFAULT NULL,
  `unit_creatorid` int(11) DEFAULT 1,
  `unit_name` varchar(50) NOT NULL,
  `unit_system_default` varchar(50) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `unit_time_default` varchar(50) DEFAULT 'no' COMMENT 'yes|no (used to identify time unit)'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate]';

-- --------------------------------------------------------

--
-- Table structure for table `updates`
--

CREATE TABLE `updates` (
  `update_id` int(11) NOT NULL,
  `update_created` datetime NOT NULL,
  `update_updated` datetime NOT NULL,
  `update_version` decimal(10,2) DEFAULT NULL,
  `update_mysql_filename` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='tracks updates sql file execution';

-- --------------------------------------------------------

--
-- Table structure for table `updating`
--

CREATE TABLE `updating` (
  `updating_id` int(11) NOT NULL,
  `updating_created` datetime NOT NULL,
  `updating_updated` datetime NOT NULL,
  `updating_type` varchar(100) NOT NULL COMMENT 'modal|cronjob|url',
  `updating_name` varchar(100) DEFAULT NULL COMMENT 'used for updating the record',
  `updating_function_name` varchar(150) DEFAULT NULL COMMENT '[required]  for cronjob updating. This is the name of the function',
  `updating_update_version` varchar(10) DEFAULT NULL COMMENT 'which version this update is for',
  `updating_request_path` varchar(250) DEFAULT NULL COMMENT 'e.g. /updating/action/update-currency-settings',
  `updating_update_path` varchar(250) DEFAULT NULL COMMENT 'e.g. /updating/action/update-currency-settings',
  `updating_notes` tinytext DEFAULT NULL,
  `updating_payload_1` text DEFAULT NULL,
  `updating_payload_2` text DEFAULT NULL,
  `updating_payload_3` text DEFAULT NULL,
  `updating_started_date` datetime DEFAULT NULL,
  `updating_completed_date` datetime DEFAULT NULL,
  `updating_system_log` text DEFAULT NULL COMMENT 'any comments generated by the system when running this update',
  `updating_status` varchar(50) DEFAULT 'new' COMMENT 'new|processing|failed|completed'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `unique_id` varchar(150) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL COMMENT 'date when acccount was deleted',
  `creatorid` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `clientid` int(11) DEFAULT NULL COMMENT 'for client users',
  `account_owner` varchar(10) DEFAULT 'no' COMMENT 'yes | no',
  `primary_admin` varchar(10) DEFAULT 'no' COMMENT 'yes | no (only 1 primary admin - created during setup)',
  `avatar_directory` varchar(100) DEFAULT NULL,
  `avatar_filename` varchar(100) DEFAULT NULL,
  `type` varchar(150) NOT NULL COMMENT 'client | team |contact',
  `status` varchar(20) DEFAULT 'active' COMMENT 'active|suspended|deleted',
  `role_id` int(11) NOT NULL DEFAULT 2 COMMENT 'for team users',
  `last_seen` datetime DEFAULT NULL,
  `theme` varchar(100) DEFAULT 'default',
  `last_ip_address` varchar(100) DEFAULT NULL,
  `social_facebook` varchar(200) DEFAULT NULL,
  `social_twitter` varchar(200) DEFAULT NULL,
  `social_linkedin` varchar(200) DEFAULT NULL,
  `social_github` varchar(200) DEFAULT NULL,
  `social_dribble` varchar(200) DEFAULT NULL,
  `pref_language` varchar(200) DEFAULT 'english' COMMENT 'english|french|etc',
  `pref_email_notifications` varchar(10) DEFAULT 'yes' COMMENT 'yes | no',
  `pref_leftmenu_position` varchar(50) DEFAULT 'collapsed' COMMENT 'collapsed | open',
  `pref_statspanel_position` varchar(50) DEFAULT 'collapsed' COMMENT 'collapsed | open',
  `pref_filter_own_tasks` varchar(50) DEFAULT 'no' COMMENT 'Show only a users tasks in the tasks list',
  `pref_filter_own_projects` varchar(50) DEFAULT 'no' COMMENT 'Show only a users projects in the projects list',
  `pref_filter_show_archived_projects` varchar(50) DEFAULT 'no' COMMENT 'Show archived projects',
  `pref_filter_show_archived_tasks` varchar(50) DEFAULT 'no' COMMENT 'Show archived projects',
  `pref_filter_show_archived_leads` varchar(50) DEFAULT 'no' COMMENT 'Show archived projects',
  `pref_filter_own_leads` varchar(50) DEFAULT 'no' COMMENT 'Show only a users projects in the leads list',
  `pref_view_tasks_layout` varchar(50) DEFAULT 'kanban' COMMENT 'list|kanban',
  `pref_view_leads_layout` varchar(50) DEFAULT 'kanban' COMMENT 'list|kanban',
  `pref_view_projects_layout` varchar(50) DEFAULT 'list' COMMENT 'list|card|milestone|pipeline|category|gnatt',
  `pref_theme` varchar(100) DEFAULT 'default',
  `remember_token` varchar(150) DEFAULT NULL,
  `forgot_password_token` varchar(150) DEFAULT NULL COMMENT 'random token',
  `forgot_password_token_expiry` datetime DEFAULT NULL,
  `force_password_change` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `notifications_system` varchar(10) DEFAULT 'no' COMMENT 'no| yes | yes_email [everyone] NB: database defaults for all notifications are ''no'' actual values must be set in the settings config file',
  `notifications_new_project` varchar(10) DEFAULT 'no' COMMENT 'no| yes_email [client]',
  `notifications_projects_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email [everyone]',
  `notifications_billing_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email |[team]',
  `notifications_new_assignement` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email [team]',
  `notifications_leads_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email [team]',
  `notifications_tasks_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email  [everyone]',
  `notifications_tickets_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email  [everyone]',
  `notifications_reminders` varchar(10) DEFAULT 'yes_email' COMMENT 'yes_email | no',
  `thridparty_stripe_customer_id` varchar(150) DEFAULT NULL COMMENT 'optional - when customer pays via ',
  `dashboard_access` varchar(150) DEFAULT 'yes' COMMENT 'yes|no',
  `welcome_email_sent` varchar(150) DEFAULT 'no' COMMENT 'yes|no',
  `space_uniqueid` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='[truncate] except user id 0 & 1';

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `unique_id`, `created`, `updated`, `deleted`, `creatorid`, `email`, `password`, `first_name`, `last_name`, `phone`, `position`, `clientid`, `account_owner`, `primary_admin`, `avatar_directory`, `avatar_filename`, `type`, `status`, `role_id`, `last_seen`, `theme`, `last_ip_address`, `social_facebook`, `social_twitter`, `social_linkedin`, `social_github`, `social_dribble`, `pref_language`, `pref_email_notifications`, `pref_leftmenu_position`, `pref_statspanel_position`, `pref_filter_own_tasks`, `pref_filter_own_projects`, `pref_filter_show_archived_projects`, `pref_filter_show_archived_tasks`, `pref_filter_show_archived_leads`, `pref_filter_own_leads`, `pref_view_tasks_layout`, `pref_view_leads_layout`, `pref_view_projects_layout`, `pref_theme`, `remember_token`, `forgot_password_token`, `forgot_password_token_expiry`, `force_password_change`, `notifications_system`, `notifications_new_project`, `notifications_projects_activity`, `notifications_billing_activity`, `notifications_new_assignement`, `notifications_leads_activity`, `notifications_tasks_activity`, `notifications_tickets_activity`, `notifications_reminders`, `thridparty_stripe_customer_id`, `dashboard_access`, `welcome_email_sent`, `space_uniqueid`) VALUES
(1, '63f530a8217904.02016488', '2023-01-19 22:02:01', '2023-05-16 09:41:00', NULL, 1, 'admin@upskygroup.com', '$2y$10$FnKlCuJgj88UgapnKLVY4ehAm4xTUR22dW8q7CU9b0FAqU3vk9BgK', 'Upsky', 'Group', NULL, NULL, NULL, 'no', 'yes', NULL, NULL, 'team', 'active', 1, '2023-05-16 09:41:00', 'default', '116.58.26.194', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'open', 'open', 'no', 'no', 'no', 'yes', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'vwZNpypgGnfIe15AsvQlKHuDd0peD9QfzxvE2xkp92eCeOtuN9aLFfJWdNeb', NULL, NULL, 'no', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'email', NULL, 'yes', 'no', '63f53219158b19.52356059'),
(4, '63f656956612d2.01888565', '2023-02-22 18:53:25', '2023-02-22 18:53:36', '2023-02-22 18:53:36', 1, '', '', 'Elizabeth', 'Harrington', NULL, 'Doloribus ut dicta a', NULL, 'no', 'no', NULL, '', 'team', 'deleted', 0, NULL, 'default', NULL, NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'collapsed', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', NULL, NULL, NULL, 'yes', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f65695674b78.36819161'),
(3, '63f53219143ca8.28516688', '2023-02-21 22:05:29', '2023-02-22 20:13:57', '2023-02-22 20:13:57', 1, '', '', 'Hunter', 'Blevins', '+1 (544) 756-3773', 'Id veniam deserunt', NULL, 'no', 'no', NULL, '', 'team', 'deleted', 0, '2023-02-22 18:54:27', 'default', '111.119.187.34', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'open', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'kdAF7JkeeilTjjy4X47Rivqhra4DC9KqBapRgsWxkGn2kYelzbJCRq3HlQKk', NULL, NULL, 'no', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f53219158b19.52356051'),
(5, '63f66987eca797.23485686', '2023-02-22 20:14:15', '2023-02-22 20:24:39', '2023-02-22 20:24:39', 1, '', '', 'Herrod', 'Mcclain', NULL, 'VP', NULL, 'no', 'no', NULL, '', 'team', 'deleted', 0, NULL, 'default', NULL, NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'collapsed', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', NULL, NULL, NULL, 'yes', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f66987ee0fd9.65354187'),
(6, '63f66c034342a0.15898184', '2023-02-22 20:24:51', '2023-02-22 21:25:25', '2023-02-22 21:25:25', 1, '', '', 'Rama', 'Tyson', '+1 (644) 426-1706', 'Laborum do aliquam m', NULL, 'no', 'no', NULL, '', 'team', 'deleted', 0, NULL, 'default', NULL, NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'collapsed', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', NULL, NULL, NULL, 'yes', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f66c03453ff0.38874295'),
(7, '63f6858882d6c7.97709904', '2023-02-22 22:13:44', '2023-02-22 22:15:01', '2023-02-22 22:15:01', 1, '', '', 'Karina', 'Shelton', '+1 (429) 796-4447', 'Esse et aut quia dol', NULL, 'no', 'no', NULL, '', 'team', 'deleted', 0, NULL, 'default', NULL, NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'collapsed', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', NULL, NULL, NULL, 'yes', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f6858884e0b1.71664430'),
(8, '63f686476bd799.53476342', '2023-02-22 22:16:55', '2023-03-09 15:23:04', NULL, 1, 'mark.noah@upskygroup.com', '$2y$10$6hosO.Uk3FDD3NsOWss7OeL/k/OwugQlRKaBPvfJ6UNJShEIPVB.q', 'Mark', 'Noah', NULL, 'VP EDUCATION & TRAINING', NULL, 'no', 'no', NULL, NULL, 'team', 'active', 3, '2023-03-09 15:23:04', 'default', '73.37.131.5', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'open', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'qc3rOdehRZ2bGNfuBeoCsx6i7ICPaJb5qEbisTmcjQljtHwiLXyOOdjt0Y3q', NULL, NULL, 'no', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f686476d6908.52433543'),
(9, '63f68680df9651.05213537', '2023-02-22 22:17:52', '2023-06-09 19:28:33', NULL, 1, 'Wisdom.Primus@upskygroup.com', '$2y$10$QIbgOOongzWtM3gqLsy35ewA71aUZ7jGFg3mlqiYsdaPJfdSdW1f6', 'Wisdom', 'Primus', '(612)223-0300', 'C.E.O.', NULL, 'no', 'no', NULL, NULL, 'team', 'active', 1, '2023-06-09 19:28:33', 'default', '209.107.179.186', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'open', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'VHqEZdK5vAkL8A2x6pFvmZVxp24jEzi9UecdAqkz8C7Wit5uiVBH4Qt6W4bo', NULL, NULL, 'no', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f68680e13ed8.37002034'),
(10, '63f686b1c1b717.56906157', '2023-02-22 22:18:41', '2023-02-27 16:19:33', '2023-02-27 16:19:33', 1, '', '', 'Esther', 'dossou', NULL, 'VP COMMUNICATIONS', NULL, 'no', 'no', NULL, '', 'team', 'deleted', 0, NULL, 'default', NULL, NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'collapsed', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', NULL, NULL, NULL, 'yes', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f686b1c3a502.52781074'),
(16, '63fcca400a3b52.21203204', '2023-02-27 16:20:32', '2023-02-27 20:06:06', NULL, 1, 'esther.dossou@upskygroup.com', '$2y$10$RgbUl6CypZiwIC5JBq4WDuyJCMMA1w00iERoYmGueI3s/8lygcsja', 'Esther', 'Dossou', NULL, 'VP COMMUNICATIONS', NULL, 'no', 'no', NULL, NULL, 'team', 'active', 3, '2023-02-27 20:06:06', 'default', '172.59.220.248', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'collapsed', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'O3GTeoVf4cxyKHIKzR9ft4AzHBzM9MaQP5LwQh07xLHK7eLtNi6blo9OXFgM', NULL, NULL, 'no', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63fcca400cbe10.70721553'),
(11, '63f687000a9e35.13906696', '2023-02-22 22:20:00', '2023-06-08 12:37:12', NULL, 1, 'peter.ted@upskygroup.com', '$2y$10$pTxJJGr/gBW6BlN1/bmaeezDuN1bYsDp5hMUpewuMG9Xv50f3LQeu', 'Peter', 'Ted', NULL, 'VP SALES & BUSINESS CONTINUITY', NULL, 'no', 'no', NULL, NULL, 'team', 'active', 3, '2023-06-08 12:37:12', 'default', '172.56.90.166', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'open', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'DmluWtUmjU3XRsufCqM8WRm4zHyeqkdGusjrcISPYUjPBB98OXgk3cGkahMf', NULL, NULL, 'no', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f687000c5cc0.00098754'),
(12, '63f68811771029.20046843', '2023-02-22 22:24:33', '2023-02-22 22:51:11', '2023-02-22 22:51:11', 1, '', '', 'Wesley', 'Best', '+1 (628) 419-8154', 'Voluptatem velit mod', NULL, 'no', 'no', NULL, '', 'team', 'deleted', 0, '2023-02-22 22:50:51', 'default', '103.255.4.249', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'open', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'y2fLJsR3kQYL83XYGvQoqTZiMdDNBilmJMBhfFljYKxEzlzcMXmzGLgm6DrM', NULL, NULL, 'no', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f68811794b19.37119624'),
(13, '63f8c5950a4517.13493395', '2023-02-24 15:11:33', '2023-02-24 15:48:27', '2023-02-24 15:48:27', 1, '', '', 'John', 'Wyatt', '+1 (212) 606-4731', 'Developer', NULL, 'no', 'no', NULL, '', 'team', 'deleted', 0, '2023-02-24 15:45:13', 'default', '103.255.4.83', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'open', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'gFX2ytWr21rQkREbc6uIPj4vNb8CPyLKY00sZahUHCuRTRro6FXqmwI38rvV', NULL, NULL, 'no', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '63f8c5950bc546.10901023'),
(17, NULL, '2023-06-07 15:59:19', '2023-06-07 16:20:59', NULL, 0, 'awsdevops112@gmail.com', '$2y$10$rSEwi33Xj6pI/OZ94z4NQuuZGBDy3os3GIqFjvbjfHZt9QZmmiu2.', 'Sunil', 'kumar', NULL, NULL, 3, 'yes', 'no', NULL, NULL, 'client', 'active', 2, '2023-06-07 16:20:59', 'default', '49.207.220.93', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'open', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'vOWubAL8u0zAQ10dQePUzdcTYkrHysVvohpae3cMam1Gn1oBwchyVFqInuli', NULL, NULL, 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'no', 'no', 'yes_email', 'yes_email', 'yes_email', NULL, 'yes', 'no', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `webforms`
--

CREATE TABLE `webforms` (
  `webform_id` int(11) NOT NULL,
  `webform_uniqueid` varchar(100) DEFAULT NULL,
  `webform_created` datetime NOT NULL,
  `webform_updated` datetime NOT NULL,
  `webform_creatorid` int(11) NOT NULL,
  `webform_title` varchar(100) DEFAULT NULL,
  `webform_type` varchar(100) DEFAULT NULL COMMENT 'lead|etc',
  `webform_builder_payload` text DEFAULT NULL COMMENT 'json object from form builder',
  `webform_thankyou_message` text DEFAULT NULL,
  `webform_notify_assigned` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `webform_notify_admin` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `webform_submissions` tinyint(4) DEFAULT 0,
  `webform_user_captcha` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `webform_submit_button_text` varchar(100) DEFAULT NULL,
  `webform_background_color` varchar(100) DEFAULT '#FFFFFF' COMMENT 'white default',
  `webform_lead_title` varchar(100) DEFAULT NULL,
  `webform_status` varchar(100) DEFAULT 'enabled' COMMENT 'enabled|disabled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `webhooks`
--

CREATE TABLE `webhooks` (
  `webhooks_id` int(11) NOT NULL,
  `webhooks_created` datetime NOT NULL,
  `webhooks_updated` datetime NOT NULL,
  `webhooks_creatorid` int(11) DEFAULT 0,
  `webhooks_gateway_name` varchar(100) DEFAULT NULL COMMENT 'stripe|paypal|etc',
  `webhooks_type` varchar(100) DEFAULT NULL COMMENT 'type of call, as sent by gateway',
  `webhooks_payment_type` varchar(30) DEFAULT NULL COMMENT 'onetime|subscription',
  `webhooks_payment_amount` decimal(10,2) DEFAULT NULL COMMENT '(optional)',
  `webhooks_payment_transactionid` varchar(150) DEFAULT NULL COMMENT 'payment transaction id',
  `webhooks_matching_reference` varchar(100) DEFAULT NULL COMMENT 'e.g. Stripe (checkout session id) | Paypal ( random string) that is used to match the webhook/ipn to the initial payment_session',
  `webhooks_matching_attribute` varchar(100) DEFAULT NULL COMMENT 'mainly used to record what is happening with a subscription (e.g cancelled|renewed)',
  `webhooks_payload` text DEFAULT NULL COMMENT '(optional) json payload',
  `webhooks_comment` text DEFAULT NULL COMMENT '(optional)',
  `webhooks_started_at` datetime DEFAULT NULL COMMENT 'when the cronjob started this webhook',
  `webhooks_completed_at` datetime DEFAULT NULL COMMENT 'when the cronjob completed this webhook',
  `webhooks_attempts` tinyint(4) DEFAULT 0 COMMENT 'the number of times this webhook has been attempted',
  `webhooks_status` varchar(20) DEFAULT 'new' COMMENT 'new | processing | failed | completed   (set to processing by the cronjob, to avoid duplicate processing)'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Record all actionable webhooks, for later execution by a cronjob';

-- --------------------------------------------------------

--
-- Table structure for table `webmail_templates`
--

CREATE TABLE `webmail_templates` (
  `webmail_template_id` int(11) NOT NULL,
  `webmail_template_created` datetime NOT NULL,
  `webmail_template_updated` datetime NOT NULL,
  `webmail_template_creatorid` int(11) NOT NULL,
  `webmail_template_name` varchar(150) DEFAULT NULL,
  `webmail_template_body` text DEFAULT NULL,
  `webmail_template_type` text DEFAULT NULL COMMENT 'clients|leads'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`attachment_id`);

--
-- Indexes for table `automation_assigned`
--
ALTER TABLE `automation_assigned`
  ADD PRIMARY KEY (`automationassigned_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `category_type` (`category_type`),
  ADD KEY `category_creatorid` (`category_creatorid`);

--
-- Indexes for table `category_users`
--
ALTER TABLE `category_users`
  ADD PRIMARY KEY (`categoryuser_id`);

--
-- Indexes for table `checklists`
--
ALTER TABLE `checklists`
  ADD PRIMARY KEY (`checklist_id`),
  ADD KEY `checklistresource_type` (`checklistresource_type`),
  ADD KEY `checklistresource_id` (`checklistresource_id`),
  ADD KEY `checklist_creatorid` (`checklist_creatorid`),
  ADD KEY `checklist_clientid` (`checklist_clientid`),
  ADD KEY `checklist_status` (`checklist_status`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`client_id`),
  ADD KEY `client_creatorid` (`client_creatorid`),
  ADD KEY `client_categoryid` (`client_categoryid`),
  ADD KEY `client_status` (`client_status`),
  ADD KEY `client_created_from_leadid` (`client_created_from_leadid`),
  ADD KEY `client_app_modules` (`client_app_modules`),
  ADD KEY `client_importid` (`client_importid`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `comment_creatorid` (`comment_creatorid`),
  ADD KEY `comment_clientid` (`comment_clientid`),
  ADD KEY `commentresource_type` (`commentresource_type`),
  ADD KEY `commentresource_id` (`commentresource_id`);

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`doc_id`);

--
-- Indexes for table `contract_templates`
--
ALTER TABLE `contract_templates`
  ADD PRIMARY KEY (`contract_template_id`),
  ADD KEY `contract_template_creatorid` (`contract_template_creatorid`);

--
-- Indexes for table `cs_affiliate_earnings`
--
ALTER TABLE `cs_affiliate_earnings`
  ADD PRIMARY KEY (`cs_affiliate_earning_id`);

--
-- Indexes for table `cs_affiliate_projects`
--
ALTER TABLE `cs_affiliate_projects`
  ADD PRIMARY KEY (`cs_affiliate_project_id`);

--
-- Indexes for table `cs_events`
--
ALTER TABLE `cs_events`
  ADD PRIMARY KEY (`cs_event_id`);

--
-- Indexes for table `customfields`
--
ALTER TABLE `customfields`
  ADD PRIMARY KEY (`customfields_id`);

--
-- Indexes for table `email_log`
--
ALTER TABLE `email_log`
  ADD PRIMARY KEY (`emaillog_id`);

--
-- Indexes for table `email_queue`
--
ALTER TABLE `email_queue`
  ADD PRIMARY KEY (`emailqueue_id`),
  ADD KEY `emailqueue_type` (`emailqueue_type`),
  ADD KEY `emailqueue_resourcetype` (`emailqueue_resourcetype`),
  ADD KEY `emailqueue_resourceid` (`emailqueue_resourceid`),
  ADD KEY `emailqueue_pdf_resource_type` (`emailqueue_pdf_resource_type`),
  ADD KEY `emailqueue_pdf_resource_id` (`emailqueue_pdf_resource_id`),
  ADD KEY `emailqueue_status` (`emailqueue_status`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`emailtemplate_id`),
  ADD KEY `emailtemplate_type` (`emailtemplate_type`),
  ADD KEY `emailtemplate_category` (`emailtemplate_category`);

--
-- Indexes for table `estimates`
--
ALTER TABLE `estimates`
  ADD PRIMARY KEY (`bill_estimateid`),
  ADD KEY `bill_clientid` (`bill_clientid`),
  ADD KEY `bill_creatorid` (`bill_creatorid`),
  ADD KEY `bill_categoryid` (`bill_categoryid`),
  ADD KEY `bill_status` (`bill_status`),
  ADD KEY `bill_type` (`bill_type`),
  ADD KEY `bill_visibility` (`bill_visibility`),
  ADD KEY `bill_viewed_by_client` (`bill_viewed_by_client`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `eventresource_type` (`eventresource_type`),
  ADD KEY `eventresource_id` (`eventresource_id`),
  ADD KEY `event_creatorid` (`event_creatorid`),
  ADD KEY `event_type` (`event_item`),
  ADD KEY `event_parent_type` (`event_parent_type`),
  ADD KEY `event_parent_id` (`event_parent_id`),
  ADD KEY `event_item_id` (`event_item_id`);

--
-- Indexes for table `events_tracking`
--
ALTER TABLE `events_tracking`
  ADD PRIMARY KEY (`eventtracking_id`),
  ADD KEY `eventtracking_userid` (`eventtracking_userid`),
  ADD KEY `eventtracking_eventid` (`eventtracking_eventid`),
  ADD KEY `eventtracking_status` (`eventtracking_status`),
  ADD KEY `parent_type` (`parent_type`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `resource_type` (`resource_type`),
  ADD KEY `resource_id` (`resource_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`),
  ADD KEY `expense_clientid` (`expense_clientid`),
  ADD KEY `expense_projectid` (`expense_projectid`),
  ADD KEY `expense_creatorid` (`expense_creatorid`),
  ADD KEY `expense_billable` (`expense_billable`),
  ADD KEY `expense_billing_status` (`expense_billing_status`),
  ADD KEY `expense_billable_invoiceid` (`expense_billable_invoiceid`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`file_id`),
  ADD KEY `file_creatorid` (`file_creatorid`),
  ADD KEY `file_clientid` (`file_clientid`),
  ADD KEY `fileresource_type` (`fileresource_type`),
  ADD KEY `fileresource_id` (`fileresource_id`);

--
-- Indexes for table `file_folders`
--
ALTER TABLE `file_folders`
  ADD PRIMARY KEY (`filefolder_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`bill_invoiceid`),
  ADD KEY `invoice_clientid` (`bill_clientid`),
  ADD KEY `invoice_projectid` (`bill_projectid`),
  ADD KEY `invoice_creatorid` (`bill_creatorid`),
  ADD KEY `invoice_categoryid` (`bill_categoryid`),
  ADD KEY `invoice_status` (`bill_status`),
  ADD KEY `invoice_recurring` (`bill_recurring`),
  ADD KEY `bill_type` (`bill_type`),
  ADD KEY `bill_invoice_type` (`bill_invoice_type`),
  ADD KEY `bill_subscriptionid` (`bill_subscriptionid`),
  ADD KEY `bill_recurring_parent_id` (`bill_recurring_parent_id`),
  ADD KEY `bill_visibility` (`bill_visibility`),
  ADD KEY `bill_cron_status` (`bill_cron_status`),
  ADD KEY `bill_viewed_by_client` (`bill_viewed_by_client`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `item_categoryid` (`item_categoryid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`(191));

--
-- Indexes for table `kb_categories`
--
ALTER TABLE `kb_categories`
  ADD PRIMARY KEY (`kbcategory_id`);

--
-- Indexes for table `knowledgebase`
--
ALTER TABLE `knowledgebase`
  ADD PRIMARY KEY (`knowledgebase_id`),
  ADD KEY `knowledgebase_categoryid` (`knowledgebase_categoryid`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`lead_id`),
  ADD KEY `lead_creatorid` (`lead_creatorid`),
  ADD KEY `lead_categoryid` (`lead_categoryid`),
  ADD KEY `lead_email` (`lead_email`),
  ADD KEY `lead_status` (`lead_status`),
  ADD KEY `lead_converted_clientid` (`lead_converted_clientid`),
  ADD KEY `lead_active_state` (`lead_active_state`),
  ADD KEY `lead_visibility` (`lead_visibility`);

--
-- Indexes for table `leads_assigned`
--
ALTER TABLE `leads_assigned`
  ADD PRIMARY KEY (`leadsassigned_id`),
  ADD KEY `leadsassigned_userid` (`leadsassigned_userid`),
  ADD KEY `leadsassigned_leadid` (`leadsassigned_leadid`);

--
-- Indexes for table `leads_sources`
--
ALTER TABLE `leads_sources`
  ADD PRIMARY KEY (`leadsources_id`);

--
-- Indexes for table `leads_status`
--
ALTER TABLE `leads_status`
  ADD PRIMARY KEY (`leadstatus_id`);

--
-- Indexes for table `lineitems`
--
ALTER TABLE `lineitems`
  ADD PRIMARY KEY (`lineitem_id`),
  ADD KEY `lineitemresource_linked_type` (`lineitemresource_linked_type`),
  ADD KEY `lineitemresource_linked_id` (`lineitemresource_linked_id`),
  ADD KEY `lineitemresource_type` (`lineitemresource_type`),
  ADD KEY `lineitemresource_id` (`lineitemresource_id`),
  ADD KEY `lineitem_type` (`lineitem_type`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `message_status` (`message_status`),
  ADD KEY `message_creatorid` (`message_creatorid`),
  ADD KEY `message_creator_uniqueid` (`message_creator_uniqueid`),
  ADD KEY `message_target_uniqueid` (`message_target_uniqueid`),
  ADD KEY `message_type` (`message_type`),
  ADD KEY `message_source` (`message_source`),
  ADD KEY `message_target` (`message_target`);

--
-- Indexes for table `messages_tracking`
--
ALTER TABLE `messages_tracking`
  ADD PRIMARY KEY (`messagestracking_id`),
  ADD KEY `messagetracking_target` (`messagestracking_target`),
  ADD KEY `messagestracking_target` (`messagestracking_target`),
  ADD KEY `messagestracking_user_unique_id` (`messagestracking_user_unique_id`);

--
-- Indexes for table `milestones`
--
ALTER TABLE `milestones`
  ADD PRIMARY KEY (`milestone_id`),
  ADD KEY `milestone_projectid` (`milestone_projectid`),
  ADD KEY `milestone_creatorid` (`milestone_creatorid`),
  ADD KEY `milestone_type` (`milestone_type`);

--
-- Indexes for table `milestone_categories`
--
ALTER TABLE `milestone_categories`
  ADD PRIMARY KEY (`milestonecategory_id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`note_id`),
  ADD KEY `note_creatorid` (`note_creatorid`),
  ADD KEY `noteresource_type` (`noteresource_type`),
  ADD KEY `noteresource_id` (`noteresource_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `payment_creatorid` (`payment_creatorid`),
  ADD KEY `payment_invoiceid` (`payment_invoiceid`),
  ADD KEY `payment_clientid` (`payment_clientid`),
  ADD KEY `payment_projectid` (`payment_projectid`),
  ADD KEY `payment_gateway` (`payment_gateway`),
  ADD KEY `payment_subscriptionid` (`payment_subscriptionid`);

--
-- Indexes for table `payment_sessions`
--
ALTER TABLE `payment_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `session_gateway_name` (`session_gateway_name`),
  ADD KEY `session_gateway_ref` (`session_gateway_ref`);

--
-- Indexes for table `product_tasks`
--
ALTER TABLE `product_tasks`
  ADD PRIMARY KEY (`product_task_id`);

--
-- Indexes for table `product_tasks_dependencies`
--
ALTER TABLE `product_tasks_dependencies`
  ADD PRIMARY KEY (`product_task_dependency_id`),
  ADD KEY `product_task_dependency_taskid` (`product_task_dependency_taskid`),
  ADD KEY `product_task_dependency_blockerid` (`product_task_dependency_blockerid`),
  ADD KEY `product_task_dependency_type` (`product_task_dependency_type`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`project_id`),
  ADD KEY `FK_projects` (`project_clientid`),
  ADD KEY `project_creatorid` (`project_creatorid`),
  ADD KEY `project_categoryid` (`project_categoryid`),
  ADD KEY `project_status` (`project_status`),
  ADD KEY `project_visibility` (`project_visibility`),
  ADD KEY `project_type` (`project_type`),
  ADD KEY `project_active_state` (`project_active_state`),
  ADD KEY `project_billing_type` (`project_billing_type`),
  ADD KEY `clientperm_tasks_view` (`clientperm_tasks_view`),
  ADD KEY `project_progress_manually` (`project_progress_manually`),
  ADD KEY `clientperm_tasks_collaborate` (`clientperm_tasks_collaborate`),
  ADD KEY `clientperm_tasks_create` (`clientperm_tasks_create`),
  ADD KEY `clientperm_timesheets_view` (`clientperm_timesheets_view`),
  ADD KEY `clientperm_expenses_view` (`clientperm_expenses_view`),
  ADD KEY `assignedperm_milestone_manage` (`assignedperm_milestone_manage`),
  ADD KEY `assignedperm_tasks_collaborate` (`assignedperm_tasks_collaborate`);

--
-- Indexes for table `projects_assigned`
--
ALTER TABLE `projects_assigned`
  ADD PRIMARY KEY (`projectsassigned_id`),
  ADD KEY `projectsassigned_projectid` (`projectsassigned_projectid`),
  ADD KEY `projectsassigned_userid` (`projectsassigned_userid`);

--
-- Indexes for table `projects_manager`
--
ALTER TABLE `projects_manager`
  ADD PRIMARY KEY (`projectsmanager_id`),
  ADD KEY `projectsmanager_userid` (`projectsmanager_userid`),
  ADD KEY `projectsmanager_projectid` (`projectsmanager_projectid`);

--
-- Indexes for table `proposals`
--
ALTER TABLE `proposals`
  ADD PRIMARY KEY (`doc_id`);

--
-- Indexes for table `proposal_templates`
--
ALTER TABLE `proposal_templates`
  ADD PRIMARY KEY (`proposal_template_id`),
  ADD KEY `proposal_template_creatorid` (`proposal_template_creatorid`);

--
-- Indexes for table `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`reminder_id`),
  ADD KEY `reminderresource_type` (`reminderresource_type`),
  ADD KEY `reminderresource_id` (`reminderresource_id`),
  ADD KEY `reminder_status` (`reminder_status`),
  ADD KEY `reminder_sent` (`reminder_sent`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD KEY `role_type` (`role_type`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`settings_id`);

--
-- Indexes for table `settings2`
--
ALTER TABLE `settings2`
  ADD PRIMARY KEY (`settings2_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`subscription_id`),
  ADD KEY `subscription_gateway_id` (`subscription_gateway_id`),
  ADD KEY `subscription_gateway_product` (`subscription_gateway_product`),
  ADD KEY `subscription_gateway_price` (`subscription_gateway_price`),
  ADD KEY `subscription_creatorid` (`subscription_creatorid`),
  ADD KEY `subscription_clientid` (`subscription_clientid`),
  ADD KEY `subscription_projectid` (`subscription_projectid`),
  ADD KEY `subscription_categoryid` (`subscription_categoryid`),
  ADD KEY `subscription_status` (`subscription_status`),
  ADD KEY `subscription_visibility` (`subscription_visibility`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tag_id`),
  ADD KEY `tag_creatorid` (`tag_creatorid`),
  ADD KEY `tagresource_type` (`tagresource_type`),
  ADD KEY `tag_visibility` (`tag_visibility`),
  ADD KEY `tagresource_id` (`tagresource_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`task_id`),
  ADD KEY `task_creatorid` (`task_creatorid`),
  ADD KEY `task_clientid` (`task_clientid`),
  ADD KEY `task_billable` (`task_billable`),
  ADD KEY `task_milestoneid` (`task_milestoneid`),
  ADD KEY `task_priority` (`task_priority`),
  ADD KEY `taskresource_id` (`task_projectid`),
  ADD KEY `task_visibility` (`task_visibility`),
  ADD KEY `task_client_visibility` (`task_client_visibility`),
  ADD KEY `task_importid` (`task_importid`),
  ADD KEY `task_active_state` (`task_active_state`),
  ADD KEY `task_billable_status` (`task_billable_status`),
  ADD KEY `task_billable_invoiceid` (`task_billable_invoiceid`),
  ADD KEY `task_billable_lineitemid` (`task_billable_lineitemid`),
  ADD KEY `task_recurring` (`task_recurring`),
  ADD KEY `task_recurring_parent_id` (`task_recurring_parent_id`),
  ADD KEY `task_recurring_finished` (`task_recurring_finished`);

--
-- Indexes for table `tasks_assigned`
--
ALTER TABLE `tasks_assigned`
  ADD PRIMARY KEY (`tasksassigned_id`),
  ADD KEY `tasksassigned_taskid` (`tasksassigned_taskid`),
  ADD KEY `tasksassigned_userid` (`tasksassigned_userid`);

--
-- Indexes for table `tasks_dependencies`
--
ALTER TABLE `tasks_dependencies`
  ADD PRIMARY KEY (`tasksdependency_id`),
  ADD KEY `tasksdependency_projectid` (`tasksdependency_projectid`),
  ADD KEY `tasksdependency_clientid` (`tasksdependency_clientid`),
  ADD KEY `tasksdependency_taskid` (`tasksdependency_taskid`),
  ADD KEY `tasksdependency_blockerid` (`tasksdependency_blockerid`),
  ADD KEY `tasksdependency_type` (`tasksdependency_type`);

--
-- Indexes for table `tasks_status`
--
ALTER TABLE `tasks_status`
  ADD PRIMARY KEY (`taskstatus_id`);

--
-- Indexes for table `tax`
--
ALTER TABLE `tax`
  ADD PRIMARY KEY (`tax_id`),
  ADD KEY `taxresource_type` (`taxresource_type`),
  ADD KEY `taxresource_id` (`taxresource_id`);

--
-- Indexes for table `taxrates`
--
ALTER TABLE `taxrates`
  ADD PRIMARY KEY (`taxrate_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `ticket_creatorid` (`ticket_creatorid`),
  ADD KEY `ticket_categoryid` (`ticket_categoryid`),
  ADD KEY `ticket_clientid` (`ticket_clientid`),
  ADD KEY `ticket_projectid` (`ticket_projectid`),
  ADD KEY `ticket_priority` (`ticket_priority`),
  ADD KEY `ticket_status` (`ticket_status`);

--
-- Indexes for table `tickets_status`
--
ALTER TABLE `tickets_status`
  ADD PRIMARY KEY (`ticketstatus_id`);

--
-- Indexes for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  ADD PRIMARY KEY (`ticketreply_id`),
  ADD KEY `ticketreply_creatorid` (`ticketreply_creatorid`),
  ADD KEY `ticketreply_ticketid` (`ticketreply_ticketid`),
  ADD KEY `ticketreply_clientid` (`ticketreply_clientid`);

--
-- Indexes for table `timelines`
--
ALTER TABLE `timelines`
  ADD PRIMARY KEY (`timeline_id`),
  ADD KEY `timeline_eventid` (`timeline_eventid`),
  ADD KEY `timeline_resourcetype` (`timeline_resourcetype`),
  ADD KEY `timeline_resourceid` (`timeline_resourceid`);

--
-- Indexes for table `timers`
--
ALTER TABLE `timers`
  ADD PRIMARY KEY (`timer_id`),
  ADD KEY `timer_creatorid` (`timer_creatorid`),
  ADD KEY `timer_taskid` (`timer_taskid`),
  ADD KEY `timer_projectid` (`timer_projectid`),
  ADD KEY `timer_clientid` (`timer_clientid`),
  ADD KEY `timer_status` (`timer_status`),
  ADD KEY `timer_billing_status` (`timer_billing_status`),
  ADD KEY `timer_billing_invoiceid` (`timer_billing_invoiceid`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_id`);

--
-- Indexes for table `updates`
--
ALTER TABLE `updates`
  ADD PRIMARY KEY (`update_id`);

--
-- Indexes for table `updating`
--
ALTER TABLE `updating`
  ADD PRIMARY KEY (`updating_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `primary_contact` (`account_owner`),
  ADD KEY `type` (`type`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `email` (`email`),
  ADD KEY `dashboard_access` (`dashboard_access`);

--
-- Indexes for table `webforms`
--
ALTER TABLE `webforms`
  ADD PRIMARY KEY (`webform_id`);

--
-- Indexes for table `webhooks`
--
ALTER TABLE `webhooks`
  ADD PRIMARY KEY (`webhooks_id`);

--
-- Indexes for table `webmail_templates`
--
ALTER TABLE `webmail_templates`
  ADD PRIMARY KEY (`webmail_template_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `automation_assigned`
--
ALTER TABLE `automation_assigned`
  MODIFY `automationassigned_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[do not truncate] - only delete where category_system_default = no', AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `category_users`
--
ALTER TABLE `category_users`
  MODIFY `categoryuser_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `checklists`
--
ALTER TABLE `checklists`
  MODIFY `checklist_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contract_templates`
--
ALTER TABLE `contract_templates`
  MODIFY `contract_template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `cs_affiliate_earnings`
--
ALTER TABLE `cs_affiliate_earnings`
  MODIFY `cs_affiliate_earning_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cs_affiliate_projects`
--
ALTER TABLE `cs_affiliate_projects`
  MODIFY `cs_affiliate_project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `cs_events`
--
ALTER TABLE `cs_events`
  MODIFY `cs_event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customfields`
--
ALTER TABLE `customfields`
  MODIFY `customfields_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=481;

--
-- AUTO_INCREMENT for table `email_log`
--
ALTER TABLE `email_log`
  MODIFY `emaillog_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `email_queue`
--
ALTER TABLE `email_queue`
  MODIFY `emailqueue_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `emailtemplate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'x', AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `estimates`
--
ALTER TABLE `estimates`
  MODIFY `bill_estimateid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `events_tracking`
--
ALTER TABLE `events_tracking`
  MODIFY `eventtracking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `file_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_folders`
--
ALTER TABLE `file_folders`
  MODIFY `filefolder_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `bill_invoiceid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kb_categories`
--
ALTER TABLE `kb_categories`
  MODIFY `kbcategory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `knowledgebase`
--
ALTER TABLE `knowledgebase`
  MODIFY `knowledgebase_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `lead_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads_assigned`
--
ALTER TABLE `leads_assigned`
  MODIFY `leadsassigned_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads_sources`
--
ALTER TABLE `leads_sources`
  MODIFY `leadsources_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads_status`
--
ALTER TABLE `leads_status`
  MODIFY `leadstatus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `lineitems`
--
ALTER TABLE `lineitems`
  MODIFY `lineitem_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `messages_tracking`
--
ALTER TABLE `messages_tracking`
  MODIFY `messagestracking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `milestones`
--
ALTER TABLE `milestones`
  MODIFY `milestone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `milestone_categories`
--
ALTER TABLE `milestone_categories`
  MODIFY `milestonecategory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[truncate]';

--
-- AUTO_INCREMENT for table `payment_sessions`
--
ALTER TABLE `payment_sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_tasks`
--
ALTER TABLE `product_tasks`
  MODIFY `product_task_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_tasks_dependencies`
--
ALTER TABLE `product_tasks_dependencies`
  MODIFY `product_task_dependency_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `projects_assigned`
--
ALTER TABLE `projects_assigned`
  MODIFY `projectsassigned_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[truncate]';

--
-- AUTO_INCREMENT for table `projects_manager`
--
ALTER TABLE `projects_manager`
  MODIFY `projectsmanager_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proposals`
--
ALTER TABLE `proposals`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proposal_templates`
--
ALTER TABLE `proposal_templates`
  MODIFY `proposal_template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reminders`
--
ALTER TABLE `reminders`
  MODIFY `reminder_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `settings_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `settings2`
--
ALTER TABLE `settings2`
  MODIFY `settings2_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `subscription_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `task_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks_assigned`
--
ALTER TABLE `tasks_assigned`
  MODIFY `tasksassigned_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[truncate]';

--
-- AUTO_INCREMENT for table `tasks_dependencies`
--
ALTER TABLE `tasks_dependencies`
  MODIFY `tasksdependency_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks_status`
--
ALTER TABLE `tasks_status`
  MODIFY `taskstatus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tax`
--
ALTER TABLE `tax`
  MODIFY `tax_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxrates`
--
ALTER TABLE `taxrates`
  MODIFY `taxrate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets_status`
--
ALTER TABLE `tickets_status`
  MODIFY `ticketstatus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  MODIFY `ticketreply_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timelines`
--
ALTER TABLE `timelines`
  MODIFY `timeline_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timers`
--
ALTER TABLE `timers`
  MODIFY `timer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `updates`
--
ALTER TABLE `updates`
  MODIFY `update_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `updating`
--
ALTER TABLE `updating`
  MODIFY `updating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `webforms`
--
ALTER TABLE `webforms`
  MODIFY `webform_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `webhooks`
--
ALTER TABLE `webhooks`
  MODIFY `webhooks_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `webmail_templates`
--
ALTER TABLE `webmail_templates`
  MODIFY `webmail_template_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
