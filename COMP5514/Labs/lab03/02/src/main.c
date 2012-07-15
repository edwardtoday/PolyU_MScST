/*
 * OpenGL bitmap smiley demo.
 * Written by Michael Sweet.
 */

#include <GL/glut.h>


/*
 * Globals...
 */

int        Width;  /* Width of window */
int        Height; /* Height of window */


/*
 * Functions...
 */

void Redraw(void);
void Resize(int width, int height);


/*
 * 'main()' - Open a window and display some bitmaps.
 */

int                /* O - Exit status */
main(int  argc,    /* I - Number of command-line arguments */
     char *argv[]) /* I - Command-line arguments */
    {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB);
    glutInitWindowSize(792, 573);
    glutCreateWindow("Bitmap Smiley Face Example");
    glutReshapeFunc(Resize);
    glutDisplayFunc(Redraw);
    glutMainLoop();
    return (0);
    }


/*
 * 'Redraw()' - Redraw the window...
 */

void
Redraw(void)
    {
    int	           i;         /* Looping var */
    static GLubyte smiley[] = /* 16x16 smiley face */
        {
        0x03, 0xc0, 0, 0, /*       ****       */
        0x0f, 0xf0, 0, 0, /*     ********     */
        0x1e, 0x78, 0, 0, /*    ****  ****    */
        0x39, 0x9c, 0, 0, /*   ***  **  ***   */
        0x77, 0xee, 0, 0, /*  *** ****** ***  */
        0x6f, 0xf6, 0, 0, /*  ** ******** **  */
        0xff, 0xff, 0, 0, /* **************** */
        0xff, 0xff, 0, 0, /* **************** */
        0xff, 0xff, 0, 0, /* **************** */
        0xff, 0xff, 0, 0, /* **************** */
        0x73, 0xce, 0, 0, /*  ***  ****  ***  */
        0x73, 0xce, 0, 0, /*  ***  ****  ***  */
        0x3f, 0xfc, 0, 0, /*   ************   */
        0x1f, 0xf8, 0, 0, /*    **********    */
        0x0f, 0xf0, 0, 0, /*     ********     */
        0x03, 0xc0, 0, 0  /*       ****       */
        };


    glClearColor(0.0, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    glColor3f(1.0, 0.0, 0.0);
    for (i = 0; i < 100; i ++)
        { 
        glRasterPos2i(rand() % Width, rand() % Height);
        glBitmap(16, 16, 8, 8, 0, 0, smiley);
        }

    glFinish();
    }


/*
 * 'Resize()' - Resize the window...
 */

void
Resize(int width,  /* I - Width of window */
       int height) /* I - Height of window */
    {
    /* Save the new width and height */
    Width  = width;
    Height = height;

    /* Reset the viewport... */
    glViewport(0, 0, width, height);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(0.0, (GLfloat)width, 0.0, (GLfloat)height, -1.0, 1.0);
    glMatrixMode(GL_MODELVIEW);
    }
