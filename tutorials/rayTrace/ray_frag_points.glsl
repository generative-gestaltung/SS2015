#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
uniform vec3 camPos;
uniform float time;
uniform float near;

uniform float W;
uniform float H;
uniform sampler2D texture;

float distanceToPlane (vec3 point, vec3 planePoint, vec3 planeNormal) {
  vec3 diff = point - planePoint;
  return dot (planeNormal, diff);
}

bool collideWithPlane (vec3 point0, vec3 point1, vec3 planePoint, vec3 planeNormal) {
  float d0 = distanceToPlane(point0, planePoint, planeNormal);
  float d1 = distanceToPlane(point1, planePoint, planeNormal);

  return (sign(d0) != sign(d1));
}

bool collide (vec3 theRay) {
	return true;
}


vec3 intersectWithPlane (vec3 start, vec3 dir, vec3 planePoint, vec3 PlaneNormal) {
	float s = (planePoint.z - start.z) / dir.z;
	return camPos + s*dir;
}




bool insideQuad (vec3 p, vec2 center) {

	float GAP = 140.0; //*sin(time*2.4+p.x*0.02) * sin(time+p.y*0.03) + 100.0;
	float alpha = 0.5;
	
	return (length(p.xy-center) < GAP);
}

float SIZE = 500.0;
int blockSize = 4;
void main() {


	vec3 col = vec3(0,0,0);
	vec3 cam = camPos+vec3(W/2.0, H/2.0, 0.0);
	vec3 point = vec3(gl_FragCoord.x, gl_FragCoord.y, near);
	vec3 dir = normalize (point-cam);

	for (int i=0; i<=2; i++) {


		vec3 p = intersectWithPlane (cam, dir, vec3(0,0,5.0-float(i)*15.0)+time*5.0, vec3(0,0,1));


		vec2 center = vec2 (p.x-mod(p.x, SIZE)+SIZE/2.0, p.y-mod(p.y, SIZE)+SIZE/2.0);
		vec2 hyperCenter = vec2 (p.x-mod(p.x, SIZE*float(blockSize))+SIZE*float(blockSize)/2.0, p.y-mod(p.y, SIZE*float(blockSize))+SIZE*float(blockSize)/2.0);
		vec2 texCoord = hyperCenter / vec2(W,H) / p.z *2.0 + vec2(0.5, 0.5);

		vec4 imageColor = texture2D (texture, vec2(texCoord.x, 1.0 - texCoord.y));	

		if ( insideQuad(p, center)) {

			//int ind = int(mod(float(i) + p.x*0.002+time, 3.0));
			//int i = int(mod(center.x, 4.0)); //mod();
			//int j = int(mod(center.y, 4.0));
			col = imageColor.xyz;
		}
	}
	
	gl_FragColor = vec4 (col, 1.0);
}
