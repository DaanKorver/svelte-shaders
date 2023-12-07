<script>
	import { T, useFrame } from '@threlte/core';
	import { DoubleSide } from 'three';

	import vertex from './lamb.vert.glsl';
	import fragment from './lamb.frag.glsl';

	useFrame(({ clock }) => {
		uniforms.uTime.value = clock.getElapsedTime();
	});

	const uniforms = {
		uTime: {
			value: 0
		}
	};
</script>

<T.Mesh rotation.x={Math.PI / 2} position.y={1}>
	<T.ShaderMaterial {uniforms} side={DoubleSide} vertexShader={vertex} fragmentShader={fragment} />
	<T.SphereGeometry args={[]} />
</T.Mesh>
