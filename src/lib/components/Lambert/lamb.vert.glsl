varying vec3 vNormal;

void main() {
  vec4 final = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
  gl_Position = final;

  vNormal = normal;
}