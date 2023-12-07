precision mediump float;

uniform sampler2D uTexture1;
uniform sampler2D uTexture2;
uniform float uTime;

varying float vNoise;
varying vec2 vUv;

#ifndef PI
#define PI 3.141592653589793
#endif

void main() {

  vec2 uv = vUv;

  float progress = (sin(uTime * .8) + 1.) / 2.;

  vec4 col1 = vec4(vec3(1., 0., 0.), 1.);
  vec4 col2 = vec4(vec3(0., 0., 1.), 1.);
  vec4 tex1 = texture2D(uTexture1, vUv);
  vec4 tex2 = texture2D(uTexture2, vUv);

  float threshold = 0.;
  float range = 1.;
  float t = smoothstep(vNoise, vNoise + .1, progress);
  vec4 final = mix(tex1, tex2, t);

  vec4 color = mix(col1, col2, vNoise);
  gl_FragColor = final;
}

  // gl_FragColor = vec4(vec3(vNoise), 1.0);
  // float progress = (sin(uTime * 2.) + 1.) / 2.;

  // float s = step(progress, (vUv.y + vUv.x) / 2.);
  // progress, 0.5 * (vUv.y + vUv.x);
  // float s = smoothstep(progress, progress + .3, (uv.x + uv.y) / 2.);
  // vec3 col = vec3(s);

  // gl_FragColor = vec4(col, 1.);
  // gl_FragColor = mix(tex1, tex2, s);

  // float t = step(.3, vNoise * 1.);