classdef base_synapse < handle
    properties
        presynID
        postsyn     % struct array
    end
    
    methods
        function obj = base_synapse(N_postsyn)
            obj.presynID = containers.Map;
            obj.postsyn  = zeros(N_postsyn, 1);
        end
    end
end