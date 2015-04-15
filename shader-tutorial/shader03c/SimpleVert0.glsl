#define PROCESSING_TEXTURE_SHADER

uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec2 vertTexCoord;

uniform float total_w;
uniform float total_h;
uniform float timePassed;

uniform sampler2D texture;
float freq = 1.0;
float height = 1.0;

void main() {
    
    vec2 worldTexCoord = vertex.xy / vec2(total_w, total_h);
    height = texture2D(texture, worldTexCoord).r;
    
    vec2 time = vec2(timePassed, timePassed);
    vec2 add = sin (freq * time) / 2.0 - 0.5;
    add *= texCoord*40.0;
    vec4 position = vertex + vec4(add,height*100.0,0);
    
    gl_Position = transform * position;
    
    vertColor = vec4(worldTexCoord,0,1);
    vertTexCoord = texCoord;
}