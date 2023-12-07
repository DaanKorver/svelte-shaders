uniform float uTime;

varying vec3 vNormal;

void main() {
  vec3 lightPos = vec3(-10., 6., -10.);

  lightPos.y += sin(uTime * 2.) * 10.;

  float diffuse = 1.;
  float ld = dot(normalize(vNormal), normalize(lightPos));
  // float ld = dot(normalize(vNormal), normalize(lightPos)) * 0.5 + 0.5;

  vec3 color = vec3(1., 0., 0.);
  color *= (ld * diffuse);

  vec4 final = vec4(color, 1.);

  gl_FragColor = final;
}