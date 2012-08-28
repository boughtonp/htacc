component mod_deflate extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_deflate.html

	function DeflateBufferSize(value)         { return arguments; } // value
	function DeflateCompressionLevel(value)   { return arguments; } // value
	function DeflateMemLevel(value)           { return arguments; } // value
	function DeflateWindowSize(value)         { return arguments; } // value

	function DeflateFilterNote(notename)      { return ArrayLen(arguments) GT 1 ? _rename('type':arguments[1],'notename':arguments[2]) : arguments; } // [type] notename

}