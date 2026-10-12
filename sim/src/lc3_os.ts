// LC-3 OS image

import badTrap from './os/bad_trap.asm';
import getcTrap from './os/getc.asm';
import haltTrap from './os/halt.asm';
import inTrap from './os/in.asm';
import outTrap from './os/out.asm';
import putsTrap from './os/puts.asm';
import putspTrap from './os/putsp.asm';

type AsmModule = typeof haltTrap;

const trapVectors: Record<number, AsmModule> = {
	0x20: getcTrap,
	0x21: outTrap,
	0x22: putsTrap,
	0x23: inTrap,
	0x24: putspTrap,
	0x25: haltTrap,
};

// device register defaults
const ioDefaults = {
	0xfe04: 0x8000, // display status register: ready
	0xfffe: 0xffff, // machine control register: running
};

const routines = [getcTrap, outTrap, putsTrap, inTrap, putspTrap, badTrap, haltTrap];

function buildOs() {
	const memory: Record<number, number> = {};

	// load traps into os
	for (const { orig, machineCode } of routines) {
		for (let i = 0; i < machineCode.length; i++) {
			const address = orig + i;
			// sanity check overlaps
			if (address in memory) {
				throw new Error(`OS sources overlap at 0x${address.toString(16)}`);
			}
			memory[address] = machineCode[i];
		}
	}

	// trap vector table points at trap origins or the bad trap
	for (let address = 0x0000; address <= 0x00ff; address++) {
		memory[address] = address in trapVectors ? trapVectors[address].orig : badTrap.orig;
	}

	// load io defaults
	for (const [address, value] of Object.entries(ioDefaults)) {
		memory[Number(address)] = value;
	}

	return memory;
}

const lc3os = buildOs();

export { lc3os };
