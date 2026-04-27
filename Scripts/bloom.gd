extends Button

@onready var envir = $"/root/Node3D/WorldEnvironment"
@onready var environment : Environment = envir.environment
@onready var btn = $"Button"

var property = true:
	set(new_property):
		property = new_property
		if new_property:
			btn.text = "Enabled"
		else:
			btn.text = "Disabled"

func _ready() -> void:
	if environment.glow_enabled == true:
		property = true
	else:
		property = false
	btn.pressed.connect(_press)
	

func _press():
	print("Bloom toggle")
	if property == true:
		property = false
		environment.glow_enabled = false   
	else:
		property = true
		environment.glow_enabled = true   
	
