% Assignment 1
% David Fries 115940, Jonas Linﬂ 115899, Maximilian Margraf 115692
%
%

function main
    clear all;
    close all;
    %open images
    A = imread('11.jpg');
   
    %C = imread('Unbenannt.png');
    
    %display image
    figure;
    imshow(A);
    [x,y] = ginput(4);
    %homo function
  
    B = imread('12.jpg');
    figure;
    imshow(B);
    [xt,yt] = ginput(4);
   
    H = homo(x,y,xt,yt);
    i=geokor(H,A,B);
    imshow(i);
    
    figure;
    imshow(i);
    [x,y] = ginput(4);
    
    C = imread('13.jpg');
    figure;
    imshow(C);
    [xt,yt] = ginput(4);
   
    H = homo(x,y,xt,yt);
    i=geokor(H,i,C);
    imshow(i)
end

function H = homo (x,y,xt,yt)
    %points from slides for testing
    x1 = [x(1),y(1),1]';
    x2 = [x(2),y(2),1]';
    x3 = [x(3),y(3),1]';
    x4 = [x(4),y(4),1]';
    x1t = [xt(1),yt(1),1]';
    x2t = [xt(2),yt(2),1]';
    x3t = [xt(3),yt(3),1]';
    x4t = [xt(4),yt(4),1]';
    
    %calculation of center
    t = [(x1(1)+x2(1)+x3(1)+x4(1))/4;(x1(2)+x2(2)+x3(2)+x4(2))/4;1] 
    tt = [(x1t(1)+x2t(1)+x3t(1)+x4t(1))/4;(x1t(2)+x2t(2)+x3t(2)+x4t(2))/4;1] 
    %translation to center
    x1c = x1-t;
    x2c = x2-t;
    x3c = x3-t;
    x4c = x4-t;
    %second value set
    x1tc = x1t-tt;
    x2tc = x2t-tt;
    x3tc = x3t-tt;
    x4tc = x4t-tt;
    %calculation of scale by absolute values of centered points 
    s = (abs(x1c) + abs(x2c)+ abs(x3c) + abs(x4c))/4;
    st = (abs(x1tc) + abs(x2tc)+ abs(x3tc) + abs(x4tc))/4;
   
    
    %transformation matrices
    T = [1/s(1), 0, -t(1)/s(1); 0, 1/s(2) ,-t(2)/s(2); 0, 0, 1];
    Tt = [1/st(1), 0 , -tt(1)/st(1); 0, 1/st(2) ,-tt(2)/st(2); 0, 0, 1];
    
    %transformed values
    
    x_1 = T*x1;
    x_2 = T*x2;
    x_3 = T*x3;
    x_4 = T*x4;
    x_1t = Tt*x1t;
    x_2t = Tt*x2t;
    x_3t = Tt*x3t;
    x_4t = Tt*x4t;
    null = [0,0,0]';
    
    %construction of design matrix
    A1 = [-x_1t(3)*x_1',null',x_1t(1)*x_1'; null', -x_1t(3)*x_1',x_1t(2)*x_1'];
    A2 = [-x_2t(3)*x_2',null',x_2t(1)*x_2'; null', -x_2t(3)*x_2',x_2t(2)*x_2'];
    A3 = [-x_3t(3)*x_3',null',x_3t(1)*x_3'; null', -x_3t(3)*x_3',x_3t(2)*x_3'];
    A4 = [-x_4t(3)*x_4',null',x_4t(1)*x_4'; null', -x_4t(3)*x_4',x_4t(2)*x_4'];
    A5 = [null', null' , null'];
    A =  [-x_1t(3)*x_1',null',x_1t(1)*x_1'; null', -x_1t(3)*x_1',x_1t(2)*x_1';-x_2t(3)*x_2',null',x_2t(1)*x_2'; null', -x_2t(3)*x_2',x_2t(2)*x_2';-x_3t(3)*x_3',null',x_3t(1)*x_3'; null', -x_3t(3)*x_3',x_3t(2)*x_3';-x_4t(3)*x_4',null',x_4t(1)*x_4'; null', -x_4t(3)*x_4',x_4t(2)*x_4';null', null' , null'];
    %singular value decomposition
    [U,D,V] = svd(A);
    
    %matrix of smallest singular value
    H_1=[V(1,9),V(2,9),V(3,9);V(4,9),V(5,9),V(6,9);V(7,9),V(8,9),V(9,9)];
    
    %reverse conditioning
    H = inv(Tt)*H_1*T;
    H = H/H(3,3)
  
end