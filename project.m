clc
clear all
close all
warning off
%a=imread('testimage.png');
a=uigetfile({'*.png';'*.jpg'},'File Selector');
% subplot(2,2,1);
% imshow(a);

%x=imread('SECRET.png');
x=uigetfile({'*.png';'*.jpg'},'File Selector');
% subplot(2,2,2);
% imshow(x);
%image2 = imresize(image2, size(image1));
%[r c g]=size(a);
%x=imresize(x,[r c]);
x=imresize(x,size(a));
ra=a(:,:,1);
ga=a(:,:,2);
ba=a(:,:,3);
rx=x(:,:,1);
gx=x(:,:,2);
bx=x(:,:,3);
for i=1:r
    for j=1:c
       nc(i,j)= bitand(ra(i,j),254);
       ns(i,j)= bitand(rx(i,j),128);
       ds(i,j)=ns(i,j)/128;
       fr(i,j)=nc(i,j)+ds(i,j);
    end
end
redsteg=fr;
for i=1:r
    for j=1:c
       nc(i,j)= bitand(ga(i,j),254);
       ns(i,j)= bitand(gx(i,j),128);
       ds(i,j)=ns(i,j)/128;
       fr(i,j)=nc(i,j)+ds(i,j);
    end
end
greensteg=fr;
for i=1:r
    for j=1:c
       nc(i,j)= bitand(ba(i,j),254);
       ns(i,j)= bitand(bx(i,j),128);
       ds(i,j)=ns(i,j)/128;
       fr(i,j)=nc(i,j)+ds(i,j);
    end
end
bluesteg=fr;
finalsteg=cat(3,redsteg,greensteg,bluesteg);
redstegr=finalsteg(:,:,1);
greenstegr=finalsteg(:,:,2);
bluestegr=finalsteg(:,:,3);
% subplot(2,2,3);
% imshow(finalsteg);
title('Stegmented Image');
for i=1:r
    for j=1:c
        nc(i,j)=bitand(redstegr(i,j),1);
        ms(i,j)=nc(i,j)*128;
    end
end
recoveredr=ms;
for i=1:r
    for j=1:c
        nc(i,j)=bitand(greenstegr(i,j),1);
        ms(i,j)=nc(i,j)*128;
    end
end
recoveredg=ms;
for i=1:r
    for j=1:c
        nc(i,j)=bitand(bluestegr(i,j),1);
        ms(i,j)=nc(i,j)*128;
    end
end
recoveredb=ms;
output=cat(3,recoveredr,recoveredg,recoveredb);
title('Carrier Image');
subplot(2,2,1);
imshow(a);
title('Secret Image');
subplot(2,2,2);
imshow(x);
subplot(2,2,3);
imshow(finalsteg);



subplot(2,2,4);
imshow(output);
title('Recovered Image');
