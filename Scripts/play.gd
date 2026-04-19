extends Button

@onready var bck_vector = pivot_offset
@onready var bck_offset2 = pivot_offset_ratio

func _ready() -> void:
	# Ensure the initial pivot is set to center for proper scaling
	var center_pivot = Vector2(size.x / 2, size.y / 2)
	pivot_offset = center_pivot
	bck_vector = center_pivot
	bck_offset2 = pivot_offset_ratio  # Save original ratio if used

	button_down.connect(_press)
	button_up.connect(_press_end)
	mouse_entered.connect(_hover)
	mouse_exited.connect(_exit)

func _press() -> void:
	print("begin")
	var new_tween = create_tween()
	new_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)

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
