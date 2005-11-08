## usage: QM = imolib_block_quantize(M, BlockDims, QuantFactor, Inverse,
##				     QuantMatrix)
##
## Quantize M blockwise. An individual quant factor can be specified for
## each block.
##
## M must be a matrix.
##
## BlockDims can be either a scalar or a 2 length row vector. A scalar
## means square blocks.
##
## QuantFactor can be either a scalar or a matrix. If it is a matrix,
## its dimensions must be coherent with M dimensions and BlockDims, so
## that each quant coefficient applies to a M block.
##
## Inverse is an optional boolean to set inverse quantization. Default
## is false.
##
## QuantMatrix is also optional. If set, it must be a matrix with
## BlockDims dimensions. It is used to modify the quant factor for each
## block coefficient.

function QM = imolib_block_quantize(M, BlockDims, QuantFactor, Inverse, \
				    QuantMatrix)


  if (nargout > 1 || nargin < 3 || nargin > 5)
    usage("blah");
  end

  ## Get the block dimensions and check that M dimensions are multiples
  ## of them
  if (size(BlockDims, 1) != 1 || length(BlockDims) > 2) 
    error("Block Dimensions should be either an integer or a 1x2 matrix\n");
  end

  if (size(BlockDims, 2) == 1)

    BlockRows = BlockColumns = BlockDims;

  elseif (size(BlockDims, 2) == 2)

    BlockRows = BlockDims(1);
    BlockColumns = BlockDims(2);

  end

  if (mod(size(M, 1), BlockRows) != 0) 
    error("Number of M rows is not multiple of %d\n", BlockRows);
  end
  if (mod(size(M, 2), BlockColumns) != 0)
    error("Number of M columns is not multiple of %d\n", BlockColumns);
  end

  ## Work out the number of blocks
  NBlocks = size(M) ./ [BlockRows, BlockColumns];

  ## Check QuantFactor
  if (length(QuantFactor) > 1)
    if (size(QuantFactor, 1) != NBlocks(1)
	|| size(QuantFactor, 2) != NBlocks(2))
      error(["QuantFactor dimensions does not agree with Block dimensions ", \
	     "and M dimensions\n"]);
    end
  else
    QuantFactor = QuantFactor * ones(NBlocks);
  end

  ## Check QuantMatrix if present or create it otherwise

  if (nargin == 5)
    if (size(QuantMatrix, 1) != BlockRows 
	|| size(QuantMatrix, 2) != BlockColumns)
      error("QuantMatrix dimensions does not agree with Block dimensions\n");
    end
  else
    QuantMatrix = ones(BlockRows, BlockColumns);
  end

  ## Unset inverse quantization by default
  if (nargin < 4) 
    Inverse = false;
  end

  ## Quantize the matrix
  
  QM = zeros(size(M));

  for Y = 1:NBlocks(1)
    for X = 1:NBlocks(2)

      Rows = ((Y - 1)*BlockRows + 1) : Y*BlockRows;
      Columns = ((X - 1)*BlockColumns + 1) : X*BlockColumns;

      AuxBlock = M(Rows, Columns);
      
      QM(Rows, Columns) = imolib_quantize(AuxBlock,  QuantFactor(Y, X), \
					  Inverse, QuantMatrix);
    end
  end

endfunction