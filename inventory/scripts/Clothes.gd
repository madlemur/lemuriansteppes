class_name Clothes extends Gear

@export var clothes_type : ClothesType = ClothesType.SHIRT

enum ClothesType {
	SHIRT,
	HAT,
	PANTS,
	SHOES,
	GLOVES,
	BELT,
	CAPE,
}

## The number of attachment moints for a given piece of clothing. Used to attach certain
## storage gear (pouches, etc) for fast access
var attachments : Dictionary[ClothesType, int] = {
	ClothesType.PANTS: 2,
	ClothesType.BELT: 2,
}

const category : Category = Category.GEAR
const type : Type = Type.CLOTHES

func _get_type() -> String:
	return ClothesType.keys()[clothes_type].capitalize()
