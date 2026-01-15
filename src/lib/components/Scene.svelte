<script lang="ts">
	import { T } from '@threlte/core';
	import { ContactShadows, Float, useGltf, OrbitControls, HTML } from '@threlte/extras';
	import { onMount } from 'svelte';
	import CherryTree from './models/cherry_tree.svelte';
	import { gsap, ScrollTrigger } from '$lib/index';
	import Branch from './Branch.svelte';

	const branches: {
		id: number;
		title: string;
		subtitle: string;
		position: [number, number, number];
		description: string;
	}[] = [
		{
			id: 0,
			title: 'Act I',
			subtitle: 'The Beginning',
			position: [0.5, -2, 1], // Lower trunk area
			description: 'The Great Awakening - A new legend begins.'
		},
		{
			id: 1,
			title: 'Act II',
			subtitle: 'The Roots',
			position: [-1.5, 0, 1.5], // Mid-lower branch
			description: 'The Origin Story - Deep roots in Nsukka.'
		},
		{
			id: 2,
			title: 'Act III',
			subtitle: 'The Growth',
			position: [2, 2, -1], // Mid-upper branch
			description: 'Core Memories - Shared laughter and discovery.'
		},
		{
			id: 3,
			title: 'Act IV',
			subtitle: 'The Support',
			position: [-1.5, 6, 1], // Upper branch
			description: 'The Inner Circle - A forest of souls.'
		},
		{
			id: 4,
			title: 'Epilogue',
			subtitle: 'Easter Eggs',
			position: [0.5, 8, 0.5], // Top area
			description: 'Hidden Gems - Quiet secrets of a life well-lived.'
		}
	];

	let {
		activeChapter = $bindable(-1),
		scrollDirection = $bindable(1)
	}: {
		activeChapter?: number;
		scrollDirection?: number;
	} = $props();
	let cameraRef: any = $state();
	let controlsRef: any = $state();

	onMount(() => {
		gsap.registerPlugin(ScrollTrigger);

		// Create a master timeline
		const tl = gsap.timeline({
			scrollTrigger: {
				trigger: 'body',
				start: 'top top',
				end: 'bottom bottom',
				scrub: 1,
				invalidateOnRefresh: true
			},
			onUpdate: function () {
				const time = this.time();
				const totalDuration = this.duration();
				// @ts-ignore
				const direction = this.scrollTrigger ? this.scrollTrigger.direction : 1;
				scrollDirection = direction;

				let current = -1;

				branches.forEach((_, i) => {
					// Define a window where the camera has "landed"
					let windowStart = i + 0.3;
					let windowEnd = i + 0.8;

					// Edge cases: keep first act visible at top, last at bottom
					if (i === 0) windowStart = 0.2;
					if (i === branches.length - 1) windowEnd = totalDuration + 1; // Ensure it stays until the end

					if (time >= windowStart && time <= windowEnd) {
						current = i;
					}
				});

				if (activeChapter !== current) {
					activeChapter = current;
				}
			}
		});

		branches.forEach((branch, i) => {
			// 1. Move Camera (Faster move to allow for dwelling)
			tl.to(
				cameraRef.position,
				{
					x: branch.position[0] * 3.5,
					y: branch.position[1] + 1.5,
					z: 7,
					duration: 0.3,
					ease: 'power2.inOut'
				},
				i
			);

			// 2. Aim Camera Target
			tl.to(
				controlsRef.target,
				{
					x: branch.position[0],
					y: branch.position[1],
					z: branch.position[2],
					duration: 0.3,
					ease: 'power2.inOut'
				},
				i
			);
		});
	});
</script>

<T.PerspectiveCamera makeDefault position={[15, 10, 20]} fov={40} bind:ref={cameraRef}>
	<OrbitControls
		enableDamping
		dampingFactor={0.05}
		autoRotate
		autoRotateSpeed={0.5}
		enableZoom={false}
		minPolarAngle={Math.PI / 2}
		maxPolarAngle={Math.PI / 2}
		target={[0, 2, 0]}
		bind:ref={controlsRef}
	/>
</T.PerspectiveCamera>

<T.DirectionalLight position={[10, 20, 10]} intensity={2} castShadow />
<T.AmbientLight intensity={0.5} />

<Float speed={1} rotationIntensity={0.2} floatIntensity={0.3}>
	<CherryTree />

	{#each branches as branch, i}
		<Branch
			position={branch.position}
			index={i}
			title={branch.title}
			description={branch.description}
		/>
	{/each}
</Float>

<ContactShadows position={[0, -4.1, 0]} scale={20} blur={2} far={5} opacity={0.4} />

<style>
</style>
