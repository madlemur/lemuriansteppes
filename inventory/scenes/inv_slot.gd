extends Control

signal slot_entered(slot)
signal slot_exited(slot)

@onready var filter = $StatusFilter

var slot_id
var is_hovering: bool = false
var state : States = States.FREE

enum States { DEFAULT, TAKEN, FREE }


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_color(a_state : States = States.DEFAULT) -> void:
	match a_state:
		States.DEFAULT:
			filter.color = Color(Color.WHITE, 0.0)
		States.TAKEN:
			filter.color = Color(Color.CRIMSON, 0.4)
		States.FREE:
			filter.color = Color(Color.FOREST_GREEN, 0.4)


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
