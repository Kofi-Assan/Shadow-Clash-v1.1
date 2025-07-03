extends Area2D

@onready var torch: Area2D = $"."
@onready var torch_battery: Timer = $Torch_Battery

signal enemy_burned(enemy)

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	pass

func _process(delta: float) -> void:
	pass
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage()
		emit_signal("enemy_burned", body)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body._on_resume_timeout()
		pass
