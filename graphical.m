
%%Phase1: Taking Input
C = [3 5];
A = [1 2; 1 1; 0 1];
b = [2000; 1500; 600];


%%Phase2: Plotting Graph
y1 = 0:1:max(b);

x21 = (b(1) - (A(1,1).*y1))/A(1,2);
x22 = (b(2) - (A(2,1).*y1))/A(2,2);
x23 = (b(3) - (A(3,1).*y1))/A(3,2);

x21 = max(0, x21);
x22 = max(0, x22);
x23 = max(0, x23);

plot(y1, x21, 'r', y1, x22, 'g', y1, x23, 'b');


%%Phase3: Corner Points
cx1 = find(y1==0);

c1 = find(x21==0);
Line1 = [y1(:, [c1 cx1]) ; x21(:, [c1 cx1])]';

c2 = find(x22==0);
Line2 = [y1(:, [c2 cx1]) ; x22(:, [c2 cx1])]';

c3 = find(x23==0);
Line3 = [y1(:, [c3 cx1]) ; x23(:, [c3 cx1])]';

corps = unique([Line1; Line2; Line3], 'rows');


%%Phase4: Intersection Points
HG = [0; 0];

for i=1:3
    hg1 = A(i, :);
    b1 = b(i, :);

    for j=i+1:3
        hg2 = A(j, :);
        b2 = b(j, :);

        Aa = [hg1; hg2];
        Bb = [b1; b2];
        Xx = Aa \ Bb;
        HG = [HG Xx];
    end
end

pt = HG';

%%Phase5: Final Corner Points
allpt = [corps; pt];
points = unique(allpt, 'rows');


%%Phase6: Feasible Region
PT = constraint(points);
PT = unique(PT, 'rows');


%%Phase7: Calculate Function Value

for i=1:size(PT, 1)
    Fx(i, :) = sum(PT(i, :).*C);
end

Vert = [PT Fx];


%%Phase8: Optimal Value

[fxVal, index] = max(Fx);
optval = Vert(index, :);

ANS = array2table(optval);



function hh = constraint(X)

x1 = X(:, 1);
x2 = X(:, 2);

cons1 = x1+2.*x2-2000;

h1 = find(cons1 > 0);

X(h1, :) = [];


x1 = X(:, 1);
x2 = X(:, 2);

cons2 = x1 + x2 -  1500;
h2 = find(cons2>0);

X(h2, :) = [];

x1 = X(:, 1);
x2 = X(:, 2);

cons3 = x2 -  600;
h3 = find(cons3>0);

X(h3, :) = [];


hh = X;
end

