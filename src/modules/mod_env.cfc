component mod_env extends="base"
{
	// http://httpd.apache.org/docs/current/mod/mod_env.html

	function PassEnv()                 { return  _rename('envVariables':arguments);; } // env-variable [env-variable] ...
	function SetEnv(envVariable,value) { return arguments; }                           // env-variable value
	function UnsetEnv()                { return  _rename('envVariables':arguments);; } // env-variable [env-variable] ...

}