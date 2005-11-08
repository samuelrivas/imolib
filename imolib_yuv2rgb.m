## Usage:

function [R, G, B] = imolib_yuv2rgb(Y, U, V, Reverse)

  if nargin < 4
    Reverse = false;
  end
  
  
  R = G = B = zeros(size(Y));

  if (Reverse)
    R = 0.257*Y + 0.504*U + 0.098*V + 16;
    G = -0.148*Y - 0.291*U + 0.439*V + 128; 
    B = 0.439*Y - 0.368*U - 0.071*V + 128;
  else 
    R = 1.164*(Y - 16) + 1.596*(V - 128);
    G = 1.164*(Y - 16) - 0.813*(V - 128) - 0.391*(U - 128);
    B = 1.164*(Y - 16) + 2.018*(U - 128);
  end
endfunction