shader_type spatial;
render_mode unshaded;

// Declare the screen texture uniform
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// Adjustable parameters for the effect
uniform float bloom_threshold = 1.0;
uniform float bloom_intensity = 2.0;
uniform float bloom_spread = 2.0;

void fragment() {
    vec3 scene_color = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
    vec3 bright_color = max(scene_color - vec3(1.0), vec3(0.0));
   ALBEDO = scene_color + bright_color * 2.0;
ALPHA = 0.0;   
}