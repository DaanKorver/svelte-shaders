precision mediump float;

varying vec2 vUv;
varying float vHeight;

void main() {
  vec3 color1 = vec3(0.137, 0.537, 0.855); // Blue color
  vec3 color2 = vec3(0.059, 0.369, 0.612); // Blue color
  vec3 color = mix(color1, color2, smoothstep(0.0, 0.2, vHeight));
  // gl_FragColor = vec4(vUv, 1.0, 1.0);
  gl_FragColor = vec4(color, 1.0);
}