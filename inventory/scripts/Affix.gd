## Affix is where the extra bonuses to gear need to interact with the rest of
## the game loop. This is where stat bonuses, or combat triggers, or whatever
## are defined. It also needs to work in conjunction with the rest of the inventory
## items as far as "using this item produces this effect" goes. May need to see 
## how that part of the game loop shapes up. i.e., Could everything be treated
## like an Affix? On one hand, everything goes through the same pipeline, on the 
## other, Affixes get bloated into general-purpose actions...
class_name Affix extends RefCounted

@export var stat : String
@export var type : Type
@export var min_amount : float
@export var max_amount : float
@export var amount : float
@export var template_string : String :
	get:
		match(type):
			Type.PERCENT:
				return "+{amount}% {stat}"
			Type.STAT:
				return "+{amount} {stat}"
		return "Affix Modifier"

var label : String :
	get:
		return template_string.format({
			"amount" : ("%.2f" % amount) if ( type == Type.PERCENT) else ("%d" % amount), 
			"stat": stat.replace("_", " ")
		})

enum Type {
	PERCENT,
	STAT,
}
