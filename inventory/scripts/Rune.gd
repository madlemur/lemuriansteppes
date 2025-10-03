## Runes are a hybrid "Item". They don't exist as real items, per se. They are
## created by the character (or by a [hopefully] friendly NPC) and applied to 
## pieces of gear. They may have requirements to create/apply, but they don't
## exist on their own as separate items. With the proper gear and skill,
## Runes can be erased. If the skill of the eraser is lower than the quality of
## the Rune, there is a chance (inverse to the difference in skill/quality) that
## the Rune become permanent, so beware trying to erase a "cursed" Rune applied
## by a master Runesmith. (Yes, Runes can have negative affixes, even with high
## qualities. Yay, trickster spirits!)
class_name Rune extends Socketable

@export var quality : RuneQuality = RuneQuality.NORMAL
@export var type : RuneType = RuneType.PROTECTION
var is_erasable : bool = true
var required_components : Dictionary[Component, int] = {}
var affixes : Array[Affix] = [] # TBD based on RuneType and Rune Quality

enum RuneType {
	PROTECTION,
	FIRE,
	SHOCK,
	LIFE,
	ALACRITY,
	SIGHT,
}

enum RuneQuality {
	SMUDGED,
	NORMAL,
	FINE,
	POWERFUL,
	ANCESTRAL,
	SPIRITUAL,
	DEIFIC
}

func _get_compound_category() -> String :
	var _quality : String = RuneQuality.keys()[quality]
	var _type : String = RuneType.keys()[type]
	var _cursed : bool = false
	for a in affixes:
		if a.amount < 0 :
			_cursed = true
	
	return "{cursed}{quality}{runetype}{type}".format({
		"cursed": "Cursed " if _cursed else "",
		"quality": "%s " % _quality.capitalize() if quality != RuneQuality.NORMAL else "",
		"runetype": "%s " % _type.capitalize(),
		"type": _get_type()
	})

func _get_type() -> String:
	return "Rune"
