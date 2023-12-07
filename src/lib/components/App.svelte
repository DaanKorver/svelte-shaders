<script lang="ts">
	import { Canvas } from '@threlte/core';
	// import Scene from './Scene.svelte';
	import Grass from './Grass/Grass.svelte';
	import Base from './Base.svelte';
	import Lambert from './Lambert/Lambert.svelte';
	import NoiseTransition from './NoiseTransition/NoiseTransition.svelte';
	import { page } from '$app/stores';
	import { get } from 'svelte/store';

	function getComponent() {
		const shader = get(page).url.searchParams.get('s');
		switch (shader) {
			case 'grass':
				return Grass;
			case 'lambert':
				return Lambert;
			case 'noise':
				return NoiseTransition;
			default:
				return Grass;
		}
	}
</script>

<Canvas>
	<svelte:component this={getComponent()} />
	<Base />
</Canvas>
