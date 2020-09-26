classdef BaseLayer < handle 
    properties
        % parameter
        total_neurons
        dim
        N_neurons_in_dim
        
        % data
        synapse     % type: containers.Map
    end
    
    methods
        function obj = BaseLayer(N_neurons_in_dim)            
            obj.total_neurons = prod(N_neurons_in_dim);
            obj.dim = length(N_neurons_in_dim);
            obj.N_neurons_in_dim = N_neurons_in_dim;    
            obj.synapse = containers.Map;
        end
    end
    
    methods(Abstract)
        generate_synapse(obj, syn_param);     
    end
end