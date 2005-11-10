## Usage: [R G B] = imolib_yuv2rgb(Y, U, V, Reverse)
##
## Y,U,V must be integer matrices with the same dimensions
## Reverse is optional and must be a boolean. Default value is false
##
## If Reverse is true then R,G and B must be read as Y,U and V and conversely
##
## Note that there as much ways to translate RGB to YUV as authors and 
## standards you can read. I simply took a pretty common one

function [R, G, B] = imolib_yuv2rgb(Y, U, V, Reverse)

  ## Check the input and output
  if (nargin < 3 || nargin > 4 || nargout > 3)
    usage("Usage: [R G B] = imolib_yuv2rgb(Y, U, V, Reverse)\n");
  end

  if (nargin < 4)
    Reverse = false;
  end

  if (!ismatrix(Y) || !ismatrix(U) || !ismatrix(V) || !isbool(Reverse))
    error("Input types are not correct\n");
  end

  if (any(size(Y) != size(U) | size(Y) != size(V)))
    error("Matrix dimensions must agree\n")
  end
    
  R = G = B = zeros(size(Y));

  if (Reverse)
    R = round(0.257*Y + 0.504*U + 0.098*V + 16);
    G = round(-0.148*Y - 0.291*U + 0.439*V + 128);
    B = round(0.439*Y - 0.368*U - 0.071*V + 128);
  else 
    R = round(1.164*(Y - 16) + 1.596*(V - 128));
    G = round(1.164*(Y - 16) - 0.813*(V - 128) - 0.391*(U - 128));
    B = round(1.164*(Y - 16) + 2.018*(U - 128));
  end

  ## Saturate the values
  R = R .* (R > 0 & R < 256) + 255 * (R > 255);
  G = G .* (G > 0 & G < 256) + 255 * (G > 255);
  B = B .* (B > 0 & B < 256) + 255 * (B > 255);
  
endfunction