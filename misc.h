#ifndef _MISC_H
#define _MISC_H

typedef enum {
    CMP_LE,
    CMP_LT,
    CMP_EQ,
    CMP_GE,
    CMP_GT,
    CMP_NE
} cmp_op;

typedef enum {
    OVERFLOW_OP_ADD,
    OVERFLOW_OP_SUB,
    OVERFLOW_OP_MUL,
} overflow_op;

#endif
