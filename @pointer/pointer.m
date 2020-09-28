classdef pointer < handle
    properties
        x
    end
    methods
        function obj = pointer(x)
            if nargin>0
                obj.x = x;
            end
        end
    end
end