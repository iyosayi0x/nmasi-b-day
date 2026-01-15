<script lang="ts">
	import { Canvas } from '@threlte/core';
	import { fade } from 'svelte/transition';
	import Icon from '@iconify/svelte';
	import Scene from '$lib/components/Scene.svelte';
	import ActOverlay from '$lib/components/ActOverlay.svelte';
	import ChowdeckModal from '$lib/components/ChowdeckModal.svelte';

	let activeAct = $state(-1);
	let scrollDirection = $state(1);
	let showChowdeck = $state(true);
</script>

<div class="scroll-container relative w-full bg-midnight">
	{#if showChowdeck}
		<ChowdeckModal onClaim={() => (showChowdeck = false)} />
	{/if}

	<!-- Floating Decorations -->
	<div class="pointer-events-none fixed inset-0 z-10 overflow-hidden">
		<div class="animate-float-slow absolute top-[10%] left-[5%] text-accent/20">
			<Icon icon="ph:sparkle-fill" class="text-3xl md:text-5xl" />
		</div>
		<div class="animate-float-slower absolute top-[15%] right-[10%] text-accent/10">
			<Icon icon="ph:star-fill" class="text-xl md:text-3xl" />
		</div>
		<div class="animate-float absolute bottom-[20%] left-[8%] text-accent/15">
			<Icon icon="ph:sparkle-bold" class="text-2xl md:text-4xl" />
		</div>
		<div class="animate-float-slow absolute right-[12%] bottom-[15%] text-accent/10">
			<Icon icon="ph:star-bold" class="text-4xl md:text-6xl" />
		</div>
	</div>

	<ActOverlay activeChapter={activeAct} direction={scrollDirection} />

	<!-- 3D Canvas Layer (Fixed) -->
	<div class="fixed inset-0 z-0 h-screen w-full">
		<Canvas>
			<Scene bind:activeChapter={activeAct} bind:scrollDirection />
		</Canvas>
	</div>

	<!-- Scroll to Explore Indicator -->
	{#if !showChowdeck && activeAct === -1}
		<div
			class="pointer-events-none fixed bottom-12 left-1/2 z-20 flex -translate-x-1/2 animate-bounce flex-col items-center gap-2 opacity-50 md:bottom-20"
			transition:fade
		>
			<span class="text-[10px] font-black tracking-[0.4em] text-white uppercase"
				>Initiate Scroll</span
			>
			<div>
				<Icon icon="ph:caret-down-bold" class="text-2xl text-accent" />
			</div>
		</div>
	{/if}

	<!-- Scrollable Content to provide height for ScrollTrigger -->
	<div class="relative z-10 w-full">
		{#each Array(5) as _, i}
			<section class="pointer-events-none flex h-screen w-full items-center justify-center">
				<!-- Spacer for each act -->
			</section>
		{/each}
	</div>

	<!-- Background Atmosphere Overlay -->
	<div class="pointer-events-none fixed inset-0 z-[5]">
		<div class="bg-radial-gradient absolute inset-0 from-accent/5 to-transparent"></div>
	</div>
</div>

<style>
	.bg-radial-gradient {
		background: radial-gradient(circle at center, var(--tw-gradient-from), var(--tw-gradient-to));
	}

	@keyframes fade-in-up {
		from {
			opacity: 0;
			transform: translateY(20px);
		}
		to {
			opacity: 1;
			transform: translateY(0);
		}
	}
</style>
