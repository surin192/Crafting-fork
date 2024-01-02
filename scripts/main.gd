extends Node2D

@export var difficulty: float = 1
# const OUTWARD_LIMIT: int = Vector2(450, 350)

var laser_scene: PackedScene = preload("res://scenes/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/grenade.tscn")
var asteroid_scene: PackedScene = preload("res://scenes/asteroid.tscn")


func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	$Projectiles.add_child(laser)
	laser.global_position = pos
	laser.rotation = direction.angle()
	laser.direction = direction


func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	$Projectiles.add_child(grenade)
	grenade.global_position = pos
	grenade.linear_velocity = direction


func _process(_delta):
	var random_check = randi_range(0, int(50 / difficulty))
	# var random_check = 0
	if random_check == 0:
		var asteroid = asteroid_scene.instantiate() as Area2D
		$Projectiles.add_child(asteroid)

		match randi_range(0, 3):
			0:
				# Left
				var spawnpoint = Vector2(-425, randi_range(-325, 325))
				asteroid.position = (%Player.position + spawnpoint)
				# asteroid.direction = spawnpoint.normalized()
				asteroid.direction = (
					Vector2.RIGHT + Vector2(0, randf_range(-1, 1))
				)
			1:
				# Right
				var spawnpoint = Vector2(425, randi_range(-325, 325))
				asteroid.position = (%Player.position + spawnpoint)
				asteroid.direction = (
					Vector2.LEFT + Vector2(0, randf_range(-1, 1))
				)

			2:
				# Top
				var spawnpoint = Vector2(-425, randi_range(-325, 325))
				asteroid.position = (%Player.position + spawnpoint)
				asteroid.direction = (
					Vector2.DOWN + Vector2(randf_range(-1, 1), 0)
				)

			3:
				# Bottom
				var spawnpoint = Vector2(randi_range(-425, 425), -325)
				asteroid.position = (%Player.position + spawnpoint)
				asteroid.direction = (
					Vector2.UP + Vector2(randf_range(-1, 1), 0)
				)
