function c = hybrid(fun, DL, tol)
fprintf('Func-count    x          f(x)             Procedure\n');
a = DL(1);
b = DL(2);
iter = 1;
solved = 0;
while solved == 0
    if(iter >= 100)
        fprintf ('Root not found after 100 iterations.');
        c = 0;
        return;
    end
    %Secant Method
    c = a - feval(fun,a) * (a - b) / (feval(fun,a)-feval(fun,b));
    sc = feval(fun, c);
    %Bisectional Method
    bc = feval(fun,(a+b)/2);
    %Compare
    if (abs(sc) > abs(bc))
        c = (a+b)/2;
        if(bc <= 0)
            a = c;
        else
            b = c;
        end
        fprintf('  %3i        %2.4f     %4.8e        bisection\n',iter+1,c,bc);
    else
        if(abs(a - c) < abs(b - c))
            b = c;
        else
            a = c;
        end
        fprintf('  %3i        %2.4f     %4.8e        secant\n',iter+1,c,sc);
        if(a > b)
            c = b;
            b = a;
            a = c;
        end
    end
    iter = iter+1;
    if(abs(bc) < tol | abs(sc) < tol)
        solved = 1;
    end
end
end
    