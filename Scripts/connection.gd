class_name Connection
extends Node

@onready var host_btn = $multiplayertest/Panel/host
@onready var join_btn = $multiplayertest/Panel/join
@onready var req = $multiplayertest/Panel/request
func create_server(port, max_cli) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port, max_cli)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(func(id):
		print("connected: ", id)
		req.text = str("connected: " , id)
		)
	multiplayer.peer_disconnected.connect(func(id): 
		print("disconnected: ", id)
		req.text = str("disconnected: " , id)
		)
	print("Server started on port ", port)
	req.text = str("server started on port " , port)

func join_server(ip, port) -> void:
	var peer = ENetMultiplayerPeer.new()
	var res = peer.create_client(ip, port)
	req.text = str("created client for " , ip , port)
	if res == OK:
		multiplayer.multiplayer_peer = peer
		print("Joined!")
		req.text = str("joined a peer")
	else:
		req.text = str("failed to join a peer")
		print("Failed to join: ", res)
func _eh(btn):
	btn.get_node("text").visible = true
func _ready() -> void:
	host_btn.pressed.connect(func():
		create_server(9999, 4)
		_eh(host_btn)
		)
	join_btn.pressed.connect(func():
		join_server("localhost", 9999)
		_eh(join_btn)
		)
	
