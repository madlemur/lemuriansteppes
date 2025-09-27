class_name Categories extends Attributable

static var dbTableCfg : DatabaseTable
	
func _init() -> void:
	super()
	dbTableCfg.tablecfg.name = "Categories"
	var name : DatabaseTable.FieldDef = \
		DatabaseTable.FieldDef.new() \
		.config("name", DatabaseTable.Types.TEXT)
	var desc : DatabaseTable.FieldDef = \
		DatabaseTable.FieldDef.new() \
		.config("description", DatabaseTable.Types.TEXT)
	var resource_path : DatabaseTable.FieldDef = \
		DatabaseTable.FieldDef.new() \
		.config("texture_path", DatabaseTable.Types.TEXT)
	fields.append(name)
	fields.append(desc)
	fields.append(resource_path)
