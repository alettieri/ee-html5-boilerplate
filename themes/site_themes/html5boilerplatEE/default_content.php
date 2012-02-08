<?php

$original_url = 'http://html5boilerplatEE.kc-webdesign.co.uk';
$tables = array(
		'exp_categories',
		'exp_category_fields',
		'exp_category_field_data',
		'exp_category_groups',
		'exp_category_posts',
		'exp_channels',
		'exp_channel_data',
		'exp_channel_fields',
		'exp_channel_titles',
		'exp_comments',
		'exp_fieldtypes',
		'exp_field_formatting',
		'exp_field_groups',
		'exp_global_variables',
		'exp_relationships',
		'exp_snippets',
		'exp_statuses',
		'exp_status_groups',
		'exp_templates',
		'exp_template_groups',
		'exp_upload_prefs'
	);

$thepath = './themes/site_themes/html5boilerplatEE/template.sql';
$template = file_get_contents($thepath);

$pattern = "/^(CREATE[ A-Z]+`(".implode('|', $tables).")`.*);/Ums";
preg_match_all($pattern, $template, $matches);

foreach($matches[2] AS $table)
{
	$this->db->query("DROP TABLE ".$table);
}

foreach($matches[1] AS $sql)
{
	$this->db->query($sql);
}


$pattern = "/(^INSERT[ A-Z]+`(".implode('|', $tables).")`.*);\\n/Ums";
preg_match_all($pattern, $template, $matches);

foreach ($matches[1] AS $sql)
{
	$sql = str_replace($original_url, $this->userdata['site_url'], $sql);
	$this->db->query($sql);
}