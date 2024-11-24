extends MeshInstance3D

@onready var interact_area = $InteractArea
@onready var interact_gizmo = $InteractIcon

@export var item_dialogue : DialogueResource
@export var dialogue_title : String = "this_is_a_node_title"
@export var item_scale = 0.5
var fade_time = 1


var interactable = false :
    set (value):
        interact_gizmo.visible = value            
        interactable = value
    get:
        return interactable

func _ready():
    interact_area.body_entered.connect(_body_entered)
    interact_area.body_exited.connect(_body_exited)
    %Player.interact.connect(_interact)    
    pass
    

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

func view_item():
    %Player.interactable = false
    %ItemViewer.update_mesh(self.mesh, item_scale)
    GameManager.hide_labels = true
    var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
    tween.tween_property(%FadeRect, "color", Color(0, 0, 0, 1), fade_time)
    tween.tween_property(GameManager, "hide_item_viewer", false, fade_time)
    await get_tree().create_timer(fade_time*2).timeout
    %DialogueMenu.start(item_dialogue.duplicate(), dialogue_title)
    %FadeRect.color = Color(0, 0, 0, 0)
    self.queue_free()    
    pass
    
func _interact():
    if interactable:
        view_item()
        
    pass
