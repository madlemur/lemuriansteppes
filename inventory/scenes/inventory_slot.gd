class_name InventorySlot extends Control

signal slot_entered(slot)
signal slot_exited(slot)

@onready var filter = $StatusFilter

var slot_id
var is_hovering: bool = false
var state : State = State.FREE
var item_stored = null

enum State { DEFAULT, TAKEN, FREE }


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

static func get_color(a_state : State) -> Color:
	var color: Color = Color(Color.WHITE, 0.0)
	match a_state:
		InventorySlot.State.DEFAULT:
			color = Color(Color.WHITE, 0.0)
		InventorySlot.State.TAKEN:
			color = Color(Color.CRIMSON, 0.4)
		InventorySlot.State.FREE:
			color = Color(Color.FOREST_GREEN, 0.4)
	return color


func set_color(a_state : State = State.DEFAULT) -> void:
	filter.color = get_color(a_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_global_rect().has_point(get_global_mouse_position()):
		if not is_hovering:
			is_hovering = true
			slot_entered.emit(self)
	else:
		if is_hovering:
			is_hovering = false
			slot_exited.emit(self)
