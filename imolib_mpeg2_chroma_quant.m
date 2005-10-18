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