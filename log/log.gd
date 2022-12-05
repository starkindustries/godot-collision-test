extends Area2D

@onready var label: Label = $Label

@export var stop: bool = false

var label_data: String = ""
var initial_position: Vector2
var move_speed: float = 10.0


func _ready():
	initial_position = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_label()
	var distance = (global_position - initial_position).length()	
	if distance < 60 and not stop:
		position += Vector2.UP * delta * move_speed


func update_label():
	var layer = str(get_collision_layer())
	var mask = str(get_collision_mask())
	label.text = str(name) + "|" + layer + "|" + mask
	if not label_data.is_empty():
		label.text += "|" + label_data


func _on_area_entered(area):
	label_data = str(area.name)
	stop = true


func _on_area_exited(area):
	label_data = ""


func _on_body_entered(body):
	label_data = str(body.name) + " body"
	stop = true


func _on_body_exited(body):
	label_data = ""
