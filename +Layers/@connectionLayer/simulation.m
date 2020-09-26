function simulation(obj, time_now)   
    % connectionLayer simulation
    keOutDegree = sum(1 : 2 : obj.exc_out*2-1)*2 + obj.exc_out*2; % a diamond shape of projection range    
    kiOutDegree = sum(1 : 2 : obj.inh_out*2-1)*2 + obj.inh_out*2;
    
    for i = 1 : max(size(obj.syn_in_layer))
        for j = 1 : max(size(obj.syn_in_layer{i}))
            obj.syn_in_layer{i}{j}.simulation(time_now, keOutDegree, kiOutDegree);
        end
    end
end












