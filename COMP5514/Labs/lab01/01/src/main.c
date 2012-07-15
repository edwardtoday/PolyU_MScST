/* -------------------------------------------------------------------- */
/* main.c: the first program in OpenGL: displays Hello World		*/
/* -------------------------------------------------------------------- */

#include <stdio.h>
#include <stdlib.h>

#include <OpenGL/OpenGL.h>
#include <GLUT/GLUT.h>

void myDisplay(void);
void myClearBuffers(int, int);

void myClearBuffers (int w, int h) {
	float faspect;

	glClearColor (0.0, 0.0, 0.0, 0.0);
	glClear (GL_COLOR_BUFFER_BIT);
	glutSwapBuffers ();
	glClearColor (0.0, 0.0, 0.0, 0.0);
	glClear (GL_COLOR_BUFFER_BIT);

	faspect = (float) h / (float) w;

printf("myClearBuffers: faspect=%f\n", faspect);

	glutSwapBuffers ();

}

void myDisplay(void) {
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glClear(GL_COLOR_BUFFER_BIT);
	glutSwapBuffers();
}

int main(int argc, char **argv) {

printf("main before glutInit\n");
printf("main before glutInit\n");
printf("main before glutInit\n");

	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE);
	glutInitWindowPosition (0, 0);
	glutInitWindowSize(400, 400);
	glutCreateWindow("Hello World");
	glutReshapeFunc(myClearBuffers);
	glutDisplayFunc(myDisplay);

printf("main before glutMainLoop\n");

	glutMainLoop ();

printf("main after glutMainLoop\n");

	exit(0);
}

