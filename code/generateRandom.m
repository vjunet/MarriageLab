function [ mat ] = generateRandom( n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:n
    mat(i,:) = randperm(n,n);

end

