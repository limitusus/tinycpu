/**
 * Config file of CPU
 */

/* Clock Rate */
`define RATE 100

/* Register/Memory Data width */
`define DATA_WIDTH 32
/* Register Addr width */
`define ADDR_WIDTH 5
/* Memory Addr width */
`define MEM_ADDR_WIDTH `DATA_WIDTH

/* PC Address Width */
`define PC_ADDR_WIDTH 5
/* Instruction width */
`define WORD_WIDTH 32

/* Control width */
`define CTRL_WIDTH 4
/* ALUOp WIDTH */
`define ALUOP_WIDTH 6

/* Assembly OP width */
`define ASM_OP_WIDTH `ALUOP_WIDTH

/* WIDTH of WORD */
`define BYTE_WIDTH 32
`define HALF_WIDTH `DATA_WIDTH/2

/* Opecode Definition */
`define NM_ADD 0
`define NM_ADDI 1
`define NM_MUL 0
`define NM_MULI 7
`define NM_DIV 0
`define NM_DIVI 8
`define NM_SUB 0
`define NM_LUI 3
`define NM_AND 0
`define NM_ANDI 4
`define NM_OR 0
`define NM_ORI 5
`define NM_XOR 0
`define NM_XORI 6
`define NM_NOR 0
`define NM_SLL 0
`define NM_SRL 0
`define NM_SRA 0
`define NM_LW 16
`define NM_LH 18
`define NM_LB 20
`define NM_SW 24
`define NM_SH 26
`define NM_SB 28
`define NM_BEQ 32
`define NM_BNE 33
`define NM_BLT 34
`define NM_BLE 35
`define NM_J 40
`define NM_JAL 41
`define NM_JR 42
