extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -730.0

func respawn():
	self.visible = false
	can_move = false
	await get_tree().create_timer(0.5).timeout
	self.global_position = Vector2(2,2)
	self.visible = true
	can_move = true
	await get_tree().create_timer(0.5).timeout
	took_damage = false

var can_move = true
var took_damage = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)

		if collision.get_collider().name == "TileMapLayer3":
				if took_damage == false:
					took_damage = true
					respawn()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if can_move == false:
		return
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()
