<cfset browserString= cgi.http_user_agent>
<!--- <cfdump var="#browserString#"> --->
<cfif FindNoCase("MSIE",browserString)>
	<cfset browserType="ie">
<cfelse>
	<cfset browserType="mozilla">
</cfif>
