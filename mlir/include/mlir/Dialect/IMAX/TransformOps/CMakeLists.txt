set(LLVM_TARGET_DEFINITIONS IMAXTransformOps.td)
mlir_tablegen(IMAXTransformOps.h.inc -gen-op-decls)
mlir_tablegen(IMAXTransformOps.cpp.inc -gen-op-defs)
add_public_tablegen_target(MLIRIMAXTransformOpsIncGen)

add_mlir_doc(IMAXTransformOps IMAXTransformOps Dialects/ -gen-op-doc)