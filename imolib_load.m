## Usage imolib_load(File)
##
## Can load either ppm or pgm images

function imolib_load(File)

  [Fid, Msg] = fopen(File, "r", "ieee-le");
  
  if (Fid == -1)
    error("Failed to open: %s\n", Msg);
  end

  read_magic(Fid);

  printf("Closing\n");

  fclose(Fid)
endfunction

function read_magic(Fid)

  Magic = setstr(fread(Fid, 2, "int8")');
  if strcmp(Magic, "P4")
    printf("PBM\n");
  elseif strcmp(Magic, "P5")
    printf("PGM\n");
  elseif strcmp(Magic, "P6")
    printf("PPM\n");
  elseif strcmp(Magic, "P7")
    printf("PAM\n");
  else
    error("Not a PNM format");
  end
      
endfunction