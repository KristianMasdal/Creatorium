extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isAngledRight = false
var timeSinceLastWiggle = 0
var wiggleSpeed = 1
var wiggleArc = Vector2()
var treeSize = 1
var hp = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	timeSinceLastWiggle = 0
	randomize()
	hp = 100
	print("Tree! ", self.position)
	wiggleArc = Vector2(rand_range(1,10),rand_range(350,359))
	wiggleSpeed = rand_range(0.5,1)
	treeSize = rand_range(0.15, 0.35)
	self.scale = Vector2(treeSize, treeSize)
	self.modulate = Color(rand_range(0,1),rand_range(0,1),rand_range(0,1))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeSinceLastWiggle += wiggleSpeed
	if (hp <= 0):
		self.free()
	else:
		if (timeSinceLastWiggle > 30):
			if (treeSize < 2):
				hp = hp * treeSize
				treeSize += 0.02
				self.scale = Vector2(treeSize, treeSize)
			if (isAngledRight):
				isAngledRight = false
				self.rotation_degrees = wiggleArc.x
			else:
				isAngledRight = true
				self.rotation_degrees = wiggleArc.y
			timeSinceLastWiggle = 0
func interact_with(interactor, amount):
	hp = hp - amount
	print("", interactor + "Interacted with me!")