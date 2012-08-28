component mod_so extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_so.html

	function LoadFile()                  { return _rename('filenames':arguments); } // filename [filename] ...
	function LoadModule(module,filename) { return arguments; }                      // module filename

}