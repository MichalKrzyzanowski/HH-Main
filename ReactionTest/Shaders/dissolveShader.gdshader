shader_type canvas_item;

uniform float dissolveState: hint_range(0, 1) = 0;
uniform float dissolveThickness = 0.05;
uniform sampler2D dissolveNoise;
uniform vec4 dissolveColor: hint_color;

void fragment()
{
	vec4 textureColor = texture(TEXTURE, UV);
	float brightness = texture(dissolveNoise, UV).r;
	COLOR = textureColor;
	float dissolveDif = abs(dissolveState - brightness);
	COLOR.rgb += dissolveColor.rgb * step(dissolveDif, dissolveThickness);
	COLOR.a *= step(dissolveState, brightness);
}