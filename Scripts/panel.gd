extends Panel


@onready var general_frame = $General
@onready var graphical_frame = $Graphical
@onready var control_frame = $Control
@onready var about_frame = $About
@onready var container = $"../Scroll/ScrollContainer/VBoxContainer"
@onready var general_btn = container.get_node("General")
@onready var controls_btn = container.get_node("Controls")
@onready var graphical_btn = container.get_node("Graphical")
@onready var about_btn = container.get_node("About")

var phase :String = "general"
var active_tween : Tween

func _set_phase(new_value : String) -> void:
	if active_tween:
		active_tween.kill()
	
	var prev_btn : Button
	if phase == "general":
		prev_btn = general_btn
	elif phase == "control":
		prev_btn = controls_btn
	elif phase == "graphical":
		prev_btn = graphical_btn
	elif phase == "about":
		prev_btn = about_btn
	
	if prev_btn:
		prev_btn.remove_theme_color_override("font_color")
	
	phase = new_value
	var btn : Button
	if phase == "general":
		btn = general_btn
		general_frame.visible = true
		graphical_frame.visible = false
		control_frame.visible = false
		about_frame.visible = false
	elif phase == "control":
		btn = controls_btn
		general_frame.visible = false
		graphical_frame.visible = false
		control_frame.visible = true
		about_frame.visible = false
	elif phase == "graphical":
		btn = graphical_btn
		general_frame.visible = false
		graphical_frame.visible = true
		control_frame.visible = false
		about_frame.visible = false
	elif phase == "about":
		btn = about_btn
		general_frame.visible = false
		graphical_frame.visible = false
		control_frame.visible = false
		about_frame.visible = true
	
	if btn:
		btn.add_theme_color_override("font_color", Color("white"))
		active_tween = create_tween()
		active_tween.set_loops()
		active_tween.tween_property(btn, "theme_override_colors/font_color", Color("7d7d7dff"), 0.5)
		active_tween.tween_property(btn, "theme_override_colors/font_color", Color("white"), 0.5)

func _ready():
	print("test")
	general_btn.pressed.connect(_general_press)
	controls_btn.pressed.connect(_control_press)
	graphical_btn.pressed.connect(_graphical_press)
	about_btn.pressed.connect(_about_press)
	_set_phase("general")
	
	
func _general_press():
	_set_phase("general")
	print("general")
	
func _control_press():
	_set_phase("control")
	print("control")
	
func _graphical_press():
	_set_phase("graphical")
	print("grpahical")
	
func _about_press():
	_set_phase("about")
	print("about")
