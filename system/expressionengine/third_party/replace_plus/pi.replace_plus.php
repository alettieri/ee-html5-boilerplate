<?php

/*
=====================================================
 This ExpressionEngine plugin was created by Laisvunas
 - http://devot-ee.com/developers/ee/laisvunas/
=====================================================
 Copyright (c) Laisvunas
=====================================================
 Purpose: Find and replace characters in some text.
=====================================================
*/

$plugin_info = array(
                 'pi_name'          => 'Find and Replace Plus',
                 'pi_version'       => '1.4.1',
                 'pi_author'        => 'Laisvunas',
                 'pi_author_url'    => '- http://devot-ee.com/developers/ee/laisvunas/',
                 'pi_description'   => 'Finds and replaces characters in some text, like the php str_replace() function',
                 'pi_usage'         => replace_plus::usage()
               );


class Replace_plus {

    var $return_data;

    // ----------------------------------------
    //  Find and Replace Plus
    // ----------------------------------------

    function Replace_plus()
    {
      $this->EE =& get_instance();
      
      // fetch tagdata
      $tagdata = $this->EE->TMPL->tagdata;
      
      //echo '$tagdata: ['.$tagdata.']';
      
      // prepare for cleaning up params
      $dirty = array(':SPACE:', ':QUOTE:', ':SLASH:', ':LD:', ':RD:');
      $clean = array(' ', '"', '/', '{', '}');
      
      // fetch tag's params
      $find_param = $this->EE->TMPL->fetch_param('find');
      $replace_param = $this->EE->TMPL->fetch_param('replace');
      $multiple_param = $this->EE->TMPL->fetch_param('multiple');
      $casesensitive_param = $this->EE->TMPL->fetch_param('casesensitive');
      $regex_param = $this->EE->TMPL->fetch_param('regex');
      $regex_limit = $this->EE->TMPL->fetch_param('regex_limit') ? $this->EE->TMPL->fetch_param('regex_limit') : -1;
      
      // clean up tag's params
      $find_param = str_replace($dirty, $clean, $find_param);
      $replace_param = str_replace($dirty, $clean, $replace_param);
      
      // dafault for parameter "replace" is empty string
      if ($replace_param === FALSE)
      {
        $replace_param = '';
      }
      
      // I. Finding if there is at least one {replace_area}{/replace_area}
      // variable pair
      
      $opening_tag_pos = strpos($tagdata, LD.'replace_area');
      $closing_tag_pos = strpos($tagdata, LD.'/replace_area'.RD);
      // the case there is no {replace_area}{/replace_area}
      // variable pair
      if ($opening_tag_pos === FALSE OR $closing_tag_pos === FALSE)
      {
        
        // II. Perform find-replace
        
        $tagdata = $this->perform_find_replace($tagdata, $find_param, $replace_param, $multiple_param, $casesensitive_param, $regex_param, $regex_limit);
        
        // output tagdata
        $this->return_data = $tagdata;
      }
      else
      {
        // III. Finding data inside the last {replace_area}{/replace_area}
        // variable pair
        
        while (strpos($tagdata, LD.'replace_area') !== FALSE)
        {
          $opening_tag_last_pos = strrpos($tagdata, LD.'replace_area');
          //echo 'opening_tag_last_pos: '.$opening_tag_last_pos.'<br><br>';
          if ($opening_tag_last_pos !== FALSE)
          {
            $tagdata_first_half = substr($tagdata, 0, $opening_tag_last_pos);
            //echo 'tagdata_first_half:<br><br>'.$tagdata_first_half.'<br><br>';
            $tagdata_second_half = substr($tagdata, $opening_tag_last_pos);
            //echo 'tagdata_second_half:<br><br>'.$tagdata_second_half.'<br><br>';
            $tagdata_second_half_splitted = explode(LD.'/replace_area'.RD, $tagdata_second_half, 2);
            //echo 'count tagdata_second_half_splitted: '.count($tagdata_second_half_splitted).'<br><br>';
            
            // the case there are both opening and closing part of
            // {replace_area}{/replace_area} variable pair
            if (count($tagdata_second_half_splitted) >= 2)
            {
              //echo 'tagdata_second_half_splitted 0: <br><br>'.$tagdata_second_half_splitted[0].'<br><br>';
              //echo 'tagdata_second_half_splitted 1: <br><br>'.$tagdata_second_half_splitted[1].'<br><br>';
              $replace_area = $tagdata_second_half_splitted[0];
              $right_brace_pos = strpos($replace_area, RD);
              $parameters = substr($replace_area, 0, $right_brace_pos);
              //echo 'parameters: '.$parameters.'<br><br>';
              $replace_area = substr($replace_area, $right_brace_pos + 1);
              //echo 'replace_area:<br><br>'.$replace_area.'<br><br>';
              
              // IV. Fetch parameters of {replace_area} variable pair

                $find = $this->fetch_area_parameter($parameters, 'find');
                $find = str_replace($dirty, $clean, $find);
                //echo 'find: '.$find.'<br><br>'; 
                $replace = $this->fetch_area_parameter($parameters, 'replace');
                $replace = str_replace($dirty, $clean, $replace);
                // dafault for parameter "replace" is empty string
                if ($replace === FALSE)
                {
                  $replace = '';
                }
                //echo 'replace: '.$replace.'<br><br>';
                $multiple = $this->fetch_area_parameter($parameters, 'multiple');
                //echo 'multiple: '.$multiple.'<br><br>';
                $casesensitive = $this->fetch_area_parameter($parameters, 'casesensitive');
                //echo 'casesensitive: '.$casesensitive.'<br><br>';
                $regex = $this->fetch_area_parameter($parameters, 'regex');
                //echo 'regex: '.$regex.'<br><br>';
                $regex_limit = $this->fetch_area_parameter($parameters, 'regex_limit');
                //echo 'regex_limit: '.$regex_limit.'<br><br>';
              
              // V. Perform find-replace
              
              $replace_area = $this->perform_find_replace($replace_area, $find, $replace, $multiple, $casesensitive, $regex, $regex_limit);
              
              // assemble tagdata
              $tagdata = $tagdata_first_half.$replace_area.$tagdata_second_half_splitted[1];
              //echo 'tagdata: <br><br>'.$tagdata;              
            }
            else
            {
              break;
            }
          }
          else
          {
            break;
          }
        }
        // output tagdata
        $this->return_data = $tagdata;
      }
    }
    // END FUNCTION  
    
// ----------------------------------------
//  Plugin Usage
// ----------------------------------------

// This function describes how the plugin is used.

function usage()
{
ob_start(); 
?>
This plugin works pretty much the same as the php str_replace() function:
http://www.php.net/manual/en/function.str-replace.php and the preg_replace() function:
http://www.php.net/manual/en/function.preg-replace.php

ExpressionEngine strips the white space from the beginning and the end of each parameter. Because of this,
if you want to replace something with a space, use the string ":SPACE:" instead.
If you want to use a double quote in a parameter value, use the string ":QUOTE:" instead.
If you want to use slash in a parameter value, use the string ":SLASH:" instead.
If you want to use left curly brace in a parameter value, use the string ":LD:" instead.
If you want to use right curly brace in a parameter value, use the string ":RD:" instead.

PARAMETERS

1) find - Required. Allows you to specify what strings should be found. You can specify
several strings using pipeline character.

2) replace - Optional. Allows you to specify what strings should replace the strings found.
You can specify several strings using pipeline character. In case you leave this parameter undefined,
the strings found will be replaced with empty string.

3) multiple - Optional. Allows you to specify if you seach for several strings (value "yes"), or
for just one string (value "no"). Default is "no".

4) casesensitive - Optional. Allows you to specify if you want to do casesensitive replace (value "yes")
or caseinsensitive replace (value "no"). Default is "yes".

5) regex - Optional. Allows you to specify regular expression. The value of this param must be "yes" in case the value
of the param "find" is a regular expression.

6) regex_limit - Optional. The maximum possible of regex replacements. Default value is -1 (no limit).

VARIABLE PAIRS

{replace_area}{/replace_area} - Optional. allows you to specify area in which the plugin should do find-replace
operations.

Each parameter can be used not only inside exp:replace_plus tag but also inside {replace_area}
variable pair. In case parameter is defined both inside exp:replace_plus tag and inside {replace_area}
variable pair, the value of the latter overrides the value of the former.

{replace_area}{/replace_area} can be nested. This feature can be handy in cases initial find-replace produces
unwanted results. Those unwanted results can be corrected by wrapping one variable pair inside another pair having
different "find" and "replace" parameters.

EXAMPLES

# Replace A with B:

{exp:replace_plus find="you" replace="we"}
  text you want processed
{/exp:replace_plus}

Result: text we want processed

# Replace A with B inside {replace_area} and {/replace_area} variable pair:

{exp:replace_plus find="you" replace="we"}
text you want processed
{replace_area}
text you want processed
{/replace_area}
text you want processed
{/exp:replace_plus}

Result: 
text you want processed
text we want processed
text you want processed

# Replace A with B inside several {replace_area}{/replace_area} variable pairs:

{exp:replace_plus}
text you want processed
{replace_area find="you" replace="we"}
text you want processed
{/replace_area}
{replace_area find="you" replace="I"}
text you want processed
{/replace_area}
text you want processed
{/exp:replace_plus}

Result: 
text you want processed
text we want processed
text I want processed
text you want processed

# Replace A with B inside {replace_area}{/replace_area} variable pair and
correct unwanted results by wrapping it within another {replace_area}{/replace_area} variable pair:

{exp:replace_plus}
text you want processed
{replace_area find=":SPACE:&gt;:SPACE:" replace=">"}
{replace_area find="<|>" replace="&lt;|&gt;"}
{if total results > 0}
<p>text you want processed</p>
{/if}
{/replace_area}
{/replace_area}
text you want processed
{/exp:replace_plus}

Result: 
text you want processed
&lt;p&gt;text you want processed&lt;/p&gt;
text you want processed

# Replace A with a space:

{exp:replace_plus find="o" replace=":SPACE:"}
  text you want processed
{/exp:replace_plus}

Result: text y u want pr cessed


# Replace a space with nothing

{exp:replace_plus find=":SPACE:"}
  text you want processed
{/exp:replace_plus}

Result: textyouwantprocessed


# Replace A, B and C with D:

{exp:replace_plus find="a|e|i|o|u" replace="X" multiple="yes"}
  text you want processed
{/exp:replace_plus}

Result: tXxt yXX wXnt prXcXssXd


# Replace A, B and C with X, Y and Z:

{exp:replace_plus find="text|you|want" replace="words|we|have" multiple="yes"}
  text you want processed
{/exp:replace_plus}

Result: words we have processed

# Regular Expression find and replace:

{exp:replace_plus find="\w+" replace="*" regex="yes"}
  text you want processed
{/exp:replace_plus}

Result: * * * *

# Regular Expression find and replace with backreference:

{exp:replace_plus find="<a[^>]*href=QUOTE(.+)QUOTE[^>]*>(.*)<\/a>" replace="$2 ($1)" regex="yes"}
  <a href="http://www.foo.com/">text</a> you want <a href="http://www.bar.com/">processed</a>
{/exp:replace_plus}

Result: text (http://www.foo.com/) you want processed (http://www.bar.com/)

Note: if you want to replace something with nothing, best is to omit the replace parameter altogether.
If you want to find multiple strings, always use the multiple="yes" parameter, or else it will search
for the literal string, including vertical bars. The multiple parameter has no effect when using a
regular expression find and replace.

This function is case sensitive by default. Use the parameter casesensitive="no" to ignore case, both
for a normal as for a regular expression find and replace.

When using regex="yes" it is recommended that you set your Debug Preference (Admin > System Preferences
> Output and Debugging Preferences) to 1, so Super Admins can make sure their regular expressions
aren't generating server errors.

<?php
$buffer = ob_get_contents();
	
ob_end_clean(); 

return $buffer;
}
// END USAGE

// ----------------------------------------
//  Helper functions
// ----------------------------------------

function fetch_area_parameter($param_string, $param_name)
{  
  $param_name_pos = strpos($param_string, ' '.$param_name);
  if ($param_name_pos !== FALSE)
  {
    $param_value = substr($param_string, $param_name_pos);
    //echo 'param_value1: '.$param_value.'<br><br>';
    $left_quote_pos = strpos($param_value, '"');
    $param_value = substr($param_value, $left_quote_pos + 1);
    //echo 'param_value2: '.$param_value.'<br><br>';
    $right_quote_pos = strpos($param_value, '"');
    $param_value = substr($param_value, 0, $right_quote_pos);
    //echo 'param_value3: '.$param_value.'<br><br>';
    
  }
  elseif ($this->EE->TMPL->fetch_param($param_name) !== FALSE AND $param_name !== 'key')
  {
    $param_value = $this->EE->TMPL->fetch_param($param_name);
    //echo 'param_value4: '.$param_value.'<br><br>';
  }
  elseif ($param_name !== 'replace')
  {
    $param_value = FALSE;
  }
  else
  {
    $param_value = '';
  }
  //echo 'param_value5: '.$param_value.'<br><br>';
  return $param_value;
}

function perform_find_replace($data, $find, $replace, $multiple, $casesensitive, $regex, $regex_limit)
{
  // regular expression replace
  if ($regex == 'yes' AND $find !== FALSE AND ($replace OR $replace === ''))
  {
    // check find parameter value for first and last character
    if (substr($find, 0, 1) != "/") 
    { 
      $find = "/".$find; 
    }
    if (substr($find, -1, 1) != "/") 
    { 
      $find .= "/"; 
    }
    
    // add case insensitive flag
    if ($casesensitive === 'no')
    {
      $find .= "i";
    }
    $data = preg_replace($find, $replace, $data, $regex_limit);
  }
  // normal str_replace
  elseif ($find !== FALSE AND ($replace OR $replace === ''))
  {
    //echo 'OOOOOOOOOOOOO<br><br>';
    if ($multiple)
    {
      // convert find parameter value to array
      $find  = explode("|", $find);
      
      // convert replace parameter value to array if vertical bar is found
      $replace = (substr_count($replace,"|") == 0) ? $replace : explode("|", $replace);
      
    } 
    // perform str_replace
    if ($casesensitive === 'no' AND function_exists('str_ireplace'))
    {
      $data = str_ireplace($find, $replace, $data);
    }
    if ($casesensitive === 'yes' OR $casesensitive === FALSE)
    {
      $data = str_replace($find, $replace, $data);
    }
    //echo 'data:<br><br>'.$data.'<br><br>';
  }
  return $data;
}

}
// END CLASS

// str_ireplace for php < 5.0    

// +----------------------------------------------------------------------+
// | PHP Version 4                                                        |
// +----------------------------------------------------------------------+
// | Copyright (c) 1997-2004 The PHP Group                                |
// +----------------------------------------------------------------------+
// | This source file is subject to version 3.0 of the PHP license,       |
// | that is bundled with this package in the file LICENSE, and is        |
// | available at through the world-wide-web at                           |
// | http://www.php.net/license/3_0.txt.                                  |
// | If you did not receive a copy of the PHP license and are unable to   |
// | obtain it through the world-wide-web, please send a note to          |
// | license@php.net so we can mail you a copy immediately.               |
// +----------------------------------------------------------------------+
// | Authors: Aidan Lister <aidan@php.net>                                |
// +----------------------------------------------------------------------+
//
// $Id: str_ireplace.php,v 1.18 2005/01/26 04:55:13 aidan Exp $


/**
 * Replace str_ireplace()
 *
 * @category    PHP
 * @package     PHP_Compat
 * @link        http://php.net/function.str_ireplace
 * @author      Aidan Lister <aidan@php.net>
 * @version     $Revision: 1.18 $
 * @since       PHP 5
 * @require     PHP 4.0.0 (user_error)
 * @note        count not by returned by reference, to enable
 *              change '$count = null' to '&$count'
 */
if (!function_exists('str_ireplace')) {
    function str_ireplace($search, $replace, $subject, $count = null)
    {
        // Sanity check
        if (is_string($search) && is_array($replace)) {
            user_error('Array to string conversion', E_USER_NOTICE);
            $replace = (string) $replace;
        }

        // If search isn't an array, make it one
        if (!is_array($search)) {
            $search = array ($search);
        }
        $search = array_values($search);

        // If replace isn't an array, make it one, and pad it to the length of search
        if (!is_array($replace)) {
            $replace_string = $replace;

            $replace = array ();
            for ($i = 0, $c = count($search); $i < $c; $i++) {
                $replace[$i] = $replace_string;
            }
        }
        $replace = array_values($replace);

        // Check the replace array is padded to the correct length
        $length_replace = count($replace);
        $length_search = count($search);
        if ($length_replace < $length_search) {
            for ($i = $length_replace; $i < $length_search; $i++) {
                $replace[$i] = '';
            }
        }

        // If subject is not an array, make it one
        $was_array = false;
        if (!is_array($subject)) {
            $was_array = true;
            $subject = array ($subject);
        }

        // Loop through each subject
        $count = 0;
        foreach ($subject as $subject_key => $subject_value) {
            // Loop through each search
            foreach ($search as $search_key => $search_value) {
                // Split the array into segments, in between each part is our search
                $segments = explode(strtolower($search_value), strtolower($subject_value));

                // The number of replacements done is the number of segments minus the first
                $count += count($segments) - 1;
                $pos = 0;

                // Loop through each segment
                foreach ($segments as $segment_key => $segment_value) {
                    // Replace the lowercase segments with the upper case versions
                    $segments[$segment_key] = substr($subject_value, $pos, strlen($segment_value));
                    // Increase the position relative to the initial string
                    $pos += strlen($segment_value) + strlen($search_value);
                }

                // Put our original string back together
                $subject_value = implode($replace[$search_key], $segments);
            }

            $result[$subject_key] = $subject_value;
        }

        // Check if subject was initially a string and return it as a string
        if ($was_array === true) {
            return $result[0];
        }

        // Otherwise, just return the array
        return $result;
    }
}


    
?>