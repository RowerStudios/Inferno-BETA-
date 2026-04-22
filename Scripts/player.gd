extends CharacterBody3D

const BASESPEED = 8.0
const SPRINTMULTIPLIER = 1.7
const JUMP_VELOCITY = 9
const SENSITIVITY = 0.002

# 1. This variable acts as your "On/Off" switch
var is_playing: bool = false

@onready var head = $Head
@onready var camera = $Head/Camera3D
func _ready():
	var sender_node = get_node("/root/Node3D/Control/Panel/Button")
	sender_node.game_started.connect(playing)
# 2. This is the function other scripts will call
func playing():
	is_playing = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	# Only allow camera movement if is_playing is true
	if is_playing and event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)

func _physics_process(delta: float) -> void:
	# 3. If the game hasn't started, skip all movement logic
	if not is_playing:
		return 

	var SPEED = BASESPEED
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("sprint"):
		SPEED = BASESPEED * SPRINTMULTIPLIER

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
