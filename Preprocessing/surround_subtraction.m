% Fatemeh Razavipour, July 2019

function [ D_ASL_vol ] = surround_subtraction( ASL_vol )

    ASL_T=ASL_vol(:,:,:,1:2:end); % TAG
    ASL_C=ASL_vol(:,:,:,2:2:end); % Control
    t=size(ASL_C,4);
    vol_t(:,:,:,1)=ASL_C(:,:,:,1)-ASL_T(:,:,:,1);
    c=2;
    for i=1:1:t-1

       vol_t(:,:,:,c)=(ASL_C(:,:,:,i)+ASL_C(:,:,:,i+1))./2-ASL_T(:,:,:,i);
        c=c+1;
    end

    D_ASL_vol=(vol_t(:,:,:,1:end));

end
