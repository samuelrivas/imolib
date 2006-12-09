## Usage imolib_load_pgm(File)
##
## Loads pgm images
##
## Return [Img, ColourMap]

function [Img, ColourMap] = imolib_load_pgm(File)

  if (nargin != 1 || nargout > 3)
    usage("[Img, ColourMap] = imolib_load_pgm(File)\n");
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

  if (Header(1) != 5)
    error("Not a PGM image\n");
  end

  
  ## Load the image bytes in a singe column vector
  Width = Header(2);
  Height = Header(3);
  Depth = Header(4);

  ## TODO: Supports depths higher than 255
  if (Depth > 255) 
    error("Two-byte sized pixels are not supported yet (depth must be less than 256)\n")
  end

  Bytes = Height*Width;
  Raster = zeros(1, Bytes);

  [Raster, Count] = fread(Fid, Bytes, "uchar");

  if (Count != Bytes)
    error("Cannot read the whole image (maybe file is too short)\n");
  end
  
  Img = reshape(Raster, Width, Height)';
  ColourMap = gray(Depth);

  fclose(Fid)
endfunction
