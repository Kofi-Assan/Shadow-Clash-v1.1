extends Area2D

@export var player: Node2D
@onready var interior: TileMapLayer = $"../../TileMap/Interior"
@onready var enemy: CharacterBody2D = %Enemy
@onready var top_left: PointLight2D = $"../Danger/Top_left"
@onready var top_right: PointLight2D = $"../Danger/Top_right"
@onready var bottom_left: PointLight2D = $"../Danger/Bottom_left"
@onready var bottom_right: PointLight2D = $"../Danger/Bottom_right"

func _on_enemy_player_entered() -> void:
	%Hit_Overtime.start()
	pass # Replace with function body.

func _on_hit_overtime_timeout() -> void:
	player.health -= 20
	%Player.speed = 10
	print("Player's HP: " + str(player.health))
	if player.health <= 30:
		danger()
	if player.health <= 0:
		player.speed = 0
		player.modulate = Color.RED
		%Restart.show()

	pass # Replace with function body.

func _on_body_entered(body: CharacterBody2D) -> void:
	_on_enemy_player_entered()
	pass # Replace with function body.

func _on_body_exited(body: Node2D) -> void:
	%Hit_Overtime.stop()
	pass # Replace with function body.

func _on_restart_pressed() -> void:
	pass # Replace with function body.

func danger() -> void:
	%Top_left.enabled = true
	%Top_right.enabled = true
	%Bottom_left.enabled = true
	%Bottom_right.enabled = true
	%Top_left.energy = 10
	%Top_right.energy = 10
	%Bottom_left.energy = 10
	%Bottom_right.energy = 10
