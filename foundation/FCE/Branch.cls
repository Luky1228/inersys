Class FCE.Branch Extends (%Persistent,%Library.Populate,%XML.Adaptor)
{
	/// National currency at this branch
	Property NationalCurrency As FCE.CurrencyName[InitialExpression = "USD"];
	/// Branch's Telephone
	Property Phone As FCE.PhoneNumber [Required];
	/// Uniue index on branch phone
	Index PhoneIndex On Phone[Unique];
	/// Branch adress
	Property Address As FCE.RealEstate;
	/// Inde for branch address
	Index AddressIndex On Address[Unique ];
	ForeignKey RealEstateFK(Address) References FCE.RealEstate()[OnDelete = setnull ];
	/// Open hours
	Property Opens As %Time(MINVAL= "$ztimeh(""6:00am"")", MAXVAL = "$ztimeh(""12:00n"")");
	/// Branch closes between:
	Property Closes As %Time(MINVAL= "$ztimeh(""1:00pm"")", MAXVAL = "$ztimeh(""10:00pm"")");
	/// Calc Open Duration
	Property DurationOpen As %String [Calculated, SqlComputed, SqlComputeCode = 
	{
		if ( {Closes} = "") || ({Opens} = "")
		{
			set {DurationOpen} = ""
		}
		else
		{
			set {DurationOpen} = $ztime({Closes} - {Opens})
		}	
	}];
	Property CurrencyBalances As array of %Numeric (MINVAL = 0, MAXVAL = 100000000, POPSPEC = ":5:##class(FCE.Currency).Currency()")[SqlFieldName = Balance];
	Index CBIndex On CurrencyBalances(KEYS);
	
	/// create a JSON object from Branch properties
	Method CopyToObject(object as %DynamicObject) as %Status
	{
		set object.ID = ..%Id()
		set object.Phone = ..Phone
		set object.Opens = $ztime(..Opens)
		set object.Closes = $ztime(..Closes)
		set object.Address = ..Address
		return $$$OK
	}
	
	/// copy a JSON object into Branch properties
	Method CopyFromObject(object as %DynamicObject) as %Status
	{
		set ..Phone  = object.Phone
		set ..Opens = $ztimeh(object.Opens)
		set ..Closes = $ztimeh(object.Closes)
		return $$$OK
	}
	
	
	
Storage Default
{
<Data name="BranchDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>NationalCurrency</Value>
</Value>
<Value name="3">
<Value>Phone</Value>
</Value>
<Value name="4">
<Value>Address</Value>
</Value>
<Value name="5">
<Value>Opens</Value>
</Value>
<Value name="6">
<Value>Closses</Value>
</Value>
<Value name="7">
<Value>Closes</Value>
</Value>
</Data>
<Data name="CurrencyBalances">
<Attribute>CurrencyBalances</Attribute>
<Structure>subnode</Structure>
<Subscript>"CurrencyBalances"</Subscript>
</Data>
<DataLocation>^FCE.BranchD</DataLocation>
<DefaultData>BranchDefaultData</DefaultData>
<IdLocation>^FCE.BranchD</IdLocation>
<IndexLocation>^FCE.BranchI</IndexLocation>
<StreamLocation>^FCE.BranchS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}