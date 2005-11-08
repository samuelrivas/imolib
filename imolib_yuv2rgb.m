## Usage:

function [R, G, B] = imolib_yuv2rgb(Y, U, V, Reverse)

  if nargin < 4
    Reverse = false;
  end
  
  if (Reverse)
    Coeff = ([0.299 0.587 0.114; -0.147 -0.289 0.436; 0.615 -0.515 -0.100]);
  else 
    Coeff = ([1 0 1.140; 1 -0.395 -0.58; 1 2.032 0]);
  end
  
  R = G = B = zeros(size(Y));

  for I = 1:size(Y)(1)
    for J = 1:size(Y)(1)
      Triplet = Coeff * [Y(I,J); U(I,J); V(I,J)];
      R(I,J) = Triplet(1);
      G(I,J) = Triplet(2);
      B(I,J) = Triplet(3);
    end
  end
endfunction