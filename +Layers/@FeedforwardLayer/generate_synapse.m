function [syn_in_layer] = generate_synapse(obj, conn_strength, speed)
    % parameters   :
    % conn_strength: 2*2 matrix, contain 2 connecting strength of each synapse.
    %                    exc | inh
    %               fast  *    *
    %               slow  *    *
    %                 
    % speed : 3*2 matrix: 
    %        decay | rise
    %       E  *       *
    %       I  *       *
    %       X  *       *
    %                 
    % ke           : radius of exc projection range.
    % ki           : radius of inh projection range.
    
    keOutDegree = sum(1 : 1 : obj.ke-2) * 4 + (obj.ke - 1) * 4; % a diamond shape projection shape
%     temp_exc(keOutDegree).ei_type = 'exc';   % exc or inh type
%     temp_exc(keOutDegree).taur = 1;  % fast or slow type
%     temp_exc(keOutDegree).J = conn_strength(1, 1);
    
    kiOutDegree = sum(1 : 1 : obj.ki-2) * 4 + (obj.ki - 1) * 4;
%     temp_inh(kiOutDegree).ei_type = 'inh';   % exc or inh type
%     temp_inh(kiOutDegree).taud = 1;  % fast or slow type
%     temp_inh(kiOutDegree).J = conn_strength(1, 1);
    
    for i = 1 : obj.total_neurons   % generate synapse from ith neuron to other nerurons
        if rand < obj.N_exc_neuron / total_neurons      % presynaptic neuron: exc neuron
            postsyn_IDs = get_projection_field(presyn_ID, obj.ke, size(obj.neuron_in_layer));
            [temp_exc(:).ID] = postsyn_IDs{:};
            [temp_exc(:).ei_type] = 'exc';
            [temp_exc(:).taur] = deal(speed(1, 2));
            [temp_exc(:).taud] = deal(speed(1, 1));
            
            obj.syn_in_layer(i) = temp_exc;
        else                                            % presynaptic neuron: inh neuron
            postsyn_IDs = get_projection_field(presyn_ID, obj.ki, size(obj.neuron_in_layer));
            [temp_inh(:).ID] = postsyn_IDs{:};
            [temp_exc(:).ei_type] = 'inh';
            [temp_inh(:).taur] = deal(speed(1, 2));
            [temp_inh(:).taud] = deal(speed(1, 1));
            
            obj.syn_in_layer(i) = temp_inh;
        end
    end
end

function [postsyn_IDs] = get_projection_field(presyn_ID, k, layer_size)
%   return a cell array
    [presyn_pos.x, presyn_pos.y] = ind2sub(layer_size, presyn_ID);
    mask = strel('diamond', k).Neighborhood;
    % 判断mask中为1的sub，再带入到neuron_layer中
    postsyn_IDs = 
end



















