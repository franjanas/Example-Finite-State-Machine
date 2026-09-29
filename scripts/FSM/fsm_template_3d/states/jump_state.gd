extends State

class_name JumpState

func enter():
	player.velocity = Vector3.ZERO
	player.velocity.y -= 400.0
	

func physics_update(_delta: float):
	var input_dir: Vector2 = Input.get_vector("left","right","forward","back")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	player.velocity.y = player.JUMP_VELOCITY
	
	if direction:
		player.velocity.x = direction.x * player.SPEED
		player.velocity.z = direction.z * player.SPEED

	
	player.move_and_slide()
	
	if player.is_on_floor():
		if input_dir != Vector2.ZERO:
			state_machine.change_state("runstate")
		else:
			state_machine.change_state("idlestate")
	else:
		state_machine.change_state("fallingstate")
