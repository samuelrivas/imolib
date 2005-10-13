## Usage imolib_load(File)
##
## Can load either ppm or pgm images

function imolib_load(File)

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

  switch (Header(1))
    case 4
      Format = "PBM";
    case 5
      Format = "PGM";
      read_pgm(Fid, Header(2), Header(3), Header(4))
    case 6
      Format = "PPM";
    case 7
      Format = "PAM";
    otherwise
      error("Not a PNM format");
  end
  fclose(Fid)
endfunction

function read_pgm(Fid, Width, Height, Depth)
  
  [Raster, Count] = fread(Fid, Width, "uchar");
  printf("Read %d\n", Count)
  Raster
endfunction

      
