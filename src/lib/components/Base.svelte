<script>
	import { ContactShadows, Grid, OrbitControls } from '@threlte/extras';
	import { T } from '@threlte/core';
	import Stats from './Stats.svelte';
</script>

<Grid
	position.y={-0.001}
	cellColor="#ffffff"
	sectionColor="#ffffff"
	sectionThickness={0}
	fadeDistance={25}
	cellSize={2}
/>

<T.DirectionalLight intensity={0.8} position.x={5} position.y={10} />
<T.AmbientLight intensity={0.2} />

<ContactShadows scale={10} blur={2} far={2.5} opacity={0.5} />

<T.PerspectiveCamera makeDefault position={[-10, 10, 10]} fov={35}>
	<OrbitControls enableZoom enableDamping target.y={1.5} />
</T.PerspectiveCamera>

<Stats />
