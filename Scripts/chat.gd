extends Control

@onready var frame = $Chats
@onready var ChatBox = $Chats/ChatBox
@onready var Send = $Chats/ChatBox/C_O2
@onready var c_o = $Chats/C_O
@onready var SC = $Chats/ScrollContainer/VBoxContainer
@onready var PLACE_holder = $Chats/ScrollContainer/PLACEHOLDER_chat


var _pos: Vector2
var boolean := false
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			_chat()
			ChatBox.text = ""
			get_viewport().set_input_as_handled()
		if event.keycode == KEY_SLASH:
			_press()
			

func _send_sys(msg):
	var new_chat = PLACE_holder.duplicate()
	new_chat.text = "[SYSTEM]"
	new_chat.visible = true
	SC.add_child(new_chat)
	var label = new_chat.get_node("chat_label")
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.size_flags_horizontal = Control.SIZE_FILL
	label.text = msg
func _ready() -> void:
	Send.pressed.connect(_chat)
	_pos = frame.position
	c_o.pressed.connect(_press)

func _press():
	print("hi")
	var tween = create_tween()
	var target_position = Vector2(0, 300) if boolean else Vector2(0, 0)
	tween.tween_property(frame, "position", target_position, 0.1).set_trans(Tween.TRANS_QUAD)
	boolean = !boolean
	
func _chat():
	if ChatBox.text == "":
		_send_sys(str("Please Type a message in the chat box below!"))
		return
	var msg = ChatBox.text
	var new_chat = PLACE_holder.duplicate()
	new_chat.visible = true
	SC.add_child(new_chat)
	var chat_l = new_chat.get_node("chat_label")
	new_chat.get_node("chat_label").text = msg
	ChatBox.text = ""
	await get_tree().process_frame
	$Chats/ScrollContainer.scroll_vertical = 999999
	
