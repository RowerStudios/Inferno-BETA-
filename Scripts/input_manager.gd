extends Node

@onready var mainmenu = $"/root/Node3D/Control"
@onready var pause = $"/root/Node3D/Pause"
@onready var settings = $"/root/Node3D/Settings"

func _input(event: InputEvent):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			print("ESC pressed")
			if mainmenu.visible:
				pass 
			elif settings.visible:
				settings.visible = false
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				pause.visible = true
