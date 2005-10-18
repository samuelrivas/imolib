## Usage M = imolib_iquantize(QM, Factor, QuantMatrix)
##
## Inverse Quantization the M matrix with Factor. If QuantMatrix is
## present, an additional factor is used for each individual coefficient
##
## The operation is roughly the next: M = QM ./ QuantMatrix * Factor

function M = imolib_iquantize(QM, Factor, QuantMatrix)

  if (nargout > 1 || (nargin != 2 && nargin != 3))
    usage(["M = imolib_iquantize(QM, Factor, QuantMatrix)\nQuantMatrix ", \
	   "is optional"]);
  end

  if (nargin != 3)
    QuantMatrix = ones(size(QM));
  elseif (~ all(size(QM) == size(QuantMatrix)))
    error("QuantMatrix and QM dimensions don't agree");
  end

  M = QM .* QuantMatrix * Factor;

endfunction