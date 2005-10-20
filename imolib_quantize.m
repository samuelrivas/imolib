## Usage QM = imolib_quantize(M, Factor, Inverse, QuantMatrix)
##
## Quantizes the M matrix with Factor. If QuantMatrix is present, an
## additional factor is used for each individual coefficient.
##
## The inverse parameter is also optional. If it is non-zero then
## an inverse quantization is performed
##
## The operation is roughly the next:
## QM = round(M ./ (Factor * QuantMatrix))

function QM = imolib_quantize(M, Factor, Inverse, QuantMatrix)

  if (nargout > 1 || nargin < 2 || nargin  > 4)
    usage("QM = imolib_quantize(M, Factor, Inverse, QuantMatrix)\n");
  end

  if (nargin != 4)
    QuantMatrix = ones(size(M));
  elseif (~ all(size(M) == size(QuantMatrix)))
    error("QuantMatrix and M dimensions don't agree");
  end

  if (nargin == 2)
    Inverse = 0;
  end

  if (Inverse)
    QM = M .* QuantMatrix * Factor;
  else 
    QM = round(M ./ (Factor * QuantMatrix));
  end

endfunction