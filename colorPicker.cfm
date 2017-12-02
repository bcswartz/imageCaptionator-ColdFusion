<cfset colorList= '00,33,66,99,CC,FF'>

<cfoutput>
	<div id="colorBox">
		<!--- <div id="selectedInfo"
			<span id="selectedHex">to:</span>
		</div> --->
		<!--- <div class="line_spacer" style="padding-bottom:.4ex;"></div>
 --->
		<table id="gridTbl" frame="1" border="0" cellpadding="0" cellspacing="0" style="background-color:black;">
			<tr>

				<td rowspan="2">
					<table frame="0" border="0" cellpadding="0" cellspacing="1">
						<tr><td class="aColor" style="background-color:##000000" width="10" height="10"></td></tr>
						<tr><td class="aColor" style="background-color:##333333" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##666666" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##999999" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##CCCCCC" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##FFFFFF" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##FF0000" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##00FF00" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##0000FF" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##FFFF00" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##00FFFF" width="10" height="10"></td></tr>
						<tr>	<td class="aColor" style="background-color:##FF00FF" width="10" height="10"></td></tr>
					</table>
				</td>

				<td rowspan="2">
					<table frame="0" border="0" cellpadding="0" cellspacing="1">
						<cfloop index="cnt" from="1" to="12">
							<tr>
							<td style="background-color:##000000" width="10" height="10"></td>
							</tr>
						</cfloop>
					</table>
				</td>


				<cfloop index="blockNum" from="1" to="3">
					<cfset first= ListGetAt(colorList,blockNum,",") />
					<td>
						<table frame="0" border="0" cellpadding="0" cellspacing="1">
							<cfloop index="third" list="#colorList#" delimiters=",">
								<tr>
									<cfloop index="second" list="#colorList#" delimiters=",">
										<!---style="border:1px solid black;"--->
										<td class="aColor" style="background-color:###first##second##third#" title="###first##second##third#" width="10" height="10"></td>
									</cfloop>
								</tr>
							</cfloop>
						</table>
					</td>
				</cfloop>
			</tr>
			<tr>
				<cfloop index="blockNum" from="4" to="6">
					<cfset first= ListGetAt(colorList,blockNum,",") />
					<td>
						<table frame="0" border="0" cellpadding="0" cellspacing="1">
							<cfloop index="third" list="#colorList#" delimiters=",">
								<tr>
									<cfloop index="second" list="#colorList#" delimiters=",">
										<td class="aColor" style="background-color:###first##second##third#" title="###first##second##third#" width="10" height="10"></td>
									</cfloop>
								</tr>
							</cfloop>
						</table>
					</td>
				</cfloop>
			</tr>
			
		</table>

	</div>
</cfoutput>