#include <asm/desc.h>

void my_store_idt(struct desc_ptr *idtr) {
// <STUDENT FILL> - HINT: USE INLINE ASSEMBLY
    __asm__ volatile ("sidt %0"
            : "=m"(*idtr));
// </STUDENT FILL>
}

void my_load_idt(struct desc_ptr *idtr) {
// <STUDENT FILL> - HINT: USE INLINE ASSEMBLY
    __asm__ volatile ("lidt %0"
            :: "m"(*idtr));
// <STUDENT FILL>
}

void my_set_gate_offset(gate_desc *gate, unsigned long addr) {
// <STUDENT FILL> - HINT: NO NEED FOR INLINE ASSEMBLY
    gate->offset_low = addr & 0xFFFF;
    gate->offset_middle = (addr >> 16) & 0xFFFF;
    gate->offset_high = (addr >> 32) & 0xFFFFFFFF;
// </STUDENT FILL>
}

unsigned long my_get_gate_offset(gate_desc *gate) {
// <STUDENT FILL> - HINT: NO NEED FOR INLINE ASSEMBLY
    unsigned long offset = 0;

    offset = gate->offset_high;
    offset <<= 16;
    offset |= gate->offset_middle;
    offset <<= 16;
    offset |= gate->offset_low;

    return offset;
// </STUDENT FILL>
}
