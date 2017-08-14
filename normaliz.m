%************************************************************************%
%            Normalization dataset function                              %
%************************************************************************%
function norm_dataset= normaliz(dataset,method)

switch method
    case 'avg'          %metodo de normalizacion por promedio
        for i=1:size(dataset,2)
        norm_dataset(:,i)=dataset(:,i)./sum(dataset')'
        end
        
    case 'maxmin'           %Metodo de normalizacion tomando como referencia el maximo y minimo dato
        for i=1:size(dataset,2)
            if(max(dataset(:,i))-min(dataset(:,i))==0)
                norm_dataset(:,i)=1;
            else
        norm_dataset(:,i)=(dataset(:,i)-min(dataset(:,i)))/(max(dataset(:,i))-min(dataset(:,i)));
            end
        end
    case 'ann-maxmin'           %Metodo de normalizacion tomando como referencia el maximo y minimo dato
        for i=1:size(dataset,2)
        norm_dataset(:,i)=(0.8*(dataset(:,i)-min(dataset(:,i)))/(max(dataset(:,i))-min(dataset(:,i))))+0.1;
        end
    case 'bi-maxmin'        %metodo de normalizacion escalizando entre -1 y 1
        for i=1:size(dataset,2)
        norm_dataset1(:,i)=(dataset(:,i)-min(dataset(:,i)))/(max(dataset(:,i))-min(dataset(:,i)));
        end
        norm_dataset=norm_dataset1.*(1-(-1))+(-1);      %para escalar datos entre 1 y -1
    case 'ann-bi-maxmin'        %metodo de normalizacion escalizando entre -1 y 1
        for i=1:size(dataset,2)
        norm_dataset(:,i)=(1.8*(dataset(:,i)-min(dataset(:,i)))/(max(dataset(:,i))-min(dataset(:,i))))-0.9;
        end
end