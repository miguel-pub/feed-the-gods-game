@tool
extends RigidBody2D
class_name Block

# ------------------------------> IMPORTS <----------------------------------
const BIG_BLOCK = preload("res://Assets/Sprites/BigBlock.png")
const LONG_BLOCK_GRAY = preload("res://Assets/Sprites/Long-Block-Gray.png")
const SMALL_BLOCK = preload("res://Assets/Sprites/SmallBlock.png")





# ------------------------------> IMPORTS <----------------------------------
var mouse_in_block: bool = false
var ignore_input: bool = false
enum BlockType {
	NORMAL,
	FLOATING,
	BOUNCY,
	NON_CLICKABLE,
}

enum BlockSize {
	SQUARESMALL,
	SQUAREMID,
	SQUAREBIG,
	RECTSMALL,
	RECTMID,
	RECTBIG,
}

@export var block_type: BlockType = BlockType.NORMAL:
	set(value):
		block_type = value
		#_apply_block_type()
	get:
		return block_type

@export var block_size: BlockSize = BlockSize.SQUAREMID:
	set(value):
		block_size = value
		_apply_block_size()
	get:
		return block_size

func _ready() -> void:
	input_pickable = false

# ------------------------------> CUSTOM FUNCS <----------------------------------
func _apply_block_size() -> void:
	for child in get_children():
		if child is Sprite2D:
			child.queue_free()
	var sprite = Sprite2D.new()
	match block_size:
		BlockSize.SQUARESMALL:
			sprite.texture = SMALL_BLOCK
			
		BlockSize.SQUAREMID:
			sprite.texture = BIG_BLOCK
			
		BlockSize.SQUAREBIG:
			pass
			
		BlockSize.RECTSMALL:
			pass
			
		BlockSize.RECTMID:
			sprite.texture = LONG_BLOCK_GRAY
			
		BlockSize.RECTBIG:
			pass
	add_child(sprite)

# ------------------------------> CUSTOM FUNCS <----------------------------------


# ------------------------------> SIGNALS <----------------------------------
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click") and mouse_in_block == true and ignore_input == false:
		queue_free()
		print("click")
		
func _mouse_shape_enter(shape_idx: int) -> void:
	mouse_in_block = true
	print(mouse_in_block)
	
func _mouse_shape_exit(shape_idx: int) -> void:
	mouse_in_block = false
	print(mouse_in_block)
# ------------------------------> SIGNALS <----------------------------------
