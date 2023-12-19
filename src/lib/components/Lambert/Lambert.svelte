<script>
	import { T, useTask } from '@threlte/core';
	import { DoubleSide } from 'three';

	import fragment from './lamb.frag.glsl';
	import vertex from './lamb.vert.glsl';

	useTask((delta) => {
		uniforms.uTime.value += delta;
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
