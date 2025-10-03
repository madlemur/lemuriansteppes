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

const category : Category = Category.GEAR
const type : Type = Type.CLOTHES

func _get_type() -> String:
	return ClothesType.keys()[clothes_type].capitalize()
