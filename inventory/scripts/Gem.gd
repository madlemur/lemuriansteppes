## Much like in Diablo (where this concept was brazenly cribbed from), gems can
## be collected, and added to pieces of gear to provide a variety of benefits.
## Once added, they cannot be removed (or at least, not without destroying the
## gem). In general, they _should_ provide more "bang for the buck" than Runes,
## which can be erased multiple times, if needed.
class_name Gem extends Socketable

#TODO: Move to a game-level configuration
const MAX_GEM_STACK : int = 20

@export var type : GemType
@export var quality : GemQuality
var affixes : Array[Affix] = [] # TBD based on GemType and GemQuality

var color : Color:
	get:
		return COLORS[type]

enum GemQuality {
	FLAWED,
	CHIPPED,
	NORMAL,
	FLAWLESS,
	GLEAMING,
}

enum GemType {
	TOPAZ,
	AMYTHEST,
	EMERALD,
	RUBY,
	SAPPHIRE,
	DIAMOND,
}

var COLORS : Array[Color] = [
	Color(0.74, 0.86, 0.05),
	Color(.51, 0, .81), 
	Color(.07, .58, .05),
	Color(.8,  .12, .16),
	Color(0,   .23, .96),
	Color(0.76, 0.75, 0.75)
]

func _init() -> void:
	max_stack = MAX_GEM_STACK

func _get_compound_category() -> String :
	var _quality : String = GemQuality.keys()[quality]
	var _type : String = GemType.keys()[type]
	
	return "{quality}{type}".format({
		"quality": "%s " % _quality.capitalize() if quality != GemQuality.NORMAL else "",
		"type": "%s " % _type.capitalize()
	})

func _get_type() -> String:
	return "Gem"
