.version 8.7
.target sm_89
.address_size 64

.visible .entry benchmark_kernel(
    .param .u64 param0,
    .param .u64 param1
)
{
    .reg .pred p1, p2, p3, p4, p5;
    .reg .b64 r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r41;

    ld.param.u64 r0, [param0];
    ld.param.u64 r1, [param1];
    setp.eq.s64 p1, r0, 0;
    mov.u64 r41, 0;
    @p1 bra L7;

    add.s64 r2, r0, -1;
    and.b64 r3, r0, 3;
    setp.lt.u64 p2, r2, 3;
    mov.u64 r4, 0;
    mov.u64 r41, r4;
    @p2 bra L4;

    sub.s64 r5, r3, r0;
    mov.u64 r4, 0;

L3:
    add.s64 r6, r4, r41;
    add.s64 r7, r4, r6;
    add.s64 r8, r4, r7;
    add.s64 r9, r4, r8;
    add.s64 r41, r9, 6;
    add.s64 r4, r4, 4;
    add.s64 r10, r5, r4;
    setp.ne.s64 p3, r10, 0;
    @p3 bra L3;

L4:
    setp.eq.s64 p4, r3, 0;
    @p4 bra L7;

    neg.s64 r11, r3;

L6:
    .pragma "nounroll";
    add.s64 r41, r4, r41;
    add.s64 r4, r4, 1;
    add.s64 r11, r11, 1;
    setp.ne.s64 p5, r11, 0;
    @p5 bra L6;

L7:
    cvta.to.global.u64 r12, r1;
    st.global.u64 [r12], r41;
    ret;
}
