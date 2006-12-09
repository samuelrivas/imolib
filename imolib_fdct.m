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

## Usage Transform imolib_fdct(M, Inverse)
##
## M must be an 8x8 matrix
##

##
## A (not so) fast implementation of the 8x8 discrete cosine transform
## Two possible improvements are:
##
## - Caching the C matrix to avoid recalculating it in each call
## - Exploit the C matrix periodicity to save some computations
##
function Transform = imolib_fdct(M, Inverse)

  ## Check input
  if (nargout > 1 || nargin < 1 || nargin > 2)
    usage("Transform = imolib_fdct(M, Inverse)\n");
  end

  if (!all(size(M) == [8,8]))
    error("M must be 8x8\n");
  end

  if (nargin == 1)
    Inverse = false;
  end

  if (!isbool(Inverse))
    error("Inverse must be boolean\n");
  end

  C = zeros(8);

  for X = 1:8

    if (X == 1)
      S = sqrt(0.125);
    else 
      S = 0.5;
    end

    for Y = 1:8
      C(X,Y) = S * cos((pi/8)*(X - 1)*(Y-0.5));
    end
  end

  if (!Inverse)
    Transform = round(C*M*C');
  else
    Transform = round(C'*M*C);
  end
endfunction;
