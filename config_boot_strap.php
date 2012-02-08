<?php

/**
* Custom configuration bootsrtap file for ExpressionEngine
*
* Place config.php in your site root
* Add require(realpath(dirname(__FILE__) . '/../../config.php')); to the bottom of system/expressionengine/config/config.php
* Add require(realpath(dirname(__FILE__) . '/../../config.php')); to the bottom of system/expressionengine/config/database.php
* If you have moved your site root you'll need to update the require_once path
*
* Also includes custom DB configuration file based on your environment
*
* Posiible DB configuration options
*
* $env_db_config['hostname'] = "";
* $env_db_config['username'] = "";
* $env_db_config['password'] = "";
* $env_db_config['database'] = "";
* 
* @author Leevi Graham <http://leevigraham.com>
* @link http://expressionengine.com/index.php?affiliate=leevigraham&page=wiki/EE_2_Config_Overrides/
* @link http://eeinsider.com/blog/eeci-2010-how-erskine-rolls-with-ee/ - Hat tip to: Erskine from EECI2010 Preso
* @version 1.5
*
* == Changelog ==
*
* Version 1.1
*     - Changed 'gv_' to 'global:'
*     - Added {global:cm_subscriber_list_slug} for campaignmonitor.com integration
*     - Added {global:google_analytics_key} for Google Analytics integration
*     - Make $_POST array available as global vars with 'post:' prefix
*     - Make $_GET array available as global vars with 'get:' prefix
*     - Added more inline commenting
*     - Swapped order of system config and global vars
*
* Version 1.2
*     - Removed $_GET and $_POST parsing. You should use Mo Variables instead. https://github.com/rsanchez/mo_variables
*
* Version 1.3
*     - Added encryption key
*
* Version 1.4
*     - Updated NSM .htaccess path. v1.1.0 of the addon requires the config setting to be an array
*
* Version 1.5
*     - Added global:404_entry_id
*/

// Setup the environment
if( !defined( 'NSM_ENV' ) ) {
    define('NSM_SERVER_NAME', $_SERVER['SERVER_NAME']);
    
    define('NSM_BASEPATH', dirname(__FILE__));
    define('NSM_SYSTEM_FOLDER', 'system');

    // Set the environment

    if ( strstr( NSM_SERVER_NAME, 'local.' ) ) define('NSM_ENV', 'local'); /** http://local.ee-html5-boilerplate.com **/
    elseif( strstr( NSM_SERVER_NAME, 'dev.' ) ) define('NSM_ENV', 'dev'); /** http://dev.ee-html5-boilerplate.com **/
    elseif( strstr( NSM_SERVER_NAME, 'stage.' ) ) define('NSM_ENV', 'staging'); /** http://staging.ee-html5-boilerplate.com **/
    else define('NSM_ENV', 'production');   /** http://ee-html5-boilerplate.com **/


    define('NSM_SITE_URL', 'http://'.NSM_SERVER_NAME); //SITE URL with or without www.
}

// Define the environment settings

$env_config = array();
$env_db_config = array();
$env_global_vars = array();


// Set the environmental config and global vars
if (NSM_ENV == 'local') { 
    $env_db_config = array(
        'hostname' => '',
        'username' => '',
        'password' => '',
        'database' => ''
    );
    
    $env_global_vars = array(
        'global:cm_subscriber_list_slug' => '',
        'global:google_analytics_key' => '########-#'
    );
}
elseif(NSM_ENV == 'dev') {
    $env_db_config = array(
        'hostname' => '',
        'username' => '',
        'password' => '',
        'database' => ''
    );
    $env_global_vars = array(
        'global:cm_subscriber_list_slug' => '',
        'global:google_analytics_key' => '########-#'
    );
}
elseif(NSM_ENV == 'staging') {
    $env_db_config = array(
        'hostname' => '',
        'database' => '',
        'username' => '',
        'password' => ''
    );
    $env_global_vars = array(
        'global:cm_subscriber_list_slug' => '',
        'global:google_analytics_key' => '########-#'
    );
}
else {
    $env_global_vars = array(
        'global:cm_subscriber_list_slug' => '',
        'global:google_analytics_key' => ''
    );
}



// Config bootsrap... GO!
if(isset($config)) {

    /**
    * Custom global variables
    *
    * This is a bit sucky as they are pulled straight from the $assign_to_config array.
    * See EE_Config.php around line 90 or search for: 'global $assign_to_config;'
    * Output the global vars in your template with: 
    * <?php $EE = get_instance(); print('<pre><code>'.print_r($EE->config->_global_vars, TRUE) . '</code></pre>');  ?>
    */
    $default_global_vars = array(
        // General - Set the production environment so we can test / show / hide components
        'global:env'                    => NSM_ENV,

        // Tag parameters - Short hand tag params
        'global:param_disable_default'  => 'disable="categories|pagination|member_data"',
        'global:param_disable_all'      => 'disable="categories|custom_fields|member_data|pagination"',
        'global:param_cache_param'      => 'cache="yes" refresh="10"',
        '-global:param_cache_param'     => '-cache="yes" refresh="10"', // disable by adding a '-' to the front of the global

        // Date and time - Short hand date and time
        'global:date_time'          => '%g:%i %a',
        'global:date_short'         => '%F %d, %Y',
        'global:date_full'          => '%F %d %Y, %g:%i %a',

        /**
         * Theme - URL to theme assets
         * Example: <script src="{global:theme_url}/js/libs/modernizr-1.6.min.js"></script>
         */
        'global:theme_url'          => NSM_SITE_URL . '/themes/site_themes/ee-html5-boilerplate',
        
        /**
         * CampaignMonitor - Slug for CM signup forms
         * Example: <form action="http://newism.createsend.com/t/y/s/{global:cm_subscriber_list_slug}/" method="post">...</form>
         */
        'global:cm_subscriber_list_slug' => false,

        /**
         * Google Analytics Key
         * Example: 
         *      <script type="text/javascript"> 
         *          var _gaq = _gaq || []; 
         *          _gaq.push(['_setAccount', 'UA-{global:google_analytics_key}']);  
         *          _gaq.push(['_trackPageview']);
         *      </script>
         */
        'global:google_analytics_key' => false,

        // NSM Gravatar
        'global:nsm_gravatar_default_avatar' => NSM_SITE_URL . '/uploads/member/avatars/default.png',
 	
        // Store the entry_id for the 404 page
	'global:404_entry_id' => '2',
  );

    // Make this global so we can add some of the config variables here
    global $assign_to_config;

    if(!isset($assign_to_config['global_vars']))
        $assign_to_config['global_vars'] = array();

    $assign_to_config['global_vars'] = array_merge($assign_to_config['global_vars'], $default_global_vars, $env_global_vars);
        
    /**
     * Config. This shouldn't have to be changed if you're using the Newism EE2 template.
     */
    $default_config = array(

        // General preferences
        'license_number' => '',
        'site_index' => '',
        'admin_session_type' => 'cs',
        'new_version_check' => 'y',
        'doc_url' => 'http://expressionengine.com/user_guide/',

        'site_url' => NSM_SITE_URL,
        'cp_url' => NSM_SITE_URL.'/'.NSM_SYSTEM_FOLDER.'/index.php',

        // Set this so we can use query strings
        'uri_protocol' => 'PATH_INFO',

        // Datbase preferences
        'db_debug' => 'n',
        'pconnect' => 'n',
        'enable_db_caching' => 'n',

        // Site preferences
        // Some of these preferences might actually need to be set in the index.php files.
        // Not sure which ones yet, I'll figure that out when I have my first MSM site.
        'is_site_on' => 'y',
        'site_404' => 'site/four04',

        'webmaster_email' => 'alettieri@gmail.com',
        'webmaster_name' => 'Nautical Channel Webmaster',

        // Localization preferences
        'server_timezone' => 'UM6',
        'server_offset' => FALSE,
        'time_format' => 'us',
        'daylight_savings' => 'y',
        'honor_entry_dst' => 'y',

        // Channel preferences
        'use_category_name' => 'y',
        'word_separator' => 'dash',
        'reserved_category_word' => 'category',

        // Template preferences
        'strict_urls' => 'y',
        'save_tmpl_files' => 'y',
        'save_tmpl_revisions' => 'n',
        'tmpl_file_basepath' => NSM_BASEPATH . '/themes/site_themes/ee-html5-boilerplate/',
        'hidden_template_indicator' => "_",

        // Theme preferences
        'theme_folder_path' => NSM_BASEPATH . '/themes/',
        'theme_folder_url' => NSM_SITE_URL . '/themes/',
		
        // Tracking preferences
        'enable_online_user_tracking' => 'n',
        'dynamic_tracking_disabling' => '500',
        'enable_hit_tracking' => 'n',
        'enable_entry_view_tracking' => 'n',
        'log_referrers' => 'n',

        // Member preferences
        'allow_registration' => 'n',
        'profile_trigger' => '--sdjhkj2lffgrerfvmdkndkfisolmfmsd' . time(),

        'prv_msg_upload_path' => NSM_BASEPATH . '/content/uploads/member/pm_attachments',
        'enable_emoticons' => 'n',

        'enable_avatars' => 'n',
        'avatar_path' => NSM_BASEPATH . '/content/uploads/member/avatars/',
        'avatar_url' => NSM_SITE_URL . '/uploads/member/avatars/',
        'avatar_max_height' => 100,
        'avatar_max_width' => 100,
        'avatar_max_kb' => 100,

        'enable_photos' => 'n',
        'photo_path' => NSM_BASEPATH . '/content/uploads/member/photos/',
        'photo_url' => NSM_SITE_URL . '/uploads/member/photos/',
        'photo_max_height' => 200,
        'photo_max_width' => 200,
        'photo_max_kb' => 200,

        'sig_allow_img_upload' => 'n',
        'sig_img_path' => NSM_BASEPATH . '/content/uploads/member/signature_attachments/',
        'sig_img_url' => NSM_SITE_URL . '/uploads/member/signature_attachments/',
        'sig_img_max_height' => 80,
        'sig_img_max_width' => 480,
        'sig_img_max_kb' => 30,
        'sig_maxlength' => 500,

        'captcha_font' => 'y',
        'captcha_rand' => 'y',
        'captcha_require_members' => 'n',
        'captcha_path' => NSM_BASEPATH . '/content/'.NSM_SYSTEM_FOLDER.'/images/captchas/',
        'captcha_url' => NSM_SITE_URL.'/'.NSM_SYSTEM_FOLDER.'/images/captchas/',

        // Encryption / Session key
        'encryption_key' => '',

        // NSM htaccess Generator
        'nsm_htaccess_generator_path' => array(NSM_BASEPATH . "/content/.htaccess")
    );



    // Build the new config object
    $config = array_merge($config, $default_config, $env_config);
    
    
}


// DB bootsrap... GO!
if(isset($db['expressionengine']))
{
    $default_db_config = array("cachedir" => APPPATH . "cache/db_cache/");
    $db['expressionengine'] = array_merge($db['expressionengine'], $default_db_config, $env_db_config);  
}
