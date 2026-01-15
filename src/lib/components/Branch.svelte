<script lang="ts">
	import { HTML } from '@threlte/extras';
	import Icon from '@iconify/svelte';

	let {
		position = [0, 0, 0] as [number, number, number],
		index = 0,
		title = '',
		description = '',
		active = false,
		onclick = () => {}
	}: {
		position?: [number, number, number];
		index?: number;
		title?: string;
		description?: string;
		active?: boolean;
		onclick?: (e: MouseEvent) => void;
	} = $props();

	let hovered = $state(false);
</script>

<HTML {position} center transform={false} pointerEvents="auto">
	<button
		class="group relative flex items-center justify-center transition-all duration-500"
		onmouseenter={() => (hovered = true)}
		onmouseleave={() => (hovered = false)}
		{onclick}
	>
		<!-- Minimal Pulse Effect -->
		<div
			class="absolute h-6 w-6 animate-ping rounded-full bg-accent/20 duration-1000 group-hover:scale-150"
		></div>

		<!-- Main Marker (Smaller) -->
		<div
			class="relative flex h-6 w-6 items-center justify-center rounded-full border border-white/40 bg-midnight/80 text-accent shadow-[0_0_15px_rgba(var(--color-accent-rgb),0.3)] backdrop-blur-md transition-all duration-300 group-hover:scale-110 group-hover:border-accent group-hover:bg-accent group-hover:text-midnight"
		>
			<span class="text-[10px] font-black">{index + 1}</span>
		</div>

		<!-- Content Card (Sleeker) -->
		<div
			class="pointer-events-none absolute left-8 w-44 origin-left translate-x-2 scale-95 transform rounded-lg border border-white/5 bg-midnight/95 p-3 opacity-0 backdrop-blur-xl transition-all duration-300 group-hover:translate-x-0 group-hover:scale-100 group-hover:opacity-100"
		>
			<div class="mb-1 flex items-center gap-2">
				<h3 class="text-[10px] font-black tracking-[0.15em] text-accent uppercase">{title}</h3>
			</div>
			<p class="text-[10px] leading-relaxed text-ghost/60">
				{description}
			</p>

			<!-- Tiny Accents -->
			<div class="absolute top-2 right-2 h-1 w-1 rounded-full bg-accent/30"></div>
		</div>

		<!-- Connector Line (Thinner) -->
		<div
			class="pointer-events-none absolute top-1/2 left-6 h-px w-2 origin-left scale-x-0 bg-accent/50 transition-transform duration-500 group-hover:scale-x-100"
		></div>
	</button>
</HTML>

<style>
</style>
