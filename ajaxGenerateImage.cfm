
<cftry>
<cfset imageData= QueryNew("type,text,font,fsize,style,strikethrough,underline,color,lft,itop,background,width,height,depth","VarChar,VarChar,VarChar,Integer,VarChar,Varchar,VarChar,VarChar,Integer,Integer,Varchar,Integer,Integer,Integer")>

<!---Store all the data in the query object--->
<cfloop index="line" list="#form.textData#" delimiters="^">
	<cfset temp= QueryAddRow(imageData,1)>
	<cfif ListGetAt(line,1,"|") EQ "tBlock">
		<cfset temp= QuerySetCell(imageData,"type",ListGetAt(line,1,"|"))>
		<cfset temp= QuerySetCell(imageData,"text",ListGetAt(line,2,"|"))>
		<!---Safari for some reason encases the font in single-quotes--->
		<cfif Left(ListGetAt(line,3,"|"),1) EQ "'">
			<cfset fixStart= Replace(ListGetAt(line,3,"|"),"'","","ALL")>
			<cfset temp= QuerySetCell(imageData,"font",fixStart)>
		<cfelse> 
			<cfset temp= QuerySetCell(imageData,"font",ListGetAt(line,3,"|"))>
		</cfif>
		<cfif ListGetAt(line,4,"|") LT 0>
			<cfset temp= QuerySetCell(imageData,"fsize",8)>
		<cfelse>	
			<cfset temp= QuerySetCell(imageData,"fsize",ListGetAt(line,4,"|"))>
		</cfif>
		<cfset temp= QuerySetCell(imageData,"style",ListGetAt(line,5,"|"))>
		<cfset temp= QuerySetCell(imageData,"strikethrough",ListGetAt(line,6,"|"))>
		<cfset temp= QuerySetCell(imageData,"underline",ListGetAt(line,7,"|"))>
		<cfset temp= QuerySetCell(imageData,"color",ListGetAt(line,8,"|"))>
		<cfif ListGetAt(line,9,"|") LT 0>
			<cfset temp= QuerySetCell(imageData,"lft",0)>
		<cfelse>
			<cfset temp= QuerySetCell(imageData,"lft",ListGetAt(line,9,"|"))>
		</cfif>
		<cfif ListGetAt(line,10,"|") LT 0>
			<cfset temp= QuerySetCell(imageData,"itop",0)>
		<cfelse>
			<cfset temp= QuerySetCell(imageData,"itop",ListGetAt(line,10,"|"))>
		</cfif>
		<cfif ListGetAt(line,11,"|") LT 1>
			<cfset temp= QuerySetCell(imageData,"depth",1)>
		<cfelse>	
			<cfset temp= QuerySetCell(imageData,"depth",ListGetAt(line,11,"|"))>
		</cfif>	
		<cfset temp= QuerySetCell(imageData,"height",0)>
		<cfset temp= QuerySetCell(imageData,"width",0)>
	<cfelse>
		<!---Have to set the font size--->
		<cfset temp= QuerySetCell(imageData,"fsize",0)>
		<cfset temp= QuerySetCell(imageData,"type",ListGetAt(line,1,"|"))>
		<cfset temp= QuerySetCell(imageData,"background",ListGetAt(line,2,"|"))>
		<cfif ListGetAt(line,3,"|") LT 0>
			<cfset temp= QuerySetCell(imageData,"lft",0)>
		<cfelse>
			<cfset temp= QuerySetCell(imageData,"lft",ListGetAt(line,3,"|"))>
		</cfif>
		<cfif ListGetAt(line,4,"|") LT 0>
			<cfset temp= QuerySetCell(imageData,"itop",0)>
		<cfelse>
			<cfset temp= QuerySetCell(imageData,"itop",ListGetAt(line,4,"|"))>
		</cfif>
		<cfif ListGetAt(line,5,"|") LT 0>
			<cfset temp= QuerySetCell(imageData,"width",0)>
		<cfelse>
			<cfset temp= QuerySetCell(imageData,"width",ListGetAt(line,5,"|"))>
		</cfif>
		<cfif ListGetAt(line,6,"|") LT 0>
			<cfset temp= QuerySetCell(imageData,"height",0)>
		<cfelse>
			<cfset temp= QuerySetCell(imageData,"height",ListGetAt(line,6,"|"))>
		</cfif>
		<cfif ListGetAt(line,7,"|") LT 1>
			<cfset temp= QuerySetCell(imageData,"depth",1)>
		<cfelse>	
			<cfset temp= QuerySetCell(imageData,"depth",ListGetAt(line,7,"|"))>
		</cfif>	
	</cfif>
</cfloop>

<!---Order query--->
<cfquery name="imageQry" dbtype="query">
	select type, text, font, fsize, style, strikethrough, underline, color, lft, itop, background, width, height, depth
	from imageData
	order by depth ASC, type ASC
</cfquery>

<!---Store query and image name in session--->
<cfset session.imageQry= imageQry>
<cfset session.imageFile= form.imageFile>

<!---Now go through the query and layer the image--->
<cfimage action="read" source="images/#form.imageFile#" name="baseImage" />
<cfoutput query="imageQry">
	<cfif imageQry.type EQ 'tBlock'>
		
		<cfset attr= StructNew()>
		<cfset attr.font= imageQry.font>
		<cfset sizeVal= Trim(imageQry.fsize)>
		<cfset attr.size= sizeVal>
		<cfset attr.style= imageQry.style>
		<cfset attr.strikeThrough= imageQry.strikethrough>
		<cfset attr.underline= imageQry.underline>
		<cfset ImageSetDrawingColor(baseImage,imageQry.color)>
		<cfset leftVal= imageQry.lft>
		<cfset topVal= imageQry.itop + sizeVal>
		<cfset ImageDrawText(baseImage,imageQry.text,leftVal,topVal,attr)>
		
	<cfelse>
	
		<cfset widthVal= Int(width)>
		<cfset heightVal= Int(height)>
		<cfset colorImage=ImageNew("",widthVal,heightVal,"rgb",imageQry.background)>
		<cfset leftVal= Int(lft)>
		<cfset topVal= Int(itop)>
		<cfset ImagePaste(baseImage,colorImage,imageQry.lft,imageQry.itop) />
		
	</cfif>
</cfoutput>

<!---Record IP just to get an idea of uniques--->
<cfquery datasource="#application.ds#" username="#application.ds_user#" password="#application.ds_pwd#">
	insert into captionTries (
		ipAddress,
		tryDate
		) VALUES (
		<cfqueryparam value="#cgi.REMOTE_ADDR#" cfsqltype="cf_sql_varchar">,
		<cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
		)
</cfquery>

<!--- <div width="500px;"> --->
<cfimage action="writetobrowser" source="#baseImage#"/>

<cfcatch type="any">
<!---
	<cfdump var="#session.imageQry#">
	<cfdump var="#cfcatch#"> --->

<p style="color:red;font-weight:bold;">An error has occurred; please try again.</p>
</cfcatch>
</cftry>