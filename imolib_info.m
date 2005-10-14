## usage imolib_format("FileName")

function [Format, Height Width, Depth] = imolib_info(File)

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
    case 6
      Format = "PPM";
    case 7
      Format = "PAM";
    otherwise
      error("Not a PNM format");
  end

  Width = Header(2);
  Height = Header(3);
  Depth = Header(4);

  fclose(Fid);
endfunction
