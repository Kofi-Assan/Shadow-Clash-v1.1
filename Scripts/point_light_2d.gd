extends PointLight2D
@onready var torch_battery: Timer = $"../Torch_Battery"
@export var percent: int
@onready var torch_brightness: PointLight2D = $"../PointLight2D"

# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("toggle_flashlight"):
		torch_battery.percentages()
		torch_battery.start()
	else:
		torch_battery.stop()
		pass
