class_name InventoryFilter extends Control

@onready var status_filter: ColorRect = $StatusFilter

var slot_id

func set_filter(state: InventorySlot.State) -> void:
	status_filter.color = InventorySlot.get_color(state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
