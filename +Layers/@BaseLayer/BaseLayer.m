classdef BaseLayer < handle
    properties
        total_neurons
        dim
        N_neurons_in_dim
    end
    
    methods
        function obj = BaseLayer(total_neurons, dim, N_neurons_in_dim)
            obj.total_neurons = total_neurons;
            obj.dim = dim;
            obj.N_neurons_in_dim = N_neurons_in_dim;
        end
    end
end