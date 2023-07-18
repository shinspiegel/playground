shader_type canvas_item;

uniform vec4 overlay_color : source_color = vec4(1,1,1, 0.3);
uniform float threshold : hint_range(0.0, 1.0) = 0.001;
uniform sampler2D general_camera_texture;

bool is_visible_pixel(vec4 c) {
	if (c.a > 0.0) {
		return true;
	}
	
	return false;
}

bool is_diff_from_general_camera(vec2 uv, vec4 c) {
	vec4 previous_color = texture(general_camera_texture, uv);
	vec4 diff = abs(previous_color - c);
	
	if (diff.r > threshold || diff.g > threshold || diff.b > threshold || diff.a > threshold) {
		return true;
	} 
	return false;
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	bool is_visible = is_visible_pixel(color);
	bool is_diff = is_diff_from_general_camera(SCREEN_UV, color);
	
	if (is_visible && is_diff) {
		COLOR = overlay_color;
	}
}