function val = SSIM(im, ref)
    if size(im,3) == 3
        temp = permute(im,[1 3 2]);
        im = reshape(temp,[],size(im,2),1);
        
        temp = permute(ref,[1 3 2]);
        ref = reshape(temp,[],size(ref,2),1);
    end
        
        
    val = ssim(im,ref);
    