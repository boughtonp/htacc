<cfcomponent output=false >


	<cffunction name="init" output=false >
		<cfargument name="Filename"        type="String"  required />
		<cfargument name="IncludeComments" type="Boolean" default=false />

		<cfset var FileContents = FileRead(Filename) />

		<cfset Variables.IncludeComments = Arguments.IncludeComments />

		<cfset Variables.Modules = {} />
		<cfset var ModuleFiles = DirectoryList('./modules',true,'name','core.cfc|mod_*.cfc') />
		<cfloop index="local.CurModule" array=#ModuleFiles# >
			<cfset CurModule = CurModule.replaceAll('\.cfc$','') />
			<cfset Modules[CurModule] = createObject('component','modules.#CurModule#') />
		</cfloop>

		<cfset This.Directives = parseConfig(FileContents) />

	</cffunction>


	<cffunction name="parseConfig" returntype="Array" output=false >
		<cfargument name="Text" type="String" required />

		<cfset var Stack = [{Children:[]}] />

		<cfloop index="local.CurLine" array=#Text.split('(?<!\\)\n++\s*+')# >

			<cfif left(CurLine,1) EQ '##' >
				<cfif IncludeComments >
					<cfif ArrayLen(Stack[1].Children) AND StructKeyExists( ArrayLast(Stack[1].Children) , 'Comment' ) >
						<cfset ArrayLast(Stack[1].Children).Comment &= chr(10) & mid(CurLine,2) />
					<cfelse>
						<cfset ArrayAppend( Stack[1].Children , {Comment:mid(CurLine,2)} ) />
					</cfif>
				</cfif>

			<cfelseif left(CurLine,2) EQ '</' >
				<cfset var SectionName = ListFirst(CurLine,'</ >') />

				<cfif ArrayLen(Stack) LT 2 >
					<cfthrow
						type    = "HtaccessCFC.ParseConfig.SectionEnd.NotInSection"
						message = "Found `#CurLine#` when not in section."
					/>
				<cfelseif SectionName NEQ Stack[1].Name >
					<cfthrow
						type    = "HtaccessCFC.ParseConfig.SectionEnd.Mismatch"
						message = "Found `#CurLine#` expected `</#Stack[1].Name#>`"
					/>
				</cfif>

				<cfset ArrayAppend( Stack[2].Children , Stack[1] ) />
				<cfset ArrayDeleteAt(Stack,1) />

			<cfelseif left(CurLine,1) EQ '<' >
				<cfset var SectionName = ListFirst(CurLine,'< >') />

				<cfset var Params = trim(mid(CurLine,2+len(SectionName))) />

				<cfif Right(Params,1) NEQ '>' >
					<cfthrow
						type    = "HtaccessCFC.ParseConfig.SectionStart.MissingClose"
						message = "Found `#Right(Params,1)#` expected `>`"
						detail  = "Section tags spanning multiple lines are not supported."
					/>
				</cfif>

				<cfset Params = left(Params,len(Params)-1) />

				<cfset ArrayPrepend
					( Stack
					,
						{ Name       : SectionName
						, Text       : CurLine
						, ParamText  : Params
						, ParamArray : parseParams(Params)
						, Children   : []
						}
					)/>

			<cfloop item="local.CurModule" collection=#Modules#>
				<cfif StructKeyExists(Modules[CurModule],SectionName)>
					<cfset Stack[1].Param = Modules[CurModule][SectionName](ArgumentCollection=Stack[1].ParamArray) />
				</cfif>
			</cfloop>

			<cfelse>
				<cfset ArrayAppend
					( Stack[1].Children
					, parseDirective(CurLine)
					) />
			</cfif>

		</cfloop>

		<cfif ArrayLen(Stack) GT 1>
			<cfthrow
				type    = "HtaccessCFC.ParseConfig.SectionEnd.Missing"
				message = "Reached end of file without finding `</#Stack[1].Name#>`"
			/>
		</cfif>

		<cfreturn Stack[1].Children />
	</cffunction>


	<cffunction name="parseDirective" returntype="Struct" output=false >
		<cfargument name="Text"  type="String" required />

		<cfset var Directive =
			{ Text      : Arguments.Text
			, Name      : ListFirst(Arguments.Text,' ')
			, ParamText : ListRest(Arguments.Text,' ')
			}/>

		<cfset Directive.ParamArray = parseParams(Directive.ParamText) />

		<cfloop item="local.CurModule" collection=#Modules#>
			<cfif StructKeyExists(Modules[CurModule],Directive.Name)>
				<cfset Directive.Param = Modules[CurModule][Directive.Name](ArgumentCollection=Directive.ParamArray) />
			</cfif>
		</cfloop>

		<cfreturn Directive />
	</cffunction>


	<cffunction name="parseParams" returntype="Array" output=false >
		<cfargument name="Text"  type="String" required />

		<cfset var Params = [] />

		<cfset var Text = trim(Text)    />
		<cfset var StartPos = 1         />
		<cfset var CharPos  = 0         />
		<cfset var TextLen  = Len(Text) />

		<cfwhile ++CharPos LTE TextLen >

			<cfset CurChar = mid(Text,CharPos,1) />

			<cfif trim(CurChar) EQ '' AND mid(Text,CharPos-1,1) NEQ '\' >

				<cfset ArrayAppend ( Params , mid(Text,StartPos,1+CharPos-StartPos) )/>

				<cfset StartPos = 1+CharPos />

			<cfelseif CurChar EQ '"' >

				<cfwhile mid(Text,++CharPos,1) NEQ '"' >
					<cfif CharPos GTE TextLen >
						<cfthrow
							type    = "HtaccessCFC.ParseParams.MissingQuote"
							message = "Reached end of directive without finding closing quote for param starting at `#StartPos#` in `#Text#`"
						/>
					</cfif>
				</cfwhile>

				<cfset ArrayAppend( Params , mid(Text,StartPos,1+CharPos-StartPos) )/>
				<cfset StartPos = 1+CharPos />

			</cfif>

		</cfwhile>

		<cfif StartPos LT CharPos >
			<cfset ArrayAppend( Params , mid(Text,StartPos) )/>
		</cfif>

		<cfreturn Params />
	</cffunction>


</cfcomponent>