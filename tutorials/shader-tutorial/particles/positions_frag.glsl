#define PROCESSING_COLOR_SHADER


uniform sampler2D positions;
uniform sampler2D velocities;

uniform float width;
uniform float height;


void main() 
{
	vec2 texCoord = gl_FragCoord.xy / vec2(width, height);
	vec3 pos = texture2D(positions, texCoord).xyz;
	
	gl_FragColor.rgb = pos + vec3(0.1,0,0);
	gl_FragColor.a = 1.0;
}