## Copyright 2006 Samuel Rivas <samuel@lambdastream.com>
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

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