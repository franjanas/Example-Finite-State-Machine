extends State

class_name FallingState

func physics_update(_delta: float):
	var input_dir: Vector2 = Input.get_vector("left","right","forward","back")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	player.velocity += player.get_gravity() * _delta
	
	if direction:
		player.velocity.x = direction.x * player.SPEED
		player.velocity.z = direction.z * player.SPEED
	
	player.move_and_slide()

	if player.is_on_floor() and input_dir == null:
		state_machine.change_state("idlestate")
	elif player.is_on_floor() and input_dir != null:
		state_machine.change_state("runstate")
