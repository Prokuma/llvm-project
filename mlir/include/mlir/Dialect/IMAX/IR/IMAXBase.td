#ifdef IMAX_BASE
#define IMAX_BASE

include "mlir/IR/AttrTypeBase.td"


def IMAX_Dialect : Dialect {
  let name = "imax";
  let cppNamespace = "::mlir::imax";
  let hasOperationAttrVerify = 1;
  let extraClassDeclaration = [{
    /// Get the name of the attribute used to annotate the modules that contain
    /// kernel modules.
    static StringRef getContainerModuleAttrName() {
      return "imax.container_module";
    }
    /// Get the name of the attribute used to annotate external kernel
    /// functions.
    static StringRef getKernelFuncAttrName() { return "imax.kernel"; }

    /// Returns whether the given function is a kernel function, i.e., has the
    /// 'imax.kernel' attribute.
    static bool isKernel(Operation *op);

    /// Returns the number of workgroup (thread, block) dimensions supported in
    /// the IMAX dialect.
  }];

  let discardableAttrs = (ins
    "::mlir::DenseI32ArrayAttr":$known_block_size,
    "::mlir::DenseI32ArrayAttr":$known_grid_size
  );

  let dependentDialects = ["arith::ArithDialect"];
  let useDefaultAttributePrinterParser = 1;
  let useDefaultTypePrinterParser = 1;
}

class IMAX_I32Enum<string name, string description, list<I32EnumAttrCase> cases> : I32EumAttr<name, description, cases> {
    let genSpecializedAttr = 0;
    let cppNamespace = "::mlir::imax";
}
class IMAX_I32EnumAttr<string mnemonic, IMAX_I32Enum enumInfo> :
    EnumAttr<IMAX_Dialect, enumInfo, mnemonic> {
    let assemblyFormat = "<` $value `>";
}

def IMAX_AddressSpaceGlobal : I32EnumAttrCase<"Global", 1, "global">;
def IMAX_AddressSpaceWorkgroup : I32EnumAttrCase<"Workgroup", 2, "workgroup">;
def IMAX_AddressSpacePrivate : I32EnumAttrCase<"Private", 3, "private">;
def IMAX_AddressSpaceEnum : IMAX_I32Enum<"AddressSpace", "Address space for IMAX dialect", [
    IMAX_AddressSpaceGlobal,
    IMAX_AddressSpaceWorkgroup,
    IMAX_AddressSpacePrivate
]>;
def IMAX_AddressSpaceAttr : IMAX_I32EnumAttr<"address_space", IMAX_AddressSpaceEnum>;

def IsMMAMatrixTypePred : CPred<"::llvm::isa<::mlir::imax::MMAMatrixType($_self)>">;

def IMAX_MMAMatrix : DialectType<
    IMAX_Dialect, IsMMAMatrixTypePred, "MMAMatrixType">;

def IMAX_MMAMemRef : MemRefOf<[I8, I32, F16, F32, VectorOfRankAndType<[1], [I8, I32, F16, F32]>]>;

class IMAX_Attr<string sttrName, string attrNnemonicm, list<Trait> traits = []> : AttrDef<IMAX_Dialect, attrName, traits> {
    let mnemonic = attrNnemonic;
}

#endif