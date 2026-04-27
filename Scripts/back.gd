extends Button

@onready var bck_vector = pivot_offset
@onready var bck_offset2 = pivot_offset_ratio
@onready var panel = $"../../.."
@onready var Main = $"../../../../Control"
@onready var sound = $"../../../../AudioStreamPlayer3D"
@onready var pause = $"/root/Node3D/Pause"
@onready var hover = $"/root/Node3D/Hover"
@onready var click = $"/root/Node3D/Click"


func _play():
	if Main.get_node("Panel").visible:
		sound.bus = "Master"
		Main.visible = true
		panel.visible = false
	elif Main.visible == false:
		panel.visible = false
		pause.visible = true
		
	
func _input(event: InputEvent) -> void:
	if panel.visible == true:
		if event.is_action_pressed("ui_cancel"):
			_press()

func _ready() -> void:
	var center_pivot = Vector2(size.x / 2, size.y / 2)
	pivot_offset = center_pivot
	bck_vector = center_pivot
	bck_offset2 = pivot_offset_ratio  
	
	button_down.connect(_press)
	button_up.connect(_press_end)
	mouse_entered.connect(_hover)
	mouse_exited.connect(_exit)

func _press() -> void:
	click.play()
	print("begin")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
	_play()

func _press_end() -> void:
	print("end")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.25, 1.25), 0.1)

func _hover() -> void:
	hover.play()
	print("hover")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.25, 1.25), 0.1)

func _exit() -> void:
	print("exit")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)   
