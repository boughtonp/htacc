component mod_expires extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_expires.html

	function ExpiresActive(value)          { return arguments; } // On|Off
	function ExpiresByType(mimeType,value) { return arguments; } // MIME-type <code>seconds
	function ExpiresDefault(value)         { return arguments; } // <code>seconds return arguments;

}