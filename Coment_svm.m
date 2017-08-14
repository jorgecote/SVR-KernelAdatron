%************************************************************************%
%                   SVM entrenado por algoritmo Kernel-Adatron           %
%                       M�quina de vectores de soporte para regresi�n    %
%       Argumentos:                                                      %
%           * norm_dataset    : Conjunto de datos entrenamiento          %
%           * norm_dataset_val: Conjunto de datos de validaci�n          %
%           * iter       : Cantidad m�xima de iteraciones                %
%           * eps        : Desviaci�n m�xima permitida en la SVM         %
%           * C          : T�rmino de penalizaci�n para datos desviados de
%                           la SVM                                       %
%           * type       : Tipo de kernel a utilizar                     %
%           * sigma      : Ancho del kernel gaussiano                    %
%           * p          : Grado de polinomio en kernel polin�mico       %
%                                                                        %
%************************************************************************%                       


function [norm_dataset fx fx_val etotal e etotal_val]=svm(norm_dataset,norm_dataset_val,iter,eps,C,type,sigma,p)
%Tama�o del conjunto de datos
datasetsize=size(norm_dataset);
output=norm_dataset(:,size(norm_dataset,2));
output_val=norm_dataset_val(:,end);
%Normalizaci�n de conjunto de datos
norm_dataset=normaliz(norm_dataset,'maxmin');
norm_dataset_val=normaliz(norm_dataset_val,'maxmin');
%N�mero de muestras
Q=datasetsize(1);
input=norm_dataset(:,1:size(norm_dataset,2)-1);
normal_val=norm_dataset_val(:,1:end-1);
datos=Q;
 n=1;
 etotal=1;
%Inicializaci�n d epar�metros
alpha=zeros(datos,1);
alpha_ast=zeros(datos,1);
eta=zeros(1,datos);
b=0;
i=0;
j=0;

%Funci�n auxiliar para calcular kernel
k=kernel(input,input,type,sigma,p);
k_val=kernel(input,normal_val,type,sigma,2);
%Calcular n (eta) tasa de aprendizaje
if(strcmp(type,'Polynomic'))
    for j=1:datos
    eta(j)=(1./(norm(input(j,:))^2+1)^2);
   
    end
elseif(strcmp(type,'Gaussian'))
    for j=1:datos
    eta(j)=1/k;      
    end
else
    for j=1:datos
    eta(j)=0.001;
    end
end
%Algoritmo Kernel Adatron
while(etotal(n)>0.00001)
  
%Calculo delta_alpha and delta_alpha_ast
delta_alpha=eta'.*(-((alpha-alpha_ast)'*k)'+output-eps-b);

%Actualizaci�n de alpha
for i=1:datos
if(alpha(i)+delta_alpha(i)<0)
    alpha(i)=0;
end
if((alpha(i)+delta_alpha(i)>=0)&&(alpha(i)+delta_alpha(i)<=C))
    alpha(i)=alpha(i)+delta_alpha(i);
end
if(alpha(i)+delta_alpha(i)>C)
   alpha(i)=C;
end
end

delta_alpha_ast=eta'.*(((alpha-alpha_ast)'*k)'-output-eps+b);
%Actualizaci�n de alpha_ast
for i=1:datos
if(alpha_ast(i)+delta_alpha_ast(i)<0)
    alpha_ast(i)=0;
end
if((alpha_ast(i)+delta_alpha_ast(i)>=0)&&(alpha_ast(i)+delta_alpha_ast(i)<=C))
    alpha_ast(i)=alpha_ast(i)+delta_alpha_ast(i);
end
if(alpha_ast(i)+delta_alpha_ast(i)>C)
   alpha_ast(i)=C;
end
end
% C�lculo de t�rmino de Bias
b=b+sum(delta_alpha-delta_alpha_ast);
n=n+1;
%Salida de aprendizaje SVM
fx=((alpha-alpha_ast)'*k)'+b;
%Salida de validaci�n de SVM
fx_val=((alpha-alpha_ast)'*k_val)'+b;
%Error MSE de validaci�n
etotal_val(n)=(1/size(norm_dataset_val,1))*sum((output_val-fx_val).^2);
%Error MSE de aprendizaje
etotal(n)=(1/Q)*sum((output-fx).^2);
etotal(n)
if(n==iter)
    etotal(n)=0;
end
end
e=(1/Q)*((output-fx).^2);


