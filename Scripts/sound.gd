extends Node3D

@onready var sound = $"AudioStreamPlayer3D"
@onready var control = $Control

func _ready() -> void:
	DiscordRPC.app_id = 1496487190404796416
	sound.playing = true
	DiscordRPC.start_timestamp = Time.get_unix_time_from_system()
	_update_rpc()

func _update_rpc():
	if control.visible:
		DiscordRPC.details = "In Main Menu"
		DiscordRPC.state = "Testing"
	else:
		DiscordRPC.details = "Testing :" + str(GameData.level)
		#DiscordRPC.state = "Secrets : " + str(GameData.secrets) + str("/") + str(GameData.total_secrets)
		DiscordRPC.state = "Tester"
	DiscordRPC.refresh()
