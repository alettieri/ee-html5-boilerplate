<?php

// --------------------------------------------------------------------

$required_modules = array('email', 'rss', 'comment', 'search', 'mailinglist');

// --------------------------------------------------------------------

$default_group = 'site';


/**
 * Default Preferences and Access Permissions for all Templates
 */

$default_template_preferences = array('caching'			=> 'n',
									  'cache_refresh'	=> 0,
									  'php_parsing'		=> 'none', // none, input, output
									  );

// Uses the Labels of the default four groups, as it is easier than the Group IDs, let's be honest
$default_template_access = array('Banned' 	=> 'n',
								 'Guests'	=> 'y',
								 'Pending'	=> 'y');

// --------------------------------------------------------------------

/**
 * Template Specific Preferences and Settings
 */


$no_access = array(
					'Banned'	=> 'n',
					'Guests'	=> 'n',
					'Members'	=> 'n',
					'Pending'	=> 'n'
					);

$template_access['includes']['index'] = $no_access;
$template_access['search']['index'] = $no_access;
				
