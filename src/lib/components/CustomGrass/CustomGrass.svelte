<script lang="ts">
	import { onMount } from 'svelte';
	import { createGrass } from './grass';
	import { useTask, useThrelte } from '@threlte/core';

	const { scene } = useThrelte();

	const uniforms = {
		uTime: {
			value: 0
		}
	};

	onMount(() => {
		const m = createGrass({ uniforms });

		scene.add(m);
	});

	useTask((delta) => {
		uniforms.uTime.value += delta;
	});
</script>
