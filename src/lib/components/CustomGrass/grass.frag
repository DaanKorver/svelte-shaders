precision mediump float;

varying vec2 vUv;

#define PI 3.14159265359
#define TWO_PI 6.28318530718

void main() {

  vec2 uv = vUv * 2.0 -1.;
  uv.y += .5;

   // Angle and radius from the current pixel
  float a = atan(uv.x,uv.y)+PI ;
  float r = TWO_PI/float(3);

  float d = 0.0;
  // Shaping function that modulate the distance
  d += cos(floor(.5+a/r)*r-a)*length(uv);
  float triangle = 1.0-step(.7,d);

  if(triangle == 0.) {
    discard;
  }

  vec3 color1 = vec3(0.439,0.753,0.282);
  vec3 color2 = vec3(0.067,0.486,0.075);
  vec3 mixed = mix(color1, color2, 1. - vUv.y);

  float ao = 0.2 + pow(vUv.y, 1.7);

  vec4 final = vec4(mixed * ao, 1);

  gl_FragColor = final;
}