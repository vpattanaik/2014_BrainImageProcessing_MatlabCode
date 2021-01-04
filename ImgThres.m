function imgTrs = ImgThres( imgR,Trs )

imgTrs = imgR > Trs;

imgTrs = bwareaopen(imgTrs,230);

end

