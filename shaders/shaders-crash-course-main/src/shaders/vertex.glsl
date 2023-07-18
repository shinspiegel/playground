attribute vec3 position;

uniform mat4 = projectionMatrix;
uniform mat3 modelViewMatrix;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;

uniform float uTime;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
}