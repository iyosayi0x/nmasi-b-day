<script lang="ts">
	import Icon from '@iconify/svelte';
</script>

<div class="grid h-full grid-cols-1 gap-8 md:grid-cols-2">
	<div
		class="relative h-64 overflow-hidden rounded-xl border border-white/5 bg-midnight/40 p-1 md:h-full"
	>
		<img
			src="/act2_nsukka_keke.png"
			alt="Nsukka"
			class="h-full w-full rounded-lg object-cover opacity-60"
		/>
		<div class="absolute inset-0 bg-linear-to-t from-midnight to-transparent"></div>
		<div class="absolute bottom-4 left-4">
			<p class="text-[10px] font-bold tracking-[0.2em] text-accent uppercase">
				Protocol: Nsukka Spiderwoman
			</p>
		</div>
	</div>
	<div class="flex flex-col justify-center space-y-6">
		<div class="space-y-4">
			<h4 class="text-sm font-black tracking-widest text-white uppercase">The Action Report</h4>
			<p class="text-xs leading-relaxed text-ghost/60 md:text-sm">
				"They say heroes are born in labs. <span
					class="text-accent underline decoration-accent/30 underline-offset-4"
					>You were born jumping out of a moving Keke.</span
				> Since that leap of faith in Nsukka, gravity has never quite applied to you."
			</p>
		</div>
		<div class="flex items-center gap-3">
			<div class="flex h-10 w-10 items-center justify-center rounded-full bg-accent/10 text-accent">
				<Icon icon="ph:spider-fill" class="animate-pulse text-xl" />
			</div>
			<p class="text-[10px] font-bold tracking-wider text-ghost/40">
				ANOMALY DETECTED: UNSTOPPABLE MOMENTUM
			</p>
		</div>
	</div>
</div>
