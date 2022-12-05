extends RigidBody2D

@export var marker1: Marker2D
@export var marker2: Marker2D
@onready var label: Label = $Label

var initial_position: Vector2
var label_data: String

func _ready():
	initial_position = global_position
	add_constant_force(Vector2.UP * 5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	update_label()
	if constant_force != Vector2.ZERO:
		if (global_position - initial_position).length() > 10:
			constant_force = Vector2.ZERO
		
	

func update_label():
	var layer = str(get_collision_layer())
	var mask = str(get_collision_mask())
	label.text = layer + "|" + mask
	if not label_data.is_empty():
		label.text += "|" + label_data

func _on_body_entered(body):
	print("Skull _on_body_entered: ", body.name)
	label_data = body.name


func _on_body_exited(body):
	print("Skull _on_body_exited: ", body.name)
	label_data = ""
