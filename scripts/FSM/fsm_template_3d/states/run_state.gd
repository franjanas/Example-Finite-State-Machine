extends State

class_name RunState

func enter():
	pass

func physics_update(_delta: float):
	var input_dir: Vector2 = Input.get_vector("left","right","forward","back")
	var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * player.SPEED
		player.velocity.z = direction.z * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, player.SPEED)
	

	player.move_and_slide()
	check_state_condition()

func check_state_condition() -> void:
	if is_zero_approx(player.velocity.length()):
		state_machine.change_state("idlestate")
	if not player.is_on_floor():
		state_machine.change_state("fallingstate")

func handle_input(_event: InputEvent):
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("jumpstate")
