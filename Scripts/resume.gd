extends Button
@onready var node = $"../../../.."
func _ready() -> void:
	pressed.connect(_resume)
	
func _resume():
	print("game resumed")
	node.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
