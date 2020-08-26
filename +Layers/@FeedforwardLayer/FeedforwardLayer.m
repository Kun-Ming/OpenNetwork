classdef FeedforwardLayer < Layers.BaseLayer
    properties
        N_exc_neuron
        N_inh_neuron
        syn_type    % precentage of each syn type
        neuron_layer    % neuron's distribution in this layer, a 1d/2d/3d matrix of neuron object.
    end
    
    methods
        function obj = FeedforwardLayer(N_neurons_in_dim, N_exc_neuron, N_inh_neuron, syn_type)
            assert(isequal(N_exc_neuron + N_inh_neuron, sum(N_neurons_in_dim)), ...
                "constructing FeedforwardLayer error: N_exc_neuron + N_inh_neuron != N_neurons_in_dim");
            
            obj = obj@Layers.BaseLayer(N_neurons_in_dim);
            
            obj.N_exc_neuron = N_exc_neuron;
            obj.N_inh_neuron = N_inh_neuron;
            obj.syn_type = syn_type;
            obj.neuron_layer = repmat(allNeurons.EIFneurons(), obj.N_neurons_in_dim);
            
        end
        
        [all_syn_layer] = generate_syn(conn_strength, type, speed);
    end
end