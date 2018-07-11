///Parrent for classes <class>FCE.RealEstate</class> and <class> FCE.MilingAddres </class>
Class FCE.Address Extends (%Library.Populate,%XML.Adaptor)[Abstract]
{
	Property Street As %String[Required ];
	Property City As %String[Required ];
	Property State As %String(MAXLEN = 2, VALUELIST = "-NY-NJ-MA-TX")[Required ];
	//Property Zip As %String(MAXLEN = 10, PATTERN = "5n.1(1""-""4n)");
	Property Zip As FCE.Regex(REGEX="\d{5}(-\d{4})?") [Required ];
	/// Print
	Method Print() 
	{
		write !, ..Street,!, ..City," ", ..State," ", ..Zip
	}
	
	
}