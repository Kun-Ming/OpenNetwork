classdef FeedforwardLayer < BaseLayer
    properties
        N_exc_neuron
        N_inh_neuron
        syn_type    % probability of each syn type
        neuron_layer    % neuron's distribution in this layer, a 1d/2d/3d matrix of neuron object.
    end
    
    methods
        function obj = FeedforwardLayer(N_neurons_in_dim, N_exc_neuron, N_inh_neuron, syn_type)
            
            obj = obj@BaseLayer(N_neurons_in_dim);
            
            obj.N_exc_neuron = N_exc_neuron;
            obj.N_inh_neuron = N_inh_neuron;
            obj.syn_type = syn_type;
           
        end
        
        function construct(obj)
            
            obj.neuron_layer = zeros(N_neurons_in_dim);
            obj.neuron_layer(1) = EIFneurons();
            
        end
        
        
        
    end
end