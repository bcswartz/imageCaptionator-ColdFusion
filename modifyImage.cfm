<script language="javascript" src="jquery-1.2.3.js"></script>
<script type="text/javascript" src="jquery.ui-1.5b/selector.js"></script>
<script type="text/javascript" src="jquery.ui-1.5b/event.js"></script>

<script type="text/javascript" src="jquery.ui-1.5b/ajax.js"></script>
<script type="text/javascript" src="jquery.ui-1.5b/fx.js"></script>
<script type="text/javascript" src="jquery.ui-1.5b/offset.js"></script>
<script type="text/javascript" src="jquery.ui-1.5b/jquery.dimensions.js"></script>

<script type="text/javascript" src="jquery.ui-1.5b/ui.mouse.js"></script>
<script type="text/javascript" src="jquery.ui-1.5b/ui.draggable.js"></script>
<script type="text/javascript" src="jquery.ui-1.5b/ui.draggable.ext.js"></script>
<script type="text/javascript" src="jquery.ui-1.5b/ui.resizable.js"></script>

<script type="text/javascript" src="jquery.form.js"></script>

<script language="javascript" src="imageCaptionator.js"></script>
<cfparam name="url.imageFile" default="symbraUp.png" />

<cfinclude template="selectValues.cfm">
<cfinclude template="browserDetect.cfm">

<cfinclude template="header.cfm">
<div id="navigationDiv">
	<p><a href="index.cfm">Home</a> > <a href="selectImage.cfm">Select Image</a> > Create Image</p>
</div>

<cfoutput>
<div id="outmostDiv">
	<div id="leftBlock">
		<p id="controlColTitle">Control Column</p>
		<form id="modifyImageForm" name="modifyImageForm" method="post" action="ajaxGenerateImage.cfm">
			<input type="hidden" id="blockCount" name="blockCount" value="1" size="2"/>
			<input type="hidden" id="blockId" name="blockId" value="" size="2" />
			<input type="hidden" id="imageFile" name="imageFile" value="#url.imageFile#" size="2"/>
			<input type="hidden" id="browserType" name="browserType" value="#browserType#" />
			<div id="selectedItem" class="noShow">
				<span id="selectedBlockTitle">Selected Block:</span> 
				<div id="textOnlyControls">
					<p>
						<label for="str" id="lblString">Text:</label>
						<input type="text" name="str" id="str" value="" maxlength="1000"/>
					</p>
					<p>
						<label for="font" id="lblFont">Font:</label>
						<select name="font" id="font">
							<cfloop query="fontQry">
								<option value="#font#">#font#</option>
							</cfloop>
						</select>
					</p>
					<p>
						<label for="fontSize" id="lblFontSize">Font Size:</label>
						<input type="text" name="fontSize" id="fontSize" size="2" value="" /> px
					</p>
					<p>
						<label for="style" id="lblStyle">Font Style:</label>
						<select name="style" id="style">
							<cfloop query="fontStylesQry">
								<option value="#opt#">#text#</option>
							</cfloop>
						</select>
					</p>
					<p>
					<label for="textDecoration" id="lblTextDecoration">Decoration:</label>
					<select name="dec" id="dec">
						<cfloop query="fontDecsQry">
							<option value="#opt#">#text#</option>
						</cfloop>
					</select>
					</p>
				</div>
				<div id="universalControls">
					<p>
						<label for="depth" id="lblDepth">Layer:</label>
						<input type="text" name="depth" id="depth" size="2" value="" />
					</p>
					<p>
						<label for="colorTarget" id="lblColorTarget">Color:</label><br />
						<cfinclude template="colorPicker.cfm" />
					</p>
					<input type="button" name="buttonDelete" id="buttonDelete" value="Delete This Block" class="noShow">
				</div>
				<!--- <textarea name="textData" id="textData" rows="5" cols="20" ></textarea> --->
				<input type="hidden" name="textData" id="textData" value="" /> 
			</div>
		
		
	</div>
	<div id="rightBlock">
		<div id="imageBlock">
			<div id="workspaceBlock">
				<div id="workspaceLeft">
					<img id="theImage" src="images/#url.imageFile#"/>	
				</div>
				
				<p>Use the buttons to add blocks of text and/or blocks of color to the image.  Clicking on a block will make it the active block, and you can use the controls in the left-hand column to modify the selected block.  The changes you make with the controls will take effect as soon as you click or tab away from the the control option you changed.</p>  
				<p>You can also use the mouse to click and drag the color blocks anywhere on the image, and you can click and drag the edges of the color blocks to resize them (note: any part of a text or color box that falls outside of the image will be lost when the image is generated).</p>
				<p>To change the color of any text or color block, simply click on the block and then choose a color from the color grid in the control column.</p>
				<p>You can place blocks on top of one another.  By default, blocks added later will have a higher layer value and will stay on top of earlier blocks, but you can change the layer of any block by changing the layer value in the control column.</p>
				<p>When you're done, click the <strong>Generate Image</strong> button to create an image file that incorporates all of the text and color blocks you've added.</p>
				<p>
				<input type="button" name="buttonAddText" id="buttonAddText" value="Add Text Block" />
				<input type="button" name="buttonAddColor" id="buttonAddColor" value="Add Color Block" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="buttonGenerateImage" id="buttonGenerateImage" value="Generate Image">	
				</p>
				
			</form>					
			</div>
			<div id="resultBlock">
				<div id="resultImage"></div>
				<!--- <center> --->
					<span id="generateMsg">Generated image will appear here.</span>
					<img id="spinImage" src="images/spinner.gif" class="noShow">
				<p class="libraryText noShow">The new image is displayed to the left.  It might look a bit different from the images above (the fonts especially), so you might need to make some adjustments and try again.   Once it looks the way you want, you can right-click on this image to save it down to your computer.</p>
				<p class="libraryText noShow">If you want to add this image to a gallery showcasing what others have done with this tool, click on the <strong>Save to Gallery</strong> button.  The new image itself won't be saved, but database records representing the text and color boxes you added will be created and associated with the original image, and the image itself can be recreated using that information (saving on the need to store lots of image files).</p>
				<p class="libraryText noShow">One request:  please don't save your image to the gallery if you used questionable or hateful language:  the hounds pictured here are polite and would never say such things, and such images may be deleted from the gallery.</p>
				
				<form name="saveNewImage" id="saveNewImage" method="post" action="saveToGallery.cfm" class="noShow">
	<input type="submit" name="submitSave" id="submitSave" value="Save to the Gallery" />
</form>
				
				<!--- </center> --->
				

			</div>
		</div> 
	</div>
</div>

</cfoutput>