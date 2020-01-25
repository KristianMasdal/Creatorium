extends Node2D

var building = preload("res://Scenes/Building.tscn")
var testDestination
var timer = 0
var actionTime = 0
var timeSinceLastMove = 0
var isAngledRight = false
var foundResource = false
var atTarget = false
var target = null
var resources = 0
export var maxDistance = 400
var color = Vector3()
func _ready():
	color = Color(rand_range(0,1),rand_range(0,1),rand_range(0,1))
	self.modulate = color
	timer = 0
	actionTime = 60
	#self.position = Vector2(50,50)
	self.z_index = 243
	foundResource = false
	
func _process(delta):
	if (resources > 9):
		build()
	if (!foundResource):
		wander()
	elif(target):
		foundResource = true
		gather(target)
func findResource(resource):
	print("Searching for resource..")
	#move()
	
func gather(tar: Object):
	if (tar == null):
		return
	if (tar.isDead == false):
		var tarPos = tar.get_global_position()
		move(tarPos, 1)
		if (self.global_position.x - tarPos.x < 10 && self.global_position.y - tarPos.y < 10 ):
			tar.interact_with("Chop", 5)
	if (tar.hp <= 0):	
		resources += 1
		foundResource = false
		return

func wander():
	timer += 1
	timeSinceLastMove += 1
	if ($Tween.is_active()):
		$Sprite.play("active")
	else:
		$Sprite.play("default")
	if (timer - actionTime > 20 && timeSinceLastMove > 5*60):
		randomize()
		var destination = Vector2(rand_range(-maxDistance, maxDistance), rand_range(-maxDistance, maxDistance))
		move(destination, 4)
		actionTime = 60
		timer = 0
		print("Moving to ", destination)
		print("From ", $".".global_position)	
		timeSinceLastMove = 0
		
func move(destination, speed):
	$Tween.interpolate_property($".", "position", $".".global_position, destination, speed,
        	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func build():
	resources -= 10
	var buildingInst = building.instance()
	buildingInst.global_position = self.global_position
	buildingInst.get_node("Sprite").modulate = color
	self.get_parent().add_child(buildingInst)

# Signal for colliding with area2D body
func _on_Area2D_body_entered(body):
	if(body.has_method('interact_with') && !foundResource):
		foundResource = true
		print("Human found a tree!")
		target = body
		gather(target)
		#body.interact_with("test", 5)