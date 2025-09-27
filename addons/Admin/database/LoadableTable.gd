class_name LoadableTable extends Resource

@export var database : DatabaseConfig
@export var name : StringName
@export var keyname : String = "id"
@export var requires_pk : bool = true
@export_file("res://ConfigScripts/Database/") var table_config : String
var fields : Array[DatabaseTable.FieldDef] = []

# Initialize the primary key.
func _init() -> void:
	# M2M join tables don't require primary keys
	# Although SQLite will create ROWID anyway...
	# godot-sqlite doesn't support the WITHOUT ROWID feature
	if ! requires_pk :
		return
	# Set up primary key
	fields.append(DatabaseTable.FieldDef.new() \
		.config_field(keyname, DatabaseTable.Types.INT) \
		.set_field_flag(DatabaseTable.Flags.PRIMARY_KEY) \
		.set_field_flag(DatabaseTable.Flags.NON_NULL))

## flags are of type Array[Dictionary[DatabaseTable.Flags, Variant]] to handle paramaters
func add_field(fname : String, ftype : DatabaseTable.Types, fflags : Array[Dictionary]) -> LoadableTable :
	var field = DatabaseTable.FieldDef.new().config_field(fname, ftype)
	for f in fflags :
		if f.size() != 1 :
			printerr("Misconfigured field definition!")
			continue
		var k = f.keys()[0]
		field.set_field_flag(k, f[k])
		fields.append(field)
	return self

## Create database table, or update existing table, if needed
func create_table() -> void:
	var results = database.database.query("PRAGMA table_info(" + name + ")")
	if results.size > 0 :
		if !check_table() :
			update_table()
		else :
			return
	var preppedFields : Dictionary[String, Dictionary] = {}
	for f in fields :
		preppedFields.set(f.name, f.get_field_def())
	database.database.create_table(name, preppedFields)
	
## Check database table against the given configuration
func check_table() -> bool:
	if !database.database.query("PRAGMA table_info(" + name + ")") :
		printerr("Unable to retreive table info for table ", name)
		return false
	var results = database.database.query_result
	
	return true
	
## Update the database table to match the given configuration.
## Not always the best idea, given SQLite's ALTER TABLE behavior...
func update_table() -> void:
	pass

## Drop the table from the database, erasing all the data...
func drop_table() -> void:
	pass

## Dump the database table to a text file
func dump_table(filename: String) -> void:
	pass
