function simulation(obj, input, curr_t, dt, delta_t, v_t)
    
    if ~obj.state
        obj.v = obj.v + (dt / obj.tau_m) * ( (obj.v_leaky - obj.v) + ...
        delta_t * exp((obj.v - v_t)/delta_t) + input );
    
        if obj.v > obj.v_th
            obj.spike_train(curr_t) = true;
            obj.state = true;
        end
    end
    
end