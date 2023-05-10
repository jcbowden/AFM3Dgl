unit glAntiAlias;

interface
Uses
  Windows, OpenGL, Math  ;
Const
PI1 = 3.14159265358979323846 ;

Type
    TNormalDataD = array [1..4] of TGLdouble ;
    TNormalDataS = array [1..4] of TGLfloat ;

procedure GLAccumFrustrum(ViewPortCW, ViewPortCH,left, right, bottom, top, near1, far1,
                                pixdx, pixdy, eyedx, eyedy, focus : TGLdouble) ;
procedure GLAccumPerspective(ViewPortCW, ViewPortCH,fovy, aspect, near1, far1, pixdx,
                                pixdy, eyedx, eyedy, focus : TGLdouble) ;

Function GetNormalD(V1, V2, V3: array of Double; Normalize : Bool) : TNormalDataD ;
Function GetNormalS(V1, V2, V3: array of Single) : TNormalDataS ;


implementation   // this code is translated from C code found in the OpenGL Programming Guide (AKA Red Book)
                 // translation by josh bowden 2/2000


procedure GLAccumFrustrum(ViewPortCW, ViewPortCH, left, right, bottom, top, near1, far1,
                                pixdx, pixdy, eyedx, eyedy, focus : TGLdouble) ;
Var
  xwsize, ywsize, dx, dy : TGLdouble ;
begin
//  glGetIntegerv(GL_VIEWPORT, @Viewport[1]) ;

  xwsize := right - left ;
  ywsize := top - bottom ;
  dx := -(pixdx*xwsize/ViewPortCW + eyedx*near1/focus) ;
  dy := -(pixdy*ywsize/ViewPortCH + eyedy*near1/focus) ;

  glMatrixMode(GL_PROJECTION) ;
  glLoadIdentity ;
  glFrustum(left+dx, right+dx, bottom+dy, Top+dy, near1, far1) ;
  glMatrixMode(GL_MODELVIEW) ;
  glLoadIdentity ;
  glTranslatef(-eyedx, -eyedy, 0.0) ;
end ;



procedure GLAccumPerspective(ViewPortCW, ViewPortCH, fovy, aspect, near1, far1, pixdx,
                                pixdy, eyedx, eyedy, focus : TGLdouble) ;
Var
  fov2, left, right, bottom, top : TGLdouble ;
begin
  fov2 := ((fovy*PI1)/ 180.0) / 2.0 ; // convert angle from degrees to radians
  top := near1 / (cos(fov2) /sin(fov2)) ;
  bottom := - top ;
  right := top * aspect ;
  left := - right ;
  GLAccumFrustrum(ViewPortCW, ViewPortCH, left, right, bottom, top, near1, far1,
                                pixdx, pixdy, eyedx, eyedy, focus) ;
end ;


Function GetNormalS(V1, V2, V3: array of Single): TNormalDataS ;
Var
S1, S2 : array[0..2] of Single ;
Length : TGLdouble ;
begin

S1[0] := V1[0]-V2[0] ;  S1[1] := V1[1]-V2[1] ; S1[2] := V1[2]-V2[2] ;  // convert 3 points into 2 vectors
S2[0] := V2[0]-V3[0] ;  S2[1] := V2[1]-V3[1] ; S2[2] := V2[2]-V3[2] ;

Result[1] := (S1[1]*S2[2])-(S1[2]*S2[1])   ;  // calculate cross product of the two vectors
Result[2] := (S1[2]*S2[0])-(S1[0]*S2[2])   ;
Result[3] := (S1[0]*S2[1])-(S1[1]*S2[0])   ;

Result[4] := sqrt( sqr(Result[1]) +  sqr(Result[2]) + sqr(Result[3]) )   ;

{If Length <> 0 Then
begin
  Result[1] := Result[1] / Result[4] ;
  Result[2] := Result[2] / Result[4] ;
  Result[3] := Result[3] / Result[4] ;
 // Result[4] := Result[4] / 2 - if area wanted divide total by 2
end ;      }
end ;

Function GetNormalD(V1, V2, V3: array of Double; Normalize : Bool): TNormalDataD ;
Var
S1, S2 : array[0..2] of Double ;
Length : TGLdouble ;
begin

S1[0] := V1[0]-V2[0] ;  S1[1] := V1[1]-V2[1] ; S1[2] := V1[2]-V2[2] ;  // convert 3 points into 2 vectors
S2[0] := V2[0]-V3[0] ;  S2[1] := V2[1]-V3[1] ; S2[2] := V2[2]-V3[2] ;

Result[1] := (S1[1]*S2[2])-(S1[2]*S2[1])   ;  // calculate cross product of the two vectors
Result[2] := (S1[2]*S2[0])-(S1[0]*S2[2])   ;
Result[3] := (S1[0]*S2[1])-(S1[1]*S2[0])   ;

Result[4] := sqrt(sqr(Result[1]) +  sqr(Result[2]) + sqr(Result[3]) )   ;

If Normalize then
begin
  If Result[4] <> 0 Then
  begin
    Result[1] := Result[1] / Result[4] ;
    Result[2] := Result[2] / Result[4] ;
    Result[3] := Result[3] / Result[4] ;
  //  Result[4] := Result[4] / 2   ;  // this gives the area of the triangle rather than the area of the quadrilateral
  end ;                               // if area wanted divide final by two
end ;
end ;



{procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   MouseDownBool := True ;
   XDown := X ;
   YDown := Y ;
   DirCount := 0 ;
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
// Angle = ammount of rotation around axis
// Angle == distance moved from point of mouse button down
If MouseDownBool Then
  begin
    DirX := XDown - X ;
    DirY := YDown - Y ;
    Angle :=  PriorAngle + (Sqrt(sqr(DirX)+sqr(DirY)))/2 ;
    StatusBar1.SimpleText :=FloatToStrf(DirX,ffGeneral,4,3)+'  '+FloatToStrf(DirY,ffGeneral,4,3)+'  '+ FloatToStrf(Angle,ffGeneral,4,3) ;
    if Angle >360 then
    begin
     Angle := 0 ;
     PriorAngle := 0 ;
     XDown := X ;
     YDown := Y ;
    end ;
    repaint ;
  end ;
end;

procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
MouseDownBool := False ;
PriorAngle := angle ;
OldDirX := DirX  ;
OldDirY := DirY ;
end;        }


end.
 