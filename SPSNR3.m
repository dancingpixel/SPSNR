function im = SPSNR3(im, NMF0, NME0)
	
    % Vertical Noise Removal
    im = stripeRemovalSPSNR3(im, NMF0, NME0);
      
    % Horizontal Noise Removal
    im      = imrotate(im,90) ;
    im      = stripeRemovalSPSNR3(im, NMF0, NME0);
    im      = imrotate(im,-90) ;
