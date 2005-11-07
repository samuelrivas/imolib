## usage: TM = imolib_block_dct(M, BlockSize, Inverse)
##
## M must be an integer matrix with dimensions multiple of BlockSize
## BlockSize must be an integer
## Inverse is optional and must be a boolean
##
## If inverse is false, TM is a matrix with M dimensions. M is split up
## in BlockSize x BlockSize matixes and the DCT transform is applied to
## each of them to get the coefficients for the same submatrix in TM
##
## If inverse is true the inverse cosine transform is applied instead of
## the straight DCT.
##
## One note on performance. If BlockSize is not 8 a naïve implementation
## of the DCT is used, resunting in a very slow operation. If BlockSize
## is 8 a much faster implementation is used

function TM = imolib_block_dct(M, BlockSize, Inverse)

  ## Check arguments

  if (nargout > 1 || nargin < 2 || nargin > 3)
    usage("TM = imolib_block_dct(M, BlockSize, Iverse)\n");
  end

  if (nargin < 3)
    Inverse = false;
  end

  ## Check argument types
  
  if (!isnumeric(M)) 
    error("M must be numeric\n");
  end

  if (!isnumeric(BlockSize) || length(BlockSize) > 1)
    error("BlockDims must be a number\n");
  end


  ## Check Matrix matrix dimesions with  BlockSize
  
  if (mod(size(M, 1), BlockSize) != 0) 
    error("Number of M rows is not multiple of BlockSize\n");
  end
  if (mod(size(M, 2), BlockSize) != 0)
    error("Number of M columns is not multiple of BlockSize\n");
  end

  ## Work out the number of blocks
  NBlocks = size(M) / BlockSize;

  TM = zeros(size(M));

  for Y = 1:NBlocks(1)
    for X = 1:NBlocks(2)

      Rows = ((Y - 1)*BlockSize + 1) : Y*BlockSize;
      Columns = ((X - 1)*BlockSize + 1) : X*BlockSize;

      AuxBlock = M(Rows, Columns);

      if (BlockSize == 8)
	TM(Rows, Columns) = imolib_fdct(AuxBlock, Inverse);
      else
	
	if (Inverse)
	  TM(Rows, Columns) = imolib_idct(AuxBlock);
	else
	  TM(Rows, Columns) = imolib_dct(AuxBlock);
	end
      end
    end
  end
endfunction