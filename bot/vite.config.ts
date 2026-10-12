import lc3AsmPlugin from '@lc3/sim/vite-plugin-lc3-asm.js';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [lc3AsmPlugin()],
	build: {
		outDir: 'dist',
		minify: false,
		lib: {
			entry: 'src/index.ts',
			formats: ['es'],
			fileName: () => 'worker.js',
		},
		rollupOptions: {
			external: [/^node:/],
		},
	},
});
