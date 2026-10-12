import { resolve } from 'path';
import lc3AsmPlugin from '@lc3/sim/vite-plugin-lc3-asm.js';
import { defineConfig } from 'vite';
import { createHtmlPlugin } from 'vite-plugin-html';

export default defineConfig({
	root: '.',
	plugins: [
		lc3AsmPlugin(),
		createHtmlPlugin({
			minify: {
				collapseWhitespace: true,
				conservativeCollapse: true,
				removeComments: true,
			},
		}),
	],
	build: {
		outDir: 'dist',
		rollupOptions: {
			input: {
				main: resolve(__dirname, 'index.html'),
			},
		},
	},
	optimizeDeps: {
		include: ['jquery', 'bootstrap'],
	},
});
