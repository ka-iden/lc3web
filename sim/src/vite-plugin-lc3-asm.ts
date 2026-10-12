// Vite preprocessor for LC-3 assembly sources
// see lc3-asm.d.ts for import type

import { readFile } from 'node:fs/promises';
import assemble from './lc3_as.js';

export default function lc3AsmPlugin() {
	return {
		name: 'vite-plugin-lc3-asm',
		async load(id: string) {
			if (!id.endsWith('.asm')) return null;

			const source = await readFile(id, 'utf-8');
			const result = assemble(source);

			if (result.error) {
				throw new Error(`Failed to assemble ${id}:\n  ` + result.error.join('\n  '));
			}

			const { orig, machineCode, symbolTable } = result;
			return `
				const program = {
				  orig: ${JSON.stringify(orig)},
				  machineCode: ${JSON.stringify(machineCode)},
				  symbolTable: ${JSON.stringify(symbolTable)},
				};
				export default program;
			`;
		},
	};
}
