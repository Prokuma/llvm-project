#ifndef IMAX_OPS
#define IMAX_OPS

include "mlir/Dialect/IMAX/IR/IMAXBase.td"


class IMAX_Op<string mnemonic, list<Trait> traits = []> :
    Op<IMAX_Dialect, mnemonic, traits>;

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

#endif // IMAX_OPS