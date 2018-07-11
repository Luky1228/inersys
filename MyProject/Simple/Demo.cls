Class Simple.Demo
{
	ClassMethod Hello(name As %String, Output nameReversed As %String) As %String
	{
		set affirmation = ""
		try {
			for i = 1:1:$length(name) {write !, "Hello World!"}
			set nameReversed = $reverse(name)
			set affirmation = name _ "is your friend."
		}
		catch e {
			write !, ex.Name, "error. 404"
		}
		return affirmation
	}
}