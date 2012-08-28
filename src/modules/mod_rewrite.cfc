component mod_rewrite extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_rewrite.html

	function RewriteBase(urlPath)                  { return arguments;} // URL-path
	function RewriteCond(testString,condPattern)   { return arguments;} // TestString CondPattern
	function RewriteEngine(value)                  { return arguments;} // on|off
	function RewriteOptions(options)               { return arguments;} // Options
	function RewriteRule(pattern,substituion,flags){ return arguments;} // Pattern Substitution [flags]

	function RewriteMap() { return _rename('mapName':arguments[1],'mapType':ListFirst(arguments[2],':'),'mapSource':ListRest(arguments[2],':'));} // MapName MapType:MapSource

}