%Assignment 1
%David Fries 115940, Jonas Linß 115899, Maximilian Margraf 115692
%Aufgabe I
%1
%
%2
%
%3
%

function main
    clear all;
    close all;
    
    % ' steht für transposed
    %Kreuzprodukt 2er Punkte = Linie zwischen Punkten
    %Kreuzprodukt 2er Linien = Schnittpunkt
   
    %Aufgabe II 1a
    pointx = [2,3,1]';
    pointy = [-4,5,1]';
    linez = cross(pointx, pointy)
    
    a = 0;
    linex = [cosd(a), sind(a), -1]';
    liney = [0, 0, -1]';
    pointz = cross(linex, liney);
    
    %Aufgabe II b
    t = [6, -7, 1]';
    [m] = movePoint(pointx, t);
    [n] = movePoint(pointy, t);
    
    Rmat = [cosd(15), -sind(15), 0; sind(15), cosd(15), 0; 0, 0, 1];
    [m] = rotatePoint(m, Rmat);
    [n] = rotatePoint(n, Rmat);
    
    d = 8;
    [m] = scalePoint(m, d);
    [n] = scalePoint(n, d);
    m, n
    
    M = [1, 0, 6; 0, 1 ,-7; 0, 0, 1];
    [line] = moveLine(linez, M);
    [line] = rotateLine(line, Rmat);
    [line] = scaleLine(line, d)
    [m] = checkOnLine(m, line);
    H = ['M ', m];
    disp(H)
    
    [m] = checkOnLine(n, line);
    H = ['N ', m];
    disp(H)
end

function [move] = movePoint(vec, x)
    move = vec + x;
    return;
end

function [rotate] = rotatePoint(vec, X)
    rotate = X * vec;
    return;
end

function [scale] = scalePoint(vec, d)
    scale = d * vec;
    return;
end

function [move] = moveLine(vec, X)
    move = inv(X)';
    move = move * vec;
    return;
end

function [rotate] = rotateLine(vec, X)
    rotate = inv(X)';
    rotate = rotate * vec;
    return;
end

function [scale] = scaleLine(vec, d)
    SM = [d, 0, 0; 0, d, 0; 0, 0, 1];
    scale = inv(SM)';
    scale = scale * vec;
    return;
end

function [m] = checkOnLine(point, line)
    check = point' * line;
    if check == 0
        m= 'auf der Linie';
    else
        m= 'nicht auf der Linie';
    end
    return;
end

