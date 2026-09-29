extends CharacterBody3D

class_name Player

const SPEED: float = 9.0
const JUMP_VELOCITY: float = 6.0

@export_group("Look sensitivity")
@export var mouse_sens: float = 0.003
@export var controller_sens: float = 5.0

@export_group("Camera")
@export var cam_max_angle: float = 85.0
@export var horizontal_offset: float = 0.7

var pitch: float = 0.0

@export var camera: Camera3D
@export var pivot: Node3D 
#I usually have a Node3D called Pivot and a child is Camera3D if
#it's 1st person, if it's 3rd i have the SpringArm first and Camera3D as a child

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_with_mouse(event)

func rotate_with_mouse(event: InputEvent) -> void:
	rotate_y(-event.relative.x * mouse_sens)
	
	pitch -= event.relative.y * mouse_sens
	pitch = clamp(pitch, deg_to_rad(-cam_max_angle), deg_to_rad(cam_max_angle))
	pivot.rotation.x = pitch

func rotate_with_controller(delta: float) -> void:
	var input_vec: Vector2 = Input.get_vector("joy_axis_left","joy_axis_right", "joy_axis_up", "joy_axis_down")
	rotate_y(-input_vec.x * controller_sens * delta)
	
	pitch -= input_vec.y * controller_sens * delta
	pitch = clamp(pitch, deg_to_rad(-cam_max_angle), deg_to_rad(cam_max_angle))
	pivot.rotation.x = pitch
