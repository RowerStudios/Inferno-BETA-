extends CharacterBody3D

var t_bob = 0.0
var is_playing: bool = false

@onready var head = $Head
@onready var camera = $Head/Camera3D

func _ready():
	var sender_node = get_node("/root/Node3D/Control/Panel/Button")
	sender_node.game_started.connect(playing)

func playing():
	is_playing = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if is_playing and event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * PlayerData.sensitivity)
		camera.rotate_x(-event.relative.y * PlayerData.sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta: float) -> void:
	if not is_playing:
		return

	var SPEED = PlayerData.base_speed

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = PlayerData.jump_velocity

	if Input.is_action_pressed("sprint") and is_on_floor():
		SPEED = PlayerData.base_speed * PlayerData.sprint_multiplier

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)

	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * PlayerData.bob_freq) * PlayerData.bob_amp
	pos.x = cos(time * PlayerData.bob_freq / 2) * PlayerData.bob_amp
	return pos
