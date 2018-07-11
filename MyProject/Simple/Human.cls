Class Simple.Human Extends (%Persistent,%Library.Populate)
{
	Property Name As %String [Required ];
	Property PhoneNum As %String;
	Property State As %String;
	/// documentation
	Parameter SPECIES = "Homo sapiense";
/// documentation
	Method Print(state as %String = "MA") 
	{
		write !, ..Name, "lives in ", ..State, " and is "
		if (..State = state) {
			write "a ", ..#SPECIES, ". " 
		}
		else {
			write "an extra-terrestrail. "
		}
		write "Phone is: ", ..PhoneNum, ". "
	}
	/// Insert with SQL
	ClassMethod Insert(nm As %String ="", ps As %String = "", sta As %String = "")
	{
		set allEmpty = ((nm = "") && (ph = "") && (sta = ""))
		quit:(allEmpty)
		&sql(insert into simple.human (name, phonenum, state) values(:nm, :ph, :sta))
		if (SQLCODE = 0) {
			&sql(select count(*) into :simple.human)
			write !, count, " records"
		}
		else
		{
			write !, "SQLCODE: ", SQLCODE, !, %msg
		}	
	}
	/// Constructor
	Method %OnNew(name As %String ="", phone As %String = "", hstate As %String = "", wstate As %String = "") As %Status
	{
		set retVal = $$$OK
		set ..Name = name
		set ..PhoneNum = phone
		set ..State = hstate
		
		return retVal
	}
	/// list humans by name
	Query ByName(start As %String) As %SQLQuery [SqlProc]
	{
		SELECT ID, "Name", State, PhoneNum
		FROM Human
		WHERE ("Name" %STARTSWITH :start)
		ORDER BY "Name"
	}
	/// Version
	Parameter VERSIONPROPERTY = "Version";
	Property Version As %Integer;
	
	/// 
	Property SSN As %String [Required];
	/// 
	Index Key On SSN [IdKey, PrimaryKey, Unique];
Storage Default
{
<Data name="HumanDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>PhoneNum</Value>
</Value>
<Value name="4">
<Value>State</Value>
</Value>
<Value name="5">
<Value>Version</Value>
</Value>
</Data>
<DataLocation>^Simple.HumanD</DataLocation>
<DefaultData>HumanDefaultData</DefaultData>
<IdLocation>^Simple.HumanD</IdLocation>
<IndexLocation>^Simple.HumanI</IndexLocation>
<StreamLocation>^Simple.HumanS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}