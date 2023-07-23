shader_type canvas_item;

uniform bool active = false;
uniform vec3 overlay : source_color = vec3(1,1,1);

void fragment() {
	vec4 new_color = texture(TEXTURE, UV);
	
	if (active == true) {
		new_color = vec4(overlay, texture(TEXTURE, UV).a);
	}
	
	COLOR = new_color;
}