function vprintf(varargin)
% VPRINTF controlled printing
% 
global verbosity
if verbosity~=0 
    fprintf(varargin{:});
end

