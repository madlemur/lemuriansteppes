@abstract
class_name Consumable extends Item

@export var type : Type = Type.FOOD

enum Type {
	FOOD,
	FIRST_AID,
	AMMUNITION,
	REAGENT, 
}
