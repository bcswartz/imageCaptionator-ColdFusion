<cfinclude template="header.cfm">
<div id="navigationDiv">
	<p><a href="index.cfm">Home</a> > <a href="selectImage.cfm">Select Image</a> > <a href="modifyImage.cfm">Create Image</a> > Save to Gallery</p>
</div>

<div style="padding:0ex .5em .5em .5em;">
	<p>Saving image to library...please wait</p>
<cfflush>

<!---Add to database--->
<cftransaction>
	<cfquery datasource="#application.ds#" username="#application.ds_user#" password="#application.ds_pwd#">
		insert into captionImages (
			imageFile
			) VALUES (
			<cfqueryparam value="#session.imageFile#" cfsqltype="cf_sql_varchar">
			)
	</cfquery>
	
	<cfquery name="lastImage" datasource="#application.ds#" username="#application.ds_user#" password="#application.ds_pwd#" maxrows="1">
		select captionImageId
		from captionImages
		order by captionImageId DESC
	</cfquery>
	
	<cfset imageId= lastImage.captionImageId>
</cftransaction>


<cfoutput query="session.imageQry">
	<cfquery datasource="#application.ds#" username="#application.ds_user#" password="#application.ds_pwd#">
		insert into captionData (
			imageId,type,text,font,fsize,style,strikethrough,underline,color,lft,itop,background,width,height,depth,dateCreated
		) VALUES (
			<cfqueryparam value="#imageId#" cfsqltype="cf_sql_numeric">,
			<cfqueryparam value="#session.imageQry.type#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#session.imageQry.text#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#session.imageQry.font#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#session.imageQry.fsize#" cfsqltype="cf_sql_numeric">,
			<cfqueryparam value="#session.imageQry.style#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#session.imageQry.strikethrough#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#session.imageQry.underline#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#session.imageQry.color#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#session.imageQry.lft#" cfsqltype="cf_sql_numeric">,
			<cfqueryparam value="#session.imageQry.itop#" cfsqltype="cf_sql_numeric">,
			<cfqueryparam value="#session.imageQry.background#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#session.imageQry.width#" cfsqltype="cf_sql_numeric">,
			<cfqueryparam value="#session.imageQry.height#" cfsqltype="cf_sql_numeric">,
			<cfqueryparam value="#session.imageQry.depth#" cfsqltype="cf_sql_numeric">,
			<cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
		)
	</cfquery>
</cfoutput>

<cfoutput>
<p>Your image has been added to the gallery:  the direct URL for your library entry is <a href="dspGallery.cfm?imageId=#imageId#">http://www.swartzfager.org/captionator/dspGallery.cfm?imageId=#imageId#</a></p>

<p>To view the entire gallery, visit <a href="dspGallery.cfm">http://www.swartzfager.org/captionator/dspGallery.cfm</a>
</p>

</cfoutput>
</div>
