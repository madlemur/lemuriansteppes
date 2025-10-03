class_name Armor extends Gear

@export var armor_type : ArmorType = ArmorType.CUIRIASS

enum ArmorType {
	CUIRIASS,
	HELM,
	CUISSE,
	GREAVES,
	GAUNTLETS,
	SHIELD,
}

const category : Category = Category.GEAR
const type : Type = Type.ARMOR

func _get_type() -> String:
	return ArmorType.keys()[armor_type].capitalize()
