class_name Gear extends Item

@export var rarity : Rarity = Rarity.COMMON
@export var quality : Quality = Quality.AVERAGE
@export var affix_count : int = 0
@export var set_member : bool = false # part of a set
@export var set_member_of : GearSet
@export var is_equipped : bool = false

var rune_count : int = 0
var max_runes : int = 0
var engravings : Array[Rune] = []

var sockets : int = 0
var max_sockets : int = 0
var socketed : Array[Gem] = []

var durability : int = 0
var max_durability : int = 0

var affixes : Array[Affix] = []

enum Type {
	WEAPON,
	ARMOR,
	JEWEWLRY,
	CLOTHES,
	STORAGE,
}

func _get_compound_category() -> String :
	var _quality : String = Quality.keys()[quality]
	var _rarity : String = Rarity.keys()[rarity]
	
	return "{quality}{rarity}{type}".format({
		"quality": "%s " % _quality.capitalize() if quality != Quality.AVERAGE else "",
		"rarity": "%s " % _rarity.capitalize() if rarity != Rarity.COMMON else "",
		"type": _get_type()
	})

func _get_type() -> String : 
	return "Gear"
