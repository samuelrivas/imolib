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
