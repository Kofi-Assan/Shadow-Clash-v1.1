extends Timer

@onready var torch: Area2D = $"../Torch"
@onready var torch_brightness: PointLight2D = $"../PointLight2D"
enum LEVELS{HIGH, MEDIUM, LOW, CRITICAL, EMPTY}

var Battery: int

func percentages():
	if torch_brightness.percent >= 80:
		#print("HIGH")
		%PointLight2D.energy = 16
		Battery == LEVELS.HIGH
		
	elif torch_brightness.percent < 80 and torch_brightness.percent >= 41:
		#print("MEDIUM")
		%PointLight2D.energy = 9
		Battery == LEVELS.MEDIUM
	elif torch_brightness.percent < 40 and torch_brightness.percent >= 16:
		#print("LOW")
		%PointLight2D.energy = 4
		%PointLight2D.scale = Vector2(0.5, 0.5)
		Battery == LEVELS.LOW
	elif torch_brightness.percent < 15 and torch_brightness.percent >= 10:
		#print("CRITICAL")
		%PointLight2D.energy == 1
		%PointLight2D.scale = Vector2(0.1, 0.1)
		Battery == LEVELS.CRITICAL
	elif torch_brightness.percent <= 9:
		#print("EMPTY")
		%PointLight2D.enabled = false
		Battery == LEVELS.EMPTY
		%CollisionShape2D.disabled = true
		pass


func _on_timeout() -> void:
	percentages()
	torch_brightness.percent -= 10
	print("Percentage: " + str(torch_brightness.percent) + "%")
	if torch_brightness.percent <= 0:
		%CollisionShape2D.hide()
		pass


func _on_charging_station_body_entered(body: Node2D) -> void:
	%"Percent per second".start()
	pass

func _on_percent_per_second_timeout() -> void:
	torch_brightness.percent += 20
	pass # Replace with function body.

func _on_charging_station_body_exited(body: Node2D) -> void:
	%"Percent per second".stop()
	pass # Replace with function body.
