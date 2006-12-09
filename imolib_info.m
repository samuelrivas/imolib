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

## usage [Format, Heigth, Width, Depth] = imolib_format("FileName")
##
## Returns information about a PNM image. Format can be either "PBM", or
## "PGM" or "PPM" or "PAM"
##
## Example:
##
## [Format, Height, Width, Depth] = imolib_info("lena.pgm")
##	Format = PGM
##	Height = 512
##	Width = 512
##	Depth = 255


function [Format, Height, Width, Depth] = imolib_info(File)

  if (nargin != 1 || nargout > 4)
    usage("[Format, Heigth, Width, Depth] = imolib_format(\"FileName\")\n")
  end

  [Fid, Msg] = fopen(File, "r", "ieee-le");
  
  if (Fid == -1)
    error("Failed to open: %s\n", Msg);
  end

  ## Read the header to identify the type, the width, the height and the
  ## depth
  [Header, Ok] = fscanf(Fid, "P%1d %d %d %d ");

  if (Ok != 4)
    error("Failed to read the header, probably it is not a PNM format\n");
  end

  switch (Header(1))
    case 4
      Format = "PBM";
    case 5
      Format = "PGM";
    case 6
      Format = "PPM";
    case 7
      Format = "PAM";
    otherwise
      error("Not a PNM format\n");
  end

  Width = Header(2);
  Height = Header(3);
  Depth = Header(4);

  fclose(Fid);
endfunction
