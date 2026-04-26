extends Button

@onready var bck_vector = pivot_offset
@onready var bck_offset2 = pivot_offset_ratio
@onready var root_node = $"/root/Node3D"
@onready var mainmenu = $"/root/Node3D/Control"
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
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
	if mainmenu.visible == true:
		var panel = mainmenu.get_node("Panel")
		for child in panel.get_children():
			var confirm = $"../.."
			confirm.remove_child(self)
			child.visible = true
			print(child.name)
			if root_node.has_node("confirm"):
				var confirm_dialog = root_node.get_node("confirm")
				root_node.remove_child(confirm_dialog)
				confirm_dialog.queue_free()
				print("Confirm dialog removed")
	else:
		print("wip")
	

func _press_end() -> void:
	print("end")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.25, 1.25), 0.1)

func _hover() -> void:
	print("hover")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.25, 1.25), 0.1)

func _exit() -> void:
	print("exit")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)   
