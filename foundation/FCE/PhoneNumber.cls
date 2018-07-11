Class FCE.PhoneNumber Extends %Library.String
{
	/// maax len of phone num
	Parameter MAXLEN = 12;
	/// phNum mask
	Parameter PATTERN = "3n1""-""3n1""-""4n";
	/// 
	ClassMethod LogicalToDisplay(%val As %String) As %String[ServerOnly = 0 ] 
	{	
		return "(" _ $piece(%val, "-") _")-" _ $piece(%val, "-", 2, 3)
	}

}