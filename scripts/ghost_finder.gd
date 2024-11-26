extends MeshInstance3D

@onready var interact_area = $InteractArea
var cur_ghost

func _ready():
    interact_area.body_entered.connect(_body_entered)

func _process(delta):
    if GameManager.search_ghosts:
        GameManager.search_ghosts = false
        var ghosts = get_tree().get_nodes_in_group("NeedyGhosts")
        if GameManager.all_ghosts_found == false:
            cur_ghost = ghosts.pick_random()
            self.global_position = cur_ghost.global_position
            self.visible = true
    
func _body_entered(body):
    if body == %Player and self.visible:
        self.visible = false
        cur_ghost.remove_from_group("NeedyGhosts")
        var remaining_ghosts = get_tree().get_nodes_in_group("NeedyGhosts")
        if remaining_ghosts.size() == 0:
            GameManager.all_ghosts_found = true
    pass
