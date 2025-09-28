extends CharacterBody2D

var character_speed : int = 80
var speed_up : int = 20
var slow_down : int = 10
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var idle: Sprite2D = $idle
@onready var walk: Sprite2D = $walk
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

func _ready() -> void:
	pass
	
func move_state() -> void:
	var move_vector : Vector2 = Vector2(0,0)
	move_vector.x = Input.get_action_strength("ui_right") - Input.get_action_raw_strength("ui_left")
	move_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Normalize movement, then adjust for isometric tileset
	move_vector = move_vector.normalized()
	move_vector.y = move_vector.y * .5
	
	
	if move_vector != Vector2.ZERO :
		if idle.visible : idle.visible = false
		if not walk.visible : walk.visible = true
		
		state_machine.travel("walk")
		velocity = velocity.move_toward(move_vector * character_speed, speed_up)
		animation_tree.set("parameters/idle/blend_position", move_vector)
		animation_tree.set("parameters/walk/blend_position", move_vector)

	else :
		if not idle.visible : idle.visible = true
		if walk.visible : walk.visible = false
		state_machine.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, slow_down)
		
	move_and_slide()


func _physics_process(_delta: float) -> void:
	move_state()
