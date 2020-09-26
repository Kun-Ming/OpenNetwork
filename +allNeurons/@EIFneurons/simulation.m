function simulation(obj, input, time_now)
    
    if obj.ref_long < time_now - obj.ref_time
        obj.v = obj.v + (obj.dt / obj.tau_m) * ( (obj.v_leaky - obj.v) + ...
        obj.delta_t * exp((obj.v - obj.v_t)/obj.delta_t) + input );
    
        if obj.v > obj.v_th
            obj.spike_train(time_now) = true;
            obj.ref_time = time_now;
        end
    else
    end
    
end