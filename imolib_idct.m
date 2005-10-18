## usage imolib_dct(M)

function M = imolib_idct(Transform)

  N = size(Transform, 1);
  if (N != size(Transform, 2))
    error("Transform must be square");
  end

  M = zeros(N,N);

  for X = 0 : N - 1
    for Y = 0 : N - 1
      M(X + 1, Y + 1) = value(X, Y, Transform);
    end
  end

endfunction

function Val = value(X, Y, Transform)

  N = length(Transform);

  sum = 0;

  for U = 0 : N - 1

    if (U == 0)
      Cu = 1 / sqrt(2);
    else
      Cu = 1;
    end

    for V = 0 : N - 1
      
      if (V == 0)
	Cv = 1 / sqrt(2);
      else
	Cv = 1;
      end
      
      sum = sum + Cu * Cv * Transform(U + 1, V + 1) \
	  * cos((2*X + 1) * U * pi/(2*N)) \
	  * cos((2*Y + 1) * V * pi/(2*N));
    end
  end

  Val = 2 * sum / N;
endfunction