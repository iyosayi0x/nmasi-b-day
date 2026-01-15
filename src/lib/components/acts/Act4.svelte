<script lang="ts">
	import { fade, fly, scale } from 'svelte/transition';
	import { quintOut } from 'svelte/easing';
	import Icon from '@iconify/svelte';
	import { onMount } from 'svelte';

	const nodes = [
		{ id: 0, x: 25, y: 30, quote: 'Pure Resilience.', icon: 'ph:shield-bold' },
		{ id: 1, x: 75, y: 25, quote: 'The smartest in the room.', icon: 'ph:brain-bold' },
		{ id: 2, x: 50, y: 15, quote: 'Light Giver.', icon: 'ph:sun-bold' },
		{ id: 3, x: 15, y: 60, quote: 'Agent of Chaos.', icon: 'ph:fire-bold' },
		{ id: 4, x: 85, y: 65, quote: 'Heart of Gold.', icon: 'ph:heart-bold' },
		{ id: 5, x: 40, y: 80, quote: 'Unstoppable.', icon: 'ph:lightning-bold' },
		{ id: 6, x: 60, y: 75, quote: 'Quiet Strength.', icon: 'ph:mountains-bold' },
		{ id: 7, x: 10, y: 15, quote: 'A True Original.', icon: 'ph:paint-brush-bold' },
		{ id: 8, x: 90, y: 10, quote: 'The Anchor.', icon: 'ph:anchor-bold' },
		{ id: 9, x: 30, y: 50, quote: 'Sunlight.', icon: 'ph:sun-horizon-bold' },
		{ id: 10, x: 70, y: 50, quote: 'Mastermind.', icon: 'ph:strategy-bold' },
		{ id: 11, x: 50, y: 40, quote: 'Visionary.', icon: 'ph:eye-bold' }
	];

	let activeNode = $state<number | null>(null);
	let mounted = $state(false);

	onMount(() => {
		mounted = true;
	});
</script>

<div
	class="relative flex h-full min-h-[450px] w-full flex-col items-center justify-center overflow-hidden rounded-3xl border border-white/10 bg-midnight/40 backdrop-blur-md"
>
	<!-- Background Glow -->
	<div class="absolute inset-0 z-0">
		<div
			class="absolute top-1/2 left-1/2 h-[600px] w-[600px] -translate-x-1/2 -translate-y-1/2 rounded-full bg-accent/5 blur-[120px]"
		></div>
		<div
			class="absolute top-0 left-0 h-full w-full bg-[radial-gradient(circle_at_50%_50%,rgba(184,134,11,0.05)_0%,transparent_70%)]"
		></div>
	</div>

	<!-- SVG Constellation Lines -->
	<svg class="absolute inset-0 z-10 h-full w-full opacity-20">
		{#each nodes as node, idx}
			{#if idx > 0}
				<line
					x1="{nodes[idx - 1].x}%"
					y1="{nodes[idx - 1].y}%"
					x2="{node.x}%"
					y2="{node.y}%"
					stroke="#B8860B"
					stroke-width="1"
					stroke-dasharray="8 4"
				/>
			{/if}
		{/each}
	</svg>

	<!-- Interactive Nodes -->
	{#if mounted}
		<div class="absolute inset-0 z-20">
			{#each nodes as node, i}
				<button
					class="group absolute h-6 w-6 -translate-x-1/2 -translate-y-1/2 cursor-pointer outline-hidden"
					style="left: {node.x}%; top: {node.y}%;"
					onmouseenter={() => (activeNode = node.id)}
					onmouseleave={() => (activeNode = null)}
					onfocus={() => (activeNode = node.id)}
					onblur={() => (activeNode = null)}
					in:scale={{ delay: i * 50, duration: 600, easing: quintOut }}
				>
					<div
						class="flex h-full w-full items-center justify-center rounded-full border border-accent/40 bg-midnight/80 transition-all duration-300 group-hover:scale-125 group-hover:border-accent group-hover:bg-accent"
					>
						<div
							class="absolute inset-0 h-full w-full animate-ping rounded-full bg-accent/20 opacity-0 group-hover:opacity-100"
						></div>
						<Icon
							icon={node.icon}
							class="text-xs text-accent transition-colors group-hover:text-midnight"
						/>
					</div>
				</button>
			{/each}
		</div>
	{/if}

	<!-- Central Content Display -->
	<div class="relative z-30 flex flex-col items-center justify-center p-8 text-center">
		{#if activeNode !== null}
			<div in:fly={{ y: 20, duration: 400 }} out:fade={{ duration: 200 }} class="max-w-md">
				<Icon icon="ph:quotes-fill" class="mx-auto mb-4 text-5xl text-accent opacity-50" />
				<h3 class="text-2xl font-black tracking-tight text-white uppercase italic md:text-4xl">
					"{nodes[activeNode].quote}"
				</h3>
				<div class="mx-auto mt-6 h-1 w-20 rounded-full bg-accent/60"></div>
			</div>
		{:else}
			<div in:fade={{ duration: 800 }} class="max-w-lg">
				<div
					class="mb-4 inline-flex items-center gap-2 rounded-full border border-accent/20 bg-accent/5 px-4 py-1"
				>
					<span class="relative flex h-2 w-2">
						<span
							class="absolute inline-flex h-full w-full animate-ping rounded-full bg-accent opacity-75"
						></span>
						<span class="relative inline-flex h-2 w-2 rounded-full bg-accent"></span>
					</span>
					<span class="text-[10px] font-black tracking-widest text-accent uppercase"
						>Detection Active</span
					>
				</div>
				<h2
					class="mb-6 text-4xl font-black tracking-tighter text-white uppercase italic md:text-6xl"
				>
					The Soul Forest
				</h2>
				<p class="text-sm leading-relaxed text-ghost/70 md:text-lg">
					A tree is only as strong as the roots that anchor it and the forest that surrounds it.
					<span class="hidden md:inline"><br /></span>
					<span class="font-bold text-accent">Interlink</span> with the nodes to reveal the voices that
					have grown alongside you. Cheers to knowing you for 5 years.
				</p>
				<div
					class="mt-8 flex justify-center gap-4 text-[10px] font-bold tracking-[0.2em] text-ghost/30 uppercase"
				>
					<span>12 Nodes Found</span>
					<span>•</span>
					<span>Network Stable</span>
				</div>
			</div>
		{/if}
	</div>
</div>

<style>
	/* Custom animations if needed */
</style>
