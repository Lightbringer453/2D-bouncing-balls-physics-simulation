#include "Image.h"
#include "math.h"

int main() {
	
	ColorImage im(512,512);
	im.Clear();

	ColorImage im2(256,256);
	
	//SaveHist(im, "color.png");
	
	for(int x=0; x<256; x++)
		for(int y=0; y<256; y++)
			im2(x,y) = im(x*2, y*2);

	im2.Save("small.png");

	for(int x=0;x<im.GetWidth()/2;x++) {
		for(int y=0; y<im.GetHeight(); y++) {
			im(x,y).b=0;
		}
	}
	
	im.Save("test.png");
	
	/*GrayscaleImage img;
	img.Load("read.png");
	
	SaveHist(img, "before.png");
	
	for(int x=0;x<img.GetWidth()/2;x++) {
		for(int y=0; y<img.GetHeight(); y++) {
			img(x,y)=(pow(img(x,y)/255.f,0.8f))*255;
		}
	}
	
	SaveHist(img, "after.png");
	
	img.Save("test2.png");*/
	
	return 0;
}
