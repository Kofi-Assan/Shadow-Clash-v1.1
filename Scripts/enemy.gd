extends CharacterBody2D

signal player_entered

var speed = 250
@export var player: Node2D
@export var health: int
@onready var enemy: CharacterBody2D = $"."
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D


func _physics_process(_delta: float) -> void:
	%Restart_Timer.wait_time = 1
	%Timer.wait_time = 0.001
	if nav_agent.is_navigation_finished():
		velocity = Vector2.ZERO
	else:
		var dir = (nav_agent.get_next_path_position() - global_position).normalized()
		velocity = dir * speed
		move_and_slide()

func makepath() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	makepath()
	pass # Replace with function body.

func _ready() -> void:
	%Top_left.enabled = false
	%Top_right.enabled = false
	%Bottom_left.enabled = false
	%Bottom_right.enabled = false
	makepath()

func take_damage():
	%Damage_overtime.start()
	enemy.speed = 0
	#health -= amount
	_on_damage_overtime_timeout()

func return_speed():
	speed = 250

func _on_resume_timeout() -> void:
	return_speed()
	%Damage_overtime.stop()
	if enemy.health <= 0:
		speed = 0
	pass # Replace with function body.

func _on_damage_overtime_timeout() -> void:
	enemy.health -= 20
	if enemy.health <= 50:
		enemy.scale = Vector2(0.7, 0.7)
		$Hitbox.scale = Vector2(1.5, 1.5)
		$Hitbox.position = Vector2(-200, -3)
	if enemy.health <= 30:
		enemy.scale = Vector2(0.5, 0.5)
		$Hitbox.scale = Vector2(2.0, 2.0)
		$Hitbox.position = Vector2(-270, -3)
	print("Enemy health:", health)
	if enemy.health <= 10:
		%Auto_regen.start()
		print("Auto Regeneration Started")

	if enemy.health <= 0:
		%Restart_Timer.start()
		enemy.modulate = Color.RED
		$CollisionShape2D.disabled = true
		%Hitbox_Collision.disabled = true
		%Despawn.start()
		pass # Replace with function body.

func _on_despawn_timeout() -> void:
	queue_free()
	pass # Replace with function body.

func _on_restart_timer_timeout() -> void:
	%Restart.show()
	pass # Replace with function body.

func _on_auto_regen_timeout() -> void:
	enemy.health += 15
	pass # Replace with function body.


func _on_hit_overtime_timeout() -> void:
	player.health -= 20
	print("Player's HP: " + str(player.health))
	
	if player.health <= 0:
		player.speed = 0
		player.modulate = Color.RED
		%Restart.show()
	pass # Replace with function body.w
	
