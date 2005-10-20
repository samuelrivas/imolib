## usage imolib_dct(M)

function Transform = imolib_dct(M)

  N = size(M, 1);
  if (N != size(M, 2))
    error("M must be square");
  end

  Transform = zeros(N,N);

  for U = 0 : N - 1
    for V = 0 : N - 1
      Transform(U + 1, V + 1) = coefficient(U, V, M);
    end
  end

endfunction

function Coeff = coefficient(U, V, M)

  N = length(M);

  sum = 0;

  for X = 0 : N - 1
    for Y = 0 : N - 1
      sum = sum + M(X + 1 , Y + 1) * cos((2*X + 1) * U * pi / (2*N)) \
	  * cos((2*Y + 1) * V * pi / (2*N));
    end
  end

  if (U == 0 && V == 0)
    C = 1/2;
  elseif (U == 0 || V == 0)
    C = 1/sqrt(2);
  else 
    C = 1;
  end

  Coeff = 2 * C * sum / N;
endfunction