set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name IMAX)
mlir_tablegen(Passes.capi.h.inc -gen-pass-capi-header --prefix IMAX)
mlir_tablegen(Passes.capi.cpp.inc -gen-pass-capi-impl --prefix IMAX)
add_public_tablegen_target(MLIRIMAXPassIncGen)

add_mlir_doc(Passes IMAXPasses ./ -gen-pass-doc)