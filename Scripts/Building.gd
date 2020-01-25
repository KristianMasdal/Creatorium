extends Node2D

var humanInstance = load("res://Scenes/Human.tscn")
var squished = false
var color = Vector3()
func _ready():
	self.z_index = 602+self.global_position.y
	$SpawnTimer.start(3)
	color = $Sprite.modulate
	

func _process(delta):
	if ($BounceTimer.is_stopped()):
		$BounceTimer.start(0.5)

# "Animates" the building
func bounce():
	if (squished):
		$Sprite.scale = Vector2(1, 0.85)
	else:
		$Sprite.scale = Vector2(1, 1)
	squished = !squished

# Spawns a human from the building every 10 seconds
func spawnHuman():
	var humanInst = humanInstance.instance()
	humanInst.global_position = self.global_position
	#humanInst.get_node("Sprite").modulate = color
	get_parent().add_child(humanInst)
	$SpawnTimer.start(10)
	
	
# Signals for timers

func _on_BounceTimer_timeout():
	bounce()


func _on_SpawnTimer_timeout():
	spawnHuman()
