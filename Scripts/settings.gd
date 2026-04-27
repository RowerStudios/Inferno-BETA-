extends Button
@onready var settings = $"../../../../../Settings"
@onready var hover = $"/root/Node3D/Hover"
@onready var click = $"/root/Node3D/Click"
@onready var node = $"../../../.."

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
	print("game resumed")
	node.visible = false
	settings.visible = true
