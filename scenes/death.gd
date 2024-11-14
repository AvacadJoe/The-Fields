extends MeshInstance3D


@export var rotation_speed = 2.0

func _process(delta):
    #self.look_at(%Player.global_position, Vector3.UP, true)
    var aim_vector = (%Player.position - self.position)
    aim_vector = aim_vector.normalized()
    var aim_vector2d = Vector2(aim_vector.x, -aim_vector.z)
    var angle_to = aim_vector2d.angle()
    #rotation = lerp_angle(rotation, angle_to, rotation_speed)
    self.rotation.y = lerp_angle(self.rotation.y, angle_to, delta*rotation_speed)
    #self.rotate_y(rad_to_deg(angle_to)*delta*.1)
    #)
    #self.rotation.y = rad_to_deg(angle_to)
   # print(angle_to)
    pass
