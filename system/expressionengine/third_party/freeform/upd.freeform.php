<?php if ( ! defined('EXT') ) exit('No direct script access allowed');
 
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
 * Freeform Module Class - Install/Uninstall/Update class
 *
 * @package 	Solspace:Freeform
 * @author		Solspace DevTeam
 * @filesource 	./system/expressionengine/third_party/freeform/upd.freeform.php
 */

require_once 'upd.freeform.base.php';

if (APP_VER < 2.0)
{
	eval('class Freeform_updater extends Freeform_updater_base { }');
}
else
{
	eval('class Freeform_upd extends Freeform_updater_base { }');
}

?>