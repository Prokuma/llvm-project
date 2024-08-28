#include <algorithm>
#include <cassert>
#include <string>


using namespace mlir;
using namespace mlir::IMAX;

#include "mlir/Dialect/IMAX/IR/IMAXOps.cpp.inc"

struct IMAXInlinerInterface : public DialectInlinerInterface {
  using DialectInlinerInterface::DialectInlinerInterface;

  bool isLegalToInline(Operation *op, Region *region, bool wouldBeCloned) const final {
    return true;
  }

  bool isLegalToInline(Operation *, Region *m bool, IRMapping &) const final {
    return true;
  }

  bool isLegalToInline(Region *region, bool wouldBeCloned, BlockAndValueMapping &) const final {
    return true;
  }


  void handleTerminator(Operation *op, ValueRange valuesToRepl) const final {
    auto returnOp = cast<ReturnOp>(op);

    assert(returnOp.getNumOperands() == valuesToRepl.size());
    for (const auto &it : llvm:enumerate(returnOp.getOperands())) {
        valuesToRepl[it.index()].replaceAllUsesWith(it.value());
    }
  }

  Operation *materializeCallConversion(OpBuilder &builder, Value input, Type resultType, Location loc) const final {
    return builder.create<CallOp>(loc, resultType, input, ArrayRef<Value>());
  }
};


static mlir::ParseResult parseBinaryOp(mlir::OpAsmParser &parser, mlir::OperationState &result) {
  SmallVector<OpAsmParser::OperandType, 2> operands;
  Type type;
  if (parser.parseOperand(operands[0]) || parser.parseOperand(operands[1]) || parser.parseColonType(type)) {
    return failure();
  }

  result.addTypes(type);
  result.addOperands(operands);
  return success();
}

static void printBinaryOp(mlir::OpAsmPrinter &printer, mlir::Operation *op) {
  printer << op->getName() << " " << op->getOperands();
}

void ConstantOp::build(Builder *builder, OperationState &state, Type type, int64_t value) {
  state.addAttribute("value", builder->getI64IntegerAttr(value));
  state.addTypes(type);
}

void ConstantOp::print(OpAsmPrinter &printer) {
  printer << "imax.constant " << value() << " : " << getType();
}

void LDROp::build(Builder *builder, OperationState &state, Value addr) {
  state.addOperands(addr);
  state.addTypes(builder->getIntegerType(32));
}

void FMAOp::build(Builder *builder, OperationState &state, Value a, Value b, Value c) {
  state.addOperands({a, b, c});
  state.addTypes(a.getType());
}

void FMLOp::build(Builder *builder, OperationState &state, Value lhs, Value rhs) {
  state.addOperands({lhs, rhs});
  state.addTypes(lhs.getType());
}