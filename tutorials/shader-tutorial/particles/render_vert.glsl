#define PROCESSING_COLOR_SHADER


uniform mat4 transform;
uniform mat4 texMatrix;


attribute vec4 vertex;
attribute vec4 color;
attribute vec2 texCoord;



void main() {

  vec4 position = vertex;
  position += vec4(texCoord.xy, 0, 0)*30.0;
  gl_Position = transform * position;
}