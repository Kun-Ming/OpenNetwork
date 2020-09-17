function simulation(obj, time_now)   
    % feedforwardLayer simulation
    keOutDegree = sum(1 : 1 : obj.ke-2) * 4 + (obj.ke - 1) * 4; % a diamond shape of projection range    
    kiOutDegree = sum(1 : 1 : obj.ki-2) * 4 + (obj.ki - 1) * 4;
    for i = 1 : obj.total_neurons
        for j = 1 : max(size(obj.syn_in_layer{i}))
            obj.syn_in_layer{i}{j}.simulation(time_now, keOutDegree, kiOutDegree);
        end
    end
end












