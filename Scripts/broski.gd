extends Button

var tween;
var original_color: Color

func _ready() -> void:
	pressed.connect(_press)
	mouse_entered.connect(_enter)
	mouse_exited.connect(_exit)


func _press():
	print("hell")
	
func _enter():
	if tween and tween.is_running():
		tween.kill()
	var original_color = self_modulate
	tween = create_tween()
	tween.tween_method(func(color): self.add_theme_color_override("font_color", color),original_color, Color.DIM_GRAY, 0.3)
func _exit():
	print("exit")
