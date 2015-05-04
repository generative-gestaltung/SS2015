#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec2 vertTexCoord;

void main() {
    
    if (vertTexCoord.x<0.1 || vertTexCoord.x>0.9 ||
        vertTexCoord.y<0.1 || vertTexCoord.y>0.9) {
        gl_FragColor = vec4(1.0,1.0,1.0,1.0);
    }
    else {
        gl_FragColor =  vertColor;
    }
}
