function output = split_data( input, window_length, window_overlay )
%SPLIT_DATA Function to split data into windows

% Buffer to store the signal information
buffer = [];
output = [];

for i=1:length(input)
    % if buffer reached the length of the window
    if ( length(buffer) >= window_length )
        % store the buffer to output signal
        output = [ output; buffer ]; %#ok<AGROW>
        % Do the overlay step
        if ( window_overlay ~= 0 )
            buffer = buffer(window_overlay:end);
        end
    else
        % otherwise, populare the buffer with new entry
        buffer = [ buffer input(i) ]; %#ok<AGROW>
    end 
end

end