declare module '*.asm' {
	const program: {
		orig: number;
		machineCode: number[];
		symbolTable: Record<string, number>;
	};
	export default program;
}
