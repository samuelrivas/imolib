## usage M = imolib_upsample(DownMatrix, Factor)
##
## DownMatrix is a NxM matrix.
## Factor must be a scalar
## M is a Factor*M x Factor*N matrix. The upsampling is a mere copy of
## coefficients to stuff M
##
## Example:
## imolib_upsample([1 2 3; 4 5 6], 2)
##   = 
##    1  1  2  2  3  3
##    1  1  2  2  3  3
##    4  4  5  5  6  6
##    4  4  5  5  6  6
##

function M = imolib_upsample(DownMatrix, Factor)

  if (nargin != 2 || nargout > 1) 
    usage("M = imolib_upsample(DownMatrix, Factor)\n");
  end
  
  if (!ismatrix(DownMatrix) || !isscalar(Factor))
    error("DownMatrix must be a matrix and Factor must be a scalar\n");
  end

  ## Create the upsampling matrices
  [Rows, Cols] = size(DownMatrix);
  
  UpLeft = zeros(Rows*Factor, Rows);
  UpRight = zeros(Cols, Cols*Factor);

  for I = 1:Factor
    UpLeft(I:Factor:Rows*Factor, 1:Rows) = eye(Rows);
    UpRight(1:Cols, I:Factor:Cols*Factor) = eye(Cols);
  end
  
  ## Upsample the matrix
  M = UpLeft*DownMatrix*UpRight;
end