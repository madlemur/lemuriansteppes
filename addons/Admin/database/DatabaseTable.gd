class_name DatabaseTable extends Object

enum Types {TEXT, INT, FLOAT, CHAR, BLOB}
enum Flags {UNIQUE, NON_NULL, PRIMARY_KEY, AUTO_INCREMENT, FOREIGN_KEY, DEFAULT}

class DataType:
	var type : Types
	## Only needed for CHAR types, which define the length of the field
	var param : int = 0
	func get_type() -> Dictionary:
		match(type):
			Types.TEXT:
				return { "data_type" : "text" }
			Types.INT:
				return { "data_type" : "int" }
			Types.FLOAT:
				return { "data_type" : "float" }
			Types.CHAR:
				return { "data_type" : "char(" + str(param) + ")" }
			Types.BLOB:
				return { "data_type" : "blob" }
		return {}
		
	func config(newtype : Types, newparam : int = 0) -> DataType :
		self.type = newtype
		self.param = newparam
		return self
	
class DataFlag:
	var flag : Flags
	## Only needed for FOREIGN_KEY (should be a String - "<tablename>.<fieldname>") or DEFAULT
	var param : Variant = null
	
	## Get a godot-sqlite ready key-value pair for use in creating tables
	func get_flag() -> Dictionary:
		match(flag):
			Flags.UNIQUE:
				return { "unique" : true }
			Flags.NON_NULL:
				return { "non_null" : true }
			Flags.PRIMARY_KEY:
				return { "primary_key" : true }
			Flags.AUTO_INCREMENT:
				return { "auto_increment" : true }
			Flags.FOREIGN_KEY:
				return { "foreign_key" : str(param) }
			Flags.DEFAULT:
				return { "default" : param }
		return {}
	
	func config(newflag : Flags, newparam : Variant = null) -> DataFlag :
		self.flag = newflag
		self.param = newparam
		return self
	
class FieldDef:
	var name : String
	var type : DataType
	var flags : Dictionary[Flags, DataFlag]
	
	func config_field(newname : String, newtype : Types, typeparam : int = 0) -> FieldDef :
		self.name = newname
		self.type = DataType.new().config(newtype, typeparam)
		self.flags = { }
		return self
	
	## Get a godot-sqlite ready dictionary for creating tables
	func get_field_def() -> Dictionary:
		var field : Dictionary[String,Variant] = { name : type.get_type() }
		if flags.size() > 0 :
			for k in flags.keys() :
				field.merge(flags[k].get_flag())
		return field

	## Set a field flag, defaulting to setting to boolean true, or assigning the param value where
	## appropriate
	func set_field_flag(flag : Flags, param : Variant = null) -> FieldDef:
		var newFlag : DataFlag = DataFlag.new().config(flag, param)
		flags.set(flag, newFlag)
		return self
	
	## Remove a flag from a field definition	
	func del_field_flag(flag : Flags) -> FieldDef :
		flags.erase(flag)
		return self
