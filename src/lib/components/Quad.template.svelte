<script>
	import { T } from '@threlte/core';
	import { DoubleSide } from 'three';
</script>

<T.Mesh rotation.x={Math.PI / 2} position.y={1}>
	<T.ShaderMaterial side={DoubleSide} />
	<T.PlaneGeometry args={[5, 5, 256, 256]} />
</T.Mesh>
