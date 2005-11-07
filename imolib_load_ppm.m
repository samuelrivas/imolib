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

  R = G = B = zeros(Height, Width);

  for I = 1:Height
    for J = 1:Width
      [Triplet, Count] = fread(Fid, 3, "uchar");

      if (Count != 3)
	error("Cannot read the whole image (maybe file is too short)");
      end

      R(I,J) = Triplet(1);
      G(I,J) = Triplet(2);
      B(I,J) = Triplet(3);
    end
  end
  
  fclose(Fid)
endfunction
