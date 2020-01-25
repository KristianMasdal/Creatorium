extends Node2D

const groundScene = preload("res://Scenes/World.tscn")
const treeScene = preload("res://Scenes/WiggleTree.tscn")
var ground = null
func _ready():
	ground = groundScene.instance()
	ground.position = self.position
	ground.name = "World"
	self.add_child(ground)

func _process(delta):
	if (Input.is_action_pressed("ui_select") == true):
		get_node("World/Ground").spawn_tree(get_global_mouse_position())
	
		
func _input(event):
	if (event.is_action("ui_left")):
		$Camera2D.move_local_x(-10)
	if(event.is_action("ui_right")):
		$Camera2D.move_local_x(10)
	if(event.is_action("ui_up")):
		$Camera2D.move_local_y(-10)
	if(event.is_action("ui_down")):
		$Camera2D.move_local_y(10)
	if (event.is_action("scroll_up")):
		$Camera2D.zoom = $Camera2D.zoom * Vector2(0.8,0.8)
	if (event.is_action("scroll_down")):	
		$Camera2D.zoom = $Camera2D.zoom * Vector2(1.2,1.2)