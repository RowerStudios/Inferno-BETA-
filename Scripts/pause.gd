extends Control

@onready var mainmenu = $"/root/Node3D/Control"
@onready var root_node = $".."
@export var scene = preload("res://Scenes/confirm.tscn")
@onready var pause = $"/root/Node3D/Pause"
@onready var settings = $"../Settings"
func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		print("Pressed back")
		if root_node.has_node("confirm"):
			print("Confirm dialog already open")
			return
		if mainmenu.visible:
			var panel = mainmenu.get_node("Panel")
			for child in panel.get_children():
				child.visible = false
				print(child.name)
			var new_scene = scene.instantiate()
			new_scene.name = "confirm"
			root_node.add_child(new_scene)
			print("back pressed on main menu")
		elif settings.visible == true:
			return
		elif not mainmenu.visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			pause.visible = true
			print("in game") 
