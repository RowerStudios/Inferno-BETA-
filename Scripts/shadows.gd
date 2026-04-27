extends Button

@onready var btn = $"Button"

var are_shadows_enabled = false:
	set(new_property):
		are_shadows_enabled = new_property
		btn.text = "Enabled" if new_property else "Disabled"

func _find_shadows():
	var lights = get_tree().get_nodes_in_group("game_lights")
	for light in lights:
		if light.shadow_enabled:
			are_shadows_enabled = true
			return
	are_shadows_enabled = false

func shadows(enabled: bool):
	var lights = get_tree().get_nodes_in_group("game_lights")
	for light in lights:
		light.shadow_enabled = enabled  

func _ready() -> void:
	_find_shadows()
	btn.pressed.connect(_press)

func _press():
	shadows(!are_shadows_enabled)  
	_find_shadows()
