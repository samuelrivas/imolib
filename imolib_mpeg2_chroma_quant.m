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

## usage CQ = imolib_mpeg2_chroma_quant()

function CQ = imolib_mpeg2_chroma_quant()

  if (nargout > 1 || nargin != 0)
    usage("usage CQ = imolib_mpeg2_chroma_quant()\n")
  end

  CQ = [ 8 16 19 22 26 27 29 34;
        16 16 22 24 27 29 34 37;
        19 22 24 27 29 34 34 37;
        22 22 26 27 29 34 37 40;
        22 26 27 29 32 35 40 48;
        26 27 29 32 35 40 48 58;
        26 27 29 34 38 46 56 69;
        27 29 35 38 46 56 69 83] ./ 16;

endfunction