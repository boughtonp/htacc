component mod_actions extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_actions.html

	function Action(actionType,cgiScript,virtual){ return arguments; } // action-type cgi-script [virtual]
	function Script(method,cgiScript){ return arguments; }             // method cgi-script

}