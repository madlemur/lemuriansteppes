class_name Jewelry extends Gear

@export var jewelry_type : JewelryType = JewelryType.RING
@export var jewelry_material : ItemMaterial = ItemMaterial.WOOD

enum JewelryType {
	RING,
	AMULET,
	BRACELET,
	EARRING,
}

const category : Category = Category.GEAR
const type : Type = Type.JEWEWLRY

func _get_compound_category() -> String :
	var _quality : String = Quality.keys()[quality]
	var _rarity : String = Rarity.keys()[rarity]
	var _material : String = ItemMaterial.keys()[jewelry_material]
	
	return "{quality}{rarity}{material}{type}".format({
		"quality": "%s " % _quality.capitalize() if quality != Quality.AVERAGE else "",
		"rarity": "%s " % _rarity.capitalize() if rarity != Rarity.COMMON else "",
		"material": "%s " % _material.capitalize(),
		"type": _get_type()
	})

func _get_type() -> String:
	return JewelryType.keys()[jewelry_type].capitalize()
