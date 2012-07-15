#include <OpenGL/gl.h> 
#include <OpenGL/glu.h>
#include <GLUT/GLUT.h> 
#include <stdio.h> 
#include <iostream> 
using namespace std;

void display(void);
void init(void);

void display(void)
{
 
  /* clear all pixels */

   glClear(GL_COLOR_BUFFER_BIT);

  /* draw white polygon (rectangle) with corners at (0.25, 0.25, 0.0) */
  /* and (0.75, 0.75, 0.0) */

   glColor3f(1.0, 1.0, 1.0);
   glBegin(GL_POLYGON);
     glVertex3f(0.25, 0.25, 0.0);
     glVertex3f(0.75, 0.25, 0.0);
     glVertex3f(0.75, 0.75, 0.0);
     glVertex3f(0.25, 0.75, 0.0);
   glEnd();

  /* don't wait! start processing buffered OpenGL routines */

   glFlush();

}

void init(void)
{

  /* select clearing (background) color */

   glClearColor(0.0, 0.0, 0.0, 0.0);

  /* initialize viewing values */

   glMatrixMode(GL_PROJECTION);
   glLoadIdentity();
   glOrtho(0.0, 1.0, 0.0, 1.0, -1.0, 1.0);
 
}

/* main program to open a window and display a polygon */

int main(int argc, char** argv)
{
      int winW = 100;
      int winH = 100;

      scanf("%d",&winW);
      scanf("%d",&winH);

      cout << winW << ',' << winH << '\n';

      glutInit(&argc, argv);
      glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
      glutInitWindowSize(winW, winH);
      glutInitWindowPosition(100, 100);
      glutCreateWindow("hello");

      init();

      glutDisplayFunc(display);
      glutMainLoop();

      return 0;
}
