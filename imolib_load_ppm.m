## Usage [R, G, B] = imolib_load_pgm(File)
##
## Can load pgm images

function [R, G, B] = imolib_load_ppm(File)

  if (nargin != 1 || nargout > 3)
    usage("[Red, Green, Blue] = imolib_load(File)");
  end

  [Fid, Msg] = fopen(File, "r", "ieee-le");
  
  if (Fid == -1)
    error("Failed to open: %s\n", Msg);
  end

  ## Read the header to identify the type, the width, the height and the
  ## depth
  [Header, Ok] = fscanf(Fid, "P%1d %d %d %d ");

  if (Ok != 4)
    error("Failed to read the header, probably it is not a PNM format");
  end

  if (Header(1) != 6)
    error("Not a PPM image");
  end

  
  ## Load the image triplets
  Width = Header(2);
  Height = Header(3);
  Depth = Header(4);

  ## TODO: Supports depths higher than 255
  if (Depth > 255) 
    error("Two-sized pixels are not supported yet (depth must "
	  + "be less than 256)")
  end

  Bytes = Height * Width * 3;
  Raster = zeros(1, Bytes);
  R = G = B = zeros(1, Height * Width);
  
  [Raster, Count] = fread(Fid, Bytes, "uchar");
  if (Count != Bytes)
    error("Cannot read the whole image (maybe file is too short)");
  end
  
  R = Raster(1:3:Bytes);
  G = Raster(2:3:Bytes);
  B = Raster(3:3:Bytes);

  R = reshape(R, Width, Height)';
  G = reshape(G, Width, Height)';
  B = reshape(B, Width, Height)';
  fclose(Fid)
endfunction
