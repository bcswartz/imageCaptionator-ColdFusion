
<cfset myImage=ImageNew("",200,100)>
<!--- Set the drawing color to green. --->
<cfset ImageSetDrawingColor(myImage,"green")>
<!--- Specify the text string and the start point for the text. --->
<cfset ImageDrawText(myImage,"It's not easy being green.",10,50)>

<!--- Get hound image --->
<cfimage action="read" source="images/symbraUp.png" name="houndImage" />

<!--- Display the text image in a browser. --->
<cfimage source="#myImage#" action="writeToBrowser">
<hr />
<!--- Combine the images--->
<cfset ImagePaste(houndImage,myImage,30,25) />
<cfimage action="writetobrowser" source="#houndImage#" />