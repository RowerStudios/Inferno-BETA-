extends Node3D

@onready var player = $AudioStreamPlayer3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.playing = true
