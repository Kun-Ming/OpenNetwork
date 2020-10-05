function simulation(obj, time_now, pre_layer, post_layer)   
    % connectionLayer simulation
    keOutDegree = sum(1 : 2 : obj.exc_out*2-1)*2 + obj.exc_out*2; % a diamond shape of projection range    
    kiOutDegree = sum(1 : 2 : obj.inh_out*2-1)*2 + obj.inh_out*2;
    
    syn_in_layer = obj.syn_in_layer;
    parfor i = 1 : max(size(syn_in_layer))
        for j = 1 : max(size(syn_in_layer{i}))
            if ~isa(syn_in_layer{i}{j}.presyn_neuron, 'allNeurons.EIFneurons')
                syn_in_layer{i}{j}.presyn_neuron = pre_layer.neuron_in_layer(syn_in_layer{i}{j}.presyn_neuron);
                syn_in_layer{i}{j}.postsyn_neuron = post_layer.neuron_in_layer(syn_in_layer{i}{j}.postsyn_neuron);
            end
            
            assert(isa(syn_in_layer{i}{j}.presyn_neuron, 'allNeurons.EIFneurons'), 'WRONG NEURON IN SYNAPSE');
            assert(isa(syn_in_layer{i}{j}.postsyn_neuron, 'allNeurons.EIFneurons'), 'WRONG NEURON IN SYNAPSE');
            
            syn_in_layer{i}{j}.simulation(time_now, keOutDegree, kiOutDegree);
        end
    end
end












