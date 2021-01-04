function imgTrs = ImgSkel( imgTrs )

imgTrs = bwmorph(imgTrs,'skel',Inf);

end