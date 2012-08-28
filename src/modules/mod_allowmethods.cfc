component mod_allowmethods extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_allowmethods.html

	function AllowMethods(){ return _rename('httpMethods':arguments); } // reset|HTTP-method [HTTP-method]...

}