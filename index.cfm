<cfinclude template="header.cfm">
<!--- <script language="javascript" src="jquery-1.2.3.js"></script>
<script language="javascript" src="/pas/views/JavaScript/jquery.curvycorners.source.js">
<script language="javascript">
	$("#mainStatement").corner({
      tl: { radius: 7 },
      tr: { radius: 7},
      bl: { radius: 0 },
      br: { radius: 0 },
      antiAlias: true,
      autoPad: true,
      validTags: ["div"] }
		);
</script> --->

<div id="navigationDiv">
	<p>&nbsp;</p>
</div>

<div style="padding:0ex .5em .5em .5em;background-color:#ffffff;">
	
	
		<center>
		<div id="mainStatement">
			
			Welcome to the Image Captionator, a proof-of-concept tool for adding text and color blocks to an image and then creating a new image based on those changes using the <a href="http://www.jquery.com" target="_blank">jQuery</a> JavaScript library and the image functions in <a href="http://www.adobe.com/products/coldfusion" target="_blank">ColdFusion 8</a>.
			
		</div>
		</center>
		<br />
	
	<img src="images/carrieExample.PNG" style="float:left;height:255px;" class="homeImages">
	<img src="images/symbraExample.PNG" style="float:right;" class="homeImages">
	
	<center>
		<h3><a class="homeOption" href="selectImage.cfm">Create An Image With the Captionator</a></h3>
		
		<p>
		  Choose an image from one of the stock images, then add your own text and color blocks to the image.  You can make professional looking captions or just add cute or humorous text around the image.  When you're done, you can download the image you created, and you can save it to the gallery for others to see if you wish.
		</p>
		<p>(Tested in FireFox, IE7, and Safari)</p>
	
	<hr />
	
	<h3><a class="homeOption" href="dspGallery.cfm">View What Others Have Done With The Tool</a></h3>
	
	<p>View some of the images folks have created in the gallery.</p>
	
	<p>(Note: the gallery itself is a bit "low-tech", as I did the bare minimum to just show the created images)</p>
	</center>
</div>
