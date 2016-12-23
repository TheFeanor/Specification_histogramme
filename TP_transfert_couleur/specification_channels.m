function w = specification_channels(u,v)

    w = zeros(512, 512, 3);
  for i = 1:3
    uch = u(:,:,i);
    vch = v(:,:,i);

    [u_sort,index_u]  = sort(uch(:)); 
    [v_sort,index_v]  = sort(vch(:)); % use 'gsort' instead of sort with Scilab
    w_temp(index_u) = v_sort;
    w(:,:,i) = reshape(w_temp,[512 512]);  % use 'matrix' instead of 'reshape' with Scilab
    
  end
end