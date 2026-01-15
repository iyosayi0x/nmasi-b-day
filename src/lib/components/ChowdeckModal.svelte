<script lang="ts">
	import { fade, scale } from 'svelte/transition';
	import { quintOut } from 'svelte/easing';
	import Icon from '@iconify/svelte';
	import { onMount } from 'svelte';
	import { supabase } from '$lib/supabase';

	let { onClaim = () => {} } = $props<{ onClaim: () => void }>();
	let chowdeckClaimed = $state(false);
	let chowdeckCode = $state('LOADING...');

	onMount(async () => {
		const { data, error } = await supabase
			.from('site_config')
			.select('value')
			.eq('key', 'chowdeck_code')
			.single();

		if (!error && data) {
			chowdeckCode = data.value;
		} else {
			chowdeckCode = 'LEGEND18'; // Fallback
		}
	});
</script>

<div
	class="fixed inset-0 z-100 flex items-center justify-center bg-midnight/80 p-6 backdrop-blur-xl"
	in:fade
>
	<div
		class="relative w-full max-w-xs overflow-hidden rounded-3xl border border-white/10 bg-midnight/40 p-8 shadow-2xl backdrop-blur-3xl"
		in:scale={{ duration: 600, easing: quintOut }}
	>
		<div class="relative z-10 flex flex-col items-center text-center">
			<Icon icon="ph:utensils-fill" class="mb-4 text-3xl text-accent" />

			<h2 class="mb-4 text-xl font-black tracking-tight text-white uppercase italic">
				Legend's Provision
			</h2>

			{#if !chowdeckClaimed}
				<div class="w-full space-y-6">
					<p class="text-xs leading-relaxed font-medium text-ghost/60">
						Use the code below to redeem your gift on the Chowdeck app.
					</p>

					<div
						class="group relative overflow-hidden rounded-2xl border border-white/5 bg-white/5 p-5 transition-all"
					>
						<span class="relative z-10 font-mono text-2xl font-black tracking-[0.2em] text-accent">
							{chowdeckCode}
						</span>
					</div>

					<button
						class="w-full rounded-full bg-accent py-3 text-[10px] font-black tracking-[0.2em] text-midnight uppercase transition-all hover:scale-105 hover:bg-white active:scale-95"
						onclick={() => {
							chowdeckClaimed = true;
							setTimeout(onClaim, 800);
						}}
					>
						Enter the Story
					</button>
				</div>
			{:else}
				<div class="flex flex-col items-center space-y-3 py-4" in:fade>
					<div
						class="flex h-10 w-10 items-center justify-center rounded-full bg-accent/20 text-accent"
					>
						<Icon icon="ph:check-bold" class="text-xl" />
					</div>
					<p class="text-[10px] font-black tracking-widest text-accent uppercase">
						Provision Secured
					</p>
				</div>
			{/if}
		</div>
	</div>
</div>

<style>
	div {
		box-shadow: 0 0 80px -20px rgba(184, 134, 11, 0.15);
	}
</style>
