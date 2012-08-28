component mod_access_compat extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_access_compat.html

	function Allow(){ return _rename('from':arguments[2]); } // from all|host|env=[!]env-variable [host|env=[!]env-variable] ...
	function Deny(){ return _rename('from':arguments[2]); }  // from all|host|env=[!]env-variable [host|env=[!]env-variable] ...
	function Order(ordering){ return arguments; }            // ordering
	function Satisfy(value){ return arguments; }             // Any|All

}