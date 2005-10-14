## Usage imolib_load(File)
##
## Can load either ppm or pgm images
##
## Return [Img, ColourMap]

function [Img, ColourMap] = imolib_load(File)

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

  if (Header(1) != 5)
    error("Not a PGM image");
  end

  
  ## Load the image bytes in a singe column vector
  Width = Header(2);
  Height = Header(3);
  Depth = Header(4);

  ## TODO: Supports depths higher than 255
  if (Depth > 255) 
    error("Two-sized pixels are not supported yet (depth must "
	  + "be less than 256")
  end

  Bytes = Height*Width;
  Raster = zeros(1, Bytes);

  [Raster, Count] = fread(Fid, Bytes, "uchar");

  if (Count != Bytes)
    error("Cannot read the whole image (maybe file is too short)");
  end
  
  Img = reshape(Raster, Width, Height)';
  ColourMap = gray(Depth);

  fclose(Fid)
endfunction

