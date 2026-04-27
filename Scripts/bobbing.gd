extends Button

@onready var btn = $"Button"
var df_freq = PlayerData.bob_freq
var property = true:
	set(new_property):
		property = new_property
		if new_property:
			btn.text = "Enabled"
		else:
			btn.text = "Disabled"

func _ready() -> void:
	if PlayerData.bob_freq == 0:
		property = false
	else:
		property = true
	btn.pressed.connect(_press)
	

func _press():
	print("Bloom toggle")
	if property == true:
		property = false
		PlayerData.bob_freq = 0  
	else:
		property = true
		PlayerData.bob_freq = df_freq  
	
