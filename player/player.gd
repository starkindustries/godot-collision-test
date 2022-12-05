extends CharacterBody2D
class_name Player


@export var move_speed : float = 50.0
@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label

enum State { IDLE, MOVING }

const TILE_LENGTH = 16

var input_direction = Vector2(0, 0)
var state = State.IDLE
var label_data: String = ""


func _ready():
	animation_player.play("idle")


func _physics_process(_delta):
	update_label()
	match state:
		State.IDLE:
			idle_state()
		State.MOVING: 
			moving_state()


func update_label():
	var layer = str(get_collision_layer())
	var mask = str(get_collision_mask())
	label.text = layer + "|" + mask
	if not label_data.is_empty():
		label.text += "|" + label_data


func get_user_input():
	var x = float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left"))
	var y = float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	return Vector2(x, y)


# IDLE STATE
func idle_state():
	# Poll for user input
	input_direction = get_user_input()
	if input_direction != Vector2.ZERO:
		state = State.MOVING


func moving_state():
	input_direction = get_user_input()
	velocity = move_speed * input_direction.normalized()
	move_and_slide()
	if velocity == Vector2.ZERO:
		state = State.IDLE


func _on_Player_body_entered(body):
	print("_on_Player_body_entered: ", body.name)
	label_data = body.name
