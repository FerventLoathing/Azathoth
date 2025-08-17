extends CharacterBody2D

const SPEED = 300.0

@export var tile_map : TileMap

var ground_layer = 0
var source_id = 0
var atlas_coord = Vector2i (0, 0)

var tiles_painted : int = 0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	for n in 5:
			for m in 5:
				place_tile(n-2, m-2)

#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("interact"):
		#for n in 5:
			#for m in 5:
				#place_tile(n-2, m-2)

func place_tile(offset_x : int, offset_y : int) -> void:
	var tile_position = tile_map.local_to_map(position) + Vector2i(offset_x, offset_y)
	
	if tile_map.get_cell_tile_data(ground_layer, tile_position) == null:
		tiles_painted +=  1 
		print(tiles_painted)
	tile_map.set_cell(ground_layer, tile_position, source_id, atlas_coord)
