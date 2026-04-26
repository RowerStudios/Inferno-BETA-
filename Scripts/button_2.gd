extends Button

@onready var node = $"../.."
@onready var settings = $"../../../Settings"
@onready var bck_vector = pivot_offset
@onready var bck_offset2 = pivot_offset_ratio
@onready var hover = $"../../Hover"
@onready var click = $"../../Click"
@onready var exit = $"../../exit"
@onready var panel = get_node("/root/Node3D/Control/Panel") 
@onready var sound = $"../../../AudioStreamPlayer3D"
@onready var control = get_node("/root/Node3D/Control") 
signal game_started

func _play():
	node.visible = false
	settings.visible = true

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
	print("begin")
	click.play()
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
	_play()

func _press_end() -> void:
	print("end")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.25, 1.25), 0.1)

func _hover() -> void:
	print("hover")
	hover.play()
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.25, 1.25), 0.1)

func _exit() -> void:
	print("exit")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)   
