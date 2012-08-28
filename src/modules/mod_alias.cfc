component mod_alias extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_alias.html

	function Alias(urlPath,path)             { return arguments; } // URL-path file-path|directory-path
	function AliasMatch(regex,path)          { return arguments; } // regex file-path|directory-path
	function RedirectPermanent(urlPath,url)  { return arguments; } // URL-path URL
	function RedirectTemp(urlPath,url)       { return arguments; } // URL-path URL
	function ScriptAlias(urlPath,path)       { return arguments; } // URL-path file-path|directory-path
	function ScriptAliasMatch(regex,path)    { return arguments; } // regex file-path|directory-path

	function Redirect(status,urlPath,url)
	{
		if( refind('^(?:permanent|temp|seeother|3\d\d)$',arguments[1]) ) return arguments;
		else if( refind('^(?:gone|4\d\d)$',arguments[1]) ) return _rename('status':arguments[1],'urlPath':arguments[2]);
		else return _rename('urlPath':arguments[1],'url':arguments[2]);
	} // [status] URL-path URL

	function RedirectMatch(status,regex,url)
	{
		if( refind('^(?:permanent|temp|seeother|3\d\d)$',arguments[1]) ) return arguments;
		else if( refind('^(?:gone|4\d\d)$',arguments[1]) ) return _rename('status':arguments[1],'regex':arguments[2]);
		else return _rename('regex':arguments[1],'url':arguments[2]);
	} // [status] URL-path URL

}