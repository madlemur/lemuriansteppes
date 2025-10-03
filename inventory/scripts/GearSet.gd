class_name GearSet extends Resource

@export var name : String = "Gear Set Name"
@export var description : String = ""
@export var affix_count : int = 0
@export var min_members : int = 1 # How many items needed to gain benefit

var affixes : Array[Affix] = []
