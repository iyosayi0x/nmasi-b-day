<script lang="ts">
	import { fade, fly } from 'svelte/transition';
	import { quintOut } from 'svelte/easing';
	import Act1 from './acts/Act1.svelte';
	import Act2 from './acts/Act2.svelte';
	import Act3 from './acts/Act3.svelte';
	import Act4 from './acts/Act4.svelte';
	import Epilogue from './acts/Epilogue.svelte';

	let { activeChapter = 0, direction = 1 } = $props<{ activeChapter: number; direction: number }>();

	const acts = [
		{ id: 0, title: 'Act I', subtitle: 'The Beginning', category: 'Security Brief' },
		{
			id: 1,
			id_name: 'Act II',
			title: 'The Roots',
			subtitle: 'The Nsukka Spiderwoman',
			category: 'Action Report'
		},
		{ id: 2, title: 'Act III', subtitle: 'The Growth', category: 'Exhibition Hall' },
		{ id: 3, title: 'Act IV', subtitle: 'The Support', category: 'Soul Forest' },
		{ id: 4, title: 'Epilogue', subtitle: 'Easter Eggs', category: 'Legacy File' }
	];
</script>

<div class="pointer-events-none fixed inset-0 z-50 flex items-center justify-center p-6 md:p-12">
	{#each acts as act, i}
		{#if activeChapter === i}
			<div
				class="act-card pointer-events-auto relative w-full max-w-4xl overflow-hidden rounded-3xl border border-white/10 bg-midnight/40 p-8 shadow-2xl backdrop-blur-3xl"
				in:fly={{ y: direction * 40, duration: 800, easing: quintOut }}
				out:fade={{ duration: 400 }}
			>
				<!-- Subtle Scanline / Grid Background -->
				<div
					class="absolute inset-0 bg-[linear-gradient(rgba(255,255,255,0.1)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.1)_1px,transparent_1px)] bg-[size:20px_20px] opacity-10"
				></div>

				<!-- Header Section -->
				<div class="relative z-10 mb-8 flex items-end justify-between border-b border-white/5 pb-4">
					<div>
						<p class="text-[10px] font-black tracking-[0.3em] text-accent uppercase">
							{act.category}
						</p>
						<h2
							class="mt-1 text-3xl font-black tracking-tighter text-white uppercase italic md:text-5xl"
						>
							{act.id === 1 ? act.title : act.id_name || act.title}
						</h2>
					</div>
					<div class="hidden text-right md:block">
						<p class="text-[10px] font-bold text-ghost/40 uppercase">Authorization: Level 05</p>
						<p class="font-mono text-[10px] text-accent uppercase">
							Secured // {new Date().toLocaleTimeString()}
						</p>
					</div>
				</div>

				<!-- Content Sections -->
				<div class="relative z-10 min-h-[400px]">
					{#if i === 0}
						<Act1 />
					{:else if i === 1}
						<Act2 />
					{:else if i === 2}
						<Act3 />
					{:else if i === 3}
						<Act4 />
					{:else if i === 4}
						<Epilogue />
					{/if}
				</div>

				<!-- Footer Accents -->
				<div
					class="mt-8 flex items-center justify-between text-[8px] font-bold tracking-widest text-ghost/20 uppercase md:text-[10px]"
				>
					<div class="flex gap-4">
						<span>PROJECT: NEPTUNE</span>
						<span>SECTOR: 7G</span>
					</div>
					<span>ARCHIVE NO: {act.id + 1}/05</span>
				</div>
			</div>
		{/if}
	{/each}
</div>

<style>
	.act-card {
		box-shadow:
			0 0 100px -20px rgba(184, 134, 11, 0.1),
			inset 0 0 20px rgba(255, 255, 255, 0.05);
	}
</style>
