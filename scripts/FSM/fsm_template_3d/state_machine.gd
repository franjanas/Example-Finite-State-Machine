@tool
extends Node

class_name StateMachine

@export var initial_state: State:
	set(value):
		initial_state = value
		update_configuration_warnings()
var current_state: State
var states: Dictionary = {}

func _get_configuration_warnings() -> PackedStringArray:
	if not initial_state:
		return ["INITIAL STATE MUST BE SET"]
	else:
		return []

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_machine = self
			child.player = self.get_parent()
	if initial_state:
		change_state(initial_state.name.to_lower())

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()
	
	current_state = states.get(new_state_name.to_lower())
	
	if current_state:
		current_state.enter()

#func play_state_animation(anim_name: StringName) -> void:
	#pass
