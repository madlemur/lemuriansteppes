class_name Consumable extends Item

@export var type : Type = Type.FOOD

enum Type {
	FOOD,
	FIRST_AID,
	AMMUNITION,
	REAGENT, 
}

func _get_type() -> String:
	return Type.keys()[type]
