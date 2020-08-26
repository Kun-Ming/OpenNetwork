classdef BaseLayer < handle
    properties
        total_neurons
        dim
        N_neurons_in_dim
    end
    
    methods
        function obj = BaseLayer(N_neurons_in_dim)
            
            obj.total_neurons = sum(N_neurons_in_dim);
            obj.dim = len(N_neurons_in_dim);
            obj.N_neurons_in_dim = N_neurons_in_dim;
            
        end
    end
end