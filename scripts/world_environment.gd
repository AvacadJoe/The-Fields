extends WorldEnvironment

@export var global_center = Vector3(0,0,0)
@export var starting_fog_density = 0.3
@export var ending_fog_density = 3.0
@export var starting_light_energy = 1.0
@export var ending_light_energy = 0.0
@export var fog_width = 100
@export var game_area_radius = 200
@export var day_time_length = 100
@export var sunlight_delay = 10
@export var fade_time = 2
@export var starting_position = Vector3(0,0,0)
@export var starting_rotation = Vector3(0,-85.5,0)
@onready var light = $DirectionalLight3D

var resetting_player = false
var rotated_player = false

func _ready():
    self.environment.volumetric_fog_enabled = true
    await get_tree().create_timer(120).timeout #120 second delay before starting the sun cycle
    self.tween_down() 
    
    #Fade in
    var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
    %FadeRect.color = Color(0, 0, 0, 1)
    tween.tween_property(%FadeRect, "color", Color(0, 0, 0, 0), fade_time)
    pass

func _process(delta):
    var player_dist_from_center_x = absf(global_center.x-%Player.global_position.x)
    var player_dist_from_center_z = absf(global_center.z-%Player.global_position.z)
    var player_dist_from_center = player_dist_from_center_z
    
    # Take the larger dist and pass it to next function
    if player_dist_from_center_x > player_dist_from_center_z:
        player_dist_from_center = player_dist_from_center_x
    
    # Start the fog / darkening effect outside of game_area_radius
    if (player_dist_from_center > game_area_radius + fog_width and not resetting_player):
        #Tween the light down, and then teleport the player to the game center, then tween light back up
        resetting_player = true
        var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
        tween.tween_property(%FadeRect, "color", Color(0, 0, 0, 1), fade_time)
        tween.tween_callback(self.reset_player)    
    elif (player_dist_from_center > game_area_radius):
        var player_dist_from_game_area = clampf((player_dist_from_center-game_area_radius)/fog_width,0, 1.0)
        self.light.light_energy = lerpf(starting_light_energy, ending_light_energy, player_dist_from_game_area)
        self.environment.volumetric_fog_density = lerpf(starting_fog_density, ending_fog_density, player_dist_from_game_area)
    else:
        self.light.light_energy = starting_light_energy
        self.environment.volumetric_fog_density = starting_fog_density
        
    pass
    

func reset_player():
    #print("reset_player")
    
    # Rotate the player to face the origin
    #var aim_vector = (Vector3(0,0,0) - %Player.position )
   # aim_vector = aim_vector.normalized()
    #var aim_vector2d = Vector2(aim_vector.x, -aim_vector.z)
    #var angle_to = aim_vector2d.angle()
   # %Player.rotation.y = rad_to_deg(angle_to)

    %Player.rotation_degrees = starting_rotation
    %Player.position = starting_position

    var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
    tween.tween_property(%FadeRect, "color", Color(0, 0, 0, 0), fade_time)
    resetting_player = false
   # tween.tween_property(self, "resetting_player", false, 1.0).set_delay(10.0)
    pass    

# Sun cycle loop
func tween_up():
    await get_tree().create_timer(sunlight_delay).timeout    
    var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
    #  Tweening light angles needs to be fixed
    #tween.tween_property(light, "rotation", Vector3(-30.0, 0.0, 0.0), day_time_length)
    tween.tween_callback(self.tween_down)    

func tween_down():
    await get_tree().create_timer(sunlight_delay).timeout
    var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
   # tween.tween_property(light, "rotation", Vector3(-20, 0.0, 0.0), day_time_length)
    tween.tween_callback(self.tween_up)    
