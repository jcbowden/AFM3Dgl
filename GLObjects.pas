unit GLObjects;

interface
Uses
  SysUtils, OpenGL  ;

Procedure ScaleBarList(Sender : TObject) ;
procedure ZScaleText(Sender : TObject) ;     // declaration  

implementation
uses AFM3D, ScaleBarOpt, Colors ;

///////////////////////////////////////////////////////////////////////////////////
// Create Arrow for Z scale bar :
///////////////////////////////////////////////////////////////////////////////////
Procedure ZBarPointerProc ;  // cube with "calipers" to indicate Z scale
begin

  glBegin(GL_QUAD_STRIP) ;
  glColor3f(1,0,1) ;  glNormal3f(0,0,-0.25);  glVertex3f(0,0.5,0);  glVertex3f(0.5,0.5,0);  glVertex3f(0,0,0);   glVertex3f(0.5,0,0);
  glColor3f(1,1,0) ;  glNormal3f(0, 0, 0.25); glVertex3f(0,0,1);    glVertex3f(0.5,0,1);
  glColor3f(0,1,0) ;  glNormal3f(0, 0, 0.25); glVertex3f(0,0.5,1);  glVertex3f(0.5,0.5,1);
  {   glVertex3f(0,0.5,0);  glVertex3f(0.5,0.5,0);    }
  glend ;

  glBegin(GL_QUADS) ;
  glColor3f(0,0,0.3) ; glNormal3f(-0.5, 0, 0);   glVertex3f(0,0.5,0);  glVertex3f(0,0.5,1);   glVertex3f(0,0,1); glVertex3f(0,0,0);
  glEnd ;

  glBegin(GL_TRIANGLE_FAN);
  glColor3f(0.3,1,0.5);    glNormal3f(-0.25, 0, -0.5);  glVertex3f(1.5,0,0.5);    glVertex3f(0.5,0,1) ;   glVertex3f(0.5,0.5,1);
  glColor3f(0,1,0);        glNormal3f(-0.25, 0, 0.25);  glVertex3f(0.0,0.5,0.5) ;
  glColor3f(0.7,0.7,0.2);  glNormal3f(0, -0.5, 0);      glVertex3f(0.5,0.5,0);
  glColor3f(0,0.5,0.5);    glNormal3f(-0.25, 0, -0.25); glVertex3f(0.5,0,0);
  glColor3f(0.5,1,0);      glNormal3f(-0.5, 0, 0);      glVertex3f(0.5,0,1);
  glEnd ;

  glColor3f(0,0,0) ;
{  glBegin(GL_TRIANGLES);    glVertex3f(0.5,0.5,1);  glVertex3f(0.5,0.5,1); glVertex3f(0,0.5,0.5);
  glEnd ;         }

end ;


///////////////////////////////////////////////////////////////////////////////////
// Render Z scale text:
///////////////////////////////////////////////////////////////////////////////////
procedure ZScaleText(Sender : TObject) ;
var
 TempFloat1 : Single ;
 TempStr : String ;
begin
        TempStr  := FloatToStrf(ZScaleHeight ,ffGeneral,5,1) + ' nm' ;  // number for end of scale
        glDisable(GL_LIGHTING) ;
        glColor4f(TextColor[0],TextColor[1],TextColor[2],TextColor[3]) ;  // text color ;

        TempFloat1 := StrToFloat(Form4.Edit2.Text) ;
        TempFloat1 := TempFloat1 * 100 ;
        TempFloat1 := ((ZScaleHeight*ZMagValue)+(ScalePerZ*TempFloat1))/3  ;

        glRasterPos3f(-ScalePerXY*5,0,TempFloat1) ; // place scale bitmap text at desired positiom near Z scale bar
        glListBase(1); // indicate the start of display lists for the glyphs.
        glCallLists(Length(TempStr),  GL_UNSIGNED_BYTE, @TempStr[1]) ;
end ;

///////////////////////////////////////////////////////////////////////////////////
// Create Z scale bar :
///////////////////////////////////////////////////////////////////////////////////
Procedure ZBarList ;
Var
 Tube_Quad : PGLUQuadricObj ;
Begin
    Tube_Quad  := gluNewQuadric() ;

    glNewList(ZSCALE_BAR, GL_COMPILE);
        glEnable(GL_LIGHTING) ;
        If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
        If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
        gluCylinder(Tube_Quad,1.5*ScalePerXY,1.5*ScalePerXY,(ZScaleHeight*ZMagValue)/3,10,30) ;

        glPushMatrix ;
          glTranslatef(-2*ScalePerXY,2.39*ScalePerXY,(ZScaleHeight*ZMagValue)/3)        ;
          glRotatef(90,1,0,0) ;
          glScalef(ScalePerXY*5,ScalePerXY*5,ScalePerXY*5) ;
          ZBarPointerProc  ;
        glpopMatrix ;

        glPushMatrix ;
          glTranslatef(-2*ScalePerXY,-2.39*ScalePerXY,0)        ;
          glRotatef(90,-1,0,0) ;
          glScalef(ScalePerXY*5,ScalePerXY*5,ScalePerXY*5) ;
          ZBarPointerProc  ;
        glpopMatrix ;
    glEndList();
end ;

///////////////////////////////////////////////////////////////////////////////////
// Create Cube for end of X-Y scale bar :
///////////////////////////////////////////////////////////////////////////////////
procedure CubeListProc ;
begin
  glScalef(ScalePerXY*8,ScalePerXY*8,ScalePerXY*8) ;
  glBegin(GL_QUAD_STRIP) ;
    glNormal3f(0, 0, -1); glVertex3f(0,1,0) ;  glVertex3f(1,1,0) ;  glVertex3f(0,0,0) ; glVertex3f(1,0,0) ;
    glNormal3f(0, -1, 0); glVertex3f(0,0,1) ;  glVertex3f(1,0,1) ;
    glNormal3f(0, 0, 1);  glVertex3f(0,1,1) ;  glVertex3f(1,1,1) ;
    glNormal3f(0, -1, 0); glVertex3f(0,1,0) ;  glVertex3f(1,1,0) ;
  glend ;
  glBegin(GL_QUADS) ;
    glNormal3f(1, 0, 0); glVertex3f(1,1,0) ;  glVertex3f(1,1,1) ;   glVertex3f(1,0,1) ; glVertex3f(1,0,0) ;
    glNormal3f(-1, 0, 0); glVertex3f(0,1,0) ;  glVertex3f(0,1,1) ;   glVertex3f(0,0,1) ; glVertex3f(0,0,0) ;
  glEnd ;
end ;



///////////////////////////////////////////////////////////////////////////////////
// Create Arrow for X-Y scale bar :
///////////////////////////////////////////////////////////////////////////////////
Procedure ScaleBarList(Sender : TObject) ;
Var
 TempStr : String ;
 Scale_Quad, Arrow_Quad : PGLUQuadricObj ;
Begin
  Scale_Quad := gluNewQuadric() ;
  Arrow_Quad := gluNewQuadric() ;
  glDeleteLists(SCALE_BAR,1) ;
    glNewList(SCALE_BAR, GL_COMPILE);
        If Form4.RadioButton1.Checked Then // half scale X-Y scale bar
        begin
             TempStr    := FloatToStrf(ScalePerXY*256,ffGeneral,5,1) + ' nm' ;  // number for end of scale
             gluCylinder(Scale_Quad,3*ScalePerXY,3*ScalePerXY,256*ScalePerXY,10,30)  ;
             glDisable(GL_LIGHTING) ;     // ** disable light for Bitmap text  **
             glColor4f(TextColor[0],TextColor[1],TextColor[2],TextColor[3]{CurrentAlphaValue}) ;   // black ;
             glRasterPos3f(8*ScalePerXY,0.0,288*ScalePerXY) ;    // place scale bitmap text at end of arrow
             glEnable(GL_LIGHTING) ;
               If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
               If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;

             glPushMatrix ; // head of arrow
               glTranslatef(0,0,256*ScalePerXY) ;
               gluCylinder(Arrow_Quad,7*ScalePerXY,0,10*ScalePerXY,18,4) ;  // head of arrow
             glPopmatrix ;

             glPushMatrix ;  // text for scale
               glTranslatef(0,0,256*ScalePerXY) ;    //  ** orientates 3D text  **
               glTranslatef(0,0,25*ScalePerXY) ;     //  ** orientates 3D text  **
               glRotatef(180,1,0,1) ;                //  ** orientates 3D text  **
               glRotatef(90,1,0,0) ;                 //  ** orientates 3D text  **
               glScalef((25*ScalePerXY),(25*ScalePerXY),(3*ScalePerXY));
               glListBase(1); // indicate the start of display lists for the glyphs.
               glCallLists(Length(TempStr),  GL_UNSIGNED_BYTE, @TempStr[1]) ;
            glPopmatrix ;

            glTranslatef(0,0,256*ScalePerXY) ;
            glTranslatef(-ScalePerXY*4.0,-ScalePerXY*4.0,-256*ScalePerXY-(ScalePerXY*8)) ;

        end ;
        If Form4.RadioButton2.Checked Then // full scale X-Y scale bar list
        begin
          TempStr    := FloatToStrf(ScalePerXY*512,ffGeneral,5,1) + ' nm' ;  // number for end of scale
          gluCylinder(Scale_Quad,3*ScalePerXY,3*ScalePerXY,511*ScalePerXY,10,30) ;

          glDisable(GL_LIGHTING) ;     // ** disable light for Bitmap text  **
          glColor4f(TextColor[0],TextColor[1],TextColor[2],CurrentAlphaValue) ;   // black ;
          glRasterPos3f(8*ScalePerXY,0.0,288*ScalePerXY) ;    // place scale bitmap text at end of arrow
          glEnable(GL_LIGHTING) ;
          If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
          If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;

          glTranslatef(0,0,511*ScalePerXY) ;
          gluCylinder(Arrow_Quad,7*ScalePerXY,0,10*ScalePerXY,18,4) ;  // head of arrow

          glPushMatrix ;  // text for scale
            glTranslatef(45*ScalePerXY,0,-255*ScalePerXY) ;  //  ** orientates 3D text  **
            glRotatef(180,1,0,1) ;              //  ** orientates 3D text  **
            glRotatef(90,1,0,0) ;               //  ** orientates 3D text  **
            glScalef((25*ScalePerXY),(25*ScalePerXY),(3*ScalePerXY));
            glListBase(1); // indicate the start of display lists for the glyphs.

            glDisable(GL_LIGHTING) ;    // ** disable light for 3D text (no effect on bitmap text)  **
            glColor4f(TextColor[0],TextColor[1],TextColor[2],TextColor[3]{CurrentAlphaValue}) ;   // black ;
            glCallLists(Length(TempStr),  GL_UNSIGNED_BYTE, @TempStr[1]) ;
            glEnable(GL_LIGHTING) ;
            If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
            If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
          glPopmatrix ;
           
          glTranslatef(-ScalePerXY*4.0,-ScalePerXY*4.0,-511*ScalePerXY-(ScalePerXY*8)) ;
        end ;

        CubeListProc ;

        glEnable(GL_LIGHTING) ;     ///
        If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
        If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;  
glEndList();  // SCALE_BAR

ZBarList ;  //********Create list for Z scale bar (above)  ********************
end ;


end.
 