<cfparam name="url.imageId" default="1">

<script language="javascript" src="jquery-1.2.3.js"></script>
<script language="javascript">
	function finishLibraryLoad () {
	$("#libraryLoadP").addClass("noShow");
}
</script>

<cfinclude template="header.cfm">
<div id="navigationDiv">
	<p><a href="index.cfm">Home</a> > Gallery </p>
</div>

<div style="padding:0ex .5em .5em .5em;">
<p>The gallery takes the image text and image block data that folks have saved using this tool and displays the images based on that data.</p>

<p>Please note that any offensive images will be removed upon discovery, and that if the gallery becomes too large I may need to remove older data.</p>

<hr />
</div>
<p id="libraryLoadP">Re-creating image from gallery data...<img id="spinImage" src="images/spinner.gif"></p>

<!---Get main query--->
<cfquery name="allImages" datasource="#application.ds#" username="#application.ds_user#" password="#application.ds_pwd#">
	select captionImageId, imageFile
	from captionImages
</cfquery>

<!---Run subqueries--->
<cfquery name="imageName" dbtype="query">
	select imageFile
	from allImages
	where captionImageId= <cfqueryparam value="#url.imageId#" cfsqltype="cf_sql_numeric">
</cfquery>

<!---Get id of next record sequentially--->
<cfquery name="nextImage" dbtype="query" maxrows="1">
	select captionImageId
	from allImages
	where captionImageId > <cfqueryparam value="#url.imageId#" cfsqltype="cf_sql_numeric">
	order by captionImageId ASC
</cfquery>

<!---Get id of previous record--->
<cfquery name="previousImage" dbtype="query" maxrows="1">
	select captionImageId
	from allImages
	where captionImageId < <cfqueryparam value="#url.imageId#" cfsqltype="cf_sql_numeric">
	order by captionImageId DESC
</cfquery>

<!---Get count of all previous images--->
<cfquery name="countPrevious" dbtype="query">
	select Count(captionImageId) as previousCount
	from allImages
	where captionImageId < <cfqueryparam value="#url.imageId#" cfsqltype="cf_sql_numeric">
</cfquery>

<!---Get count of all images--->
<cfquery name="imageCount" dbtype="query">
	select Count(captionImageId) as totalCount
	from allImages
</cfquery>

<cfif imageName.recordcount EQ 0>

	<script language="javascript">finishLibraryLoad();</script>
	<p class="no_records">There is no image data associated with this URL</p>
	
	<cfoutput>
	
		<center>
			<p class="nextImageP" align="center">
				<cfif previousImage.recordcount  EQ 1 AND previousImage.captionImageId NEQ "">
					<a href="dspGallery.cfm?imageId=#previousImage.captionImageId#"><-- View Previous Image</a>
					<cfif nextImage.recordcount  EQ 1 AND nextImage.captionImageId NEQ ""> | <cfelse> (End of Gallery)</cfif>
				</cfif>
				<cfif nextImage.recordcount  EQ 1 AND nextImage.captionImageId NEQ "">
					<a href="dspGallery.cfm?imageId=#nextImage.captionImageId#">View Next Image --></a>
				</cfif>
			</p>
		</center>
		
	</cfoutput>
	
<cfelse>	

	<cfquery name="imageQry" datasource="#application.ds#" username="#application.ds_user#" password="#application.ds_pwd#">
	select *
	from captionData
	where imageId= <cfqueryparam value="#url.imageId#" cfsqltype="cf_sql_numeric">
	order by depth ASC, type ASC
	</cfquery>
	
	<cfimage action="read" source="images/#imageName.imageFile#" name="baseImage" />
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
	
	<!--- <div width="500px;"> --->
	<div style="margin:2ex 0em 2ex 0em;">
		<center>
		<cfimage action="writetobrowser" source="#baseImage#"/>
		</center>
	</div>
	<script language="javascript">finishLibraryLoad();</script>
	
	<cfoutput>
		
		<cfif countPrevious.recordcount GT 0>
			<cfset imageOrder= countPrevious.previousCount + 1>
		<cfelse>
			<cfset imageOrder= 1>
		</cfif>
		<p align="center">Image #imageOrder# of #imageCount.totalCount#</p>
		 
		<center>
			<p class="nextImageP" align="center">
				<cfif previousImage.recordcount  EQ 1 AND previousImage.captionImageId NEQ "">
					<a href="dspGallery.cfm?imageId=#previousImage.captionImageId#"><-- View Previous Image</a>
					<cfif nextImage.recordcount  EQ 1 AND nextImage.captionImageId NEQ ""> | <cfelse> (End of Gallery)</cfif>
				</cfif>
				<cfif nextImage.recordcount  EQ 1 AND nextImage.captionImageId NEQ "">
					<a href="dspGallery.cfm?imageId=#nextImage.captionImageId#">View Next Image --></a>
				</cfif>
			</p>
		</center>
		
	</cfoutput>
	
</cfif>





