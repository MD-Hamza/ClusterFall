extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Spawner.destroyed.connect(_teleport_player);
	$Obstacle.area_entered.connect(_on_obstacle_collide)

func _on_obstacle_collide(area: Area2D):
	print("Entered by:", area.name)
	
func _teleport_player(position: Vector2):
	$Player.position = position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
