extends Button

@export var scene = preload("res://Scenes/confirm.tscn")
@onready var root_node = $"../../../../.." 
@onready var node = $"../../../.." 
@onready var hover = $"/root/Node3D/Hover"
@onready var click = $"/root/Node3D/Click"

func _ready() -> void:
	var center_pivot = Vector2(size.x / 2, size.y / 2)
	pivot_offset = center_pivot
	pressed.connect(_resume)
	button_down.connect(_press)
	mouse_entered.connect(_hover)

func _press() -> void:
	print("begin")
	click.play()

func _hover() -> void:
	print("hover")
	hover.play()
func _resume():
	print("lol")
	node.visible = false
	var new_scene = scene.instantiate()
	root_node.add_child(new_scene)
