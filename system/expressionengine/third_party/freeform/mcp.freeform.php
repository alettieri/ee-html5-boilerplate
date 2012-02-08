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
 * Freeform Class - Control Panel
 *
 * The handler class for all control panel requests
 *
 * @package 	Solspace:Freeform
 * @author		Solspace DevTeam
 * @filesource 	./system/expressionengine/third_party/freeform/mcp.freeform.php
 */
 
require_once 'mcp.freeform.base.php';

if (APP_VER < 2.0)
{
	eval('class Freeform_CP extends Freeform_cp_base { }');
}
else
{
	eval('class Freeform_mcp extends Freeform_cp_base { }');
}
?>