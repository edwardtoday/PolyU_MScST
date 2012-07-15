#include <GL\gl.h> 
#include <GL\glu.h>
#include <GL\glut.h> 
#include <stdio.h> 


GLubyte rasters[24] = { 
/* 00 */	0xc0, 0x00,	/* 1100 0000 0000 0000 */
/* 01 */	0xc0, 0x00,	/* 1100 0000 0000 0000 */
/* 02 */	0xc0, 0x00,	/* 1100 0000 0000 0000 */
/* 03 */	0xc0, 0x00,	/* 1100 0000 0000 0000 */
/* 04 */	0xc0, 0x00,	/* 1100 0000 0000 0000 */
/* 05 */	0xff, 0x00,	/* 1111 1111 0000 0000 */
/* 06 */	0xff, 0x00,	/* 1111 1111 0000 0000 */

/* 07 */	0xc0, 0x00,	/* 1100 0000 0000 0000 */
/* 08 */	0xc0, 0x00,	/* 1100 0000 0000 0000 */
/* 09 */	0xc0, 0x00,	/* 1100 0000 0000 0000 */
/* 10 */	0xff, 0xc0,	/* 1111 1111 0000 0000 */
/* 11 */	0xff, 0xc0	/* 1111 1111 0000 0000 */
}; 

void myInit(void) 
{ 
	glPixelStorei(GL_UNPACK_ALIGNMENT, 1); 
	glClearColor(0.0, 0.0, 0.0, 0.0);
} 

void myDisplay(void) 
{ 

	GLfloat wData[33*3*33*3]; 
	glClear(GL_COLOR_BUFFER_BIT); 
	glColor3f (1.0, 1.0, 1.0); 

	glRasterPos2i (20.5, 20.5); 
	glBitmap (10, 12, 0.0, 0.0, 12.0, 0.0, rasters); 
	glBitmap (10, 12, 0.0, 0.0, 12.0, 0.0, rasters); 
	glBitmap (10, 12, 0.0, 0.0, 12.0, 0.0, rasters);

	glReadPixels (20,20,33,33, GL_RGB, GL_FLOAT, wData); 
	glRasterPos2i(120.5, 120.5); 
	glDrawPixels (33,33, GL_RGB, GL_FLOAT, wData);
	glRasterPos2i(250.5, 250.5);
	glCopyPixels (120, 120, 33, 33, GL_COLOR);  

	glFlush();

} 

void myReshape(int w, int h) 
{ 
	glViewport(0, 0, w, h); 
	glMatrixMode(GL_PROJECTION); 
	glLoadIdentity(); 
	glOrtho (0, w, 0, h, -1.0, 1.0); 
	glMatrixMode(GL_MODELVIEW);
} 

/* Main Loop 
* Open window with initial window size, title bar, 
* RGBA display mode, and handle input events. 
*/

int main(int argc, char** argv) 
{ 

glutInit(&argc, argv); 
glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB); 
glutInitWindowPosition (0, 0); 
glutInitWindowSize(500, 500); 
glutCreateWindow ("Frame"); 
myInit();

glutDisplayFunc(myDisplay); 
glutReshapeFunc (myReshape); 
glutMainLoop();
} 
