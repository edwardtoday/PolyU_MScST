/*
 * OpenGL writing pixels: a rainbow of colors
 * Originally written by: W B Langdon at MUN 10 May 2007
 * Program to demonstarte use of OpenGL's glDrawPixels
 */


#include <GL/gl.h>
#include <GL/glext.h>
#include <GL/glut.h>

#include <iostream>
#include <sstream>
#include "math.h"


unsigned int window_width = 512, window_height = 512;

const int size=window_width*window_height;

struct rgbf {float r; float g; float b;};

//WBL 9 May 2007 Based on
//http://www.codeguru.com/cpp/w-d/dislog/commondialogs/article.php/c1861/
//Common.h

void toRGBf(const float h, const float s, const float v,
	    rgbf* rgb)
{
double min,max,delta,hue;
	
	max = v;
	delta = max * s;
	min = max - delta;

	hue = h;
	if(h > 300 || h <= 60)
	{
		rgb->r = max;
		if(h > 300)
		{
			rgb->g = min;
			hue = (hue - 360.0)/60.0;
			rgb->b = ((hue * delta - min) * -1);
		}
		else
		{
			rgb->b = min;
			hue = hue / 60.0;
			rgb->g = (hue * delta + min);
		}
	}
	else
	if(h > 60 && h < 180)
	{
		rgb->g = max;
		if(h < 120)
		{
			rgb->b = min;
			hue = (hue/60.0 - 2.0 ) * delta;
			rgb->r = min - hue;
		}
		else
		{
			rgb->r = min;
			hue = (hue/60 - 2.0) * delta;
			rgb->b = (min + hue);
		}
	}
	else
	{
		rgb->b = max;
		if(h < 240)
		{
			rgb->r = min;
			hue = (hue/60.0 - 4.0 ) * delta;
			rgb->g = (min - hue);
		}
		else
		{
			rgb->g = min;
			hue = (hue/60 - 4.0) * delta;
			rgb->r = (min + hue);
		}
	}
}


//Convert a wide range of data values into nice colours 

void colour(const float data, float* out)        // convert data to angle
{
  const float a = atan2(data,1)/(2*atan2(1,1));  // -1 .. +1
  const float angle = (1+a)*180;                 // red=0 at -1,+1

  const float saturation = 1;

  const float h = (data<-1||data>1)? 1 : fabs(data);

  toRGBf(angle,saturation,h,(rgbf*)out);
}


void display()                                  // Create some nice colours
                                                // (3 floats per pixel)
                                                // from data -10..+10
{

  float* pixels = new float[size*3];

  for(int i=0;i<size;i++)
  {
    colour(10.0-((i*20.0)/size),&pixels[i*3]);
  } 

  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

  //glDrawPixels writes a block of pixels to the framebuffer.

  glDrawPixels(window_width,window_height,GL_RGB,GL_FLOAT,pixels);

  glutSwapBuffers();
}

int main(int argc, char** argv)
{
  glutInit(&argc, argv);

  glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
  glutInitWindowSize(window_width, window_height);
  glutCreateWindow("OpenGL glDrawPixels demo");
  glutDisplayFunc(display);

  // glutReshapeFunc(reshape);
  // glutMouseFunc(mouse_button);
  // glutMotionFunc(mouse_motion);
  // glutKeyboardFunc(keyboard);
  // glutIdleFunc(idle);
  
  glEnable(GL_DEPTH_TEST);
  glClearColor(0.0, 0.0, 0.0, 1.0);

  // glPointSize(2);

  glutMainLoop();
}


