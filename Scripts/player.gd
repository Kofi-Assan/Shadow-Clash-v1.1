extends CharacterBody2D

@export var speed: int
@export var health: int
@onready var player: Sprite2D = $Sprite2D
@onready var torch: Area2D = $Sprite2D/Torch
@onready var torch_collision: CollisionShape2D = $Sprite2D/Torch/CollisionShape2D2
@onready var enemy: CharacterBody2D = $"../Enemy"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	torch.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	position += speed * direction * delta
	move_and_slide()
	
	if Input.is_action_pressed("left"):
		player.rotation_degrees = 180
	elif Input.is_action_pressed("right"):
		player.rotation_degrees = 0
	elif Input.is_action_pressed("up"):
		player.rotation_degrees = -90
	elif Input.is_action_pressed("down"):
		player.rotation_degrees = 90
	else:
		pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("toggle_flashlight"):
		torch.show()
		speed = 90
	else:
		torch.hide()
		speed = 500
		pass
