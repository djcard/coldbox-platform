<cfoutput>
<cfsetting showdebugoutput="false">
<!--- js --->
<cfsavecontent variable="js">
<cfoutput>
<script type="text/javascript">
	$(document).ready(function() {
		/* Activate RTE */
		$('.rte-zone').rte("#getSetting('lookups_cssPath')#/lookups.css","#rc.imgPath#/rte/");  
		 
		//Activate Date Pickers
		$(".datepicker").datepicker({ 
		    showOn: "both"
		});
		
		/* Form Validation */
		$('##addform').formValidation({
			err_class 	: "invalidLookupInput",
			err_list	: true,
			callback	: 'prepareSubmit'
		});
	});
	function submitForm(){
		$('##addform').submit();		
	}
	function prepareSubmit(){
		$('##_buttonbar').slideUp("fast");
		$('##_loader').fadeIn("slow");		
		return true;
	}
</script>
</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">

<!--- Title --->
<h2><img src="#rc.imgPath#/cog.png" align="absmiddle"> System Lookup Manager > Add Record</h2>
<!--- BACK --->
<div class="backbutton">
	<img src="#rc.imgPath#/arrow_left.png" align="absmiddle">
	<a href="#event.buildLink(rc.xehLookupList,0)#/lookupclass/#rc.lookupclass#.cfm">Back</a>
</div>
<p>Add a new <strong>#rc.lookupClass#</strong>. Please fill out all the fields.</p>

<!--- Add Form --->
<form name="addform" id="addform" action="#event.buildLink(rc.xehLookupCreate)#.cfm" method="post">
<!--- Lookup Class Choosen to Add --->
<input type="hidden" name="lookupClass" id="lookupClass" value="#rc.lookupClass#">

<fieldset>
<legend><strong>Create Form</strong></legend>

<div id="lookupFields">
	
	<!--- Loop Through Foreign Keys, to create Drop Downs --->
	<cfloop from="1" to="#arrayLen(rc.mdDictionary.ManyToOneArray)#" index="i">
	<cfset qListing = rc["q#rc.mdDictionary.ManyToOneArray[i].alias#"]>
		<label class="labelNormal">#rc.mdDictionary.ManyToOneArray[i].alias#</label>
		<select name="fk_#rc.mdDictionary.ManyToOneArray[i].alias#"
				id="fk_#rc.mdDictionary.ManyToOneArray[i].alias#"
				required="#iif(rc.mdDictionary.FieldsArray[i].nullable,false,true)#">
			<cfloop query="qListing">
			<option value="#qListing[rc.mdDictionary.ManyToOneArray[i].PK][currentrow]#">#qListing[rc.mdDictionary.ManyToOneArray[i].DisplayColumn][currentRow]#</option>
			</cfloop>
		</select>
		<br/>
	</cfloop>

	<!--- Loop through Fields --->
	<cfloop from="1" to="#ArrayLen(rc.mdDictionary.FieldsArray)#" index="i">
		<!--- Do not show the ignore Inserts or PK --->
		<cfif not rc.mdDictionary.FieldsArray[i].primaryKey and not rc.mdDictionary.FieldsArray[i].ignoreInsert>
			<!--- PROPERTY LABEL --->
			<label class="labelNormal">
				#rc.mdDictionary.FieldsArray[i].alias#
				<cfif not rc.mdDictionary.FieldsArray[i].nullable>*</cfif>
			</label>
			<!--- Help Text --->
			<label class="helptext">#rc.mdDictionary.FieldsArray[i].helptext#</label>
			
			<!--- BOOLEAN TYPES --->
			<cfif rc.mdDictionary.FieldsArray[i].datatype eq "boolean">
				<cfif rc.mdDictionary.FieldsArray[i].html eq "radio">
					<input type="radio"
							 name="#rc.mdDictionary.FieldsArray[i].alias#"
							 id="#rc.mdDictionary.FieldsArray[i].alias#"
							 value="1"
							 checked="true"
							 required="#iif(rc.mdDictionary.FieldsArray[i].nullable,false,true)#">
					<label class="rbLabel" for="#rc.mdDictionary.FieldsArray[i].alias#">Yes</label>

					<input type="radio"
						   name="#rc.mdDictionary.FieldsArray[i].alias#"
						   id="#rc.mdDictionary.FieldsArray[i].alias#"
						   value="0"
						   required="#iif(rc.mdDictionary.FieldsArray[i].nullable,false,true)#">
					<label class="rbLabel" for="#rc.mdDictionary.FieldsArray[i].alias#">No</label>
				<cfelse>
					<select name="#rc.mdDictionary.FieldsArray[i].alias#"
							id="#rc.mdDictionary.FieldsArray[i].alias#"
							required="#iif(rc.mdDictionary.FieldsArray[i].nullable,false,true)#"
							class="booleanSelect">
						<option value="1">True</option>
						<option value="0">False</option>
					</select>
				</cfif>
			<!--- DATE TYPE --->
			<cfelseif rc.mdDictionary.FieldsArray[i].datatype eq "date">
				<input type="text" size="20" value="" 
					   name="#rc.mdDictionary.FieldsArray[i].alias#"
					   id="#rc.mdDictionary.FieldsArray[i].alias#"
					   required="#iif(rc.mdDictionary.FieldsArray[i].nullable,false,true)#"
					   class="datepicker"/> 
				<br />
			<!--- TEXTTYPES --->
			<cfelse>
				<cfif rc.mdDictionary.FieldsArray[i].html eq "text">
					<input type="text"
							 name="#rc.mdDictionary.FieldsArray[i].alias#"
							 id="#rc.mdDictionary.FieldsArray[i].alias#"
							 value=""
							 size="50"
							 required="#iif(rc.mdDictionary.FieldsArray[i].nullable,false,true)#"
							 <cfif len(rc.mdDictionary.FieldsArray[i].validate)>
							 	mask="#rc.mdDictionary.FieldsArray[i].validate#"
							 </cfif>>
				<cfelseif rc.mdDictionary.FieldsArray[i].html eq "password">
					<input type="password"
							 name="#rc.mdDictionary.FieldsArray[i].alias#"
							 id="#rc.mdDictionary.FieldsArray[i].alias#"
							 value=""
							 size="50"
							 required="#iif(rc.mdDictionary.FieldsArray[i].nullable,false,true)#">
				<cfelseif rc.mdDictionary.FieldsArray[i].html eq "textarea">
					<textarea name="#rc.mdDictionary.FieldsArray[i].alias#"
								id="#rc.mdDictionary.FieldsArray[i].alias#"
								rows="10"
								required="#iif(rc.mdDictionary.FieldsArray[i].nullable,false,true)#"
							 	></textarea>
				<cfelseif rc.mdDictionary.FieldsArray[i].html eq "richtext">
					<textarea name="#rc.mdDictionary.FieldsArray[i].alias#"
							  id="#rc.mdDictionary.FieldsArray[i].alias#"
							  rows="10"
							  class="rte-zone"
							  required="#iif(rc.mdDictionary.FieldsArray[i].nullable,false,true)#"
							  ></textarea>							 	
				</cfif>
			</cfif>
			<br/>
		</cfif>
	</cfloop>
</div>
</fieldset>

<!--- Mandatory Label --->
<p>* Mandatory Fields</p>
<br />

<!--- Hidden Loader --->
<div id="_loader" class="formloader">
	<p>
		Submitting...<br />
		<img src="#rc.imgPath#/ajax-loader-horizontal.gif" align="absmiddle">
		<img src="#rc.imgPath#/ajax-loader-horizontal.gif" align="absmiddle">
	</p>
</div>

<!--- Create / Cancel --->
<div id="_buttonbar">
	<img src="#rc.imgPath#/cancel.png" border="0" align="absmiddle">
	<a href="#event.buildLink(rc.xehLookupList,0)#/lookupclass/#rc.lookupclass#.cfm" class="buttonLinks">
		Cancel
	</a>
	&nbsp;
	<img src="#rc.imgPath#/add.png" border="0" align="absmiddle">
	<a href="javascript:submitForm()" class="buttonLinks">
		Create Record
	</a>
</div>
<br />
</form>
</cfoutput>