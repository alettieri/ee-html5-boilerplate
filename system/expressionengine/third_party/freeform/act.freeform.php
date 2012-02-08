<?php if ( ! defined('EXT')) exit('No direct script access allowed');
 
 /**
 * Solspace - Freeform
 *
 * @package		Solspace:Freeform
 * @author		Solspace DevTeam
 * @copyright	Copyright (c) 2008-2011, Solspace, Inc.
 * @link		http://solspace.com/docs/addon/c/Freeform/
 * @version		3.1.0
 * @filesource 	./system/expressionengine/third_party/freeform/
 */
 
 /**
 * Freeform - Actions
 *
 * Handles All Form Submissions and Action Requests Used on both User and CP areas of EE
 *
 * @package 	Solspace:Freeform
 * @author		Solspace DevTeam
 * @filesource 	./system/expressionengine/third_party/freeform/act.freeform.php
 */

require_once 'addon_builder/addon_builder.php';

class Freeform_actions extends Addon_builder_freeform {
    
	// --------------------------------------------------------------------

	/**
	 * Constructor
	 
	 * @access	public
	 * @return	null
	 */
    
	function Freeform_actions()
    {	
    	parent::Addon_builder_freeform('freeform');
    	
    	/** -------------------------------------
		/**  Module Installed and What Version?
		/** -------------------------------------*/
			
		if ($this->database_version() == FALSE OR $this->version_compare($this->database_version(), '<', FREEFORM_VERSION))
		{
			return;
		}
	}
	/* END */


}
/* END Freeform_actions Class */


?>
