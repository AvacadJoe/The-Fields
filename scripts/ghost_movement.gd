extends MeshInstance3D

@export var delta_y = 0.5
@export var ghost_delay = 0.2
@export var float_time = 1
@export var rotate_speed = 1
@export var track_player_speed = 2
@export var ghost_dialogue : DialogueResource
@export var dialogue_title : String = "this_is_a_node_title"

@onready var interact_area = $InteractArea
@onready var interact_gizmo = $InteractIcon

var interactable = false :
    set (value):
        interact_gizmo.visible = value            
        interactable = value
    get:
        return interactable

var face_player = false
var cur_y
var cur_z
var cur_x

func _ready():
    cur_z = self.position.z
    cur_y = self.position.y
    cur_x = self.position.x
    tween_up()
    interact_area.body_entered.connect(_body_entered)
    interact_area.body_exited.connect(_body_exited)
    %Player.interact.connect(_interact)    
   

func _body_entered(body):
    if body == %Player:
        %Player.interactable = true
        self.interactable = true
    pass
    
func _body_exited(body):
    if body == %Player:
        %Player.interactable = false
        self.interactable = false
    pass

func _process(delta):
    self.rotate_y(rotate_speed*delta)
    
    if interactable:
        var aim_vector = (%Player.position - self.position)
        aim_vector = aim_vector.normalized()
        var aim_vector2d = Vector2(aim_vector.x, -aim_vector.z)
        var angle_to = aim_vector2d.angle()+PI/2-PI*1/8
        self.rotation.y = lerp_angle(self.rotation.y, angle_to, delta*track_player_speed)
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
    
func _interact():
    
    if interactable:
        %DialogueMenu.start(ghost_dialogue.duplicate(), dialogue_title)
        
    pass
