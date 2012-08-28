component core extends="base"
{
	// http://httpd.apache.org/docs/current/mod/core.html

	function AcceptFilter(protocol,accept_filter) { return arguments; }                          // procol accept_filter
	function AcceptPathInfo()                     { return arguments; }                          // On|Off|Default
	function AccessFileName()                     { return _rename('filenames':arguments); }     // filename [filename] ...
	function AddDefaultCharset(charset)           { return arguments; }                          // On|Off|charset
	function AllowEncodedSlashes()                { return arguments; }                          // On|Off|NoDecode
	function AllowOverride()                      { return _rename('directiveTypes':arguments); }// All|None|directive-type [directive-type] ...
	function AllowOverrideList(directive,directiveTypes) { return _rest('directive','directiveType',arguments); } // None|directive [directive-type] ...
	function CGIMapExtension(cgiPath,extension)   { return arguments; }                          // cgi-path .extension
	function ContentDigest()                      { return arguments; }                          // On|Off
	function DefaultRuntimeDir(directoryPath)     { return arguments; }                          // directory-path
	function DefaultType(mediaType)               { return arguments; }                          // media-type|none
	function Define(parameterName,parameterValue) { return arguments; }                          // parameter-name [parameter-value]
	function DirectoryMatch(regex)                { return arguments; }                          // regex
	function DocumentRoot(directoryPath)          { return arguments; }                          // directory-path
	function ElseIf(expression)                   { return arguments; }                          // expression
	function EnableMMAP()                         { return arguments; }                          // On|Off
	function EnableSendfile()                     { return arguments; }                          // On|Off
	function Error(message)                       { return arguments; }                          // message
	function ErrorDocument(errorCode,document)    { return arguments; }                          // error-code document
	function ExtendedStatus()                     { return arguments; }                          // On|Off
	function FileETag()                           { return _rename('components':arguments); }    // component ...
	function FilesMatch(regex)                    { return arguments; }                          // regex
	function ForceType(mediaType)                 { return arguments; }                          // media-type|None
	function GprofDir()                           { return arguments; }                          // /tmp/gprof/|/tmp/gprof/%
	function HostnameLookups()                    { return arguments; }                          // On|Off|Double
	function If(expression)                       { return arguments; }                          // expression
	function IfDefine(parameterName)              { return arguments; }                          // [!]parameter-name
	function Include(path)                        { return arguments; }                          // file-path|directory-path|wildcard
	function IncludeOptional(path)                { return arguments; }                          // file-path|directory-path|wildcard
	function KeepAlive()                          { return arguments; }                          // On|Off
	function Limit()                              { return _rename('methods':arguments); }       // method [method] ...
	function LimitExcept()                        { return _rename('methods':arguments); }       // method [method] ...
	function LimitRequestBody(bytes)              { return arguments; }                          // bytes
	function LimitRequestFields(number)           { return arguments; }                          // number
	function LimitRequestFieldSize(bytes)         { return arguments; }                          // bytes
	function LimitRequestLine(bytes)              { return arguments; }                          // bytes
	function LimitXMLRequestBody(bytes)           { return arguments; }                          // bytes
	function LocationMatch(regex)                 { return arguments; }                          // regex
	function LogLevel()                           { return _rename('levels':arguments); }        // [module:]level [module:level] ...
	function MaxKeepAliveRequests(numer)          { return arguments; }                          // number
	function MaxRangeOverlaps()                   { return arguments; }                          // default | unlimited | none | number-of-ranges
	function MaxRangeReversals()                  { return arguments; }                          // default | unlimited | none | number-of-ranges
	function MaxRanges()                          { return arguments; }                          // default | unlimited | none | number-of-ranges
	function Mutex(mechanism,mutexName,omitPid)   { return arguments; }                          // mechanism [default|mutex-name] ... [OmitPID]
	function NameVirtualHost(host)                { return arguments; }                          // addr[:port]
	function Options()                            { return _rename('options':arguments); }       // [+|-]option [[+|-]option] ...
	function Protocol(protocol)                   { return arguments; }                          // protocol
	function RLimitCPU(softLimit,maxLimit)        { return arguments; }                          // seconds|max [seconds|max]
	function RLimitMEM(softLimit,maxLimit)        { return arguments; }                          // bytes|max [bytes|max]
	function RLimitNPROC(softLimit,maxLimit)      { return arguments; }                          // number|max [number|max]
	function ScriptInterpreterSource()            { return arguments; }                          // Registry|Registry-Strict|Script
	function SeeRequestTail()                     { return arguments; }                          // On|Off
	function ServerAlias()                        { return _rename('hostnames':arguments); }     // hostname [hostname] ...
	function ServerName()                         { return arguments; }                          // [scheme://]fully-qualified-domain-name[:port]
	function ServerPath(urlPath)                  { return arguments; }                          // URL-path
	function ServerRoot(directoryPath)            { return arguments; }                          // directory-path
	function ServerSignature()                    { return arguments; }                          // On|Off|EMail
	function ServerTokens()                       { return arguments; }                          // Major|Minor|Min[imal]|Prod[uctOnly]|OS|Full
	function SetHandler(handlerName)              { return arguments; }                          // handler-name|None
	function SetInputFilter()                     { return _rename('filters':arguments[1].split(';')); } // filter[;filter...]
	function SetOutputFilter()                    { return _rename('filters',arguments[1].split(';')); } // filter[;filter...]
	function TimeOut(second)                      { return arguments; }                          // seconds
	function TraceEnable()                        { return arguments; }                          // [on|off|extended]
	function UnDefine(parameterName)              { return arguments; }                          // parameter-name
	function UseCanonicalName()                   { return arguments; }                          // On|Off|DNS
	function UseCanonicalPhysicalPort()           { return arguments; }                          // On|Off
	function VirtualHost()                        { return _rename('hosts':arguments); }         // addr[:port] [addr[:port]] ...

	function Directory(directoryPath)   { return ArrayLen(arguments) GT 1     ? _rename('regex':arguments[2])             : arguments; }          // directory-path | ~ regex
	function ErrorLog(filePath)         { return refind('^syslog(?::|$)',arguments[1]) ? _rename('facility':arguments[1]) : arguments; }          // file-path|syslog[:faci
	function ErrorLogFormat(format)     { return ArrayLen(Arguments) GT 1     ? _rename('type':arguments[1],'format':arguments[2]) : arguments; } // [connection|request] format
	function Files(filename)            { return ArrayLen(arguments) GT 1     ? _rename('regex':arguments[2])             : arguments; }          // filename | ~ regexlity]
	function IfModule(moduleIdentifier) { return find('.',arguments[1])       ? _rename('moduleFile':arguments[1])        : arguments; }          // [!]module-file|module-identifier
	function KeepAliveTimeout(seconds)  { return right(arguments[1],2) EQ 'ms'? _rename('milliseconds':arguments[1])      : arguments; }          // num[ms]
	function ServerAdmin(url)           { return find('@',arguments[1])       ? _rename('emailAddress':arguments[1])      : arguments; }          // email-address|URL

	function LimitInternalRecursion(number,depth) { if ( NOT StructKeyExists(arguments,'depth') ) { arguments.depth = arguments.number; } return arguments; }                // number [number]
	function Location(urlPath)                    { return ArrayLen(arguments) EQ 1 ? _rename('regex':arguments[2]) : refind('[^/+]:',arguments[1]) ?  _rename('url':arguments[1]) : Arguments; } // URL-path|URL | ~ regex


}