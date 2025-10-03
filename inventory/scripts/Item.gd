class_name Item extends Resource

enum Category {
	GEAR,		# Weapons, Armor, etc - No stack, quality, rarity - Visible
	COMPONENT,	# Scrap, logs, meat, etc - Stack, no quality, rarity?
	CONSUMABLE,	# Food, potions, bandages, etc, stack, quality? rarity?
	QUEST,		# Quest-related items, No stack, no quality, no rarity
	SOCKETABLE,	# Gems, Runes
}

enum Rarity {
	COMMON,		# Can be found anywhere
	UNCOMMON,	# May require resource/population/? for availability
	RARE,		# Multiple requirements for availability
	VERY_RARE,	# Many requirements, or dangerous environs for availabilty
	ULTRA_RARE, # Only available in the wild, or via quest
	UNIQUE,		# Multi-stage quest, or mind-bogglingly good luck
}

enum Quality {
	POOR,		# Negative modifier(s)
	AVERAGE,	# No modifiers, no affixes, no upgrades
	GOOD,		# No modifiers, maybe affixes OR upgrade slots
	EXCELLENT,	# Low modifiers, few affixes OR upgrade slots
	MASTERWORK, # Mult modifiers, few affixes and/or upgrade slots
	EPIC,		# Mult modifiers, mult affixes, mult upgrade slots
	LEGENDARY,  # More, more, more! Max affixes, max upgrade slots
}

enum ItemMaterial {
	STONE,
	WOOD,
	LEATHER,
	COPPER,
	BRONZE,
	IRON,
	STEEL,
	ADAMANTINE,
	SILVER,
	GOLD,
	CRYSTAL,
	FIBER,
	FLESH,
	HORN,
	HAIR,
	CLOTH,
	SILK,
	RESIN,
	SAND,
	DIRT,
	WATER,
	ICE,
	MUD,
}

@export var name : String = "Item Name"
@export var description : String = ""
@export var texture : Texture
@export var weight : float = 0.0
@export var max_stack : int = 1
@export var value : int = 0 # theoretical, modify for reputation, etc.
var inventory : Inventory
var quantity : int = 0

static var RARITY_COLORS : Array[Color] = [
	Color(.3,  .3,  .3,  1),
	Color(.18, .23, .63, 1),
	Color(.58, .5,  .8,  1),
	Color(.56, .21, .8,  1),
	Color(.54, .34, .32, 1),
	Color(.65, .65, .2,  1),
]

var compound_category : String :
	get:
		return _get_compound_category()
		
func _get_compound_category() -> String :
	return "Item"
	
func _get_type() -> String :
	return "Item"
