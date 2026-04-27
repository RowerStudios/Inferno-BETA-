extends Button

@onready var hover = $"/root/Node3D/Hover"
@onready var click = $"/root/Node3D/Click"
@onready var node = $"../../../.."

func _ready() -> void:
	var center_pivot = Vector2(size.x / 2, size.y / 2)
	pivot_offset = center_pivot
	pressed.connect(_resume)
	button_down.connect(_press)
	mouse_entered.connect(_hover)

'func _input(event: InputEvent) -> void:
	if node.visible == true:
		await get_tree().create_timer(1)
		if Input.is_action_pressed("ui_cancel"):
			_resume()'

func _press() -> void:
	print("begin")
	click.play()

func _hover() -> void:
	print("hover")
	hover.play()
	
func _resume():
	print("game resumed")
	node.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
