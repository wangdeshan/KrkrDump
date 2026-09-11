const fs = require("fs");

const garbro_evenmap = [
    "NOT_EAX",
    // NOT_EAX 0xf7 0xd0

    "DEC_EAX",
    // DEC_EAX 0x48

    "NEG_EAX",
    // NEG_EAX 0xf7 0xd8

    "INC_EAX",
    // INC_EAX 0x40

    "MOV_EAX_INDIRECT",
    // NOP              0xbe
    // AND_EAX_IMMED    0x25
    // 0x000003FF
    // MOV_EAX_INDIRECT 0x8b 0x04 0x86

    "INTERLACE_EAX",
    // PUSH_EBX      0x53
    // MOV_EBX_EAX   0x89 0xc3
    // AND_EBX_IMMED 0x81 0xe3
    // 0xAAAAAAAA
    // AND_EAX_IMMED 0x25
    // 0x55555555
    // SHR_EBX_1     0xd1 0xeb
    // SHL_EAX_1     0xd1 0xe0
    // OR_EAX_EBX    0x09 0xd8
    // POP_EBX       0x5b

    "XOR_EAX_IMMED",
    // XOR_EAX_IMMED 0x35

    "ADDORSUB_EAX_IMMED"
    // ADD_EAX_IMMED 0x05
    // SUB_EAX_IMMED 0x2d
];
const garbro_oddmap = [
    "SHR_EAX_CL",
    // PUSH_ECX    0x51
    // MOV_ECX_EBX 0x89 0xd9
    // AND_ECX_0F  0x83 0xe1 0x0f
    // SHR_EAX_CL  0xd3 0xe8
    // POP_ECX     0x59

    "SHL_EAX_CL",
    //PUSH_ECX    0x51
    //MOV_ECX_EBX 0x89 0xd9
    //AND_ECX_0F  0x83 0xe1 0x0f
    //SHL_EAX_CL  0xd3 0xe0
    //POP_ECX     0x59

    "ADD_EAX_EBX",
    //ADD_EAX_EBX 0x01 0xd8

    "NEG_EAX_ADD_EAX_EBX",
    // NEG_EAX     0xf7 0xd8
    // ADD_EAX_EBX 0x01 0xd8

    "IMUL_EAX_EBX",
    // IMUL_EAX_EBX 0x0f 0xaf 0xc3

    "SUB_EAX_EBX"
    // SUB_EAX_EBX 0x29 0xd8
];
const garbro_prologmap = [
    "MOV_EAX_IMMED",
    // MOV EAX, Random() 0xb8

    "MOV_EAX_EDI",
    // MOV_EAX_EDI 0x8b 0xc7

    "MOV_EAX_INDIRECT"
    // NOP 0xbe
    // MOV_EAX_IMMED 0x8b 0x86
    // GetRandom() & 0x000003FF
    // MOV_EAX_INDIRECT
];

const dump_evenmap = [];
dump_evenmap[0] = garbro_evenmap[0];
dump_evenmap[1] = garbro_evenmap[2];
dump_evenmap[2] = garbro_evenmap[3];
dump_evenmap[3] = garbro_evenmap[1];
dump_evenmap[4] = garbro_evenmap[5];
dump_evenmap[5] = garbro_evenmap[6];
dump_evenmap[6] = garbro_evenmap[7];
dump_evenmap[7] = garbro_evenmap[4];

const dump_oddmap = [];
dump_oddmap[0] = garbro_oddmap[2];
dump_oddmap[1] = garbro_oddmap[5];
dump_oddmap[2] = garbro_oddmap[3];
dump_oddmap[3] = garbro_oddmap[4];
dump_oddmap[4] = garbro_oddmap[1];
dump_oddmap[5] = garbro_oddmap[0];

const dump_prologmap = [];
dump_prologmap[0] = garbro_prologmap[0];
dump_prologmap[1] = garbro_prologmap[1];
dump_prologmap[2] = garbro_prologmap[2];

// console.log(garbro_evenmap)
// console.log(garbro_oddmap)
// console.log(garbro_prologmap)
// console.log(dump_evenmap)
// console.log(dump_oddmap)
// console.log(dump_prologmap)


let data = fs.readFileSync("CxdecOrder.bin");
let o1 = [];
let o2 = [];
let o3 = [];

for (let i = 0; i < 8; i++) {
	let r = data[i];
	let c = dump_evenmap[i];
	let x = garbro_evenmap.indexOf(c)
	o1[r]=x
	// console.log(r,c,x)
}
for (let i = 0; i < 6; i++) {
	let r = data[i+8];
	let c = dump_oddmap[i];
	let x = garbro_oddmap.indexOf(c)
	o2[r]=x
	// console.log(r,c,x)
}
for (let i = 0; i < 3; i++) {
	let r = data[i+14];
	let c = dump_prologmap[i];
	let x = garbro_prologmap.indexOf(c)
	o3[r]=x
	// console.log(r,c,x)
}

console.log(data)
console.log(o1.join(","))
console.log(o2.join(","))
console.log(o3.join(","))
