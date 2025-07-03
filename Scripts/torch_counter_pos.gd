extends CanvasLayer
@onready var torch_brightness: PointLight2D = $"../PointLight2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Torch_counter.text = "Flash: " + str(torch_brightness.percent) + "%"
	pass
