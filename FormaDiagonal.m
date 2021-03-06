%   Descripcion: Se busca hallar la Forma diagonal de una matriz de 2x2
%   dimensiones por medio de transformacion de similitud (P).
%   Autor: Roldan Federico
%   Version: v1.0

function [Az, Bz, Cz] = FormaDiagonal(A, B, C)
    I = [1 0; 0 1];
%Hallamos el valor absoluto de la matriz A 
    Ad = -(A)';

%Obtenemos los autovalores
    s1 = Ad(1,1);
    s2 = Ad(2,2);
    s3 = Ad(2,1);
    s4 = Ad(1,2);
    a = 1;
    b = (s1+s2);
    c = ((s1*s2)-(s3*s4));
    mostrar = ['F(s)= ', num2str(a), 's^2+(',num2str(b), 's)+(',num2str(c),')'];
    disp(mostrar);

    x1= (-b+sqrt(b^2-4*a*c))/(2*a);
    x2= (-b-sqrt(b^2-4*a*c))/(2*a);
    mostrar = ['Raices de la Funcion F(s): '];
    disp(mostrar);
    mostrar = ['                           s1 = ', num2str(x1)];
    disp(mostrar);
    mostrar = ['                           s2 = ', num2str(x2)];
    disp(mostrar);
%Obtenemos los autovectores
    Av1 = x1*I-A;
    Av2 = x2*I-A;
    
    v11 = Av1(1, 1); 
    v21 = Av1(1, 2);
    mostrar = ['Ecuacion V1 para despejar autovectores: (', num2str(v11), 'v11)+(',num2str(v21), 'v21)'];
    disp(mostrar);
  
    v12 = Av2(1, 1); 
    v22 = Av2(1, 2);  
    mostrar = ['Ecuacion V12 para despejar autovectores: (', num2str(v12), 'v12)+(',num2str(v22), 'v22)'];
    disp(mostrar);

    j = 0;

    result = 0;
    %Buscamos primero dandole un valor a v11
    while (result == 0) && (j <= 999) 
        j = j + 1;
        %Buscamos un valor de V11 que sea entero tanto con J positivo y
        %negativo
        temp = (j/v11);
        temp2 = (-j/v11);
       
        %Preguntamos si es un entero, si lo es devuelve un 0
      
        if (mod(temp,1) == 0) || (mod(temp2,1) == 0) 

        %Calculamos si remplazando los valores obtenidos la ecuacion cumple
        %la condicion de ser igual a 0
            verificar = (temp*v11)+(-(temp*v11)/v21)*v21;
            verificar2 = (temp2*v11)+(-(temp2*v11)/v21)*v21;    
        %Preguntamos si alguna de las dos verificaciones es 0
        if (verificar == 0)
             va11 = temp;
             va21 = ((temp*v11)/v21);
          
        elseif(verificar2 == 0)         
             va11 = temp2;
             va21 = ((temp2*v11)/v21);
    
        end
        if (mod(va11,1) == 0) && (mod(va21,1) == 0) 
            result = 1;
            j = 0;
            v11 = va11;
            v21 = va21;
            mostrar = ['Autovectores V1: v11 - ', num2str(v11), '   v21 - ',num2str(v21)];
            disp(mostrar);
        end
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    while (result == 1) && (j <= 999) 
        j = j + 1;
        temp = (j/v12);
        temp2 = (-j/v22);
       
        %Preguntamos si es un entero, si lo es devuelve un 0
      
        if (mod(temp,1) == 0) || (mod(temp2,1) == 0) 
 
        %Calculamos si remplazando los valores obtenidos la ecuacion cumple          
        %la condicion de ser igual a 0
            verificar = (temp*v12)+(-(temp*v12)/v22)*v22;
            verificar2 = (temp2*v12)+(-(temp2*v12)/v22)*v22;
        %Preguntamos si alguna de las dos verificaciones es 0
        if (verificar == 0)
             va12 = temp;
             va22 = ((temp*v12)/v22);

        elseif(verificar2 == 0)         
             va12 = temp2;
             va22 = ((temp2*v12)/v22);

        end
        if (mod(va12,1) == 0) && (mod(va22,1) == 0) 
            result = 0;
            v12 = va12;
            v22 = va22;
            mostrar = ['Autovectores V2: v12 - ', num2str(v12), '   v22 - ',num2str(v22)];
            disp(mostrar);
        end
        end
    end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 
  P = [v11 v12; v21 v22];
  %Hallamos las matrices necesarias para calcular las matrices Az Bz y Cz 
    Pinv = inv(P);
  %Mostramos los valores obtenidos
    disp('Matriz P:')
    disp(P);
    disp('Inversa de la Matriz P:')
    disp(Pinv);
  %Calculamos Az Bz Cz
    Az = (Pinv*A*P);
    Bz = Pinv*B;
    Cz = C*P;
   
end
