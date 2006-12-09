## Usage QM = imolib_quantise(M, Factor, Inverse, QuantMatrix)
##
## Quantises the M matrix with Factor. If QuantMatrix is present, an
## additional factor is used for each individual coefficient.
##
## The inverse parameter is an optional boolean. If it is true then
## an inverse quantisation is performed
##
## The operation is roughly the next:
## QM = round(M ./ (Factor * QuantMatrix))

function QM = imolib_quantise(M, Factor, Inverse, QuantMatrix)

  if (nargout > 1 || nargin < 2 || nargin  > 4)
    usage("QM = imolib_quantise(M, Factor, Inverse, QuantMatrix)\n");
  end

  if (nargin >= 3)
    if (!isbool(Inverse))
      error("Inverse should be a boolean\n");
    end
  end

  if (nargin != 4)
    QuantMatrix = ones(size(M));
  elseif (~ all(size(M) == size(QuantMatrix)))
    error("QuantMatrix and M dimensions don't agree\n");
  end

  if (nargin == 2)
    Inverse = false;
  end

  if (Inverse)
    QM = round(M .* QuantMatrix * Factor);
  else 
    QM = round(M ./ (Factor * QuantMatrix));
  end

endfunction
