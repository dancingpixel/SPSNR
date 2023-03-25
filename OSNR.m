function im = OSNR(im, NMF0, NME0)
	
    % Vertical Noise Removal
    im = stripeRemovalOSNR(im, NMF0, NME0);
      
    % Horizontal Noise Removal
    im      = imrotate(im,90) ;
    im      = stripeRemovalOSNR(im, NMF0, NME0);
    im      = imrotate(im,-90) ;
