Class FCE.ATM Extends (%Persistent,%XML.Adaptor,%Library.Populate)
{
	/// ID of ATM
	Property SerialNumber As %String (POPSPEC = "##class(%PopulateUtils).String(5)_##class(%PopulateUtils).String(5)")[Required ];
	/// 
	Index SerialNumberIndex On SerialNumber[Unique ];
	/// Placement of ATM
	Property Address As FCE.RealEstate;
	ForeignKey RealEstateFK(Address) References FCE.RealEstate()[OnDelete = setnull ];
	/// Amount of cash of this curencis
	Property CurrencyBalances As array of %Numeric (MINVAL = 0, MAXVAL = 10000, POPSPEC = ":5:##class(FCE.Currency).Currency()")[SqlFieldName = Balance];
	/// TO DO
	Index CBIndex On CurrencyBalances(KEYS);
Storage Default
{
<Data name="ATMDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>SerialNumber</Value>
</Value>
<Value name="3">
<Value>Address</Value>
</Value>
</Data>
<Data name="CurrencyBalances">
<Attribute>CurrencyBalances</Attribute>
<Structure>subnode</Structure>
<Subscript>"CurrencyBalances"</Subscript>
</Data>
<DataLocation>^FCE.ATMD</DataLocation>
<DefaultData>ATMDefaultData</DefaultData>
<IdLocation>^FCE.ATMD</IdLocation>
<IndexLocation>^FCE.ATMI</IndexLocation>
<StreamLocation>^FCE.ATMS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}