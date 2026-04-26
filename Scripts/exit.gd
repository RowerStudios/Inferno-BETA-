extends Button

@export var scene = preload("res://Scenes/confirm.tscn")
@onready var root_node = $"../../../../.." 
@onready var node = $"../../../.." 

func _ready() -> void:
	button_down.connect(_press)

func _press() -> void:
	print("lol")
	node.visible = false
	var new_scene = scene.instantiate()
	root_node.add_child(new_scene)
