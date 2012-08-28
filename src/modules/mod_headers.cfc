component mod_headers extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_headers.html

	function Header()        { return arguments; } // [condition] set|append|merge|add|unset|echo|edit header [value] [replacement] [early|env=[!]variable]
	function RequestHeader(action,header,value,replacement) { return arguments; } // set|append|merge|add|unset|edit header [value] [replacement] [early|env=[!]variable]

}