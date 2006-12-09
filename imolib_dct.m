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

## usage Transform imolib_dct(M)
##
## M must be a square matrix
##
## WARNING: This function is _extremely_ slow (use imolib_fdct whenever
## you can)

function Transform = imolib_dct(M)

  if (nargout > 1 || nargin != 1)
    usage("Transform imolib_dct(M)\n");
  end

  N = issquare(M);
  if (N == 0)
    error("M must be square\n");
  end

  Transform = zeros(N,N);

  for U = 0 : N - 1
    for V = 0 : N - 1
      Transform(U + 1, V + 1) = coefficient(U, V, M);
    end
  end

endfunction

function Coeff = coefficient(U, V, M)

  N = length(M);

  sum = 0;

  for X = 0 : N - 1
    for Y = 0 : N - 1
      sum = sum + M(X + 1 , Y + 1) * cos((2*X + 1) * U * pi / (2*N)) \
	  * cos((2*Y + 1) * V * pi / (2*N));
    end
  end

  if (U == 0 && V == 0)
    C = 1/2;
  elseif (U == 0 || V == 0)
    C = 1/sqrt(2);
  else 
    C = 1;
  end

  Coeff = round(2 * C * sum / N);
endfunction