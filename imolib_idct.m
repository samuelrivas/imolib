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

## usage M = imolib_dct(Transform)
##
## Transform must be a square matrix.
##
## WARNING: This function is _extremely_ slow (use imolib_fdct whenever
## you can)

function M = imolib_idct(Transform)

  if (nargout > 1 || nargin != 1)
    usage("M = imolib_dct(Transform)\n");
  end

  N = size(Transform, 1);

  if (N != size(Transform, 2))
    error("Transform must be square\n");
  end

  M = zeros(N,N);

  for X = 0 : N - 1
    for Y = 0 : N - 1
      M(X + 1, Y + 1) = value(X, Y, Transform);
    end
  end

endfunction

function Val = value(X, Y, Transform)

  N = length(Transform);

  sum = 0;

  for U = 0 : N - 1

    if (U == 0)
      Cu = 1 / sqrt(2);
    else
      Cu = 1;
    end

    for V = 0 : N - 1
      
      if (V == 0)
	Cv = 1 / sqrt(2);
      else
	Cv = 1;
      end
      
      sum = sum + Cu * Cv * Transform(U + 1, V + 1) \
	  * cos((2*X + 1) * U * pi/(2*N)) \
	  * cos((2*Y + 1) * V * pi/(2*N));
    end
  end

  Val = 2 * sum / N;
endfunction