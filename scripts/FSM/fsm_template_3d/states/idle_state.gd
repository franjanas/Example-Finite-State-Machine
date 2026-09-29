extends State

class_name IdleState

func handle_input(_event: InputEvent):
	var input: Vector2 = Input.get_vector("left","right","forward","back")
	if input:
		state_machine.change_state("runstate")
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("jumpstate")

func update(_delta: float):
	if not player.is_on_floor():
		state_machine.change_state("fallingstate")
		
