<?php if ( ! defined('EXT')) exit('No direct script access allowed');
 
 /**
 * Solspace - Add-On Builder Framework
 *
 * @package		Add-On Builder Framework
 * @author		Solspace DevTeam
 * @copyright	Copyright (c) 2008-2011, Solspace, Inc.
 * @link		http://solspace.com/docs/
 * @version		1.2.0
 */
 
 /**
 * Add-On Builder - Base Class
 *
 * A class that helps with the building of ExpressionEngine Add-Ons by allowing the automating of certain
 * tasks.
 *
 * @package 	Add-On Builder Framework
 * @subpackage	Solspace:Add-On Builder
 * @author		Solspace DevTeam
 * @link		http://solspace.com/docs/
 */

//--------------------------------------------  
//	Alias to get_instance()
//--------------------------------------------

if ( ! function_exists('ee') )
{
	function ee()
	{
		return get_instance();
	}
}

//--------------------------------------------  
//	need the bridge adaptor in 1.x
//--------------------------------------------
 
if (APP_VER < 2.0)
{
	require_once PATH . "bridge/codeigniter/ci_bridge_adaptor.php"; 
}

class Addon_builder_freeform {
	
	static $bridge_version		= '1.2.0';
	                        	
	public $cache				= array(); // Internal cache
	                        	
	public $ob_level			= 0;
	public $cached_vars			= array();
	public $switches			= array();
	
	// The general class name (ucfirst with underscores), used in database and class instantiation
	public $class_name			= '';
	
	// The lowercased class name, used for referencing module files and in URLs			
	public $lower_name			= '';
	
	// The name that we put into the Extensions DB table, different for 2.x and 1.x
	public $extension_name		= '';
	
	// Module disabled? Typically used when an update is in progress.
	public $disabled			= FALSE; 
	                        	
	public $addon_path			= '';
	public $theme				= 'default';
	public $version				= '';
	                        	
	public $crumbs				= array();
	                        	
	public $document			= FALSE;
	public $data				= FALSE;
	public $actions				= FALSE;
	
	public $module_preferences	= array();
	public $remote_data			= '';	// For remote file retrieving and storage
	
	public $sc;
	
	//this will house items that might not always be set when called.
	public $constants;
	
	//holder for the json object if ever
	public $json;
	
	//for upper right link building
	public $right_links			= array();
	
	// Member Fields array
	public $mfields				= array();
	
	public $updater;
	
	public $aob_path			= array();
	    
    // --------------------------------------------------------------------

	/**
	 * Constructor
	 *
	 * @access	public
	 * @return	null
	 */
    
	function Addon_builder_freeform($name='')
	{
		//path to this folder
		$this->aob_path = realpath(dirname(__FILE__));
        
        $this->EE =& get_instance();
        
        if ( APP_VER < 2.0)
        {
        	ee()->localize = $GLOBALS['LOC'];
        	ee()->stats	= ( ! isset($GLOBALS['STAT'])) ? FALSE : $GLOBALS['STAT'];
			
			//need a symbolic link to extension->last_call and end_script
			if ( isset($GLOBALS['EXT']) AND is_object($GLOBALS['EXT']))
	        {
	        	ee()->extensions->last_call 	=& $GLOBALS['EXT']->last_call;
				ee()->extensions->end_script 	=& $GLOBALS['EXT']->end_script;
			}			
        }

		// Super short cuts!!!
		$this->sc = $this->generate_shortcuts();

        // --------------------------------------------
        //  Session Global
        //	- Add-On Builder might be called for an Extension using the 'session_' hooks,
        //	- so we need to check for that object first.
        // --------------------------------------------
        
        if ( ! isset(ee()->session) OR ! is_object(ee()->session))
        {
        	if ( APP_VER < 2.0)
        	{
				//Have to check for ->userdata too because a REAL session instance has it always
				//Some other addon devs are creating $SESS->cache even when $SESS is null
				//That autocreates the session object before the real one clobbers it,
				//that in turn fools addons into thinking that $SESSION has already fired :/
				
				//assume its still not there
				ee()->session = FALSE;
				
				//if it is, lets grab it changed to pass by reference
        		if ( isset($GLOBALS['SESS']) AND isset($GLOBALS['SESS']->userdata)) 
				{
					ee()->session =& $GLOBALS['SESS'];
				}
        	}
        	elseif (file_exists(APPPATH.'libraries/Session.php'))
        	{
        		ee()->load->library('session');
        	}
        }
        
        // --------------------------------------------
        //  PAGE Request?  Check for $TMPL global
        // --------------------------------------------
        
        if (isset($GLOBALS['TMPL']) AND is_object($GLOBALS['TMPL']))
        {
        	ee()->TMPL =& $GLOBALS['TMPL'];
        }
        
        //--------------------------------------------
        //  CP Request?  Check for $DSP global
        //--------------------------------------------
        
        if (APP_VER < 2.0 AND REQ == 'CP' AND 
			isset($GLOBALS['DSP']) AND 
			is_object($GLOBALS['DSP']))
        {
        	ee()->cp =& $GLOBALS['DSP'];
        }
		
		//--------------------------------------------
		// Required CONSTANTs
		//--------------------------------------------
		
		if ( ! defined('QUERY_MARKER'))
		{
			define('QUERY_MARKER', (ee()->config->item('force_query_string') == 'y') ? '' : '?');
		}
		
		if ( ! defined('SLASH'))
		{
			define('SLASH', '&#47;');  // Seems this constant is the same for both EE 1.x and EE 2.x
		}
		
		if ( ! defined('T_SLASH')) // Template Parsing Slash
		{
			define('T_SLASH', (APP_VER < '2.0') ? '&#47;' : "/");
		}
		
		if ( ! defined('NL'))
		{
			define('NL', "\n");
		}
		
		if ( ! defined('PATH_THIRD') AND defined('PATH_MOD'))
		{
			define('PATH_THIRD', PATH_MOD);	
		}
		
		if ( ! defined('PATH_CP_IMG') AND defined('PATH_CP_GBL_IMG'))
		{
			define('PATH_CP_IMG', PATH_CP_GBL_IMG);	
		}
		
		//just in case we need them early
		if ( ! defined('AMP')) 
		{
			define('AMP', '&amp;');
		}
		
        if ( ! defined('BR'))  
		{
			define('BR',  '<br />');
		}
                
		if ( ! defined('NBS')) 
		{	
			define('NBS', "&nbsp;");
		}
		
		//this will later be defined by version
		if ( ! defined('SOLSPACE_THEME_PATH'))
		{
			define('SOLSPACE_THEME_PATH', ee()->config->item('theme_folder_path') . 'solspace_themes/');
		}		
		
		//this will later be defined by version
		if ( ! defined('SOLSPACE_THEME_URL'))
		{
			define('SOLSPACE_THEME_URL', ee()->config->item('theme_folder_url') . 'solspace_themes/');
		}
		
		
		// EE 1.x does not have this constant, 
		// but it adds it to every form automatically.
		// EE 2.x sets it all the time now.
		
		$constants = array(
			'XID_SECURE_HASH' 	=> (APP_VER < 2.0 OR ! defined('XID_SECURE_HASH')) ? 
											'' : XID_SECURE_HASH,											
		);
		
		$this->constants = (object) $constants;
		
		//--------------------------------------------
        // Auto-Detect Name
        //--------------------------------------------
        
        if ($name == '')
        {
        	$name = get_class($this);
        	
        	$ends = array(
				'_cp_base', 
				'_mcp', 
				'_CP', 
				'_ext', 
				'_extension', 
				'_extension_base', 
				'_updater_base', 
				'_updater', 
				'_upd', 
				'_actions',
				'_data'
			);
        	
        	foreach($ends as $remove)
        	{
        		if (substr($name, -strlen($remove)) == $remove)
        		{
        			$name = substr($name, 0, -strlen($remove));
        			break;
        		}
        	}
        }
		
		//--------------------------------------------
        // Important Class Vars
        //--------------------------------------------
        
        ee()->load->library('security');
        
		$this->lower_name		= strtolower(ee()->security->sanitize_filename($name));
    	$this->class_name		= ucfirst($this->lower_name);
    	
    	$this->extension_name	= $this->class_name . ((APP_VER < 2.0) ? '_extension' : '_ext'); 
		
		//--------------------------------------------
        // Prepare Caching
        //--------------------------------------------
    	
		//no sessions? lets use global until we get here again
    	if ( ! isset(ee()->session) OR ! is_object(ee()->session))
    	{
    		if ( ! isset($GLOBALS['solspace']['cache']['addon_builder']['addon'][$this->lower_name]))
    		{
    			$GLOBALS['solspace']['cache']['addon_builder']['addon'][$this->lower_name] = array();
    		}
    		
    		$this->cache 		=& $GLOBALS['solspace']['cache']['addon_builder']['addon'][$this->lower_name];

			if ( ! isset($GLOBALS['solspace']['cache']['addon_builder']['global']) )
			{
				$GLOBALS['solspace']['cache']['addon_builder']['global'] = array();
			}

			$this->global_cache =& $GLOBALS['solspace']['cache']['addon_builder']['global'];
    	}
		//sessions?
    	else
    	{
			//been here before?
    		if ( ! isset(ee()->session->cache['solspace']['addon_builder']['addon'][$this->lower_name]))
 			{
				//grab pre-session globals, and only unset the ones for this addon
 				if ( isset($GLOBALS['solspace']['cache']['addon_builder']['addon'][$this->lower_name]))
				{
					ee()->session->cache['solspace']['addon_builder']['addon'][$this->lower_name] = $GLOBALS['solspace']['cache']['addon_builder']['addon'][$this->lower_name];
										
					//cleanup, isle 5
					unset($GLOBALS['solspace']['cache']['addon_builder']['addon'][$this->lower_name]);
				}
 				else
 				{
 					ee()->session->cache['solspace']['addon_builder']['addon'][$this->lower_name] = array();
 				}
 			}
			
			//check for solspace-wide globals
			if ( ! isset(ee()->session->cache['solspace']['addon_builder']['global']) )
			{
				if (isset($GLOBALS['solspace']['cache']['addon_builder']['global']))
				{
					ee()->session->cache['solspace']['addon_builder']['global'] = $GLOBALS['solspace']['cache']['addon_builder']['global'];
					
					unset($GLOBALS['solspace']['cache']['addon_builder']['global']);
				}	
				else
				{
					ee()->session->cache['solspace']['addon_builder']['global'] = array();
				}
			}
 		
			$this->global_cache =& ee()->session->cache['solspace']['addon_builder']['global'];
 			$this->cache 		=& ee()->session->cache['solspace']['addon_builder']['addon'][$this->lower_name];
 		}
		
		//--------------------------------------------
        // Add-On Path
        //--------------------------------------------
        
        if (APP_VER < 2.0)
        {
        	// Because of Bridge Magic with eval() and parents, we might have to go one or two levels up
        	$parent_class		= get_parent_class($this);
        	$super_parent_class = get_parent_class($parent_class);
        
			if (($parent_class == 'Extension_builder_freeform' OR 
				 $super_parent_class == 'Extension_builder_freeform') AND 
				 is_dir(PATH_EXT.$this->lower_name.'/'))
			{
				$this->extension_name	= $this->class_name;
				$this->addon_path		= PATH_EXT . $this->lower_name.'/';
			}
			else
			{
				$this->addon_path = PATH_MOD . $this->lower_name . '/';
			}
		}
		else
		{
			$this->addon_path = PATH_THIRD . $this->lower_name . '/';
		}
		
		//--------------------------------------------
		// Language Override
		//--------------------------------------------
		
		if ( is_object(ee()->lang))
		{
			ee()->lang->loadfile($this->lower_name);
		}
		
		//--------------------------------------------
        // Module Constants
        //--------------------------------------------
        
        if ( defined(strtoupper($this->lower_name).'_VERSION') == FALSE AND 
			 file_exists($this->addon_path.'constants.'.$this->lower_name.'.php'))
        {
        	require_once $this->addon_path.'constants.'.$this->lower_name.'.php';
        }
        
        if (defined(strtoupper($this->lower_name).'_VERSION') !== FALSE)
        {
        	$this->version = constant(strtoupper($this->lower_name).'_VERSION');
        }
		        
        //--------------------------------------------
        // Data Object - Used Cached Version, if Available
        //--------------------------------------------
        
        if ( isset($this->cache['objects']['data']) AND 
			 is_object($this->cache['objects']['data']))
        {
        	$this->data =& $this->cache['objects']['data'];
        }
        else
        {			
			if ( file_exists($this->addon_path . 'data.' . $this->lower_name.'.php'))
			{                                              
				require_once $this->addon_path . 'data.' . $this->lower_name.'.php';
				
				$name = $this->class_name . '_data';
				
				$this->data = new $name($this);
				
				$this->data->sc	= $this->sc;
			}
			else
			{
				require_once $this->aob_path . '/data.addon_builder.php';
				
				$this->data = new Addon_builder_data_freeform($this);
			}
		}
		
		$this->data->parent_aob_instance =& $this;
        
        //--------------------------------------------
		// documentDOM_freeform instantiated, might move this.
		//--------------------------------------------

    	if (REQ == 'CP' AND file_exists($this->aob_path . '/document_dom.php'))
    	{
			if ( ! class_exists('documentDOM_freeform'))
			{
				require_once $this->aob_path . '/document_dom.php';
			}
    	
    		$this->document = new documentDOM_freeform();
        }
        
        //--------------------------------------------
        // Important Cached Vars - Used in Both Extensions and Modules
        //--------------------------------------------
		
		$this->cached_vars['XID_SECURE_HASH'] 	= $this->constants->XID_SECURE_HASH;
		$this->cached_vars['page_crumb']	 	= '';
		$this->cached_vars['page_title']	 	= '';
		$this->cached_vars['text_direction'] 	= 'ltr';
		$this->cached_vars['onload_events']  	= '';
		$this->cached_vars['message']		 	= '';
		
		$this->cached_vars['caller'] 		 	=& $this;
		
		//--------------------------------------------
		// Determine View Path for Add-On
		//--------------------------------------------
		
		if ( isset($this->cache['view_path']))
		{
			$this->view_path = $this->cache['view_path'];
		}
		else
		{
			$possible_paths = array();
			
			$this->theme = ee()->security->sanitize_filename($this->theme);
			
			if (APP_VER < 2.0)
			{
				if (trim($this->theme, '/') != '')
				{
					$possible_paths[] = $this->addon_path.'views/1.x/'.trim($this->theme, '/').'/';
				}
				
				$possible_paths[] = $this->addon_path.'views/1.x/default/';
				$possible_paths[] = $this->addon_path.'views/1.x/';
			}
			else
			{
				if (trim($this->theme, '/') != '')
				{
					$possible_paths[] = $this->addon_path.'views/2.x/'.trim($this->theme, '/').'/';
				}
				
				$possible_paths[] = $this->addon_path.'views/2.x/default/';
				$possible_paths[] = $this->addon_path.'views/2.x/';
			}
			
			if (trim($this->theme, '/') != '')
			{
				$possible_paths[] = $this->addon_path.'views/'.trim($this->theme, '/').'/';
			}
			
			$possible_paths[] = $this->addon_path.'views/default/';
			$possible_paths[] = $this->addon_path.'views/';
			
			foreach(array_unique($possible_paths) as $path)
			{
				if ( is_dir($path))
				{
					$this->view_path = $path;
					break;
				}
			}
		}
	}
	// END Addon_builder_freeform()
	
	
	// --------------------------------------------------------------------

	/**
	 * Creates shortcuts for common changed items between versions.
	 *
	 * @access	public
	 * @return	object
	 */
	
	function generate_shortcuts()
	{
		$is2 = ! (APP_VER < 2.0);
		
		return (object) array(
			'db'	=> (object) array(
				'channel_name'			=> $is2 ? 'channel_name'              	: 'blog_name',
				'channel_url'			=> $is2 ? 'channel_url'              	: 'blog_url',
				'channel_title'			=> $is2 ? 'channel_title'             	: 'blog_title',
				'channels'				=> $is2 ? 'exp_channels'              	: 'exp_weblogs',
				'data'					=> $is2 ? 'exp_channel_data'          	: 'exp_weblog_data',
				'channel_data'			=> $is2 ? 'exp_channel_data'          	: 'exp_weblog_data',
				'fields'				=> $is2 ? 'exp_channel_fields'        	: 'exp_weblog_fields',
				'channel_fields'		=> $is2 ? 'exp_channel_fields'        	: 'exp_weblog_fields',
				'id'					=> $is2 ? 'channel_id'                	: 'weblog_id',
				'channel_id'			=> $is2 ? 'channel_id'                	: 'weblog_id',
				'member_groups'			=> $is2 ? 'exp_channel_member_groups' 	: 'exp_weblog_member_groups',
				'channel_member_groups'	=> $is2 ? 'exp_channel_member_groups' 	: 'exp_weblog_member_groups',
				'titles'				=> $is2 ? 'exp_channel_titles'        	: 'exp_weblog_titles',
				'channel_titles'		=> $is2 ? 'exp_channel_titles'        	: 'exp_weblog_titles'
			),
			'channel'					=> $is2 ? 'channel'        				: 'weblog',
			'channels'					=> $is2 ? 'channels'        			: 'weblogs',
			'theme_path'				=> $is2 ? ee()->config->item('theme_folder_path') . 'third_party'	: ee()->config->item('theme_folder_path'),
			'theme_url'					=> $is2 ? ee()->config->item('theme_folder_url') . 'third_party'	: ee()->config->item('theme_folder_url')
		);
	}
	/* END generate_shortcuts() */

	
	// --------------------------------------------------------------------

	/**
	 * Instantiates an Object and Returns It
	 *
	 * Tired of having the same code duplicate everywhere for calling Typography, Email, Et Cetera.
	 *
	 * @access	public
	 * @return	object|NULL
	 */
    
	function instantiate( $name , $variables = array())
    {
    	$lower_name = strtolower($name);
    	$class_name = ucfirst($lower_name);
    	
    	// I am embarrassed by this exception -Paul
    	if ($lower_name == 'email')
    	{
    		$class_name == 'EEmail';
    	}
    	
    	if ( ! class_exists($class_name))
		{
			// We only load classes from the CP or CORE directories
			
			if (file_exists(PATH_CP.'core.'.$lower_name.EXT))
			{
				$location = PATH_CP.'core.'.$lower_name.EXT;
			}
			elseif (file_exists(PATH_CORE.'cp.'.$lower_name.EXT))
			{
				$location = PATH_CORE.'cp.'.$lower_name.EXT;
			}
			else
			{
				return NULL;
			}
			
			require_once $location;
		}
		
		$NEW = new $class_name();
		
		foreach($variables AS $key => $value)
		{
			$NEW->$key = $value;
		}
		
		return $NEW;
    }
    /* END instantiate() */
    
    
	// --------------------------------------------------------------------

	/**
	 * Module's Action Object
	 *
	 * intantiates the actions object and sticks it to $this->actions
	 *
	 * @access	public
	 * @return	object
	 */
	 
	function actions()
	{
		if ( ! is_object($this->actions))
		{
			require_once $this->addon_path.'act.'.$this->lower_name.'.php';
			
			$name = $this->class_name.'_actions';
			
			$this->actions = new $name();
			$this->actions->data =& $this->data;
		}
		
		return $this->actions;
	}
	// END actions()

	
	// --------------------------------------------------------------------

	/**
	 * Database Version
	 *
	 * Returns the version of the module in the database
	 *
	 * @access	public
	 * @return	string
	 */
    
	function database_version()
    {    	
    	if (isset($this->cache['database_version'])) return $this->cache['database_version'];
    	
    	//	----------------------------------------
		//	 Use Template object variable, if available
		// ----------------------------------------
    	
		//EE1
    	if ( APP_VER < 2.0 AND
			 isset($GLOBALS['TMPL']) AND 
 			 is_object($GLOBALS['TMPL']) AND 
  			 count($GLOBALS['TMPL']->module_data) > 0)
    	{
			if ( ! isset($GLOBALS['TMPL']->module_data[$this->class_name]))
    		{
				$this->cache['database_version'] = FALSE;
			}
			else
			{
				$this->cache['database_version'] = $GLOBALS['TMPL']->module_data[$this->class_name]['version'];
			}
    	}
		//EE2
		elseif ( APP_VER >= 2.0 AND
		 	 isset(ee()->TMPL) AND 
		 	 is_object(ee()->TMPL) AND 
 		 	 count(ee()->TMPL->module_data) > 0)
		{
			if ( ! isset(ee()->TMPL->module_data[$this->class_name]))
    		{
				$this->cache['database_version'] = FALSE;
			}
			else
			{
				$this->cache['database_version'] = ee()->TMPL->module_data[$this->class_name]['version'];
			}
		}
		//global cache
		elseif (isset($this->global_cache['module_data']) AND 
			isset($this->global_cache['module_data'][$this->lower_name]['database_version']))
		{
			$this->cache['database_version'] = $this->global_cache['module_data'][$this->lower_name]['database_version'];
		}
		//fill global with last resort
		else
		{
			//	----------------------------------------
			//	 Retrieve all Module Versions from the Database
			//	  - By retrieving all of them at once, 
			//   we can limit it to a max of one query per 
			//   page load for all Bridge Add-Ons
			// ----------------------------------------

	    	$query = $this->cacheless_query( 
				"SELECT module_version, module_name 
				 FROM 	exp_modules"
			);

	    	foreach($query->result_array() as $row)
	    	{
	    		if ( isset(ee()->session) AND is_object(ee()->session))
				{
					$this->global_cache['module_data'][strtolower($row['module_name'])]['database_version'] = $row['module_version'];
				}

				if ($this->class_name == $row['module_name'])
				{
					$this->cache['database_version'] = $row['module_version'];
				}
	    	}
		}
		
		//did get anything?
		return isset($this->cache['database_version']) ? $this->cache['database_version'] : FALSE;
	}
	// END database_version()
	
	
	// --------------------------------------------------------------------
		
	/**
	 * Find and return preference
	 *
	 * Any number of possible arguments, although typically I expect there will be only one or two
	 * 
	 * @access	public
	 * @param	string			Preference to retrieve
	 * @return	null|string		If preference does not exist, NULL is returned, else the value
	 */
	 
	function preference()
	{
		$s = func_num_args();
		
		if ($s == 0)
		{
			return NULL;
		}
		
		//--------------------------------------------
        // Fetch Module Preferences
        //--------------------------------------------
		
		if (sizeof($this->module_preferences) == 0 AND $this->database_version() !== FALSE)
		{
			if ( method_exists($this->actions(), 'module_preferences'))
			{
				$this->module_preferences = $this->actions()->module_preferences();
			}
			elseif ( method_exists($this->data, 'get_module_preferences'))
			{
				$this->module_preferences = $this->data->get_module_preferences();
			}
			else
			{
				return NULL;
			}
		}
		
		//--------------------------------------------
        // Find Our Value, If It Exists
        //--------------------------------------------
        
        $value = (isset($this->module_preferences[func_get_arg(0)])) ? 
					$this->module_preferences[func_get_arg(0)] : NULL;
		
		for($i = 1; $i < $s; ++$i)
		{
			if ( ! isset($value[func_get_arg($i)]))
			{
				return NULL;
			}
			
			$value = $value[func_get_arg($i)];
		}
		
		return $value;
	}
	// END preference()


	// --------------------------------------------------------------------
		
	/**
	 * Checks to see if extensions are allowed
	 *
	 * 
	 * @access	public
	 * @return	bool	Whether the extensions are allowed
	 */
	 
	function extensions_allowed()
	{	
		return $this->check_yes(ee()->config->item('allow_extensions'));
	}
	//END extensions_allowed	

	
	// --------------------------------------------------------------------
		
	/**
	 * Homegrown Version of Version Compare
	 *
	 * Compared two versions in the form of 1.1.1.d12 <= 1.2.3.f0
	 * 
	 * @access	public
	 * @param	string	First Version
	 * @param	string	Operator for Comparison
	 * @param	string	Second Version
	 * @return	bool	Whether the comparison is TRUE or FALSE
	 */
	 
	function version_compare($v1, $operator, $v2)
	{
		// Allowed operators
		if ( ! in_array($operator, array('>', '<', '>=', '<=', '==', '!=')))
		{
			trigger_error("Invalid Operator in Add-On Library - Version Compare", E_USER_WARNING);
			return FALSE;
		}
	
		// Normalize and Fix Invalid Values
		foreach(array('v1', 'v2') as $var)
		{
			$x = array_slice(preg_split("/\./", trim($$var), -1, PREG_SPLIT_NO_EMPTY), 0, 4);
			
			for($i=0; $i < 4; $i++)
			{
				if ( ! isset($x[$i]))
				{
					$x[$i] = ($i == 3) ? 'f0' : '0';
				}
				elseif ($i < 3 AND ctype_digit($x[$i]) == FALSE)
				{
					$x[$i] = '0';
				}
				elseif($i == 3 AND ! preg_match("/^[abdf]{1}[0-9]+$/", $x[$i]))
				{
					$x[$i] = 'f0';
				}
				
				// Set up for PHP's version_compare
				if ($i == 3)
				{
					$letter 	 = substr($x[3], 0, 1);
					$sans_letter = substr($x[3], 1);
					
					if ($letter == 'd')
					{
						$letter = 'dev';
					}
					elseif($letter == 'f')
					{
						$letter = 'RC';
					}
					
					$x[3] = $letter.'.'.$sans_letter;
				}
			}
			
			$$var = implode('.', $x);
		}
		
		// echo $v1.' - '.$v2;
		
		//this is a php built in function, 
		//self::version_compare is just prep work
		return version_compare($v1, $v2, $operator);
	}
	// END version_compare()

	
	// --------------------------------------------------------------------
		
	/**
	 * ExpressionEngine CP View Request
	 *
	 * Just like a typical view request but we do a few EE CP related things too
	 * 
	 * @access	public
	 * @param	array
	 * @return	void
	 */
	function ee_cp_view($view)
	{
		//--------------------------------------------
        // Build Crumbs!
        //--------------------------------------------
        
        $this->build_crumbs();
        $this->build_right_links();
        
        //--------------------------------------------
        // EE 1.x Code for Calling Certain CP Hooks
        //--------------------------------------------
        
		if (APP_VER < 2.0)
		{	
			// -------------------------------------------
			// 'show_full_control_panel_start' hook.
			//  - Full Control over CP
			//  - Modify any $DSP class variable (JS, headers, etc.)
			//  - Override any $DSP method and use their own
			//
				$edata = ee()->extensions->call('show_full_control_panel_start');
				if (ee()->extensions->end_script === TRUE) return;
			//
			// -------------------------------------------
		}
		
		//--------------------------------------------
        // Load View Path, Call View File
        //--------------------------------------------
        
        /*if (APP_VER < 2.0)
        {*/
        	// I tried to switch to the CI method in Bridge 2.0, but unfortunately it seems
        	// to break Add-Ons that used previous versions of Bridge. Disappointing.  Should 
        	// look into that a bit further when I have a bit of time.
        	
        	$output = $this->view($view, array(), TRUE);
        /*}
        else
        {
			$orig_view_path = ee()->load->_ci_view_path;
			ee()->load->_ci_view_path = $this->view_path;
			
			$output = ee()->load->view($view, $this->cached_vars, TRUE);
		
			ee()->load->_ci_view_path = $orig_view_path;
		}*/
		
		//--------------------------------------------
        // EE 1.x Code for Calling Certain CP Hooks
        //--------------------------------------------
		
		if (APP_VER < 2.0)
		{	
			// -------------------------------------------
			// 'show_full_control_panel_end' hook.
			//  - Rewrite CP's HTML
			//	- Find/Replace Stuff, etc.
			//
				if (ee()->extensions->active_hook('show_full_control_panel_end') === TRUE)
				{
					$output = ee()->extensions->call('show_full_control_panel_end', $output);
					if (ee()->extensions->end_script === TRUE) return;
				}
			//
			// -------------------------------------------
		}
		
		//--------------------------------------------
        // EE 1.x, We Add Secure Form Hashes and Output Content to Browser
        //--------------------------------------------
		
		if (APP_VER < 2.0)
		{
			if (stristr($output, '{XID_HASH}'))
			{
				$output = ee()->functions->add_form_security_hash($output);
			}

			ee()->output->_display(ee()->cp->secure_hash($output));
			exit;
		}
		
		//--------------------------------------------
        // In EE 2.x, we return the Output and Let EE Continue Building the CP
        //--------------------------------------------
		
		return $output;
	}
	// END ee_cp_view()
	
	
	// --------------------------------------------------------------------
		
	/**
	 * Javascript/CSS File View Request
	 *
	 * Outputs a View file as if it were a Javascript file
	 * 
	 * @access	public
	 * @param	array
	 * @return	void
	 */
	function file_view($view, $modification_time = '')
	{
		//--------------------------------------------
        // Auto-detect the Type
        //--------------------------------------------
       
		if (preg_match("/\.([cjs]{2,3})$/i", $view, $match) AND 
		 	in_array($match[1], array('css', 'js')))
		{
			switch($match[1])
			{
				case 'css'	:
					$type = 'css';
				break;
				case 'js'	:
					$type = 'javascript';
				break;
			}
		}
		else
		{
			exit;
		}
	
		//--------------------------------------------
        // Load View Path, Call View File
        //--------------------------------------------
        
        /*if (APP_VER < 2.0)
        {*/
        	// I tried to switch to the CI method in Bridge 1.0, but unfortunately it seems
        	// to break Add-Ons that used previous versions of Hermes. Disappointing.  Should 
        	// look into that a bit further when I have a bit of time. -Paul
        	
        	$output = $this->view($view, array(), TRUE);
        /*}
        else
        {
			$orig_view_path = ee()->load->_ci_view_path;
			ee()->load->_ci_view_path = $this->view_path;
			
			$output = ee()->load->view($view, $this->cached_vars, TRUE);
		
			ee()->load->_ci_view_path = $orig_view_path;
		}*/
		
		//--------------------------------------------
        // EE 1.x, We Add Secure Form Hashes and Output Content to Browser
        //--------------------------------------------
        
        if ($type == 'javascript' AND stristr($output, '{XID_SECURE_HASH}'))
        {
        	$output = str_replace('{XID_SECURE_HASH}', '{XID_HASH}', $output);
        }
        
        if ($type == 'javascript')
		{
			$output = ee()->functions->add_form_security_hash($output);
		}
		
		//----------------------------------------
        // Generate HTTP headers
        //----------------------------------------

        if (ee()->config->item('send_headers') == 'y')
        {
			$ext = pathinfo($view, PATHINFO_EXTENSION);
			$file = ($ext == '') ? $view.EXT : $view;
			$path = $this->view_path.$file;        
        
            $max_age			= 5184000;
			$modification_time	= ($modification_time != '') ? $modification_time : filemtime($path);
			$modified_since		= ee()->input->server('HTTP_IF_MODIFIED_SINCE');
			
			if ( ! ctype_digit($modification_time))
			{
				$modification_time	= filemtime($path);
			}

			// Remove anything after the semicolon

			if ($pos = strrpos($modified_since, ';') !== FALSE)
			{
				$modified_since = substr($modified_since, 0, $pos);
			}

			// Send a custom ETag to maintain a useful cache in
			// load-balanced environments

			header("ETag: ".md5($modification_time.$path));

			// If the file is in the client cache, we'll
			// send a 304 and be done with it.

			if ($modified_since AND (strtotime($modified_since) == $modification_time))
			{
				ee()->output->set_status_header(304);
				exit;
			}

			ee()->output->set_status_header(200);
			@header("Cache-Control: max-age={$max_age}, must-revalidate");
			@header('Vary: Accept-Encoding');
			@header('Last-Modified: '.gmdate('D, d M Y H:i:s', $modification_time).' GMT');
			@header('Expires: '.gmdate('D, d M Y H:i:s', time() + $max_age).' GMT');
			@header('Content-Length: '.strlen($output));
		}  

        //----------------------------------------
        // Send JavaScript/CSS Header and Output
        //----------------------------------------

        @header("Content-type: text/".$type);
		
		exit($output);
	}
	// END ee_cp_view()
	
	 
	// --------------------------------------------------------------------

	/**
	 * View File Loader
	 * 
	 * Takes a file from the filesystem and loads it so that we can parse PHP within it just
	 * 
	 * 
	 * @access		public
	 * @param		string		$view - The view file to be located
	 * @param		array		$vars - Array of data variables to be parsed in the file system
	 * @param		bool		$return - Return file as string or put into buffer
	 * @param		string		$path - Override path for the file rather than using $this->view_path
	 * @return		string
	 */
	 
	function view($view, $vars = array(), $return = FALSE, $path='')
	{	
		//have to keep this for legacy footers	
		global $DSP, $LANG, $PREFS;
		
		//--------------------------------------------
        // Determine File Name and Extension for Requested File
        //--------------------------------------------
        
		if ($path == '')
		{
			$ext = pathinfo($view, PATHINFO_EXTENSION);
			$file = ($ext == '') ? $view.EXT : $view;
			$path = $this->view_path.$file;
		}
		else
		{
			$x = explode('/', $path);
			$file = end($x);
		}
		
		//--------------------------------------------
        // Make Sure the File Actually Exists
        //--------------------------------------------
		
		if ( ! file_exists($path))
		{
			trigger_error("Invalid View File Request of '".$path."'");
			return FALSE;
		}
		 
		// All variables sent to the function are cached, which allows us to use them
		// within embedded view files within this file.
		 
		if (is_array($vars))
		{
			$this->cached_vars = array_merge($this->cached_vars, $vars);
		}
		extract($this->cached_vars, EXTR_PREFIX_SAME, 'var_');
		
		//print_r($this->cached_vars);
		 
		//--------------------------------------------
        // Buffer Output
        // - Increases Speed
        // - Allows Views to be Nested Within Views
        //--------------------------------------------
        
		ob_start();

		//--------------------------------------------
        // Load File and Rewrite Short Tags
        //--------------------------------------------
		
		$rewrite_short_tags = TRUE; // Hard coded setting for now...
		
		if ((bool) @ini_get('short_open_tag') === FALSE AND $rewrite_short_tags == TRUE)
		{
			echo eval('?'.'>'.preg_replace("/;*\s*\?".">/", "; ?".">", 
					  str_replace('<'.'?=', '<?php echo ', 
					 file_get_contents($path))).'<'.'?php ');
		}
		else
		{
			include($path);
		}
		
		//--------------------------------------------
        // Return Parsed File as String
        //--------------------------------------------
		
		if ($return === TRUE)
		{		
			$buffer = ob_get_contents();
			@ob_end_clean();
			return $buffer;
		}
		 
		//--------------------------------------------
        // Flush Buffer
        //--------------------------------------------
        
		if (ob_get_level() > $this->ob_level + 1)
		{
			ob_end_flush();
		}
		else
		{
			$buffer = ob_get_contents();
			@ob_end_clean();
			return $buffer;
		}
	}
	// END view()
	
	
	// --------------------------------------------------------------------

	/**
	 * Fetch the CP Stylesheet
	 *
	 * Had to build this because it was not abstracted well enough for us to simply call EE methods
	 *
	 * @access	public
	 * @param	array		An array of find/replace values to perform in the stylesheet
	 * @return	string
	 */
	 
	function fetch_stylesheet()
	{	 	
	 	// Change CSS on the click so it works like the hover until they unclick?  
        
		$ptb = ee()->config->item('publish_tab_behavior');
		$stb = ee()->config->item('sites_tab_behavior');

		$tab_behaviors = array(
			'publish_tab_selector'		=> ($ptb == 'hover') 	? 'hover' : 'active',
			'publish_tab_display'		=> ($ptb == 'none') 	? '' : 'display:block; visibility: visible;',
			'publish_tab_ul_display'	=> ($ptb == 'none') 	? '' : 'display:none;',
			'sites_tab_selector'		=> ($stb == 'hover') 	? 'hover' : 'active',
			'sites_tab_display'			=> ($stb == 'none') 	? '' : 'display:block; visibility: visible;',
			'sites_tab_ul_display'		=> ($stb == 'none') 	? '' : 'display:none;'
		);
		
		$stylesheet = $GLOBALS['DSP']->fetch_stylesheet();
	
		foreach ($tab_behaviors as $key => $val)
		{
			$stylesheet = str_replace(LD.$key.RD, $val, $stylesheet);
		}
	 	
	 	return $stylesheet;
	}
	 // END fetch_stylesheet()
	 
	 
	// --------------------------------------------------------------------
	
	/**
	 * Add Array of Breadcrumbs for a Page
	 *
	 * @access	public
	 * @param	array
	 * @return	null
	 */
	 
	function add_crumbs($array)
	{
		if ( is_array($array))
		{
			foreach($array as $value)
			{
				if ( is_array($value))
				{
					$this->add_crumb($value[0], $value[1]);
				}
				else
				{
					$this->add_crumb($value);
				}
			}
		}
	}
	/* END add_crumbs */
	
	// --------------------------------------------------------------------
	
	/**
	 * Add Single Crumb to List of Breadcrumbs
	 *
	 * @access	public
	 * @param	string		Text of breacrumb
	 * @param	string		Link, if any for breadcrumb
	 * @return	null
	 */
	
	function add_crumb($text, $link='')
	{
		$this->crumbs[] = ($link == '') ? array($text) : array($text, $link);
	}
	/* END add_crumb() */	
	
	
	// --------------------------------------------------------------------
	
	/**
	 * Takes Our Crumbs and Builds them into the Breadcrumb List
	 *
	 * @access	public
	 * @return	null
	 */
	
	function build_crumbs()
	{
		global $DSP, $OUT;
		
		if ( is_string($this->crumbs))
		{
			$DSP->title	= $this->crumbs;
			$this->cached_vars['page_crumb'] = $this->crumbs;
			$this->cached_vars['page_title'] = $this->crumbs;
			return;
		}
		
		$DSP->crumb = '';
		$this->cached_vars['page_crumb'] = '';
		$this->cached_vars['page_title'] = '';
		
		$item = (count($this->crumbs) == 1) ? TRUE : FALSE;
		
		ee()->load->helper('url');
		
		foreach($this->crumbs as $key => $value)
		{
			if (is_array($value))
			{
				$name = $value[0];
				
				if (isset($value[1]))
				{
					$name = "<a href='{$value[1]}'>{$value[0]}</a>";	
				}
				
				$this->cached_vars['page_title'] = $value[0];
			}
			else
			{
				$name = $value;
				$this->cached_vars['page_title'] = $value;
			}
			
			if (APP_VER < 2.0)
			{			
				if ($item === FALSE)
				{
					$this->cached_vars['page_crumb'] .= $name;
					$item = TRUE;
				}
				else
				{
					$this->cached_vars['page_crumb'] .= $DSP->crumb_item($name); 
				}
			}
			else
			{
				if (is_array($value) AND isset($value[1]))
				{
					ee()->cp->set_breadcrumb($value[1], $value[0]);
				}
			}
		}
		
		/** --------------------------------------------
        /**  2.0 Specific Code
        /** --------------------------------------------*/
        
		$this->cached_vars['cp_page_title'] = $this->cached_vars['page_title'];
		
		if (APP_VER >= 2.0)
		{
			ee()->cp->set_variable('cp_page_title', $this->cached_vars['cp_page_title'] );
		}
		
		/** --------------------------------------------
        /**  1.x Breadcrumb View Variable
        /** --------------------------------------------*/
		
		$DSP->crumb = $this->cached_vars['page_crumb'];
	}
	/* END build_crumbs() */
	
	
	// --------------------------------------------------------------------

	/**
	 * Field Output Prep for arrays and strings
	 *		
	 *
	 * @access	public
	 * @param	string|array	The item that needs to be prepped for output
	 * @return	string|array
	 */
    
    function output($item)
    {
    	if (is_array($item))
    	{
    		$array = array();
    		
    		foreach($item as $key => $value)
    		{
    			$array[$this->output($key)] = $this->output($value);
    		}
    		
    		return $array;
    	}
    	elseif(is_string($item))
    	{
			return htmlspecialchars($item, ENT_QUOTES);
		}
		else
		{
			return $item;
		}
    }
    /* END output() */
    
	// --------------------------------------------------------------------

	/**
	 * Cycles Between Values
	 *
	 * Takes a list of arguments and cycles through them on each call
	 *
	 * @access	public
	 * @param	string|array	The items that need to be cycled through
	 * @return	string|array
	 */
    
    function cycle($items)
    {	
    	if ( ! is_array($items))
    	{
    		$items = func_get_args();
    	}
    	
    	$hash = md5(implode('|', $items));
    	
    	if ( ! isset($this->switches[$hash]) OR ! isset($items[$this->switches[$hash] + 1]))
    	{
    		$this->switches[$hash] = 0;
    	}
    	else
    	{
    		$this->switches[$hash]++;
    	}
    	
    	return $items[$this->switches[$hash]];
    }
    /* END cycle() */
    
    
	// --------------------------------------------------------------------

	/**
	 * Order Array
	 *
	 * Takes an array and reorders it based on the value of a key
	 *
	 * @access	public
	 * @param	array	$array		The array needing to be reordered
	 * @param	string	$key		The key being used to reorder
	 * @param	string	$order		The order for the values asc/desc
	 * @return	array
	 */
    
    function order_array($array, $key, $order = 'desc')
    {	
    	// http://us2.php.net/manual/en/function.array-multisort.php
    }
    /* END order_array() */
    
	// --------------------------------------------------------------------

	/**
	 * Column Exists in DB Table
	 *
	 * @access	public
	 * @param	string	$column		The column whose existence we are looking for
	 * @param	string	$table		In which table?
	 * @return	array
	 */
    
	function column_exists( $column, $table, $cache = TRUE )
	{		
		if ($cache === TRUE AND isset($this->cache['column_exists'][$table][$column]))
		{
			return $this->cache['column_exists'][$table][$column];
		}
		
		/**	----------------------------------------
		/**	Check for columns in tags table
		/** ----------------------------------------*/
		
		$query	= ee()->db->query( "DESCRIBE `".ee()->db->escape_str( $table )."` `".ee()->db->escape_str( $column )."`" );
		
		if ( $query->num_rows > 0 )
		{
			return $this->cache['column_exists'][$table][$column] = TRUE;
		}
		
		return $this->cache['column_exists'][$table][$column] = FALSE;
	}
	/* END column_exists() */
	
	
	// --------------------------------------------------------------------

	/**
	 * Retrieve Remote File and Cache It
	 *
	 * @access	public
	 * @param	string		$url - URL to be retrieved
	 * @param	integer		$cache_length - How long to cache the result, if successful retrieval
	 * @return	bool		Success or failure.  Data result stored in $this->remote_data
	 */
	
	function retrieve_remote_file($url, $cache_length = 24, $path='', $file='')
	{
		global $FNS;
	
		$path		= ($path == '') ? PATH_CACHE.'addon_builder/' : rtrim($path, '/').'/';
		$file		= ($file == '') ? md5($url).'.txt' : $file;
		$file_path	= $path.$file;
	
		/** --------------------------------------------
        /**  Check for Cached File
        /** --------------------------------------------*/
	
		if ( ! file_exists($file_path) OR (time() - filemtime($file_path)) > (60 * 60 * round($cache_length))) 
		{
			@unlink($file_path);
		}
		elseif (($this->remote_data = file_get_contents($file_path)) === FALSE)
		{
			@unlink($file_path);
		}
		else
		{
			return TRUE;
		}
	
		/** --------------------------------------------
        /**  Validate and Create Cache Directory
        /** --------------------------------------------*/
	
		if ( ! is_dir($path))
		{
			$dirs = explode('/', trim(ee()->functions->remove_double_slashes($path), '/'));
			
			$path = '/';
			
			foreach ($dirs as $dir)
			{       
				if ( ! @is_dir($path.$dir))
				{
					if ( ! @mkdir($path.$dir, 0777))
					{
						$this->errors[] = 'Unable to Create Directory: '.$path.$dir;
						return;
					}
					
					@chmod($path.$dir, 0777);            
				}
				
				$path .= $dir.'/';
			}
		}
		
		if ($this->is_really_writable($path) === FALSE)
		{
			$this->errors[] = 'Cache Directory is Not Writable: '.$path;
			return FALSE;
		}
		
		/** --------------------------------------------
        /**  Retrieve Our URL
        /** --------------------------------------------*/
        
        $this->remote_data = $this->fetch_url($url);
        
        if ($this->remote_data == '')
        {
        	$this->errors[] = 'Unable to Retrieve URL: '.$url;
        	return FALSE;
        }
        
        /** --------------------------------------------
        /**  Write Cache File
        /** --------------------------------------------*/
        
        if ( ! $this->write_file($file_path, $this->remote_data))
		{
			$this->errors[] = 'Unable to Write File to Cache';
			return FALSE;
		}
		
		return TRUE;
	}
	/* END retrieve_remote_file() */
	
	
	// --------------------------------------------------------------------

	/**
	 * Fetch the Data for a URL
	 
	 * @access	public
	 * @param	string		$url - The URI that we are fetching
	 * @param	array		$post - The POST array we are sending
	 * @return	string
	 */
    
	function fetch_url($url, $post = array())
    {
    	$data = '';
    	
    	/** --------------------------------------------
        /**  file_get_contents()
        /** --------------------------------------------*/
    	
    	if ((bool) @ini_get('allow_url_fopen') !== FALSE AND empty($post))
		{
			if ($data = @file_get_contents($url))
			{
				return trim($data);
			}
		}
		
		/** --------------------------------------------
        /**  cURL
        /** --------------------------------------------*/

		if (function_exists('curl_init') === TRUE AND ($ch = @curl_init()) !== FALSE)
		{
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
			
			// prevent a PHP warning on certain servers
			if (! ini_get('safe_mode') AND ! ini_get('open_basedir'))
			{
				curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
			}
			
			//	Are we posting?
			if ( ! empty( $post ) )
			{
				$str	= '';
				
				foreach ( $post as $key => $val )
				{
					$str	.= urlencode( $key ) . "=" . urlencode( $val ) . "&";
				}
				
				$str	= substr( $str, 0, -1 );
			
				curl_setopt( $ch, CURLOPT_POST, TRUE );
				curl_setopt( $ch, CURLOPT_POSTFIELDS, $str );
			}
			
			curl_setopt($ch, CURLOPT_MAXREDIRS, 5);
			curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
			curl_setopt($ch, CURLOPT_TIMEOUT, 15);
			curl_setopt($ch, CURLOPT_HEADER, FALSE);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
			$data = curl_exec($ch);
			curl_close($ch);

			if ($data !== FALSE)
			{
				return trim($data);
			}
		}
		
		// --------------------------------------------
        //  fsockopen() - Last but only slightly least...
        // --------------------------------------------
		
		$parts	= parse_url($url);
		$host	= $parts['host'];
		$path	= (!isset($parts['path'])) ? '/' : $parts['path'];
		$port	= ($parts['scheme'] == "https") ? '443' : '80';
		$ssl	= ($parts['scheme'] == "https") ? 'ssl://' : '';
		
		if (isset($parts['query']) AND $parts['query'] != '')
		{
			$path .= '?'.$parts['query'];
		}
		
		$data = '';

		$fp = @fsockopen($ssl.$host, $port, $error_num, $error_str, 7); 

		if (is_resource($fp))
		{
			$getpost	= ( ! empty( $post ) ) ? 'POST ': 'GET ';
		
			fputs($fp, $getpost.$path." HTTP/1.0\r\n" ); 
			fputs($fp, "Host: ".$host . "\r\n" );
			
			if ( ! empty( $post ) )
			{
				$str	= '';
				
				foreach ( $post as $key => $val )
				{
					$str	.= urlencode( $key ) . "=" . urlencode( $val ) . "&";
				}
				
				$str	= substr( $str, 0, -1 );

				fputs($fp, "Content-type: application/x-www-form-urlencoded\r\n");
				fputs($fp, "Content-length: " . strlen( $str ) . "\r\n");
			}
			
			fputs($fp, "User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1)\r\n");
			fputs($fp, "Connection: close\r\n\r\n");
			
			if ( ! empty( $post ) )
			{
				fputs($fp, $str . "\r\n\r\n");
			}
			
			/* ------------------------------
			/*  This error suppression has to do with a PHP bug involving
			/*  SSL connections: http://bugs.php.net/bug.php?id=23220
			/* ------------------------------*/
			
			$old_level = error_reporting(0);
			
			while ( ! feof($fp))
			{
				$data .= trim(fgets($fp, 128));
			}
			
			error_reporting($old_level);

			fclose($fp); 
		}
		
		return trim($data); 
	}
	/* END fetch_url() */
	
	
	// --------------------------------------------------------------------

	/**
	 * Write File
	 *
	 * @access	public
	 * @param	$file	Full location of final file
	 * @param	$data	Data to put into file
	 * @return	bool
	 */
    
    function write_file($file, $data)
    {	
    	$temp_file = $file.'.tmp';
        
        if ( ! file_exists($temp_file))
        {
        	// Remove old cache file, prevents rename problem on Windows
        	// http://bugs.php.net/bug.php?id=44805
        	
			@unlink($file);
        	
			if (file_exists($file))
			{
				$this->errors[] = "Unable to Delete Old Cache File: ".$file;
				return FALSE;
			}
        
			if ( ! $fp = @fopen($temp_file, 'wb'))
			{
				$this->errors[] = "Unable to Write Temporary Cache File: ".$temp_file;
				return FALSE;
			}
			
			if ( ! flock($fp, LOCK_EX | LOCK_NB))
			{
				$this->errors[] = "Locking Error when Writing Cache File";
				return FALSE;
			}
			
			fwrite($fp, $data);
			flock($fp, LOCK_UN);
			fclose($fp);
			
			// Write, then rename...
			@rename($temp_file, $file);
			
			// Double check permissions
			@chmod($file, 0777); 
			
			// Just in case the rename did not work
			@unlink($temp_file);
		}
		
        return TRUE;
	}
	/* END write_file() */
	
	
	// --------------------------------------------------------------------

	/**
	 * Check that File is Really Writable, Even on Windows
	 *
	 * is_writable() returns TRUE on Windows servers when you really cannot write to the file
	 * as the OS reports to PHP as FALSE only if the read-only attribute is marked.  Ugh!
	 *
	 * Oh, and there is some silly thing with 
	 *
	 * @access	public
	 * @param	string		$path	- Path to be written to.
	 * @param	bool		$remove	- If writing a file, remove it after testing?
	 * @return	bool
	 */
    
	
	function is_really_writable($file, $remove = FALSE)
	{
		// is_writable() returns TRUE on Windows servers
		// when you really can't write to the file
		// as the OS reports to PHP as FALSE only if the
		// read-only attribute is marked.  Ugh?
		
		if (substr($file, -1) == '/' OR is_dir($file))
		{
			return self::is_really_writable(rtrim($file, '/').'/'.uniqid(mt_rand()), TRUE);
		}
		
		if (($fp = @fopen($file, 'ab')) === FALSE)
		{
			return FALSE;
		}
		else
		{
			if ($remove === TRUE)
			{
				@unlink($file);
			}
			
			fclose($fp);
			return TRUE;
		}
	}
	/* END is_really_writable() */


	// --------------------------------------------------------------------

	/**
	 *	Check Captcha
	 *
	 *	If Captcha is required by a module, we simply do all the work
	 *
	 *	@access		public
	 *	@return		bool
	 */
	
	function check_captcha()
    {        
		if ( ee()->config->item('captcha_require_members') == 'y'  || 
			(ee()->config->item('captcha_require_members') == 'n' AND ee()->session->userdata['member_id'] == 0))
		{
			if ( empty($_POST['captcha']))
			{
				return FALSE;
			}
			else
			{
				$res = ee()->db->query("SELECT COUNT(*) AS count FROM exp_captcha
										WHERE word='".ee()->db->escape_str($_POST['captcha'])."'
										AND ip_address = '".ee()->db->escape_str(ee()->input->ip_address())."'
										AND date > UNIX_TIMESTAMP()-7200");

				if ($res->row('count') == 0)
				{
					return FALSE;
				}

				ee()->db->query("DELETE FROM exp_captcha
								WHERE (word='".ee()->db->escape_str($_POST['captcha'])."' AND
									   ip_address = '".ee()->db->escape_str(ee()->input->ip_address())."')
								OR date < UNIX_TIMESTAMP()-7200");
			}
		}
		
		return TRUE;
    }
    /* END check_captcha() */	
	
	// --------------------------------------------------------------------

	/**
	 *	Check Secure Forms
	 *
	 *	Checks to see if Secure Forms is enabled, and if so sees if the submitted hash is valid
	 *
	 *	@access		public
	 *	@return		bool
	 */
	
	function check_secure_forms()
    {        
		//	----------------------------------------
		//	 Secure forms?
		//	----------------------------------------
      
        if ( ee()->config->item('secure_forms') == 'y' )
        {
        	if ( ! isset($_POST['XID']) AND ! isset($_GET['XID']))
        	{
        		return FALSE;
        	}
        	
        	$hash = (isset($_POST['XID'])) ? $_POST['XID'] : $_GET['XID'];
        	
            $query = ee()->db->query("SELECT COUNT(*) AS count FROM exp_security_hashes
            						  WHERE hash = '" . ee()->db->escape_str($hash) . "'
            						  AND ip_address = '" . ee()->db->escape_str(ee()->input->ip_address()) . "'
            						  AND date > UNIX_TIMESTAMP()-7200");
        
            if ($query->row('count') == 0)
            {
				return FALSE;
			}
                                
			ee()->db->query("DELETE FROM exp_security_hashes
							 WHERE (hash = '".ee()->db->escape_str($hash)."' AND ip_address = '" . ee()->db->escape_str(ee()->input->ip_address()) . "') 
							 OR date < UNIX_TIMESTAMP()-7200");
        }
        
		//	----------------------------------------
		//	 Return
		//	----------------------------------------
		
		return TRUE;
    }
    /* END check_secure_forms() */
	
	
	// --------------------------------------------------------------------

	//depricated. please instead include in your view headers.
	//uncompressed is available in svn
	//this is due to be moved into addon view folders

	/**
	 * A Slightly More Flexible Magic Checkbox
	 *
	 * Toggles the checkbox based on clicking anywhere in the table row that contains the checkbox
	 * Also allows multiple master toggle checkboxes at the top and bottom of a table to de/select all checkboxes
	 *		- give them a name="toggle_all_checkboxes" attribute
	 *		- No longer need to add onclick="toggle(this);" attribute
	 * No longer do you have to give your <form> tag an id="target" attrbiute, you can specify your own ID:
	 *		- <script type="text/javascript">create_magic_checkboxes('delete_cached_uris_form');</script>
	 *		- Or, if you specify no ID, it will find every <table> in the document with a class of 
	 *		'magic_checkbox_table' and create the magic checkboxes automatically
	 * Also, it fixes that annoying problem where it was very difficult to easily select text in a row.
	 *
	 *
	 * @access	public
	 * @return	string
	 */
    
    function js_magic_checkboxes()
	{
		return <<< EOT
<script type="text/javascript"> 
var lastCheckedBox="";
function create_magic_checkboxes(d){if(typeof d=="undefined"){var k=document.getElementsByTagName("table");for(d=0;d<k.length;d++)if(k[d].className.indexOf("magic_checkbox_table")>-1||k[d].className.indexOf("magicCheckboxTable")>-1)create_magic_checkboxes(k[d])}else{if(typeof d=="object")var l=d;else if(typeof d=="string"){if(!document.getElementById(d))return;l=document.getElementById(d)}else return;k=l.getElementsByTagName("tr");for(d=0;d<k.length;d++)for(var c=0;c<2;c++)for(var g=c==1?"th":"td",
h=k[d].getElementsByTagName(g),m=0;m<h.length;m++)h[m].onclick=function(e){e=e?e:window.event?window.event:"";var a=e.target||e.srcElement,i=a.tagName?a.tagName.toLowerCase():null;if(i==null){a=a.parentNode;i=a.tagName?a.tagName.toLowerCase():null}if(i!="a"&&i!=null){for(;a.tagName.toLowerCase()!="tr";){a=a.parentNode;if(a.tagName.toLowerCase()=="a")return}for(var f=a.getElementsByTagName(g),b=a.getElementsByTagName("input"),n=false,o=false,j=0;j<b.length;j++)if(b[j].type=="checkbox"){if(b[j].name==
"toggle_all_checkboxes")o=true;else n=b[j].id;break}if(!(n==false&&o==false))if(o==true){if(i=="input"){selectAllVal=b[j].checked?true:false;e=l.getElementsByTagName("tr");b=l.getElementsByTagName("input");for(j=0;j<b.length;j++)if(b[j].type=="checkbox")b[j].checked=selectAllVal;for(a=1;a<e.length;a++){f=e[a].getElementsByTagName(g);for(b=0;b<f.length;b++)f[b].className=selectAllVal==true?f[b].className.indexOf("tableCellOne")>-1?"tableCellOneHover":"tableCellTwoHover":f[b].className.indexOf("tableCellTwo")>
-1?"tableCellTwo":"tableCellOne"}}}else{if(i!="input")document.getElementById(n).checked=document.getElementById(n).checked?false:true;if(window.getSelection||document.selection&&document.selection.createRange){b=window.getSelection?window.getSelection().toString():document.selection.createRange().text;if(b!=""&&b.replace(/<\/?[^>]+(>|$)/g,"").replace(/\s*/g,"")=="")if(document.getSelection)window.getSelection().removeAllRanges();else document.selection?document.selection.empty():document.getElementById(n).focus()}for(b=
0;b<f.length;b++)f[b].className=document.getElementById(n).checked==true?f[b].className.indexOf("tableCellTwo")>-1?"tableCellTwoHover":"tableCellOneHover":f[b].className.indexOf("tableCellOne")>-1?"tableCellOne":"tableCellTwo";e.shiftKey&&lastCheckedBox!=""&&shift_magic_checkbox(document.getElementById(n).checked,lastCheckedBox,a);lastCheckedBox=a}}}}}
function shift_magic_checkbox(d,k,l){var c=l.parentNode,g=c.tagName?c.tagName.toLowerCase():null;if(g==null){c=c.parentNode;g=c.tagName?c.tagName.toLowerCase():null}if(g!=null){for(;c.tagName.toLowerCase()!="table";)c=c.parentNode;c=c.getElementsByTagName("tr");g=false;for(var h=1;h<c.length;h++)if(!(g==false&&c[h]!=k&&c[h]!=l))for(var m=0;m<2;m++){var e=m==1?"th":"td";e=c[h].getElementsByTagName(e);for(var a=c[h].getElementsByTagName("input"),i=false,f=0;f<a.length;f++)if(a[f].type=="checkbox")i=
a[f].id;if(i==false||i=="")return;document.getElementById(i).checked=d;for(a=0;a<e.length;a++)e[a].className=d==true?e[a].className.indexOf("tableCellTwo")>-1?"tableCellTwoHover":"tableCellOneHover":e[a].className.indexOf("tableCellOne")>-1?"tableCellOne":"tableCellTwo";if(c[h]==k||c[h]==l){if(g==true)break;if(g==false)g=true}}}};
</script>			
EOT;
	}
    /* END js_magic_checkboxes() */
    
	
	
	// --------------------------------------------------------------------

	/**
	 * Balance a URI
	 *
	 * @access	public
	 * @param	string	$uri
	 * @return	array
	 */
    
	function balance_uri( $uri )
	{
		$uri = '/'.trim($uri, '/').'/';
		
		if ($uri == '//' OR $uri == '')
		{
			$uri = '/';
		}
		
		return $uri;
	}
	/* END balance_uri() */
	
	// --------------------------------------------------------------------

	/**
	 * Fetch Themes for a path
	 *
	 * @access	public
	 * @param	string		$path - Absolute server path to theme directory
	 * @return	array
	 */    
    
	function fetch_themes($path)
	{
		$themes = array();
		
		if ($fp = @opendir($path))
		{ 
			while (false !== ($file = readdir($fp)))
			{			
				if (is_dir($path.$file) AND substr($file, 0, 1) != '.') 
				{				
					$themes[] = $file;
				}
			}		 
			
			closedir($fp); 
		}
	
		sort($themes);
		
		return $themes;
	}
	/* END fetch_themes() */
	
	
	// --------------------------------------------------------------------
	
	/**
	 * Allowed Group
	 *
	 * Member access validation
	 *
	 * @access	public
	 * @param	string
	 * @return	bool
	 */	
	function allowed_group($which = '')
	{
		if ( is_object(ee()->cp))
		{
			return ee()->cp->allowed_group($which);
		}
		else
		{
			return ee()->display->allowed_group($which);
		}
	}
	/* END allowed_group() */
	
	
	// --------------------------------------------------------------------
	
	/**
	 * Global Error Message Routine
	 *
	 * @access	public
	 * @param	string
	 * @return	bool
	 */	
	function show_error($which = '')
	{
		if ( function_exists('show_error'))
		{
			show_error($which);
		}
		else
		{
			ee()->display->error_message($which);
		}
	}
	/* END error_message() */
	
	// --------------------------------------------------------------------

	/**
	 *	Check if Submitted String is a Yes value
	 *
	 *	If the value is 'y', 'yes', 'true', or 'on', then returns TRUE, otherwise FALSE
	 *
	 *	@access		public
	 *	@param		string
	 *	@return		bool
	 */

    function check_yes($which)
    {
		switch($which)
		{
			case 'y'	:
			case 'yes'	:
			case 'on'	:
			case 'true'	:
				return TRUE;
			break;
			default		:
				return FALSE;	
			break;
		}
    }
    /* END check_yes() */
    
	// --------------------------------------------------------------------

	/**
	 *	Check if Submitted String is a No value
	 *
	 *	If the value is 'n', 'no', 'false', or 'off', then returns TRUE, otherwise FALSE
	 *
	 *	@access		public
	 *	@param		string
	 *	@return		bool
	 */

    function check_no($which)
    {
		switch($which)
		{
			case 'n'	:
			case 'no'	:
			case 'off'	:
			case 'false'	:
				return TRUE;
			break;
			default		:
				return FALSE;	
			break;
		}
    }
    /* END check_yes() */


	// --------------------------------------------------------------------

	/**
	 *	json_encode
	 *
	 *	@access		public
	 *	@param		object
	 *	@return		string
	 */

    public function json_encode($data)
    {
		if (function_exists('json_encode'))
		{
			return json_encode($data);
		}
		
		if ( ! class_exists('Services_JSON'))
		{
			require_once $this->aob_path . '/json.php';
		}
		
		if ( ! is_object($this->json))
		{
			$this->json = new Services_JSON();
		}
		
		return $this->json->encode($data);
    }
    /* END json_encode() */


	// --------------------------------------------------------------------

	/**
	 *	json_decode
	 *
	 *	@access		public
	 *	@param		string
	 *	@return		object
	 */

    public function json_decode($data)
    {
		if (function_exists('json_decode'))
		{
			return json_decode($data);
		}
		
		if ( ! class_exists('Services_JSON'))
		{
			require_once $this->aob_path . 'json.php';
		}
		
		if ( ! is_object($this->json))
		{
			$this->json = new Services_JSON();
		}
		
		return $this->json->decode($data);
    }
    // END json_decode()


	// --------------------------------------------------------------------

	/**
	 *	Pagination for all versions front-end and back
	 *
	 *	* = optional
	 *	$input_data = array(
	 *		'sql'					=> '', 
	 *		'total_results'			=> '', 
	 *		*'url_suffix' 			=> '',
	 *		'tagdata'				=> ee()->TMPL->tagdata,
	 *		'limit'					=> '',
	 *		*'offset'				=> ee()->TMPL->fetch_param('offset'),
	 *		*'query_string_segment'	=> 'P',
	 *		'uri_string'			=> ee()->uri->uri_string,
	 *		*'current_page'			=> 0
	 *		*'pagination_config'	=> array()
	 *	);
	 *
	 *	@access		public
	 *	@param		array
	 *	@return		array
	 */

	function universal_pagination( $input_data )
	{	
	    // -------------------------------------
	    //	prep input data
		// -------------------------------------

		//set defaults for optional items
		$input_defaults	= array(
			'url_suffix' 			=> '',
			'query_string_segment' 	=> 'P',
			'offset'				=> 0,
			'pagination_page'		=> 0,
			'pagination_config'		=> array(),
			'sql'					=> '',
			'tagdata'				=> '',
			'uri_string'			=> '',
			'paginate_prefix'		=> ''
		);

		//using query strings?
		$use_query_strings 				= (REQ == 'CP' OR ee()->config->item('enable_query_strings'));

		//array2 overwrites any duplicate key from array1
		$input_data 					= array_merge($input_defaults, $input_data);

		//make sure there is are surrounding slashes.
		$input_data['uri_string']		= '/' . trim($input_data['uri_string'], '/') . '/';

		//shortcuts
		$config							= $input_data['pagination_config'];		 
		$p								= $input_data['query_string_segment'];
		$config['query_string_segment'] = $input_data['query_string_segment'];
		$config['page_query_string']	= $use_query_strings;
				
		//current page
		if ( ! $use_query_strings AND preg_match("/$p(\d+)/s", $input_data['uri_string'], $match) )
		{		
			if ( $input_data['pagination_page'] == 0 AND is_numeric($match[1]) )
			{
				$input_data['pagination_page'] 	= $match[1];
				
				//remove page from uri string, query_string, and uri_segments
				$input_data['uri_string'] 		= ee()->functions->remove_double_slashes(
					str_replace($p . $match[1] , '', $input_data['uri_string'] )
				);
			}
		}
		else if ( $use_query_strings === FALSE)
		{
			if ( ! is_numeric($input_data['pagination_page']) )
			{
				$input_data['pagination_page'] = 0;
			}
		}
		else if ( ! in_array(ee()->input->get_post($input_data['query_string_segment']), array(FALSE, '')))
		{
			$input_data['pagination_page'] = ee()->input->get_post($input_data['query_string_segment']);
		}

		//this prevents the CI pagination class from 
		//trying to find the number itself... 
		//why isn't that an option?
		$config['uri_segment'] = 1000;

	    // -------------------------------------
	    //	prep return data
		// -------------------------------------

		$return_data 	= array(		
			'paginate'				=> FALSE,	 
			'paginate_tagpair_data'	=> '',
			'current_page'			=> 0,		
			'total_pages'			=> 0,
			'page_count'			=> '',
			'pagination_links'		=> '',
			'base_url'				=> '',
			'page_next'				=> '',
			'page_previous'			=> '',
			'pagination_page'		=> $input_data['pagination_page'],
			'tagdata'				=> $input_data['tagdata'],
			'sql'					=> $input_data['sql'],
		);

	    // -------------------------------------
	    //	Begin pagination check
		// -------------------------------------

		if (REQ == 'CP' OR 
				(strpos( $return_data['tagdata'], LD . $input_data['paginate_prefix'] . 'paginate' ) !== FALSE OR 
				 strpos( $return_data['tagdata'], LD . 'paginate' ) !== FALSE) 
			)
		{
			$return_data['paginate'] = TRUE;

			//has tags?
			if ($input_data['paginate_prefix'] != '' AND preg_match( 
					"/" . LD . $input_data['paginate_prefix'] . "paginate" . RD . "(.+?)" . 
						  LD . preg_quote(T_SLASH, '/') . $input_data['paginate_prefix'] . "paginate" . RD . "/s", 
					$return_data['tagdata'], 
					$match
				))
			{			
				$return_data['paginate_tagpair_data']	= $match[1];
				$return_data['tagdata'] 				= str_replace( $match[0], '', $return_data['tagdata'] );
			}
		
			//prefix comes first
			else if (preg_match( 
					"/" . LD . "paginate" . RD . "(.+?)" . LD . preg_quote(T_SLASH, '/') . "paginate" . RD . "/s", 
					$return_data['tagdata'], 
					$match
				))
			{			
				$return_data['paginate_tagpair_data']	= $match[1];
				$return_data['tagdata'] 				= str_replace( $match[0], '', $return_data['tagdata'] );
			}

			// ----------------------------------------
			//  Calculate total number of pages
			// ----------------------------------------

			$return_data['current_page'] 	= floor($input_data['pagination_page'] / $input_data['limit']) + 1;	
			$return_data['total_pages']		= ceil($input_data['total_results'] / $input_data['limit']);
			$return_data['page_count'] 		= ee()->lang->line('page') 		. ' ' . 
										 	  $return_data['current_page'] 	. ' ' . 
										 	  ee()->lang->line('of') 		. ' ' . 
										 	  $return_data['total_pages'];

			// ----------------------------------------
			//  Do we need pagination?
			// ----------------------------------------

			if ( $input_data['total_results'] > $input_data['limit'] )
			{
				if ( ! isset( $config['base_url'] )  )
				{
					$config['base_url']			= ee()->functions->create_url(
						$input_data['uri_string'] . $input_data['url_suffix'], 
						FALSE, 
						0
					);
				}
	
				$config['total_rows'] 	= $input_data['total_results'];
				$config['per_page']		= $input_data['limit'];
				$config['cur_page']		= $input_data['pagination_page'];

				ee()->load->library('pagination');

				ee()->pagination->initialize($config);

				$return_data['pagination_links']		= ee()->pagination->create_links();

				$return_data['base_url']				= ee()->pagination->base_url;

				//fix links if not query strings
				if ( ! $use_query_strings )
				{					
					$return_data['pagination_links']		= preg_replace( 
						"/" . preg_quote($return_data['base_url'], '/') . 
										"([0-9]+)(?:" . preg_quote(T_SLASH, '/') . ")?/s",
						rtrim( $return_data['base_url'] . $p . "$1", '/') . '/',
						$return_data['pagination_links']
					);
				}

				// ----------------------------------------
				//  Prepare next_page and previous_page variables
				// ----------------------------------------

				//next page?
				if ( (($return_data['total_pages'] * $input_data['limit']) - $input_data['limit']) >
				 	 $return_data['pagination_page'])
				{						
					$return_data['page_next'] = $return_data['base_url'] . 
						($use_query_strings ? '' : $p) . 
						($input_data['pagination_page'] + $input_data['limit']) . '/';
				}

				//previous page?
				if (($return_data['pagination_page'] - $input_data['limit'] ) >= 0) 
				{						
					$return_data['page_previous'] = $return_data['base_url'] . 
						($use_query_strings ? '' : $p) . 
						($input_data['pagination_page'] - $input_data['limit']) . '/';
				}
			}
		}

		//??
		$return_data['current_page'] 	+= $input_data['offset'];

		$return_data['sql'] 			.= 	' LIMIT ' . ($return_data['pagination_page'] + $input_data['offset']) . 
											', ' . $input_data['limit'];

		return $return_data;
	}
	//	End universal_pagination	


	// --------------------------------------------------------------------
	
	/**
	 * Create XID
	 *
	 * This creates a new XID hash in the DB for usage.
	 *
	 * @access	public
	 * @return	string
	 */
	 
	public function create_xid()
	{
		$sql 		= "INSERT INTO exp_security_hashes (date, ip_address, hash) VALUES";

		$hash 		= ee()->functions->random('encrypt');
		$sql 		.= "(UNIX_TIMESTAMP(), '". ee()->input->ip_address() . "', '" . $hash . "')";

		self::cacheless_query($sql);
			
		return $hash;
	}
	// END Create XID


	// --------------------------------------------------------------------
	
	/**
	 * cacheless_query
	 *
	 * this sends a query to the db non-cached
	 *
	 * @access	public
	 * @param	string	sql to query
	 * @return	object	query object
	 */
	public function cacheless_query($sql)
	{
		$reset = FALSE;
		
		// Disable DB caching if it's currently set
		
		if (ee()->db->cache_on == TRUE)
		{
			ee()->db->cache_off();
			$reset = TRUE;
		}
		
		$query = ee()->db->query($sql);

		// Re-enable DB caching
		if ($reset == TRUE)
		{
			ee()->db->cache_on();			
		}
		
		return $query;
	}
	// END cacheless_query


    // --------------------------------------------------------------------

	/**
	 * Implodes an Array and Hashes It
	 *
	 * @access	public
	 * @return	string
	 */
    
	public function _imploder($arguments)
    {
    	return md5(serialize($arguments));
    }
    // END
	
	
	// --------------------------------------------------------------------
	
	/**
	 * Prepare keyed result
	 *
	 * Take a query object and return an associative array. If $val is empty, 
	 * the entire row per record will become the value attached to the indicated key.
	 *
	 * For example, if you do a query on exp_channel_titles and exp_channel_data 
	 * you can use this to quickly create an associative array of channel entry 
	 * data keyed to entry id. 
	 *
	 * @access	public
	 * @return	mixed
	 */
    
	public function prepare_keyed_result( $query, $key = '', $val = '' )
    {
    	if ( ! is_object( $query )  OR $key == '' ) return FALSE;
    
 		// --------------------------------------------
        //  Loop through query
        // --------------------------------------------
        
        $data	= array();
        
        foreach ( $query->result_array() as $row )
        {
        	if ( isset( $row[$key] ) === FALSE ) continue;
        	
        	$data[ $row[$key] ]	= ( $val != '' AND isset( $row[$val] ) ) ? $row[$val]: $row;
        }
        
        return ( empty( $data ) ) ? FALSE : $data;
	}
	// END prepare_keyed_result
	
	
	// --------------------------------------------------------------------

	/**
	 * returns the truthy or last arg i
	 *
	 * @access	public
	 * @param	array 	args to be checked against
	 * @param	mixed	bool or array of items to check against
	 * @return	mixed
	 */
	public function either_or_base($args = array(), $test = FALSE)
	{
		foreach ($args as $arg)
		{
			//do we have an array of nots?
			//if so, we need to be test for type
			if ( is_array($test))
			{
				if ( ! in_array($arg, $test, TRUE) ) return $arg;
			}
			//is it implicit false?
			elseif ($test)
			{
				if ($arg !== FALSE) return $arg;
			}
			//else just test for falsy
			else
			{
				if ($arg) return $arg;
			}
		}

		return end($args);
	}
	//END either_or_base


	// --------------------------------------------------------------------

	/**
	 * returns the truthy or last arg
	 *
	 * @access	public
	 * @param	mixed	any number of arguments consisting of variables to be returned false
	 * @return	mixed
	 */
	public function either_or()
	{
		$args = func_get_args();

		return $this->either_or_base($args);
	}
	//END either_or


	// --------------------------------------------------------------------

	/**
	 * returns the non exact bool FALSE or last arg
	 *
	 * @access	public
	 * @param	mixed	any number of arguments consisting of variables to be returned false
	 * @return	mixed
	 */
	public function either_or_strict()
	{
		$args = func_get_args();

		return $this->either_or_base($args, TRUE);
	}
	// END either_or_strict

	//---------------------------------------------------------------------

	/**
	 * add_right_link 
	 * @access	public
	 * @param	(string)	string of link name
	 * @param	(string)	html link for right link
	 * @return	(null)
	 */
	
	function add_right_link($text, $link)
	{	
		//no funny business
		if (REQ != 'CP') return;

		$this->right_links[$text] = $link;
	}
	//end add_right_link

	//---------------------------------------------------------------------

	/**
	 * build_right_links 
	 * @access	public
	 * @return	(null)
	 */
	
	function build_right_links()
	{	
		//no funny business
		if (REQ != 'CP' OR empty($this->right_links)) return;
							
		if (APP_VER < 2.0)
		{
			$this->cached_vars['right_links'] = $this->right_links;
		}
		else
		{
			ee()->cp->set_right_nav($this->right_links);
		}
	}
	//end build_right_links
	
	// --------------------------------------------------------------------

	/**
	 *	Fetch List of Member Fields and Data
	 *
	 *	@access		public
	 *	@return		string
	 */
	
	public function mfields()
    {
		return $this->mfields = $this->data->get_member_fields();
	}
	// END mfields()
	
	
	// --------------------------------------------------------------------
		
	/**
	 * do we have any hooks?
	 *
	 * 
	 * @access	public
	 * @return	bool	Whether the extensions are allowed
	 */
	 
	public function has_hooks()
	{					
		//is it there? is it array? is it empty? Such are life's unanswerable questions, until now.
		if ( ((! isset($this->updater()->hooks) 	OR 
			  ! is_array($this->updater->hooks))	AND
			 (! isset($this->hooks) 				OR 
			  ! is_array($this->hooks))) 			OR 
			 (empty($this->hooks) AND empty($this->updater->hooks))
		)
		{	
			return FALSE; 
		}
		
		return TRUE;
	}
	//end has hooks	

	
	// --------------------------------------------------------------------
		
	/**
	 * loads updater object and sets it to $this->upd and returns it
	 *
	 * 
	 * @access	public
	 * @return	obj		updater object for module
	 */
	 
	public function updater()
	{					
		if ( ! is_object($this->updater) )
		{
			$class 			= $this->class_name . '_updater_base';
	
			$update_file 	= $this->addon_path . '/upd.' . $this->lower_name . '.base.php';
		
			if ( ! class_exists($class))
			{
				if (is_file($update_file))
				{
					require_once $update_file;
				}
				else
				{
					//techincally, this is false, but we dont want to halt something else because the
					//file cannot be found that we need here. Needs to be a better solution
					return FALSE;
				}			 
			}
		
			$this->updater	= new $class();
		}
		
		return $this->updater;
	}
	//end updater
		
		
	// --------------------------------------------------------------------
		
	/**
	 * Checks to see if extensions are enabled for this module
	 *
	 * 
	 * @access	public
	 * @param	bool	match exact number of hooks
	 * @return	bool	Whether the extensions are enabled if need be
	 */
	 
	public function extensions_enabled( $check_all_enabled = FALSE )
	{		
		if ( ! $this->has_hooks() ) return TRUE;
		
		$query = ee()->db->query(
			"SELECT enabled 
			 FROM 	exp_extensions 
			 WHERE 	class = '" . ee()->db->escape_str($this->extension_name) . "'
			 AND	enabled = 'y'"
		);
		
		//we arent going to look for all of the hooks because some could be turned off manually for testing
		return (($check_all_enabled) ? 
					($query->num_rows() == count($this->updater()->hooks) ) : 
					($query->num_rows() > 0) );		
	}
	//END extensions_enabled
}
/* END Addon_builder Class */
