extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const TreeInstance = preload("res://Scenes/WiggleTree.tscn")
const HumanInstance = preload("res://Scenes/Human.tscn")
var treePop = 1
var treeTimer = 0
var treeCount = 0
var trees = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	self.z_index = -590
	for i in range(-10, 10):
		for j in range(-10, 10):
			self.set_cell(i,j, tile_set.find_tile_by_name("brown_1"))
	var human = HumanInstance.instance()
	human.name = "Human"
	self.add_child(human)
	
	
#func _process(delta):
#	var popATree = randi() % 100 + 1
#	var newTree
#	if (popATree > 77):
#		newTree = TreeInstance.instance()
#		var y = rand_range(-200,240)
#		var x = rand_range(-240,240)
#		var spawnRange = 10
#		var canSpawnTree = true
#		newTree.position = Vector2(x, y)
#		newTree.z_index = y
#		# 10,10
#		for tree in self.get_children():
#			if ((newTree.position.x <= tree.position.x+spawnRange 
#			&& newTree.position.x >= tree.position.x-spawnRange) 
#			|| (newTree.position.y <= tree.position.y+spawnRange 
#			&& newTree.position.y >= tree.position.y-spawnRange)):
#				canSpawnTree = false
#				pass
#
#		if (canSpawnTree):
#			self.add_child(newTree)
func spawn_tree(pos):
	var key = Vector2(int(pos.x/20),int(pos.y/20))
	if (!trees.has(key)):
		treeCount +=1
		print("spawn tree")
		var newTree = TreeInstance.instance()
		newTree.position = pos
		newTree.z_index = 600+pos.y
	
		print("does not have tree at this position")
		#print("new Tree position: ", newTree.position)
		newTree.name = str("tree_", treeCount)
		self.add_child(newTree)
		trees[key] = newTree.name

		
		
		
		