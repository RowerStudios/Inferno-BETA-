extends Button

@onready var hover = $"/root/Node3D/Hover"
@onready var click = $"/root/Node3D/Click"

func _ready() -> void:
	pressed.connect(_press)
	mouse_entered.connect(_enter)
	mouse_exited.connect(_exit)
	add_theme_color_override("font_color", Color(0.0, 1.0, 0.0, 1.0))

func _press():
	click.play()

func _enter():
	if text == "Enabled":
		add_theme_color_override("font_color", Color(0.0, 1.0, 0.0, 1.0))
	else:
		add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
	hover.play()

func _exit():
	if text == "Enabled":
		add_theme_color_override("font_color", Color(0.0, 1.0, 0.0, 1.0))
	else:
		add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
