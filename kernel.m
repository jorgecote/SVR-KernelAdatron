%**************************************************************%
%           Kernel Function    K(x1,x2)                        %
%               Arguments:                                     %
%                   * input : Dataset x1
%                   * input2: Dataset x2                       %
%                   * type  : Type of kernel                   %
%                   * S     : Gaussian function width          %
%                   * d     : polynomic order                  %
%**************************************************************%

function K=kernel(input,input2,type,S,d)
switch (type)
    case 'Gaussian'
       
for i=1:size(input,1)
    for j=1:size(input2,1)
        K(i,j) = exp(-norm(input(i,:)-input2(j,:))^2/(2*S^2));
       
    end
end
    case 'Linear'
        K=input*input2';
    case 'Polynomic'
        K=((input*input2')+1).^d;
         
end