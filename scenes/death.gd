extends MeshInstance3D


@export var rotation_speed = 2.0

func _process(delta):
    _turn_to_player(delta)
    pass
    
func _turn_to_player(delta):
    
    var aim_vector = (%Player.position - self.position)
    aim_vector = aim_vector.normalized()
    var aim_vector2d = Vector2(aim_vector.x, -aim_vector.z)
    var angle_to = aim_vector2d.angle()
    self.rotation.y = lerp_angle(self.rotation.y, angle_to, delta*rotation_speed)
    pass
