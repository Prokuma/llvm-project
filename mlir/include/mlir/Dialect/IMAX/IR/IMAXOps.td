#ifndef IMAX_OPS
#define IMAX_OPS

include "mlir/Dialect/IMAX/IR/IMAXBase.td"


class IMAX_Op<string mnemonic, list<Trait> traits = []> :
    Op<IMAX_Dialect, mnemonic, traits>;

class IMAX_MemOp<string mnemonic, list<Trait> traits = []> :
    IMAX_Op<mnemonic, traits>;

class IMAX_EX1Op<string mnemonic, list<Trait> traits = []> :
    IMAX_Op<mnemonic, traits>;

class IMAX_EX2Op<string mnemonic, list<Trait> traits = []> :
    IMAX_Op<mnemonic, traits>;

class IMAX_EX3Op<string mnemonic, list<Trait> traits = []> :
    IMAX_Op<mnemonic, traits>;

class IMAX_AllEXOp<string mnemonic, list<Trait> traits = []> :
    IMAX_Op<mnemonic, traits>;

def IMAX_Dimension : I32EnumAttr<"Dimention", 
    "Dimention for IMAX dialect", [
        I32EnumAttrCase<"X", 0, "x">,
        I32EnumAttrCase<"Y", 1, "y">,
        I32EnumAttrCase<"Z", 2, "z">
    ]>{
    let genSpecializedAttr = 0;
    let cppNamespace = "::mlir::imax";
}
def IMAX_DimensionAttr : IMAX_I32EnumAttr<IMAX_Dialect, IMAX_Dimension, "dim">;

def LDROp : IMAX_MemOp<"ldr"> {
    let summary = "Load";
    let description = [{
        Load a value from memory.
    }];

    let arguments = (ins
        U64:$address,
        U64:$offset,
        U64:$size,
        U64:$mask
    );
    let results = (outs U64:$result);
}

def LDWROp : IMAX_MemOp<"ldwr"> {
    let summary = "Load with return";
    let description = [{
        Load a value from memory and return the address.
    }];

    let arguments = (ins
        U64:$address,
        U64:$offset,
        U64:$size,
        U64:$mask
    );
    let results = (outs U32:$result);
}

def LDBROp : IMAX_MemOp<"ldbr"> {
    let summary = "Load byte";
    let description = [{
        Load a byte from memory.
    }];

    let arguments = (ins
        U64:$address,
        U64:$offset,
        U64:$size,
        U64:$mask
    );
    let results = (outs U8:$result);
}

def STROp : IMAX_MemOp<"str"> {
    let summary = "Store";
    let description = [{
        Store a value to memory.
    }];

    let arguments = (ins
        U64:$address,
        U64:$offset,
        U64:$size,
        U64:$mask,
        U64:$value
    );
    let results = ();
}


def STWROp : IMAX_MemOp<"stwr"> {
    let summary = "Store with return";
    let description = [{
        Store a value to memory and return the address.
    }];

    let arguments = (ins
        U64:$address,
        U64:$offset,
        U64:$size,
        U64:$mask,
        U32:$value
    );
    let results = (outs U32:$result);
}

def STBROp : IMAX_MemOp<"stbr"> {
    let summary = "Store byte";
    let description = [{
        Store a byte to memory.
    }];

    let arguments = (ins
        U64:$address,
        U64:$offset,
        U64:$size,
        U64:$mask,
        U8:$value
    );
    let results = ();
}

def FMAOp : IMAX_AllEXOp<"fma"> {
    let summary = "Float multiply-add";
    let description = [{
        Multiply two floating point numbers and add a third.
    }];

    let arguments = (ins
        F32:$lhs,
        F32:$rhs,
        F32:$addend
    );
    let results = (outs F32:$result);
}

def FMSOp : IMAX_AllEXOp<"fms"> {
    let summary = "Float multiply-sub";
    let description = [{
        Multiply two floating point numbers and subtract a third.
    }];

    let arguments = (ins
        F32:$lhs,
        F32:$rhs,
        F32:$subtrahend
    );
    let results = (outs F32:$result);
}

def FMLOp : IMAX_AllEXOp<"fml"> {
    let summary = "Float multiply";
    let description = [{
        Multiply two floating point numbers.
    }];

    let arguments = (ins
        F32:$lhs,
        F32:$rhs
    );
    let results = (outs F32:$result);
}

def FADOp : IMAX_AllEXOp<"fad"> {
    let summary = "Float add";
    let description = [{
        Add two floating point numbers.
    }];

    let arguments = (ins
        F32:$lhs,
        F32:$rhs
    );
    let results = (outs F32:$result);
}

def FML3Op : IMAX_AllEXOp<"fml3"> {
    let summary = "Float multiply 3";
    let description = [{
        Multiply three floating point numbers.
    }];

    let arguments = (ins
        F32:$lhs,
        IMAX_IntegerTypeTensor:$rhs,
        IMAX_IntegerType:$idx
    );
    let results = (outs F32:$result);
}



def Add3Op : IMAX_EX1Op<"add3"> {
    let summary = "Add 3 numbers";
    let description = [{
        Add three numbers.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs,
        I32:$addend
    );
    let results = (outs I32:$result);
}

def Sub3Op : IMAX_EX1Op<"sub3"> {
    let summary = "Subtract 3 numbers";
    let description = [{
        Subtract three numbers.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs,
        I32:$subtrahend
    );
    let results = (outs I32:$result);
}

def AddOp : IMAX_EX1Op<"add"> {
    let summary = "Add two numbers";
    let description = [{
        Add two numbers.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def SubOp : IMAX_EX1Op<"sub"> {
    let summary = "Subtract two numbers";
    let description = [{
        Subtract two numbers.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}


def CmpEqOp : IMAX_EX2Op<"cmpeq"> {
    let summary = "Compare equal";
    let description = [{
        Compare two numbers for equality.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}


def CmpNeOp : IMAX_EX2Op<"cmpne"> {
    let summary = "Compare not equal";
    let description = [{
        Compare two numbers for inequality.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}


def CmpLtOp : IMAX_EX2Op<"cmplt"> {
    let summary = "Compare less than";
    let description = [{
        Compare two numbers for less than.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def CmpLeOp : IMAX_EX2Op<"cmple"> {
    let summary = "Compare less than or equal";
    let description = [{
        Compare two numbers for less than or equal.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def CmpGtOp : IMAX_EX2Op<"cmpgt"> {
    let summary = "Compare greater than";
    let description = [{
        Compare two numbers for greater than.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def CmpGeOp : IMAX_EX2Op<"cmpge"> {
    let summary = "Compare greater than or equal";
    let description = [{
        Compare two numbers for greater than or equal.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def CmovOp : IMAX_EX3Op<"cmov"> {
    let summary = "Conditional move";
    let description = [{
        Conditional move.
    }];

    let arguments = (ins
        I32:$cond,
        I32:$true_value,
        I32:$false_value
    );
    let results = (outs I32:$result);
}

def AndOp : IMAX_EX2Op<"and"> {
    let summary = "Bitwise and";
    let description = [{
        Bitwise and.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def OrOp : IMAX_EX2Op<"or"> {
    let summary = "Bitwise or";
    let description = [{
        Bitwise or.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def XorOp : IMAX_EX2Op<"xor"> {
    let summary = "Bitwise xor";
    let description = [{
        Bitwise xor.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def SllOp : IMAX_EX3Op<"sll"> {
    let summary = "Shift left logical";
    let description = [{
        Shift left logical.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def SrlOp : IMAX_EX3Op<"srl"> {
    let summary = "Shift right logical";
    let description = [{
        Shift right logical.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}


def SraaOp : IMAX_EX3Op<"sraa"> {
    let summary = "Shift right arithmetic";
    let description = [{
        Shift right arithmetic.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}

def SrabOp : IMAX_EX3Op<"srab"> {
    let summary = "Shift right arithmetic";
    let description = [{
        Shift right arithmetic.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}


def SrlmOp : IMAX_EX3Op<"srlm"> {
    let summary = "Shift right logical mask";
    let description = [{
        Shift right logical mask.
    }];

    let arguments = (ins
        I32:$lhs,
        I32:$rhs
    );
    let results = (outs I32:$result);
}


#endif // IMAX_OPS