extends CharacterBody3D

var t_bob = 0.0
var is_playing: bool = false
var is_shooting: bool = false
var sway_amount = 0.4
var sway_speed = 6.0
var sway_target_z = 0.0
var sway_target_x = 0.0
var last_mouse_delta = Vector2.ZERO
var gun_offset_y = 0.0
var was_on_floor = true

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var main = $Head/Camera3D/Main
@onready var right_arm = $Head/Camera3D/Main/RightArm
@onready var gun = right_arm.get_node("weapon")
@onready var animation = gun.get_node("Walk")
@onready var gun_main = gun.get_node("Cube")
@onready var gun_light = gun_main.get_node("OmniLight3D")

func _shoot():
	is_shooting = true
	while is_shooting:
		gun_light.visible = true
		await get_tree().create_timer(randf_range(0.07, 0.09)).timeout
		gun_light.visible = false
		await get_tree().create_timer(randf_range(0.07, 0.09)).timeout

func _ready():
	var sender_node = get_node("/root/Node3D/Control/Panel/Button")
	sender_node.game_started.connect(playing)

func playing():
	is_playing = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if is_playing and Input.is_action_just_pressed("Shoot"):
		_shoot()
	if is_playing and Input.is_action_just_released("Shoot"):
		is_shooting = false
		gun_light.visible = false
	if is_playing and event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * PlayerData.sensitivity)
		camera.rotate_x(-event.relative.y * PlayerData.sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		last_mouse_delta = event.relative

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
	if direction and is_on_floor():
		animation.speed_scale = 1.0
		if animation.current_animation != "walk_new":
			animation.play("walk_new")
	else:
		if animation.current_animation == "walk_new":
			animation.speed_scale = 0.0
	sway_target_z = clamp(-last_mouse_delta.x * 0.001, -sway_amount, sway_amount)
	sway_target_x = clamp(-last_mouse_delta.y * 0.0005, -sway_amount * 0.5, sway_amount * 0.5)
	last_mouse_delta = last_mouse_delta.lerp(Vector2.ZERO, delta * sway_speed)
	head.rotation.z = lerp(head.rotation.z, sway_target_z, delta * sway_speed)
	head.rotation.x = lerp(head.rotation.x, sway_target_x, delta * (sway_speed * 0.5))
	main.rotation.z = lerp(main.rotation.z, -sway_target_z, delta * sway_speed)
	main.rotation.x = lerp(main.rotation.x, -sway_target_x, delta * (sway_speed * 0.5))
	if not is_on_floor():
		gun_offset_y += (-velocity.y * 0.0003) * delta * 60.0
		gun_offset_y = clamp(gun_offset_y, -0.05, 0.4)
	else:
		if not was_on_floor:
			var tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_SPRING)
			tween.tween_method(func(v): gun_offset_y = v, gun_offset_y, 0.0, 0.6)
		else:
			gun_offset_y = lerp(gun_offset_y, 0.0, delta * 10.0)
	was_on_floor = is_on_floor()
	main.position.y = gun_offset_y
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * PlayerData.bob_freq) * PlayerData.bob_amp
	pos.x = cos(time * PlayerData.bob_freq / 2) * PlayerData.bob_amp
	return pos
