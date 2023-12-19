precision mediump float;

varying vec2 vUv;

void main() {


  float center = distance(vec2(.5, .9), vUv);
  float thick = step(center, 1. * (1. -vUv.y));


  if(thick == 0.) {
    discard;
  }

  vec3 color1 = vec3(0.439,0.753,0.282);
  vec3 color2 = vec3(0.067,0.486,0.075);
  vec3 mixed = mix(color1, color2, 1. - vUv.y);

  float ao = pow(vUv.y, 1.7);

  vec4 final = vec4(mixed * ao, 1);

  gl_FragColor = final;
}