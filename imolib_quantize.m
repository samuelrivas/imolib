## Usage QM = imolib_quantize(M, Factor, QuantMatrix)
##
## Quantizes the M matrix with Factor. If QuantMatrix is present, an
## additional factor is used for each individual coefficient
##
## The operation is roughly the next:
## QM = round(M ./ (Factor * QuantMatrix))

function QM = imolib_quantize(M, Factor, QuantMatrix)

  if (nargout > 1 || (nargin != 2 && nargin != 3))
    usage(["QM = imolib_quantize(M, Factor, QuantMatrix)\nQuantMatrix ", \
	   "is optional"]);
  end

  if (nargin != 3)
    QuantMatrix = ones(size(M));
  elseif (~ all(size(M) == size(QuantMatrix)))
    error("QuantMatrix and M dimensions don't agree");
  end

  QM = round(M ./ (Factor * QuantMatrix));

endfunction