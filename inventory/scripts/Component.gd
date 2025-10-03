class_name Component extends Item

@export var type : Type
@export var material : ItemMaterial
## A component could be used for multiple functions. Only if it's otherwise
## useless will it appear as just a "Trading Component". i.e., a junk item. But salt
## could be used in cooking and maybe certain runesmithing rituals. Iron could
## be used for crafting (smithing) and repairing AND runesmithing. Maybe even
## cooking, depending on dietary needs of the character... ;)
enum Type {
	TRADING = 0x0,
	CRAFTING = 0x1,
	RUNESMITHING = 0x2,
	COOKING = 0x4,
	REPAIRING = 0x8,
}

func _get_type() -> String:
	return "Component"

func _get_compound_category() -> String:
	var _type = "Trading"
	for t in Type.keys() :
		if type & Type[t] : _type = "{type}".format({"type": "%s, %s" % [ _type, t.capitalize() ]})
	var _material = Item.ItemMaterial.keys()[material].capitalize()
	return _material + " Component, used for " + _type
