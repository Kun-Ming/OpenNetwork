function simulation(obj, time_now)   
    % feedforwardLayer simulation
    keOutDegree = sum(1 : 2 : obj.ke*2-1)*2 + obj.ke*2; % a diamond shape of projection range    
    kiOutDegree = sum(1 : 2 : obj.ki*2-1)*2 + obj.ki*2;
    
    for i = 1 : obj.total_neurons
        for j = 1 : max(size(obj.syn_in_layer{i}))
            obj.syn_in_layer{i}{j}.simulation(time_now, keOutDegree, kiOutDegree);
        end
    end
end












