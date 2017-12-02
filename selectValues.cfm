<cfset fontList= "Arial,Times New Roman,Courier New,Verdana,Trebuchet MS,Tahoma,Georgia,Arial Black,Comic Sans MS,Impact" />

<cfset fontOptions= QueryNew("font","VarChar")>

<cfloop index="f" list="#fontList#" delimiters=",">
	<cfset temp= QueryAddRow(fontOptions,1)>
	<cfset temp= QuerySetCell(fontOptions,"font",f)>
</cfloop>

<cfquery name="fontQry" dbtype="query">
	select font
	from fontOptions
	order by font ASC
</cfquery>


<cfset fontStyles= QueryNew("opt,text","VarChar,Varchar")>
<cfset temp= QueryAddRow(fontStyles,1)>
<cfset temp= QuerySetCell(fontStyles,"opt","plain")>
<cfset temp= QuerySetCell(fontStyles,"text","Plain/Normal")>
<cfset temp= QueryAddRow(fontStyles,1)>
<cfset temp= QuerySetCell(fontStyles,"opt","bold")>
<cfset temp= QuerySetCell(fontStyles,"text","Bold")>
<cfset temp= QueryAddRow(fontStyles,1)>
<cfset temp= QuerySetCell(fontStyles,"opt","italic")>
<cfset temp= QuerySetCell(fontStyles,"text","Italic")>
<cfset temp= QueryAddRow(fontStyles,1)>
<cfset temp= QuerySetCell(fontStyles,"opt","boldItalic")>
<cfset temp= QuerySetCell(fontStyles,"text","Bold and Italic")>

<cfquery name="fontStylesQry" dbtype="query">
	select opt, text
	from fontStyles
</cfquery>

<cfset fontDecs= QueryNew("opt,text","VarChar,Varchar")>
<cfset temp= QueryAddRow(fontDecs,1)>
<cfset temp= QuerySetCell(fontDecs,"opt","none")>
<cfset temp= QuerySetCell(fontDecs,"text","None")>
<cfset temp= QueryAddRow(fontDecs,1)>
<cfset temp= QuerySetCell(fontDecs,"opt","underline")>
<cfset temp= QuerySetCell(fontDecs,"text","Underline")>
<cfset temp= QueryAddRow(fontDecs,1)>
<cfset temp= QuerySetCell(fontDecs,"opt","line-through")>
<cfset temp= QuerySetCell(fontDecs,"text","Strikethrough")>


<cfquery name="fontDecsQry" dbtype="query">
	select opt, text
	from fontDecs
</cfquery>
