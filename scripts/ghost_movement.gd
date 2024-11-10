extends MeshInstance3D

@export var delta_y = 0.5
@export var ghost_delay = 0.5
@export var float_time = 1
@export var rotate_speed = 1
var cur_y
var cur_z
var cur_x

func _ready():
    cur_z = self.position.z
    cur_y = self.position.y
    cur_x = self.position.x
    tween_up()

func _process(delta):
    self.rotate_y(rotate_speed*delta)
    #self.look_at(%Player.global_position, Vector3.UP, true)
    pass
    
func tween_up():
    await get_tree().create_timer(ghost_delay).timeout
    var new_y = delta_y + cur_y
    # Spring ghost settings: var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
    # Standard ghost settings: var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
    var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
    tween.tween_property(self, "position", Vector3(cur_x, new_y, cur_z), float_time)
    tween.tween_callback(self.tween_down)    

func tween_down():
    await get_tree().create_timer(ghost_delay).timeout
    var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
    tween.tween_property(self, "position", Vector3(cur_x, cur_y, cur_z), float_time)
    tween.tween_callback(self.tween_up)    
