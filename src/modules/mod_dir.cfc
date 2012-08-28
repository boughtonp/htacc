component mod_dir extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_dir.html

	function DirectoryIndex()              { return _rename('localUrls':arguments); } // disabled | local-url [local-url] ...
	function DirectoryIndexRedirect(value) { return arguments; }                      // on | off | permanent | temp | seeother | 3xx-code
	function DirectorySlash(value)         { return arguments; }                      // On|Off
	function FallbackResource(localurl)    { return arguments; }                      // local-url

}