extends StaticBody2D


@onready var label: Label = $Label

func _process(_delta):
	var layer = str(get_collision_layer())
	var mask = str(get_collision_mask())
	label.text = layer + "|" + mask
