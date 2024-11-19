shader_type spatial;
render_mode cull_disabled, shadows_disabled;

//uniform float fog_val = 0.001;
uniform sampler2D color_ramp : hint_default_black;

void fragment() {
	ALBEDO = texture(color_ramp, vec2(1.0 - UV.y, 0)).rgb ;
    //FOG = -FOG*fog_val;
}