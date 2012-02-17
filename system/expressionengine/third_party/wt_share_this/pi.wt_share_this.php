<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$plugin_info = array(
	'pi_name' => 'Webtonio Share This',
	'pi_version' => '1.0.0',
	'pi_author' => 'Antonio Lettieri',
	'pi_author_url' => 'http://webtonio.com/',
	'pi_description' => 'Adds share this buttons to posts.',
	'pi_usage' => Wt_share_this::usage()
);

class Wt_share_this {
	
	private $default = "facebook|twitter|email|plusone";
	private $keys;
	private $st_param;
	private $entry_url;
	private $entry_title;
	private $elem;
	private $show_count;
	private $count_type;
	
	public function __construct()
	{
			$this->EE 			=& get_instance();
			$this->keys 		= array("facebook"=>"st_facebook", "twitter"=>"st_twitter","email"=>"st_email","plusone"=>"st_plusone");
			$this->st_param 	= $this->EE->TMPL->fetch_param( 'share' );
			$this->entry_url 	= $this->EE->TMPL->fetch_param( "entry_url" );
			$this->entry_title 	= $this->EE->TMPL->fetch_param( "entry_title" );	
			$this->elem 		= ( $this->EE->TMPL->fetch_param( "element" ) ) 			 ? $this->EE->TMPL->fetch_param( "element" ) : "span";
			$this->share_title  = ( $this->EE->TMPL->fetch_param( "share_title" ) ) 		 ? $this->EE->TMPL->fetch_param("share_title" ) : "Share:";
			$this->show_title   = ( $this->EE->TMPL->fetch_param( "show_title" ) === "yes" ) ? true : false; 
			$this->show_count	= ( $this->EE->TMPL->fetch_param( "show_count" ) === "yes" ) ? true : false;
			$this->count_type	= ( $this->EE->TMPL->fetch_param( "count_type" ) === "v" )	 ? "_vcount" : "_hcount";
			$this->return_data 	= $this->st_nodes();
	}
	
	private function st_nodes(){
		
		$args = ($this->st_param) ? explode("|", $this->st_param) : explode("|", $this->default);
		
		$return_data = "";
		$st_node_class = "";
		
		foreach( $args as $st_node )
		{
			
			if( isset($this->keys[ $st_node ] ) )/* Is this item set? */
			{
				$st_node_class = ( $this->show_count ) ? $this->keys[ $st_node ] . $this->count_type : $this->keys[ $st_node ];
				$return_data .= "<{$this->elem} class='$st_node_class'";
			
				if( $this->entry_url ) /* is the entry_url set? */
					$return_data .= " st_url='{$this->entry_url}'";
				if( $this->entry_title ) /* is the entry_title set? */
					$return_data .= " st_title='{$this->entry_title}'";
				
				$return_data .= "></{$this->elem}>";
			} //end if
		}//end foreach
		
		if($this->show_title)
			$return_data = "<{$this->elem} class='share_title'>" . $this->share_title . "</{$this->elem}>" . $return_data;
			
		return $return_data;
		
		
	}
	
	
	
	
	
	
	/* Displays Usage info on plugin page */
	public function usage(){
		ob_start(); 
		?>
		
		{exp:wt_share_this}
		{exp:wt_share_this share="facebook|twitter|email"} shares facebook, twitter and email
		
		Count bubble
		{exp:wt_share_this show_count="y" count_type="v"} Show count above button (vertical) - default
		{exp:wt_share_this show_count="y" count_type="h"} Show count beside button (horizontal)
		
		Element
		{exp:wt_share_this element="li"} Will render each icon wrapped in a li tag (li)
		{exp:wt_share_this element="span"} Will render each icon wrapped in a span tag
		{exp:wt_share_this element="div"} Will render each icon wrapped in a div tag
		
		Label
		{exp:wt_share_this show_title="y" share_title="Share this:"} Will display Share this: before the icons - defaults to Share:
		
		
		<?php 
		$buffer = ob_get_contents();

		ob_end_clean(); 

		return $buffer;
	}
}

/* End of file pi.fg_share_this.php */ 
/* Location: ./system/expressionengine/third_party/plugin_name/pi.fg_share_this.php */