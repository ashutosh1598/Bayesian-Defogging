function Value = albedo_prior_grad(albedo, power, scale)
    
    color_sum = sum(sum(sum(repmat(albedo,1,1,3),3)));
    chromaticity = (color_sum>1e-8).*albedo./color_sum;
    [P, Q, R, S] = grid_diff(chromaticity);
    X(1,1,:)=power;
    Y(1,1,:)=scale;
    X=repmat(X,size(P,1),size(P,2),1);
    Y=repmat(Y,size(P,1),size(P,2),1);
    A = sign(P).*X.*(abs(P).^(X-1))./Y;
    A(isnan(A)) = 0;
    A= (P>1e-8).*A;
    C = sign(R).*X.*(abs(R).^(X-1))./Y;
    C(isnan(C)) = 0;
    C= (R>1e-8).*C;
    X1(1,1,:)=power;
    Y1(1,1,:)=scale;
    X=repmat(X1,size(Q,1),size(Q,2),1);
    Y=repmat(Y1,size(Q,1),size(Q,2),1);
    B = sign(Q).*X.*(abs(Q).^(X-1))./Y;
    B(isnan(B)) = 0;
    B= (Q>1e-8).*B;
    D = sign(S).*X.*(abs(S).^(X-1))./Y;
    D(isnan(D)) = 0;
    D= (S>1e-8).*D;
    Value = make_grad(A, B, C, D, albedo);
end