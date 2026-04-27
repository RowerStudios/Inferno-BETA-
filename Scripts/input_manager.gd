extends Node

@onready var mainmenu: Control = get_node_or_null("/root/Node3D/Control")
@onready var pause: Control = get_node_or_null("/root/Node3D/Pause")
@onready var settings: Control = get_node_or_null("/root/Node3D/Settings")

var confirm_scene = preload("res://Scenes/confirm.tscn")

func _input(event: InputEvent):
	if mainmenu == null or pause == null:
		return
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			print("ESC pressed")
			if mainmenu.visible:
				var panel = mainmenu.get_node("Panel")
				for child in panel.get_children():
					child.visible = false
				if not get_node_or_null("/root/Node3D/confirm"):
					var new_scene = confirm_scene.instantiate()
					new_scene.name = "confirm"
					get_node("/root/Node3D").add_child(new_scene)
			elif settings.visible:
				settings.visible = false
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				pause.visible = true
