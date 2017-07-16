{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q+,R+,S-,T+,U-,V+,W+,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
unit AFM3D;

interface

uses
  Windows, Forms, Graphics, OpenGL, Classes, ExtCtrls, Messages, Controls, ComCtrls,
  StdCtrls, Spin, Menus, Dialogs, SysUtils, Buttons, clipbrd, ShellAPI ;

const
//PYRLIST=1 ;
  SURFACELIST=300  ;
  EYE_POINTER=301  ;
  SCALE_BAR=302    ;
//SCALE_TEXT=303   ;
  ZSCALE_BAR=303   ;
  ZBARPOINTER=304  ;
  CUBELIST=305     ;
  PEAKPOINTS=306   ;
Var
    Saved8087CW: Word;
    StartFull, StopFull : DWord ;
    DirX, DirY, DirZ : Real ;
    Angle, PriorAngle : Single ;
    ZMagValue, LastZMagValue  : Single ;
    BKGRed, BKGGreen, BKGBlue : GLClampf ;
    RC    : HGLRC ;   // josh might need this
    TextColor, BarColor, LevelColor, BorderColor, EnvCol : array [0..3] of glFloat ;
    NumTriangle : Integer ;
Type
    TxyzArrayD = array [1..3] of GLDouble ;
    TxyzArrayS = array [1..3] of GLFloat ;
// procedure GetShadow(Sender : TObject) ; // declaration
procedure DisplayObjects(Sender : TObject) ; // declaration
procedure DisplayScales(Sender : TObject) ;  // declaration

//procedure XYScaleText(Sender : TObject) ;    // declaration
Function GetXYZCoord (Sender : TObject; Shift: TShiftState; X, Y : GLInt) : TxyzArrayD ;  // declaration
procedure StereoVision(Sender: TObject);     // declaration
procedure ChangeAlpha(Sender : TObject; AlphaValue : GLFloat) ; // declaration
Function LoadOrig(Filename : String) : TMemoryStream ;     // declaration
procedure OpenContinue(Sender : TObject) ;   // declaration
procedure GetColorInfo1(sender : TObject) ;  // declaration
Procedure DisplayEyePointer(DispXpos, DispYpos, DispZpos: GLFloat) ;   // declaration
Procedure ShowRedSquare ;  // declaration

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Resolution1: TMenuItem;
    High1: TMenuItem;
    Medium1: TMenuItem;
    Low1: TMenuItem;
    Style1: TMenuItem;
    Points1: TMenuItem;
    Line1: TMenuItem;
    Filled1: TMenuItem;
    ZMagnification1: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N51: TMenuItem;
    N101: TMenuItem;
    N201: TMenuItem;
    Custom1: TMenuItem;
    Lowest1: TMenuItem;
    ColorSetup1: TMenuItem;
    glFlat1: TMenuItem;
    glSmooth1: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Image1: TImage;
    Exit1: TMenuItem;
    Perspective1: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    UpDown1: TUpDown;
    Font1: TMenuItem;
    N3DFont1: TMenuItem;
    BitmapFont1: TMenuItem;
    N1: TMenuItem;
    FontDialog1: TFontDialog;
    Font2: TMenuItem;
    N2: TMenuItem;
    ScaleBar1: TMenuItem;
    Options1: TMenuItem;
    StatusBar1: TStatusBar;
    SpeedButton4: TSpeedButton;
    Stupidlylow1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Save1: TMenuItem;
    TipConvolution1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
 //   procedure Timer1Timer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Open1Click(Sender: TObject);
    procedure Low1Click(Sender: TObject);
    procedure Medium1Click(Sender: TObject);
    procedure High1Click(Sender: TObject);
//    procedure SpeedButton1Click(Sender: TObject);
    procedure Points1Click(Sender: TObject);
    procedure Line1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure ReInitialize(Var Sender : TObject) ;
    procedure N21Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N101Click(Sender: TObject);
    procedure N201Click(Sender: TObject);
    procedure Custom1Click(Sender: TObject);
    procedure Lowest1Click(Sender: TObject);
    procedure ColorSetup1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure glFlat1Click(Sender: TObject);
    procedure glSmooth1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Perspective1Click(Sender: TObject);
    procedure SpeedButton1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N3DFont1Click(Sender: TObject);
    procedure BitmapFont1Click(Sender: TObject);
    procedure Font2Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpDown1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Stupidlylow1Click(Sender: TObject);
    procedure DoAppActivate(Sender: TObject);
    procedure DoAppDeactivate(Sender: TObject);
    procedure SpeedButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure TipConvolution1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND ;
    procedure WMSMButtonUp(var msg: TWMEraseBkgnd); message WM_EXITSIZEMOVE ;
    procedure  WMSMButtonDown(var msg: TWMEraseBkgnd); message WM_ACTIVATEAPP ;
    procedure  WMMouseActivate(var msg: TWMEraseBkgnd); message WM_MOUSEACTIVATE ;
//    procedure WMActivateWindow(var msg: TWMEraseBkgnd); message WM_ACTIVATE ; //do not use
//    procedure WMSMButtonDown(var msg: TWMEraseBkgnd); message WM_ENABLE ;  // no refresh under open dialog
 //   procedure WMSMSizeMove(var msg: TWMEraseBkgnd); message WM_ENTERSIZEMOVE ;
 //   procedure WMSMButtonDown(var msg: TWMEraseBkgnd); message WM_NCACTIVATE ; // does not work
 //   procedure WMSMButtonDown(var msg: TWMEraseBkgnd); message WM_NCLBUTTONDOWN ; //freezes drop down menus
    procedure wmDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure wmDisplayChange(var msg: TWMEraseBkgnd); message WM_DISPLAYCHANGE ;
//    procedure wmPaintBkg(var Msg: TWMDropFiles); message WM_SETREDRAW ;
//    procedure wmPaintBkg(var Msg: TWMDropFiles); message  WM_PAINT;

  end;

var
  MainForm: TMainForm;
  MouseDownBool, ListCreated, FileLoaded, StayInPlace, FirstFileOpened, ShadeModelSmooth, shiftIn : bool ;
  XDown, YDown, XPos, YPos, IHeight, IWidth, NumberofList, Resolution : Integer ; // IHeight = Number of sample points in image
  ZChangeInc, Z_ScaleF, ScalePerZ, ScalePerXY, FullZScale, ZScaleHeight : Single ;
  DataLength, DataOffset : Integer ;
  DataOrig : Array[0..511,0..511] of SmallInt ;
  MaxZ, MinZ : SmallInt ;
  CenterX, CenterY, CenterZ, EyeY, EyeZ, EyeX : GLDouble ;
  SpotEx : GLFloat ;
  SpotCutoff : GLFloat ;
  L0_POS, L1_POS : array[0..3] of GLFloat ;
  L0_Dir, L1_Dir : array[0..2] of GLFloat ;
  LM_Amb : array[0..3] of GLFloat ;
  L0_AMBI : array[0..3] of GLFloat ;
  L0_SPEC, L1_SPEC : array[0..3] of GLFloat ;
  L0_Dif, L1_Dif : array[0..3] of GLFloat ;
  Mat_Spec : array[0..3] of GLFloat ;
  Mat_Dif : array[0..3] of GLFloat ;
  Mat_Amb : array[0..3] of GLFloat ;
  Mat_Emi : array[0..3] of GLFloat ;
  Shine : GLFloat ;
  HomeDir : String ;
  PerspectiveAngle, OrthoVarX, OrthoVarY : GLDouble ;
  tGMF       :Array[0..255] of tGlyphMetricsFloat;
  XYZArray : TxyzArrayD ; // stores position of feedback cursor
  CurrentAlphaValue : GLFloat ;
  FileDroped, DontRefresh, JustActivated, DispChange, GotShadowBool : Bool ;
  DropedFileName : String ;
  ZChangeCount, LastZCountPos, LastTopPos , LastLeftPos : Integer ;  // counts how many time Z height has been pressed
  TexPointer1 : pGLuint ;
  PeakStream, OrigData : TMemoryStream ; // PeakStream stores high points found in tip convolution code
  FileStr1 : TFileStream ;                // OrigData holds original 16 bit AFM data values
  AveCount, TimeCount, ClockSpeed, FPS_Ave : Integer ;
implementation

uses ZMag, Colors, Perspective,{ IntelMathKernelLibrary,} ScaleBarOpt, glAntiAlias,
  TipConvolution, GLObjects;

{$R *.DFM}
Function Ticker : DWord; register;
begin
   asm
      push EAX
      Push EDX
      db $0f,$31        // db generates a byte
      mov Result, EAX
      pop EDX
      pop EAX
    end ;
end ;

Function GetXYZCoord (Sender : TObject; Shift: TShiftState; X, Y : GLInt) : TxyzArrayD  ;
Var
  WinXInt, WinYInt : GLInt ;
  WinX, WinY, WinZ : GLDouble ;
  WinZSingle : glFloat ;
  ModelMatrix, ProjMatrix : array [1..16] of GLDouble ;
  Viewport : array [1..4] of GLInt ;
  ZPointer : pGLFloat ;
  ResX, ResY, ResZ : glDouble ;
  GotXYZ : GLInt ;
  TempInt : integer ;
begin
 ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
    glGetDoublev(GL_MODELVIEW_MATRIX, @ModelMatrix[1]) ;
    glGetDoublev(GL_PROJECTION_MATRIX, @ProjMatrix[1]) ;
    glGetIntegerv(GL_VIEWPORT, @viewport[1]) ;

    WinX := X ;
    WinXInt := X ;
    WinYInt := Viewport[4] - Y - 1 ;
    WinY :=  WinYInt ;
    //New(ZPointer) ;
    GetMem(ZPointer,4) ;
    glReadBuffer(GL_FRONT) ;
    TempInt := glGetError() ;
    form4.Label6.caption := 'pre= '+inttostr(TempInt) +' ' ;

    TempInt := glisEnabled(GL_DEPTH_TEST) ;
    if TempInt = 1 then form4.Label6.caption := form4.Label6.caption + 'Depth is '
    else  form4.Label6.caption := form4.Label6.caption + 'Depth not ' ;
    TempInt := glisEnabled(GL_FOG) ;
    if TempInt = 1 then form4.Label6.caption := form4.Label6.caption + 'Fog is '
    else  form4.Label6.caption := form4.Label6.caption + 'Fog not ' ;

    // this is not returning the Z value I want!!!
    glReadPixels(WinXInt, WinYInt,1,1,$1902{GL_DEPTH_COMPONENT},GL_FLOAT,ZPointer) ;
    TempInt := glGetError() ;
    form4.Label6.caption := form4.Label6.caption + 'post= '+inttostr(TempInt) +' '  ;
    WinZSingle := ZPointer^ ;
    WinZ := WinZSingle ;
    // WinZ :=  0.98;
    //gluUnProjectBorGL : function(winx, winy, winz: GLdouble; modelMatrix: PGLdouble; projMatrix: PGLdouble; viewport: PGLint;var objx, objy, objz: GLdouble): Integer; stdcall;
    //gluUnProject :      function(winx, winy, winz: GLdouble; modelMatrix: TMatrix4d; projMatrix: TMatrix4d; viewport: TVector4i; objx, objy, objz: PGLdouble): GLint; stdcall;
    GotXYZ :=  gluUnProjectBorGL(WinX,WinY,WinZ,@ModelMatrix[1],@ProjMatrix[1],@ViewPort[1],ResX,ResY,ResZ) ;
    If GotXYZ = GL_TRUE Then
       Form4.Label5.Caption := 'True' else  Form4.Label5.Caption := 'False' ; 

   Result[1] := ResX ;  Result[2] := ResY ;  Result[3] := ResZ ;
   glReadBuffer(GL_BACK) ;
   Dispose(ZPointer) ;
 DeactivateRenderingContext; // release control of context
end ;

procedure TMainForm.DoAppDeactivate(Sender: TObject);
begin
MainForm.Deactivate ;
end ;

procedure TMainForm.DoAppActivate(Sender: TObject);
begin
try
  ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
    SwapBuffers(MainForm.Canvas.Handle) ;// copy back buffer to front
  DeactivateRenderingContext; // release control of context
except
  on EInvalidOp Do
  end ;
  
end;


procedure TMainForm.FormCreate(Sender: TObject);

begin // initialize OpenGL and create a context for rendering
  Saved8087CW := Default8087CW;
  Set8087CW($133f);

  AveCount := 0 ;
  TimeCount := 0 ;


  StopFull := Ticker ;
  sleep(100) ;
  StartFull := Ticker ;
  If StartFull > StopFull then
    ClockSpeed := (StartFull - StopFull)
  else
  begin
    StopFull := Ticker ;
    sleep(100) ;
    StartFull := Ticker ;
    ClockSpeed := (StartFull - StopFull) ;
  end ;
  StatusBar1.Panels.Items[1].Text := IntToStr(ClockSpeed div 100000) + ' MHz' ;

  PeakStream := TMemoryStream.Create ;
  OrigData   := TMemoryStream.Create ;

  FileDroped := False ;
  Angle := 0.0 ;
  dirX := 0 ;
  DirY := 0 ;
  TextColor[0] := 1.0 ;  TextColor[1] := 0 ; TextColor[2] := 0 ; TextColor[3] := 1 ;
  BarColor[0] := 0.5 ;  BarColor[1] := 0.1 ; BarColor[2] := 0.1 ; BarColor[3] := 1 ;
  LevelColor[0] := 0.1 ; LevelColor[1] := 0.4 ; LevelColor[2]:=0.8; LevelColor[3]:=0.2 ;
  CurrentAlphaValue := 1 ;
  ZMagValue := 1 ;
  LastZMagValue := 1 ;
  XYZArray[1] := 0.0 ; XYZArray[2] := 0.0 ; XYZArray[3] := 0.0 ;   // stores position of feedback cursor
  LastZCountPos := UpDown1.Position ;
  InitOpenGL ;
  RC:=CreateRenderingContext(Canvas.Handle,[opDoubleBuffered],32,0);

  ActivateRenderingContext(Canvas.Handle,RC); // make context drawable, Set environment options
    BorderColor[0] := 1.0 ;  BorderColor[1] := 0.0 ; BorderColor[2] := 0.0 ; BorderColor[3] := 1.0 ;
    EnvCol[0] := 0.0 ; EnvCol[1] := 0.0 ; EnvCol[2] := 0.0 ; EnvCol[3] := 1.0 ;
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER, GL_NEAREST) ;//GL_NEAREST, GL_LINEAR, GL_NEAREST_MIPMAP_NEAREST, GL_NEAREST_MIPMAP_LINEAR, GL_LINEAR_MIPMAP_NEAREST, GL_LINEAR_MIPMAP_LINEAR
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER, GL_NEAREST) ;//GL_NEAREST, GL_LINEAR
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S, GL_REPEAT) ;//GL_REPEAT, GL_CLAMP
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T, GL_REPEAT) ;//GL_REPEAT, GL_CLAMP
    glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE, GL_REPLACE) ; //GL_MODULATE, GL_BLEND, GL_REPLACE, GL_DECAL
    glTexParameterfv(GL_TEXTURE_2D,GL_TEXTURE_BORDER_COLOR,@BorderColor[0]) ;
    glTexEnvfv(GL_TEXTURE_ENV,GL_TEXTURE_ENV_COLOR,@EnvCol[0]) ;
  DeactivateRenderingContext; // release control of context

  ListCreated := False ;
  FileLoaded := false ;
  FirstFileOpened := True ; ////
  StayInPlace := False ;
  shiftIn := false ;
  Resolution := 8 ;
  ShadeModelSmooth := False ;
  DontRefresh := false ;
  DispChange := False ;
  LastTopPos:= MainForm.Top ; LastLeftPos := MainForm.Left ;
  Application.OnActivate := DoAppActivate ;
  Application.OnDeactivate := DoAppDeactivate ;
end;


procedure TMainForm.FormDestroy(Sender: TObject);
begin // destroy the rendering context
  
  Set8087CW(Saved8087CW);
  DestroyRenderingContext(RC);
end;


procedure ShowRedSquare() ; // implementation
Var
TempF1, TempF2, TempF3 : GLFloat ;
begin
{  glEnable(GL_TEXTURE_2D) ;
  glMatrixMode(GL_TEXTURE) ;
  glLoadIdentity;

  glMatrixMode(GL_MODELVIEW); // activate the transformation matrix     }

TempF1 := (ScalePerXY*IHeight/2) ;
TempF2 :=  StrToFloat(Form4.Edit8.Text) ;
TempF3 :=  ScalePerXY *  Resolution  ;

glDisable(GL_LIGHTING) ;
glColor4f(LevelColor[0],LevelColor[1],LevelColor[2],LevelColor[3]) ;

glBegin(GL_QUADS) ;
  {glTexCoord2f(0.0,0.0);} glVertex3f(TempF1-TempF3,-TempF1+TempF3,TempF2) ;
 { glTexCoord2f(1.0,0.0); }glVertex3f(TempF1-TempF3,TempF1,TempF2) ;
 { glTexCoord2f(1.0,1.0); }glVertex3f(-TempF1,TempF1,TempF2) ;
 { glTexCoord2f(0.0,1.0); }glVertex3f(-TempF1,-TempF1+TempF3,TempF2) ;
glEnd;

{glDisable(GL_TEXTURE_2D) ;
glEnable(GL_LIGHTING) ;
 If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
 If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
                                                                                      }
end ;


{procedure GetShadow(Sender : TObject) ; // implementation
Var
TempX : integer ;
TempByteI : Integer  ;
TempByteB1, TempByteB2 : byte ;
DepthBuf, DepthBuf2 : TMemoryStream ;
begin
     DepthBuf := TMemoryStream.Create ;
     DepthBuf2:= TMemoryStream.Create ;

    glViewport(0,0,256,256); // set viewport to size of texture wanted
glMatrixMode(GL_PROJECTION); // activate projection matrix
    glLoadIdentity;              // set initial state
    Try
     If Form1.RadioButton1.Checked Then
       gluPerspective(PerspectiveAngle,1,10*ScalePerXY,ScalePerXY*10024); // specify perspective params (see OpenGL.hlp)
     If Form1.RadioButton2.Checked Then
       glOrtho(-OrthoVarX,OrthoVarX,-OrthoVarY,OrthoVarY,ScalePerXY/100,ScalePerXY*10048)   ;
    Except
     on  EAccessViolation do
    end ;
glMatrixMode(GL_ModelView);
    glLoadIdentity;             // set it to initial state
    gluLookAt(L1_POS[0],L1_POS[1],L1_POS[2],0,0,0,0,0,1); // set up a viewer position and view direction
    glDrawBuffer(GL_BACK) ;
    DisplayObjects(Sender) ;  // main rendering of surface
    try
     DepthBuf.SetSize(65536) ; // 65536  262144
     DepthBuf2.SetSize(65536) ;
    except
    on EOutOfMemory do
    begin
      MessageDlg('You have run out of memory, sorry',mtError,[mbOK],0) ;
      Exit ;
    end ;
    end ;
  glPixelStorei(GL_UNPACK_ALIGNMENT,1) ;
  glReadPixels(0,0,256,256,GL_DEPTH_COMPONENT,GL_UNSIGNED_BYTE,DepthBuf.Memory) ;
  TempByteB2 := 0 ;
  For TempX := 0 to 65536 do
    begin
       DepthBuf.Read(TempByteB1,1) ;
       If TempByteB1 < 255 then
        DepthBuf2.Write(TempByteB2,1)
        else
        DepthBuf2.Write(TempByteB1,1) ;
     end ;

  glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA,256,256,0,GL_LUMINANCE,GL_UNSIGNED_BYTE,DepthBuf2.Memory) ;

//    glReadPixels(0,0,256,256,GL_RGBA,GL_UNSIGNED_BYTE,DepthBuf) ;
//    glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA,256,256,0,GL_UNSIGNED_BYTE,GL_RGBA,DepthBuf) ;

    glMatrixMode(GL_PROJECTION); // activate projection matrix
    glLoadIdentity;              // set initial state
    Try
     If Form1.RadioButton1.Checked Then
       gluPerspective(PerspectiveAngle,MainForm.ClientWidth/MainForm.ClientHeight,10*ScalePerXY,ScalePerXY*10024); // specify perspective params (see OpenGL.hlp)
     If Form1.RadioButton2.Checked Then
       glOrtho(-OrthoVarX,OrthoVarX,-OrthoVarY,OrthoVarY,ScalePerXY/100,ScalePerXY*10048)   ;
    Except
     on  EAccessViolation do
    end ;
    glMatrixMode(GL_ModelView);
    glLoadIdentity; // **** might not be needed ****
    glDrawBuffer(GL_Back) ;
    glViewport(0,0,MainForm.Width,MainForm.Height); // reset viewport to correct size of window
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // clear background and depth buffer

    DepthBuf.Free ;
    DepthBuf2.Free ;

    GotShadowBool := true ;

end ;   }

Procedure DisplayEyePointer(DispXpos, DispYpos, DispZpos: GLFloat) ;   // implementation
begin
///////////////////////////////////////////////////////////////////////////
// Eye pointer  call
///////////////////////////////////////////////////////////////////////////
 If Form1.CheckBox2.Checked = False Then   // Hide Cursors checkbox = unchecked
   begin
     glPushMatrix() ;
        glDisable(GL_LIGHTING)  ;
        glTranslatef(DispXpos,DispYpos,DispZpos) ;
        glScalef(3,3,3) ;
        glCallList(EYE_POINTER) ;
        glEnable(GL_LIGHTING)  ;
        If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
        If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
     glPopMatrix() ;
   end ;
end ;


procedure DisplayScales(Sender : TObject) ;  // implementation
Var
  ScalebarZheight : GLFloat ;
  TempStr : String ;

begin
///////////////////////////////////////////////////////////////////////////
// Scale Bars call
///////////////////////////////////////////////////////////////////////////
 glEnable(GL_LIGHTING);
 If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
 If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
 If MainForm.Filled1.Checked Then glPolygonMode(GL_FRONT_AND_BACK,GL_FILL) ;  // GL_FRONT
 glDisable(GL_CULL_FACE) ;  // otherwise inside arrowheads are culled
 glShadeModel(GL_SMOOTH) ;
 glEnable(GL_NORMALIZE) ;
 glEnable(GL_DEPTH_TEST) ;

 Mat_Emi[0] := BarColor[0] ;
 Mat_Emi[1] := BarColor[1];
 Mat_Emi[2] := BarColor[2];
 Mat_Emi[3] := BarColor[3] ; // CurrentAlphaValue;
 glMaterialfv(GL_FRONT,GL_Emission,@Mat_Emi[0]) ;

 ScalebarZheight := StrToFloat(Form4.Edit1.Text) ; // height of plane of X-Y arrows

 If Form4.CheckBox5.Checked Then    // clockwise arrows shown
 begin
  If Form4.CheckBox1.Checked Then
  begin
  glPushMatrix() ;
       glTranslatef(-ScalePerXY*273,-ScalePerXY*256,ScalebarZheight) ;
       glRotatef(-90,1,0,0) ;
       glRotatef(-90,0,0,1) ;
       glCallList(SCALE_BAR) ;   // X Scale bar
  glPopMatrix() ;

  end ;
  If Form4.CheckBox2.Checked Then
  begin
  glPushMatrix() ;
       glTranslatef(ScalePerXY*256,-ScalePerXY*273,ScalebarZheight) ;
       glRotatef(-90,0,1,0) ;
       glCallList(SCALE_BAR) ;   // Y scale bar
  glPopMatrix() ;
  end ;
  If Form4.CheckBox3.Checked Then
  begin
  glPushMatrix() ;
       glTranslatef(ScalePerXY*273,ScalePerXY*256,ScalebarZheight) ;
       glRotatef(90,1,0,0) ;
       glRotatef(90,0,0,1) ;
       glCallList(SCALE_BAR) ;   // Y scale bar
  glPopMatrix() ;
  end ;
  If Form4.CheckBox4.Checked Then
  begin
  glPushMatrix() ;
       glTranslatef(-ScalePerXY*256,ScalePerXY*273,ScalebarZheight) ;
       glRotatef(90,0,1,0) ;
       glRotatef(180,0,0,1) ;
       glCallList(SCALE_BAR) ;   // Y scale bar
  glPopMatrix() ;
  end ;
  end ;

 If Form4.CheckBox6.Checked Then
 begin
  If Form4.CheckBox7.Checked Then
  begin
  glPushMatrix() ;
       glTranslatef(-ScalePerXY*256,-ScalePerXY*273,ScalebarZheight) ;
       glRotatef(90,0,1,0) ;      //
       glRotatef(180,0,0,1) ;
       glCallList(SCALE_BAR) ;   // X Scale bar
  glPopMatrix() ;
  end ;
  If Form4.CheckBox8.Checked Then
  begin
  glPushMatrix() ;
       glTranslatef(-ScalePerXY*273,ScalePerXY*256,ScalebarZheight) ;
       glRotatef(90,1,0,0) ;
       glRotatef(90,0,0,1) ;
       glCallList(SCALE_BAR) ;   // Y scale bar
  glPopMatrix() ;
  end ;
  If Form4.CheckBox9.Checked Then
  begin
  glPushMatrix() ;
       glTranslatef(ScalePerXY*256,ScalePerXY*273,ScalebarZheight) ;
       glRotatef(-90,0,1,0) ;
       glCallList(SCALE_BAR) ;   // Y scale bar
  glPopMatrix() ;
  end ;
  If Form4.CheckBox10.Checked Then
  begin
  glPushMatrix() ;
       glTranslatef(ScalePerXY*273,-ScalePerXY*256,ScalebarZheight) ;
       glRotatef(-90,1,0,0) ;
       glRotatef(-90,0,0,1) ;
       glCallList(SCALE_BAR) ;   // Y scale bar
  glPopMatrix() ;
  end ;
  end ;


If Form4.CheckBox11.Checked Then   ///************** Z Scale **********************
begin
  glPushMatrix() ;
        glTranslatef(-ScalePerXY*276,-ScalePerXY*276,0) ;
        glScalef(2,2,3) ; // changing this will effect the height of the Z scale - need to adjust ZBarList tube height and text position
        glRotatef(45,0,0,1) ;
        glCallList(ZSCALE_BAR) ;
        ZScaleText(Sender) ;
  glPopMatrix() ;
end ;
If Form4.CheckBox12.Checked Then
begin
  glPushMatrix() ;
        glTranslatef(ScalePerXY*276,-ScalePerXY*276,0) ;
        glScalef(2,2,3) ; // changing this will effect the height of the Z scale - need to adjust ZBarList tube height and text position
        glRotatef(135,0,0,1) ;
        glCallList(ZSCALE_BAR) ;
        ZScaleText(Sender) ;
  glPopMatrix() ;
end ;
If Form4.CheckBox13.Checked Then
begin
  glPushMatrix() ;
        glTranslatef(ScalePerXY*276,ScalePerXY*276,0) ;
        glScalef(2,2,3) ; // changing this will effect the height of the Z scale - need to adjust ZBarList tube height and text position
        glRotatef(225,0,0,1) ;
        glCallList(ZSCALE_BAR) ;
        ZScaleText(Sender) ;
  glPopMatrix() ;
end ;
If Form4.CheckBox14.Checked Then
begin
  glPushMatrix() ;
        glTranslatef(-ScalePerXY*276,ScalePerXY*276,0) ;
        glScalef(2,2,3) ; // changing this will effect the height of the Z scale - need to adjust ZBarList tube height and text position
        glRotatef(-45,0,0,1) ;
        glCallList(ZSCALE_BAR) ;
        ZScaleText(Sender) ;
  glPopMatrix() ;
end ;


///////////////////////////////////////////////////////////////////////////
// current cursor position (X, Y, Z) coordinates + eye pointer
///////////////////////////////////////////////////////////////////////////
  If not Form1.CheckBox2.Checked Then  // only if cursors are enabled
  begin
   TempStr :=  FloatToStrf(XYZArray[3]/ZmagValue,ffGeneral,6,4); // the X, Y, Z coordinates **from feedback buffer**
   glPushMatrix() ;
        glDisable(GL_LIGHTING)  ;
        glTranslatef(XYZArray[1],XYZArray[2],(XYZArray[3]{*ZmagValue})) ;
        glCallList(EYE_POINTER) ;
        glRotatef(180,1,1,0) ;
        glCallList(EYE_POINTER) ;
  glPopMatrix() ;
  glPushMatrix() ;
        glDisable(GL_LIGHTING)  ;
        glColor4f(TextColor[0],TextColor[1],TextColor[2],TextColor[3]) ;  // as defined on form4 - this color is attached to very next glRasterPos call
        glRasterPos3f(XYZArray[1],XYZArray[2],(XYZArray[3]{*ZmagValue})+(ScalePerZ{*ZMagValue}*5000)) ;  // XYZArray is position of cursor in 3D space
        glTranslatef(XYZArray[1],XYZArray[2],(XYZArray[3]{*ZmagValue})) ;
        glRotatef(45,1,0,0) ;
        glScalef((25*ScalePerXY),(25*ScalePerXY),(3*ScalePerXY));  // this is for 3D font only
        glCallLists(Length(TempStr),  GL_UNSIGNED_BYTE, @TempStr[1]) ;
  glPopMatrix() ;
  end ;

 glEnable(GL_LIGHTING) ;
 If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
 If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
 glDisable(GL_NORMALIZE) ;

 Mat_Emi[0] := StrToFloat(form3.Edit16.Text) ; // reset material emission to value for surface
 Mat_Emi[1] := StrToFloat(form3.Edit17.Text);
 Mat_Emi[2] := StrToFloat(form3.Edit18.Text);
 Mat_Emi[3] := CurrentAlphaValue ;
{ Mat_Spec[0] := StrToFloat(form3.Edit12.Text) ;
 Mat_Spec[1] := StrToFloat(form3.Edit13.Text);
 Mat_Spec[2] := StrToFloat(form3.Edit14.Text);
 Mat_Spec[3] := CurrentAlphaValue ;// StrToFloat(form3.Edit15.Text) ;   }
 glMaterialfv(GL_FRONT,GL_Emission,@Mat_Emi[0]) ;
// glMaterialfv(GL_FRONT,GL_SPECULAR,@Mat_Spec[0]) ;
end ;



procedure DisplayObjects(Sender : TObject) ; // implementation
begin
 If Form1.CheckBox10.Checked Then  // Cull back face polygons
   begin
     glEnable(GL_CULL_FACE) ;
     glCullFace(GL_FRONT) ;
   end
 else
   glDisable(GL_CULL_FACE) ;

 glEnable(GL_LIGHTING);
 If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
 If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;

 If ShadeModelSmooth Then  glShadeModel(GL_Smooth)
 Else glShadeModel(GL_Flat) ;
 If MainForm.Points1.Checked Then  glPolygonMode(GL_FRONT_AND_BACK,GL_POINT) ;
 If MainForm.Line1.Checked Then glPolygonMode(GL_FRONT_AND_BACK,GL_LINE) ; //   glEnable(GL_LINE_SMOOTH) ;
 If MainForm.Filled1.Checked Then
   begin
     glPolygonMode(GL_BACK,GL_FILL) ;  // GL_FRONT
     glPolygonMode(GL_FRONT,GL_LINE) ;  // GL_FRONT
   end ;

 glEnable(GL_DEPTH_TEST) ;
  /////////////////////////////////////////////////////////////////////////////
  // Surface Call
  /////////////////////////////////////////////////////////////////////////////
  glPushMatrix() ;
    glRotatef(Angle,DirY,DirX,DirZ) ;
    glRotatef(180,1,0,0) ;
    glEnable(GL_NORMALIZE) ;
    glScalef(1,1,-ZmagValue) ;
  //  if IHeight = 255 then glTranslatef(
    glCallList(SURFACELIST) ;
    glDisable(GL_NORMALIZE) ;
    If not TipArtefact.CheckBox4.Checked then
    glCallList(PEAKPOINTS) ;
  glPopMatrix() ;
end ;


Procedure DoFrameCounter ;
begin
{
//StopFull := StartFull ;
StopFull := StartFull ;
StartFull := Ticker ;
try
//QueryPerformanceCounter(
  AveCount := AveCount + 1 ;
  If StartFull >= StopFull Then
    begin
      StopFull := StartFull-StopFull ;
      TimeCount := TimeCount + StopFull ;
      If AveCount >= 5 then
        begin
          FPS_Ave :=  ClockSpeed div(TimeCount div 50) ;
          MainForm.StatusBar1.Panels.Items[2].Text := IntToStr(FPS_Ave) +' fps' ;
          TimeCount := 0 ;
          AveCount := 0 ;
        end ;
    end
   else
    begin

      StopFull := (2147483647-StopFull) + (2147483647+StartFull) ;
      TimeCount := TimeCount + StopFull ;
      If AveCount >= 5 then
        begin
          FPS_Ave :=  ClockSpeed div(TimeCount div 50) ;
          MainForm.StatusBar1.Panels.Items[2].Text := IntToStr(FPS_Ave) +' fps' ;
          TimeCount := 0 ;
          AveCount := 0 ;
        end ;
    end ;
  except on EIntoverflow do
    MainForm.StatusBar1.Panels.Items[2].Text := 'overflow' ;
  end ;
          }
end ;



procedure TMainForm.FormPaint(Sender: TObject);
Var
  FogColor : Array[0..3] of GLFloat ;
  FogMode : GLInt ;
begin // draw somthing useful
If DispChange Then
  begin
    MainForm.Close ;
{    DestroyRenderingContext(RC);
    InitOpenGL ;
    RC:=CreateRenderingContext(MainForm.Canvas.Handle,[opDoubleBuffered],32,0);  }
  end ;

If (application.Active) and  ((DontRefresh=false) and (LastTopPos=MainForm.Top) and (LastLeftPos=MainForm.Left)) then   // draw the geometry, else just swapbuffer from last redraw
begin
//StopFull := Ticker ;
ActivateRenderingContext(Canvas.Handle,RC); // make context drawable
If FileDroped Then
begin
  FileDroped := False ;
  OrigData := LoadOrig(DropedFileName) ;
  OpenContinue(Sender) ;
end ;

Screen.Cursor := crHourglass ;
  If FileLoaded = False Then
    begin
      Open1.Click ;
      FileLoaded := True ;
    end ;

   If SpeedButton2.Down Then // move viewer position
   begin
     EyeX := EyeX - ((XPos-XDown)*(ScalePerXY/10)) ;//(ScalePerXY*IHeight)/2,
     EyeY := EyeY - ((YPos-YDown)*(ScalePerXY/10)) ;//(3*(ScalePerXY*IHeight))/2,
   end ;
  If SpeedButton3.Down Then // move gaze direction (head stays in same place - i.e. rotate head)
    begin
       CenterX := CenterX - ((XPos-XDown)*(ScalePerXY/10))  ;
       CenterY := CenterY  - ((YPos-YDown)*(ScalePerXY/10));
    end ;

  L0_POS[0] := EyeX ;  // light0 tracks eye position
  L0_POS[1] := EyeY ;
  L0_POS[2] := EyeZ ;  // *(MainForm.UpDown1.Position/100)
  If Form3.CheckBox3.Checked Then L0_POS[3] := 1.0 else  L0_POS[3] := 0.0 ; // determines if light is directional(0.0) or positional(1.0)
  L0_Dir[0] := (CenterX-(EyeX)) ;
  L0_Dir[1] := (CenterY-(EyeY)) ;
  L0_Dir[2] := (CenterZ-(EyeZ)) ;// CenterZ-EyeZ ;
  glLightfv(GL_LIGHT0, GL_POSITION, @L0_POS[0]) ;
  glLightfv(GL_LIGHT0,GL_SPOT_DIRECTION, @L0_Dir[0]) ;

  L1_POS[2] := StrToFloat(Form3.Edit27.Text) ; // Edit27 = Z height of light1
  If L1_Pos[2] > 0 Then L1_Dir[2] := -1 else L1_Dir[2] := 1 ;
  glLightfv(GL_LIGHT1, GL_POSITION, @L1_POS[0]) ;     // Light1 = stationary light
  glLightfv(GL_LIGHT1,GL_SPOT_DIRECTION, @L1_Dir[0]) ;


  If Form1.CheckBox9.Checked Then   // enable fog
    begin
      glEnable(GL_FOG) ;
      FogColor[0] := BKGRed; FogColor[1] := BKGGreen ;   FogColor[2] := BKGBlue ; FogColor[3] := 1.0 ;
      glFogfv(GL_FOG_COLOR, @fogcolor[0]);
      fogmode := GL_LINEAR ;
      glFogi(GL_FOG_MODE, fogmode) ;
      glFogfv(GL_FOG_COLOR, @fogcolor[0]);
      glFogf(GL_FOG_DENSITY, 0.15) ;
      glHint (GL_FOG_HINT, GL_DONT_CARE) ;  // GL_NICEST
      glFogf(GL_FOG_START, 10*ScalePerXY) ;
      glFogf(GL_FOG_END, ScalePerXY*256*Form1.TrackBar1.Position) ;
    end
   else
     glDisable(GL_FOG) ;

  glDrawBuffer(GL_BACK) ;
  glClearColor(BKGRed,BKGGreen,BKGBlue,1.0) ;// background color of the context (set clear color for Color buffer)
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // clear background and depth buffer


//  If (GotShadowBool=False) Then GetShadow(Sender) ;

  If Form1.CheckBox6.Checked Then // red green stereo
    begin
      StereoVision(Sender)  ;
    end
  Else
    begin
      glLoadIdentity;             // set it to initial state
      gluLookAt(EyeX,EyeY,EyeZ,CenterX,CenterY,CenterZ,0,0,1); // set up a viewer position and view direction

      If Form4.CheckBox15.Checked then  // use blend function (scales drawn first)
        begin
       {   If Line1.Checked Then  // surface rendered as lines
            begin
              glEnable(GL_BLEND) ;
              ChangeAlpha(Sender,1.0)  ;
              glBlendFunc(GL_SRC_ALPHA,GL_ONE) ;    //   GL_SRC_ALPHA  GL_ONE_MINUS_SRC_ALPHA
              If MousedownBool=False then
                DisplayScales(Sender)   // display scale bars and then XYZ pointer values (when spacebar pressed)
               else
                DisplayEyePointer(CenterX,CenterY,CenterZ) ;
              ChangeAlpha(Sender,StrToFloat(Form4.Edit7.Text)) ;
              DisplayObjects(Sender) ;  // main rendering of surface
              ChangeAlpha(Sender,1.0) ;
            end
          else   // surface rendered as blended, filled polygons    }
            begin
              glEnable(GL_BLEND) ;
              ChangeAlpha(Sender,1{BarColor[3]})  ;
              glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA) ;    //   GL_SRC_ALPHA  GL_ONE_MINUS_SRC_ALPHA
              DisplayScales(Sender) ; // display scale bars (blended behind surface)
              If MousedownBool then
                DisplayEyePointer(CenterX,CenterY,CenterZ) ;
              ChangeAlpha(Sender,StrToFloat(Form4.Edit7.Text)) ;
              DisplayObjects(Sender) ;  // main rendering of surface
              ChangeAlpha(Sender,1.0) ;
            end ;
        end
      else  // do not use blend function (and scales drawn last, due to no depth testing)
        begin
            glDisable(GL_BLEND) ;
            If Form4.CheckBox16.Checked Then ShowRedSquare() ;
            DisplayObjects(Sender) ;  // main rendering of surface
            If Not Form4.CheckBox18.Checked Then
               glClear(GL_DEPTH_BUFFER_BIT) ; // checkbox18 = use depth buffer
            DisplayScales(Sender) ;  // display scale bars (over surface if depth buffer cleared immediately above)
            If MousedownBool then
              DisplayEyePointer(CenterX,CenterY,CenterZ) ;
            If shiftIn  Then // ensures depth buffer is current for reading x,y,z at mouse position
              begin
                glDrawBuffer(GL_NONE) ; // only depth buffer updated   
                DisplayObjects(Sender) ;  // main rendering of surface
              end ;
        end ;
      glflush() ;
      try
        SwapBuffers(MainForm.Canvas.Handle) // copy back buffer to front
      except
       on EInvalidOp Do
       end ;
    end ;

  Form1.Label6.Caption :=  FloatToStrf(CenterX,ffGeneral,4,2) ; // direction of sight
  Form1.Label7.Caption :=  FloatToStrf(CenterY,ffGeneral,4,2) ;
  Form1.Label8.Caption :=  FloatToStrf(CenterZ,ffGeneral,4,2) ;
  Form1.Label10.Caption :=  FloatToStrf(EyeX,ffGeneral,4,2) ;   // position of eyes
  Form1.Label11.Caption :=  FloatToStrf(EyeY,ffGeneral,4,2) ;
  Form1.Label12.Caption :=  FloatToStrf(EyeZ,ffGeneral,4,2) ;
Screen.Cursor := crArrow ;
DeactivateRenderingContext; // release control of context

DoFrameCounter ;  // calculate FPS result

LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left ;  DontRefresh := false ;
end // if mainform.active
else
  begin
  try
  ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
    SwapBuffers(MainForm.Canvas.Handle) ;// copy back buffer to front
  DeactivateRenderingContext; // release control of context
  DontRefresh := false ;
  LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left ;
except
  on EInvalidOp Do
  end ;
  end ;

// Set8087CW(Saved8087CW);
end;


procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Application.Terminate;  // #27 = escape
  if Key = #26 then Application.Terminate;  // #26 = CTRL-Z
end;


procedure TMainForm.FormResize(Sender: TObject);
begin // handle form resizing (viewport must be adjusted)
{ActivateRenderingContext(Canvas.Handle,RC); // make context drawable
  glViewport(0,0,Width,Height); // specify a viewport (has not necessarily to be the entire window)
  glMatrixMode(GL_PROJECTION); // activate projection matrix
  glLoadIdentity;              // set initial state
  Try
   If Form1.RadioButton1.Checked Then
     gluPerspective(PerspectiveAngle,ClientWidth/ClientHeight,10*ScalePerXY,ScalePerXY*10024); // specify perspective params (see OpenGL.hlp)
   If Form1.RadioButton2.Checked Then
     glOrtho(-OrthoVarX,OrthoVarX,-OrthoVarY,OrthoVarY,ScalePerXY/100,ScalePerXY*10048)   ;
  Except
   on  EAccessViolation do
  end ;
  glMatrixMode(GL_ModelView);
  glLoadIdentity; // **** might not be needed ****

//  SwapBuffers(MainForm.Canvas.Handle) ;// copy back buffer to front
wglMakeCurrent(0,0); // another way to release control of context
                                                                       }
XPos := 0 ;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
Speedbutton1.Left := MainForm.Width - 38 ;
Speedbutton2.Left := MainForm.Width - 38 ;
Speedbutton3.Left := MainForm.Width - 38 ;
Speedbutton4.Left := MainForm.Width - 38 ;
UpDown1.Left :=  MainForm.Width - 38     ;
DontRefresh := false ;
Refresh;
end;


Procedure BuildOutLineFont(afontname:String; FontSize:byte);
Var  aLF:TLogFont;
     afont,oldfont:HFont;
Begin   //%%%%
    FillChar(aLF,SizeOf(aLF),0);
  With aLF do
  Begin
    lfHeight:=-1*FontSize;
    lfEscapement:=0 ;
    lfOrientation:=0;
//    lfOrientation:=lfEscapement;
    lfWeight:=FW_Normal;
    lfItalic:=0;
    lfUnderline:=0;
    lfStrikeOut:=0;
    lfCharSet:=ANSI_CHARSET;
    lfOutPrecision:=Out_TT_Precis;
    lfClipPrecision:=Clip_Default_Precis;
    lfQuality:=Default_Quality;
    lfPitchAndfamily:=DEFault_Pitch;
    If (length(aFontname)>0) and (Length(aFontname)<31) then
     strpcopy(lfFacename,aFontname)
    else
     lfFacename:='Arial';
  end;
  aFont:=CreateFontIndirect(aLF);
  If aFont<>0 then
   Begin
    OldFont:=SelectObject(MainForm.Canvas.Handle,aFont);
    If MainForm.BitmapFont1.Checked Then
      wglUseFontBitmaps(MainForm.Canvas.Handle, 0, 255, 1); // this function works
    If MainForm.N3dFont1.Checked Then
      wglUseFontOutLines(MainForm.Canvas.Handle,0,255,1,0.01,(ScalePerXY/50),WGL_FONT_POLYGONS,@tGMF[0]) ;

    SelectObject(MainForm.Canvas.Handle,OldFont);
    DeleteObject(aFont);
   end;
end;






procedure glListSurface(Var Sender : TObject) ;
var
  Y, X, YY, XX : Integer ;
  aa, bbb, cc : GLDouble ;
  RR, GG, BB, ZeroBaseLine : GLDouble ;
  STORE1 : array[0..2,0..511] of GLDouble ;
  STORE2 : array[0..2,0..511] of GLDouble ;
  NA     : array[0..2,0..1023] of GLDouble ;
  TEMP1, TEMP2, TEMP3 : array[0..2] of GLDouble ;
  TriangleArea  : GLDouble  ;
  N1 : TNormalDataD ;
  VectProd : array[0..2] of GLDouble ;
  VectMag : GLDouble ;
  XXXbool : bool ;
  ErrorInt, FontSize : integer ;
  TempStr : String ;
  StartTime, StopTime : DWord ;
//  n1, n2, incx, incy : Integer ;
  FontName : String ;
  Point1 : TXYZArrayS ;
  TempFloat2 : Single ;
  Normalize : Bool ;// value to state if vector returned by GetNormal is scale to unit size
begin
try
Normalize := False ;
GotShadowBool := False ;
StartTime := GetTickCount;
NumTriangle := 0 ;
// ZChangeInc :=
For X := 0 to 511 Do
  begin
    STORE1[0,X] := 0 ;
    STORE1[1,X] := 0 ;
    STORE1[2,X] := 0 ;
    STORE2[0,X] := 0 ;
    STORE2[1,X] := 0 ;
    STORE2[2,X] := 0 ;
  end ;
/////////////////////////////////////////////////////////////////////////////////////
// Initialise perspective values (eye position and center of view for gluLookAt )
/////////////////////////////////////////////////////////////////////////////////////
       If (Form1.CheckBox1.Checked = False) Then   // do not keep perspective
         begin
           EyeX := 0 ;
           EyeY := 0 ; //(ScalePerXY*IHeight)/4  ;
           EyeZ := ScalePerXY*IHeight ;// ZScaleHeight + (ZScaleHeight*0.3) ;
           if IHeight <> 255 then
           begin
             CenterX := (255*ScalePerXY)-((ScalePerXY*IHeight)/2) ;
             CenterY :=  (255*ScalePerXY)-((ScalePerXY*IHeight)/2) ;
           end
            else
           begin
             CenterX := (127*ScalePerXY)-((ScalePerXY*IHeight)/2) ;
             CenterY :=  (127*ScalePerXY)-((ScalePerXY*IHeight)/2) ;
           end ;
           CenterZ := 0.0 ; //(ScalePerZ*(DataOrig[(IHeight div 2),(IHeight div 2)]+32768)) ;
           Form1.CheckBox1.Checked := True ;
         end  ;

       If LastZMagValue <> ZMagValue Then  // change Z scale => change eye position to match
         begin
           EyeZ := ((XYZArray[3]{*ZMagValue}) + (EyeZ + (XYZArray[3]{*LastZMagValue}))) ;
           CenterZ :=  ((XYZArray[3]{*ZMagValue}) + (CenterZ + (XYZArray[3]{*LastZMagValue})));
           LastZMagValue :=  ZMagValue ;
         end ;
///////////////////////////////////////////////////////////////////////////////////
// Create pyrimidal pointer of eye view position cursor (CenterX etc )
///////////////////////////////////////////////////////////////////////////////////
  glDeleteLists(EYE_POINTER,1) ;
  glNewList(EYE_POINTER, GL_COMPILE);
    gldisable(GL_LIGHTING);
    glShadeModel(GL_Smooth) ;
      glPolygonMode(GL_FRONT_AND_BACK,GL_FILL) ;
      glBegin(GL_TRIANGLE_FAN) ;
         glColor3f(1.0,0.2,0.1) ;
         glVertex3f(0.0,0.0,0.0) ;
         glVertex3f(4*ScalePerXY*1.2,0.0,4*ScalePerXY*-2.80) ;
           glColor3f(1.0,1.0,1.0) ;
           glVertex3f(4*ScalePerXY*0.30,4*ScalePerXY*0.30,4*ScalePerXY*-1.80) ;
         glColor3f(1.0,0.2,0.1) ;
         glVertex3f(0,4*ScalePerXY*1.20,4*ScalePerXY*-2.80) ;
         glColor3f(1.0,1.0,1.0) ;
           glVertex3f(4*ScalePerXY*-0.30,4*ScalePerXY*0.30,4*ScalePerXY*-1.80) ;
         glColor3f(1.0,0.2,0.1) ;
         glVertex3f(4*ScalePerXY*-1.20,0.0,4*ScalePerXY*-2.80) ;
           glColor3f(1.0,1.0,1.0) ;
           glVertex3f(4*ScalePerXY*-0.30,4*ScalePerXY*-0.30,4*ScalePerXY*-1.80) ;
         glColor3f(1.0,0.2,0.1) ;
         glVertex3f(0,4*ScalePerXY*-1.20,4*ScalePerXY*-2.80) ;
           glColor3f(1.0,1.0,1.0) ;
           glVertex3f(4*ScalePerXY*0.30,4*ScalePerXY*-0.30,4*ScalePerXY*-1.80) ;
         glVertex3f(4*ScalePerXY*1.20,0.0,4*ScalePerXY*-2.80) ;
       glEnd ;
       glEnable(GL_LIGHTING) ;
       If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
       If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
   glEndList() ;

If PeakStream.Size > 0 Then
begin
  TempFloat2 := {ZMagValue * }ScalePerZ * (MinZ+32767) ;
  PeakStream.Seek(0,soFromBeginning) ;
  glDeleteLists(PEAKPOINTS,1) ;
  glNewList(PEAKPOINTS, GL_COMPILE);
        glDisable(GL_LIGHTING) ;
        glEnable(GL_POINT_SMOOTH) ;
        glPointSize(5) ;
        glColor3f(1.0,0.0,0.0) ;
        For YY := 0 to (PeakStream.Size div 12) Do
          begin
             PeakStream.Read(Point1[1],12) ;
             Point1[3] := (({ZMagValue*}ScalePerZ*(Point1[3]+32767))-TempFloat2) + (ScalePerZ*50) ;
             glBegin(GL_POINTS) ;
               glVertex3f(Point1[2],Point1[1],Point1[3]) ;
             glEnd() ;
          end ;
        glEnable(GL_LIGHTING) ;
        If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
        If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
        glDisable(GL_POINT_SMOOTH) ;
    glEndList();
end ;   

glFrontFace(GL_CW) ;
GetColorInfo1(Sender) ;
ChangeAlpha(Sender,0.0) ;

// ******************************************************************************
// New triangle strip code starts here
// ******************************************************************************
ZeroBaseLine := ({ZMagValue*}ScalePerZ*(MinZ+32767)) ;   // subtract this from every Z value so as to have lowest point at zereo
bbb := ((ScalePerXY*(IHeight+1))/2) ;
cc  := {ZMagValue*}ScalePerZ ;
YY  := 0;
XX := 0 ;
For X := 0 to (IHeight div Resolution) Do  // get first line of XYZ points
  begin
    aa  := (XX*ScalePerXY)-bbb ;
    STORE1[0,X] := aa ;
    STORE1[1,X] := -bbb ;
    STORE1[2,X] := ((cc*(DataOrig[XX,YY]+32767))-ZeroBaseLine) ;
    XX := XX + Resolution ;
  end ;

If Form3.RadioButton11.Checked Then //use surface lighting => calculate triangle normals
begin
///////////////////////////////////////////////////////////////////////////////////
// Create Surface List :
///////////////////////////////////////////////////////////////////////////////////
 TriangleArea := 0 ;
 glNewList(SURFACELIST, GL_COMPILE); // Create a display list for the Surface
 for Y := 0 to (IWidth div Resolution)-1 Do    // Generate the points of the surface
  begin
     YY := YY + Resolution ;
     XX := 0 ;
     For X := 0 to (IHeight div Resolution)   Do  // get next line of XYZ points
      begin
        aa  := (XX*ScalePerXY)-bbb ;
        STORE2[0,X] := aa ;
        STORE2[1,X] := (YY*ScalePerXY)-bbb ;
        STORE2[2,X] := ((cc*(DataOrig[XX,YY]+32767))-ZeroBaseLine) ;
        XX := XX + Resolution ;
      end ;


     XX := 0 ;
     For X := 0 to (IHeight div Resolution)-1   Do  // get next line of XYZ points
      begin
       TEMP1[0] := STORE1[0,X]  ; TEMP1[1] := STORE1[1,X]  ;  TEMP1[2] := STORE1[2,X]  ;
       TEMP2[0] := STORE2[0,X]  ; TEMP2[1] := STORE2[1,X]  ;  TEMP2[2] := STORE2[2,X]  ;
       TEMP3[0] := STORE1[0,X+1]; TEMP3[1] := STORE1[1,X+1];  TEMP3[2] := STORE1[2,X+1];
       N1 :=  GetNormalD(Temp1,Temp2,Temp3,Normalize)  ;
       NA[0,XX] := N1[1] ;NA[1,XX] := N1[2] ;NA[2,XX] := N1[3] ; TriangleArea := TriangleArea + N1[4] ;
       XX := XX + 1;
       TEMP1[0] := STORE2[0,X+1]; TEMP1[1] := STORE2[1,X+1]; TEMP1[2] := STORE2[2,X+1];
       N1 :=  GetNormalD(Temp1,Temp2,Temp3,Normalize)  ;
       NA[0,XX] := N1[1] ;NA[1,XX] := N1[2] ;NA[2,XX] := N1[3] ; TriangleArea := TriangleArea + N1[4] ;
       XX := XX + 1;
     end ;

     If not Form1.CheckBox5.Checked Then  // do not remove Z height info)
     begin
     XX := 0 ;
     glBegin(GL_TRIANGLE_STRIP); //GL_TRIANGLE_STRIP ;
       glNormal3f(NA[0,0],NA[1,0],NA[2,0]) ;    // original 1*
       XX := XX + 1 ;
       glVertex3f(STORE1[0,0],STORE1[1,0],STORE1[2,0]) ;
       glVertex3f(STORE2[0,0],STORE2[1,0],STORE2[2,0]) ;
       For X := 1 to (IHeight div Resolution) Do  // get next line of XYZ points
        begin
          glNormal3f(NA[0,XX],NA[1,XX],NA[2,XX]) ; // original 1*
          glVertex3f(STORE1[0,X],STORE1[1,X],STORE1[2,X]) ;
          XX := XX + 1 ;
          glNormal3f(-1*NA[0,XX],-1*NA[1,XX],-1*NA[2,XX]) ;    // original -1*
          glVertex3f(STORE2[0,X],STORE2[1,X],STORE2[2,X]) ;
          XX := XX + 1 ;
          NumTriangle := NumTriangle + 2 ;
        end ;
     glEnd ; //GL_TRIANGLE_STRIP ;
     end
     else   // if Form1.CheckBox5.Checked (remove Z height info)
     begin
     XX := 0 ;
     glBegin(GL_TRIANGLE_STRIP); //GL_TRIANGLE_STRIP ;
       glNormal3f(NA[0,0],NA[1,0],NA[2,0]) ;   // original *1
       XX := XX + 1 ;
       glVertex3f(STORE1[0,0],STORE1[1,0],0.0) ;
       glVertex3f(STORE2[0,0],STORE2[1,0],0.0) ;
       For X := 1 to (IHeight div Resolution) Do  // get next line of XYZ points
        begin
          glNormal3f(NA[0,XX],NA[1,XX],NA[2,XX]) ;  // original 1*
          glVertex3f(STORE1[0,X],STORE1[1,X],0.0) ;
          XX := XX + 1 ;
          glNormal3f(-1*NA[0,XX],-1*NA[1,XX],-1*NA[2,XX]) ;  // original -1*
          glVertex3f(STORE2[0,X],STORE2[1,X],0.0) ;
          XX := XX + 1 ;
          NumTriangle := NumTriangle + 2 ;
        end ;
     glEnd ; //GL_TRIANGLE_STRIP ;
     end  ;  // if else Form1.CheckBox5.Checked

     For X := 0 to (IHeight div Resolution)  Do  // save for next iteration
       begin
         STORE1[0,X] := STORE2[0,X] ;
         STORE1[1,X] := STORE2[1,X] ;
         STORE1[2,X] := STORE2[2,X] ;
       end ;
  end ; //// End generate points of the surface
  glEndList() ;
// ******************************************************************************
// New code ends here
// ******************************************************************************
// this code makes individual triangles - slower and ***much*** more memory hungry
{   ZeroBaseLine := (ZMagValue*ScalePerZ*((MinZ+32767))) ;   // subtract this from every Z value so as to have lowest point at zereo
    bbb := ((ScalePerXY*IHeight)/2) ;
    cc  := ZMagValue*ScalePerZ ;
    YY  := 0;
    For X := 0 to (IHeight div Resolution) Do  // used to be:  (IHeight div Resolution)+1
      begin
        If X=0 Then XX:=0
        else XX := (X*Resolution)-1 ;
        aa  := (XX*ScalePerXY)-bbb ;
        STORE1[0,X] := aa ;
        STORE1[1,X] := (YY*ScalePerXY)-bbb ;
        STORE1[2,X] := ((cc*(DataOrig[XX,YY]+32767))-ZeroBaseLine) ;
      end ;

If Form3.RadioButton11.Checked Then //use surface lighting => calculate triangle normals
begin
glNewList(SURFACELIST, GL_COMPILE); // Create a display list for the Surface
glEnable(GL_LIGHTING);
glEnable(GL_LIGHT0);
glFrontFace(GL_CCW) ;
for Y := 1 to (IWidth div Resolution) Do    // Generate the points of the surface
  begin
    If Y=0 Then YY:=0  // has this got a point to it???
    else YY := (Y*Resolution)-1 ;
    glBegin(GL_TRIANGLES);
      For X := 0 to (IHeight div Resolution) Do
        begin
          If X=0 Then XX:=0
          else XX := (X*Resolution)-1 ;
          aa  := (XX*ScalePerXY)-bbb ;
          STORE2[0,X] := aa ;
          STORE2[1,X] := ((YY+Resolution)*(ScalePerXY))-bbb ;
          STORE2[2,X] := (cc*(DataOrig[XX,YY+Resolution]+32767)-ZeroBaseLine) ;

          If X+1 <= (IHeight div Resolution) Then
            begin
            TEMP1[0] := 0      ;   //  bring points relative to 0 on axis
            TEMP1[1] := STORE1[1,X]-STORE2[1,X]      ;
            TEMP1[2] := STORE1[2,X]-STORE2[2,X]      ;
            TEMP2[0] := STORE1[0,X+1]-STORE2[0,X]    ;
            TEMP2[1] := STORE1[1,X+1]-STORE2[1,X]    ;
            TEMP2[2] := STORE1[2,X+1]-STORE2[2,X]    ;

            VectProd[0] := (TEMP2[1]*TEMP1[2])-(TEMP2[2]*TEMP1[1]) ;
            VectProd[1] := 0-(TEMP2[0]*TEMP1[2]) ;
            VectProd[2] := (TEMP2[0]*TEMP1[1]) ;
            VectMag := (sqr(VectProd[0]) + sqr(VectProd[1]) + sqr(VectProd[2])) ;
            If VectMag <> 0 Then   begin
              VectMag := sqrt(VectMag) ;
              VectProd[0] :=  -1*VectProd[0]/VectMag  ;    // Normalise the vector product result
              VectProd[1] :=  -1*VectProd[1]/VectMag  ;
              VectProd[2] :=  -1*VectProd[2]/VectMag  ;
            end ;
            glNormal3f(VectProd[0],VectProd[1],VectProd[2]) ;
            If Form1.CheckBox5.Checked Then  // display no Z height info - only lighting
              begin
                glVertex3f(STORE1[0,X],STORE1[1,X],0) ;
                glVertex3f(STORE2[0,X],STORE2[1,X],0) ;
                glVertex3f(STORE1[0,X+1],STORE1[1,X+1],0) ;
                NumTriangle := NumTriangle + 3 ;
              end
            else
            begin
              glVertex3f(STORE1[0,X],STORE1[1,X],STORE1[2,X]) ;
              glVertex3f(STORE2[0,X],STORE2[1,X],STORE2[2,X]) ;
              glVertex3f(STORE1[0,X+1],STORE1[1,X+1],STORE1[2,X+1]) ;
              NumTriangle := NumTriangle + 3 ;
            end ;

            XX := XX+Resolution ;
            aa  := (XX*ScalePerXY)-bbb ;
            STORE2[0,X+1] := aa ;
            STORE2[1,X+1] := ((YY+Resolution)*(ScalePerXY))-bbb ;
            STORE2[2,X+1] := (cc*(DataOrig[XX,YY+Resolution]+32767)-ZeroBaseLine)  ;
            TEMP1[0] := STORE2[0,X]-STORE2[0,X+1]      ; // bring points relative to 0 on axis
            TEMP1[1] := 0 ; // STORE2[1,X]-STORE2[1,X+1]      ;    // =0
            TEMP1[2] := STORE2[2,X]-STORE2[2,X+1]      ;
            TEMP2[0] := 0 ; //STORE1[0,X+1]-STORE2[0,X+1]    ;    // =0
            TEMP2[1] := STORE1[1,X+1]-STORE2[1,X+1]    ;
            TEMP2[2] := STORE1[2,X+1]-STORE2[2,X+1]    ;
            VectProd[0] := (TEMP2[1]*TEMP1[2]) ;
            VectProd[1] := (TEMP2[2]*TEMP1[0]) ;
            VectProd[2] := 0-(TEMP2[1]*TEMP1[0]) ;
            VectMag := sqrt(sqr(VectProd[0]) + sqr(VectProd[1]) + sqr(VectProd[2])) ;
            //     Vectmag := snrm2(n2,VectProd[0], incx) ;  // intel math library - does not help speed
            VectProd[0] :=  -1*VectProd[0]/VectMag  ;  // Normalise the vector product result
            VectProd[1] :=  -1*VectProd[1]/VectMag  ;
            VectProd[2] :=  -1*VectProd[2]/VectMag  ;
            glNormal3f(VectProd[0],VectProd[1],VectProd[2]) ;
            If Form1.CheckBox5.Checked Then  // display no Z height info - only lighting
              begin
                glVertex3f(STORE2[0,X],STORE2[1,X],0) ;
                glVertex3f(STORE2[0,X+1],STORE2[1,X+1],0) ;
                glVertex3f(STORE1[0,X+1],STORE1[1,X+1],0) ;
                NumTriangle := NumTriangle + 3 ;
              end
            else
              begin
                glVertex3f(STORE2[0,X],STORE2[1,X],STORE2[2,X]) ;
                glVertex3f(STORE2[0,X+1],STORE2[1,X+1],STORE2[2,X+1]) ;
                glVertex3f(STORE1[0,X+1],STORE1[1,X+1],STORE1[2,X+1]) ;
                NumTriangle := NumTriangle + 3 ;
              end ;
            end ;
          end ;
          glEnd();  // GL_Triangles
          For X := 0 to (IHeight div Resolution) Do  // save for next iteration
          begin
            STORE1[0,X] := STORE2[0,X] ;
            STORE1[1,X] := STORE2[1,X] ;
            STORE1[2,X] := STORE2[2,X] ;
          end ;
        end ;
   glEndList() ;
   NumTriangle := NumTriangle div 3 ;   }
// ******************************************************************************
// old code ends here
// ******************************************************************************
end  // If Form3.RadioButton11.Checked Then //use surface lighting
  else // use set color for height value (uses GL_TRIANGLE_STRIP)
    begin
     glNewList(SURFACELIST, GL_COMPILE); // Create a display list for the Surface
        gldisable(GL_LIGHTING);
            ZeroBaseLine := ({ZMagValue*}ScalePerZ*((MinZ+32767))) ;
             for Y := 0 to (IWidth div Resolution) Do    // Generate the points of the surface
               begin
                 YY := Y*Resolution ;
                 glBegin(GL_TRIANGLE_STRIP);
                 For X := 0 to (IHeight div Resolution) Do
                    begin
                    XX := X*Resolution  ;
                    If Y < (IWidth div Resolution) then
                      begin
                        If DataOrig[XX,YY] < (MaxZ-(FullZScale/2)) Then
                          begin
                            BB := (DataOrig[XX,YY] + abs(MinZ))/(FullZScale/2);
                            RR := 0.0 ;
                            GG := 0.0 ;
                           end
                         else
                          begin
                           BB := 1.0 ;
                           RR := ((DataOrig[XX,YY] + abs(MinZ))/(FullZScale/2))- 1  ;
                           GG := RR ;
                          end ;
                        glColor3f(RR, GG, BB) ;
                      If Form1.CheckBox5.Checked Then // no Z height info
                        begin
                          glVertex3f((XX*ScalePerXY)-((ScalePerXY*IHeight)/2),(YY*ScalePerXY)-((ScalePerXY*IHeight)/2),  0  );
                          glVertex3f((XX*ScalePerXY)-((ScalePerXY*IHeight)/2),((YY+Resolution)*(ScalePerXY))-((ScalePerXY*IHeight)/2),  0  ) ;
                          NumTriangle := NumTriangle + 2 ;
                        end
                      else
                        begin
                          glVertex3f((XX*ScalePerXY)-((ScalePerXY*IHeight)/2),(YY*ScalePerXY)-((ScalePerXY*IHeight)/2),  (({ZMagValue*}ScalePerZ*(DataOrig[XX,YY]+32767))-ZeroBaseLine)  );
                          glVertex3f((XX*ScalePerXY)-((ScalePerXY*IHeight)/2),((YY+Resolution)*(ScalePerXY))-((ScalePerXY*IHeight)/2),({ZMagValue*}ScalePerZ*(DataOrig[XX,YY+Resolution]+32767)-ZeroBaseLine)  ) ;
                          NumTriangle := NumTriangle +2 ;
                        end ;
                      end ;
                    end ;

                    glEnd(); // GL_TRIANGLE_STRIP
                end ;
       NumTriangle := Numtriangle - (2*(IWidth div Resolution)) ;
       glEnable(GL_LIGHTING) ;
       If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
       If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
       glEndList() ;
    end ;

StopTime := GetTickCount;
MainForm.StatusBar1.Panels.Items[3].Text := InttoStr(NumTriangle) + ' triangles '+FloatToStrf((StopTime-StartTime)/1000,ffGeneral,5,3) + ' sec, area increase ' + FloatToStrf(((TriangleArea/2{000000})/(sqr((ScalePerXY*512)-(ScalePerXY*Resolution))/1{000000}))*100-100,ffGeneral,6,5) + '%';
                                                                                                                                                                  // divided by 2 because area was for a quadrilateral (not triangles)
TipArtefact.Edit5.Text := FloatToStrF((ScalePerXY*15),ffGeneral,4,4) ;

FontName := MainForm.FontDialog1.Font.Name ;
FontSize := MainForm.FontDialog1.Font.Size ;
BuildOutLineFont(FontName, FontSize);
GLObjects.ScaleBarList(Sender) ;  // produce list with scale bar arrows and text indicating length...
glEnable(GL_LIGHTING);
If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
except
  on EOutOfMemory do
   MessageDlg('You have run out of memory, sorry',mtError,[mbOK],0) ;
end ;

// End definition of Surface
end ;

procedure TMainForm.wmDisplayChange(var msg: TWMEraseBkgnd);// message WM_DISPLAYCHANGE
begin
DestroyRenderingContext(RC);
{InitOpenGL ;
RC:=CreateRenderingContext(MainForm.Canvas.Handle,[opDoubleBuffered],32,0);  }
If (MessageDlg('Display properties have changed! '#13'Sorry, have to exit' ,mtError,[mbOK],0))<>IDOK Then
    abort ;
    DispChange := True ;
end ;

procedure  TMainForm.WMMouseActivate(var msg: TWMEraseBkgnd);// message WM_MOUSEACTIVATE ;
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
end ;

procedure TMainForm.WMSMButtonDown(var msg: TWMEraseBkgnd); // message=WM_ACTIVATEAPP
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
end ;

procedure TMainForm.WMSMButtonUp(var msg: TWMEraseBkgnd); // message=WM_EXITSIZEMOVE
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
MainForm.Refresh ;
end ;


procedure TMainForm.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin // avoid clearing the background (causes flickering and speed penalty)
  Message.Result:=1;
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   XPos:= 0;
   YPos := 0;
   StartFull := 0 ;
   StopFull := 0 ;
   MouseDownBool := True ;
   XDown := X ;
   YDown := Y ;
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : glDouble ;
  TempY : Integer ;  // used to hold actual Y coordinate in client viewport
  TempStr : String  ;
begin

If MouseDownBool and (Speedbutton2.down or Speedbutton3.down)  Then
  begin
      If XPos > Xdown Then
        begin
          If X < XPos Then
            begin
              XDown := X ;
              XPos := X ;
            end
          else
            XPos := X ;
        end
     else
        If XPos < XDown Then
          begin
            If X > XPos Then
              begin
                XDown := X ;
                XPos := X ;
              end
            else
                XPos := X ;
          end
     else
       If Xpos = XDown Then
          XPos := X ;


     If YPos > Ydown Then
        begin
          If Y < YPos Then
            begin
              YDown := Y ;
              YPos := Y ;
            end
          else
            YPos := Y ;
        end
     else
        If YPos < YDown Then
          begin
            If Y > YPos Then
              begin
                YDown := Y ;
                YPos := Y ;
              end
            else
                YPos := Y ;
          end
     else
       If Ypos = YDown Then
          YPos := Y ;

    repaint ;
  end
 else // if MouseDownBool <> true *and* spacebar is down (i.e. shiftin = true) ****do inverse transform to find X,Y,Z position of mouse
      If shiftIn  Then
      begin
        //  Form4.Label3.Caption := '' ;
        //  StatusBar1.Panels.Items[3].Text := '' ;
        TempStr := '' ;
        TempY := Y  + (MainForm.Height - MainForm.ClientHeight) ;
        XYZArray :=   GetXYZCoord(Sender,Shift,X,TempY) ;
        TempFloat := XYZArray[1] ;
        TempStr :=  TempStr + ' ' + FloatToStrf(TempFloat,ffGeneral,5,3) + ',' ;
        TempFloat := XYZArray[2] ;
        TempStr :=  TempStr + ' ' + FloatToStrf(TempFloat,ffGeneral,5,3) + ',' ;
        XYZArray[3] := XYZArray[3] {/ ZMagValue} ;
        TempFloat := XYZArray[3] ;
        TempStr :=  TempStr + ' ' + FloatToStrf(TempFloat/ZMagValue,ffGeneral,5,3) ;
        XPos := 0 ;
        YPos := 0 ;
        XDown := 0 ;
        YDown := 0 ;
        StatusBar1.Panels.Items[0].Text := TempStr ;
        MainForm.Refresh ;
      end
  else
    If MouseDownBool and Speedbutton1.down Then
      begin
        DirX := XDown - X ;
        DirY := YDown - Y ;
        //DirX := (XDown - X) * cos(Angle)  ;
        //DirY := YDown - Y * cos(Angle)  ;
       // DirX := (MainForm.ClientWidth div 2) - X ;
       // DirY := (MainForm.ClientHeight div 2) - Y ;
        Angle :=  PriorAngle + (Sqrt(sqr(DirX)+sqr(DirY)))/10 ;
      //  StatusBar1.Panels.Items[1].Text := floatToStrf(Angle,ffGeneral,5,4) ;
        if Angle > 360 then
          begin
            Angle := 0 ;
            PriorAngle := 0 ;
            XDown := X ;
            YDown := Y ;
          end ;
      repaint ;
      end
   else
    If MouseDownBool and Speedbutton4.down Then
      begin
        DirZ := XDown - X ;
        Angle :=  PriorAngle + DirZ/3 ;
     //   StatusBar1.Panels.Items[1].Text := floatToStrf(Angle,ffGeneral,5,4) ;
        if (Angle > 360) or (Angle < -360)  then
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
  XPos:= 0;
  YPos := 0;
  XDown := 0;
  YDown := 0;
  Refresh ;
end;



Function LoadOrig(Filename : String) : TMemoryStream ; // implementation
label
  EndSearch ;
Var
  TempList: TStrings ;
  L1, L2, L3, L4, NumRead, X, Y, NumWritten  : integer ;
  TempStr1: String ;
  ScanSize,  ImageData, Z_Mag, ZScale, XYUnits, ZUnits, SamplesPerLine, NumLines : String ;
  f, Tof : file of smallint ;
  Buf: array[1..10240] of SmallInt;
  buf1 : array[0..255] of SmallInt ;
  StartFile : longint ;
  TempSmall1 : SmallInt ;
begin
  TempList := TStringList.Create ;

  for x := 0 to 255 do buf1[x] := 0 ; // initialize buffer

  If ScalePerZ <> 0 Then
    Form4.Edit8.Text := FloatToStr(StrToFloat(Form4.Edit8.Text)/ScalePerZ) ;  // height of redsquare

  If Form1.CheckBox1.Checked Then   // keep perspective = true
   begin
     EyeX := EyeX/ScalePerXY ;
     EyeY :=  EyeY/ScalePerXY ;
     EyeZ := EyeZ/ScalePerXY ;
     CenterZ := CenterZ/ScalePerXY ;
     CenterX := CenterX/ScalePerXY ;
     CenterY := CenterY/ScalePerXY ;
   end ;

    Screen.Cursor := crHourglass ;
    MainForm.Windowstate := wsNormal ;
    MainForm.Caption := Filename ;

    AssignFile(f, Filename) ;
    Reset(f) ;
    BlockRead(f, Buf , 10240, NumRead)  ;
    AssignFile(ToF, HomeDir+'\Header.txt');	{ Open output file }
    Rewrite(Tof) ;
    BlockWrite(ToF, Buf, NumRead, NumWritten);
    CloseFile(f) ;
    CloseFile(Tof) ;

    try
      With TempList Do
        begin
        LoadFromFile(HomeDir+'\Header.txt') ;

        L4 := 0 ;
        For X := 0 to TempList.Count-1 do   // looks for start of image data
          begin
            TempStr1 := UpperCase(Strings[X]) ;
            L1 := pos('IMAGE LIST',TempStr1) ;
            If L1 > 0 Then
              begin
                L4 := X+1 ;
                Strings[X] := '************************' ;
                Break ;
              end ;
          end ; // For X := 0 to TempList.Count-1 do

        If L4 = 0 then // 'IMAGE LIST' was never found
          begin
             MessageDlg('Possibly not an AFM file, can not process',mtError,[mbOK],0) ;
             Abort ;
          end ;


        For X := L4 To TempList.Count-1 Do
          begin
            TempStr1 := UpperCase(Strings[X]) ;
            L2 := pos('\DATA OFFSET:',TempStr1) ;
            If (L2 = 1)  Then
              begin
                System.Delete(TempStr1,1,14) ;
                TempStr1 := trim(TempStr1) ;
                DataOffset := StrToInt(TempStr1) ;
              end ;
            L2 := pos('\DATA LENGTH:',TempStr1) ;
            If (L2 = 1)  Then
              begin
                System.Delete(TempStr1,1,13) ;
                TempStr1 := Trim(TempStr1) ;
                DataLength := StrToInt(TempStr1) ;
              end ;
            L2 := pos('\SAMPS/LINE:',TempStr1) ;
            If (L2 = 1) Then
              begin
                System.Delete(TempStr1,1,13) ;
                TrimLeft(TempStr1) ;
                SamplesPerLine := TempStr1 ;
              end ;
            L2 := pos('\NUMBER OF LINES:',TempStr1) ;
            If (L2 = 1) Then
              begin
                System.Delete(TempStr1,1,18) ;
                TrimLeft(TempStr1) ;
                NumLines := TempStr1 ;
              end ;
            L2 := pos('\SCAN SIZE:',TempStr1) ;
            If (L2 = 1) Then
              begin
                System.Delete(TempStr1,1,12) ;
                L3 := pos(' ',TempStr1) ;
                ScanSize := Copy(TempStr1,1,L3-1) ;
                XYUnits := Copy(TempStr1,L3+1,(Length(TempStr1)-L3+1)) ;
                TrimRight(XYUnits) ;
              end ;
            L2 := pos('\IMAGE DATA:',TempStr1) ;
            If (L2 = 1) Then
              begin
                System.Delete(TempStr1,1,13) ;
                ImageData := TempStr1 ;
                If ImageData <> 'HEIGHT' Then
                  begin
                    Strings[X] := '**//***//****//***//**' ;
                  end ;
              end ;
            L2 := pos('\Z MAGNIFY IMAGE:',TempStr1) ;
            If (L2 = 1) Then
              begin
                System.Delete(TempStr1,1,17) ;
                TrimLeft(TempStr1) ;
                Z_Mag := TempStr1 ;
                If ImageData <> 'HEIGHT' Then  Z_Mag := '' ;
              end ;
            L2 := pos('\Z SCALE:',TempStr1) ;
            If (L2 = 1) Then
              begin
                If ImageData = 'HEIGHT' Then
                begin
                  System.Delete(TempStr1,1,10) ;
                  TrimLeft(TempStr1) ;
                  L3 := pos(' ',TempStr1) ;
                  ZScale := Copy(TempStr1,1,L3-1) ;
                  System.Delete(TempStr1,1,L3) ;
                  TrimLeft(TempStr1) ;
                  L3 := Pos(' ',TempStr1) ;
                  ZUnits := Copy(TempStr1,1,L3-1) ;
                  TrimRight(ZUnits) ;
                  Break ;
                end  ;
              end ;
          end ;  // For X := L1 To (L1+17) Do
        end ;
    finally
        TempList.Free   ;

      IHeight := StrToInt(SamplesPerLine)-1 ;
      IWidth := StrToInt(NumLines)-1 ;

      If  pos('NM',XYUNITS) = 0 Then
        begin
          ScanSize := FloatToStrF((StrToFloat(ScanSize)*1000),ffGeneral,10,10) ;
          XYUnits := 'nm' ;
        end ;
      If pos('NM', ZUnits) = 0 Then
        begin
          ZScale := FloatTostrF((StrToFloat(ZScale)*1000),ffGeneral,10,10) ;
          ZUnits := 'nm' ;
        end ;

      Z_ScaleF := StrToFloat(ZScale) ;
      ScalePerZ := Z_ScaleF/65536 ;
      ScalePerXY := StrToFloat(ScanSize)/(IHeight+1) ;



  try
  Result :=  TMemoryStream.Create ;
  FileStr1   := TFileStream.Create(MainForm.Caption,fmOpenReadWrite) ;
  Result.SetSize((IHeight+1)*(IWidth+1)*2) ;
  FileStr1.Seek(DataOffset,soFromBeginning) ; // DataOffset is defined in AFM file and is in bytes
  For L1 := 1 to (DataLength div 2) do        // DataLength is defined in AFM file and is in bytes
    begin
       FileStr1.Read(TempSmall1,2) ;
       Result.Write(TempSmall1,2) ;
    end ;
  finally
    FileStr1.Free ;
  end ; // finally


  For  X:=0 to 511 Do
    begin
      For Y:=0 to 511 Do
        begin
          DataOrig[X,Y] := 0 ;
        end ;
     end ;


    StartFile := (DataOffset div 2);   //indicates 16 bit data (Dataoffset is in bytes)
    AssignFile(f, Filename) ;  // file "f" is declared as "file of smallint"
    Reset(f) ;
    Seek(f,StartFile) ;
    If (IHeight=511) and (IWidth=511) Then
     begin
      BlockRead(f, DataOrig, (DataLength div 2), NumRead)
     end
    else
    if (IHeight=255) and (IWidth=255) Then
      begin
        For X := 0 to IHeight do
        begin
          BlockRead(f, buf1, (DataLength div 512), NumRead) ;
          For Y := 0 to IWidth do
              DataOrig[X,Y] := buf1[Y] ;
        end;

      end ;
   CloseFile(f) ;
//   IHeight := 511 ;
 //  IWidth := 511 ;

   MaxZ :=  -32768 ;
   MinZ :=   32767 ;
   For  X:=0 to 511 Do
    begin
      For Y:=0 to 511 Do
        begin
          TempSmall1 := DataOrig[X,Y] ;
          If TempSmall1 > MaxZ Then
            MaxZ := TempSmall1 ;
          If TempSmall1 < MinZ Then
            MinZ := TempSmall1 ;
        end ;
     end ;

   FullZScale := MaxZ-MinZ ;  {greatest variation in Z data }
   ZScaleHeight :=   ScalePerZ*FullZScale ;
   If Form1.CheckBox1.Checked Then  // Keep perspective on opening file.
     begin
       EyeX := EyeX*ScalePerXY ;
       EyeY :=  EyeY*ScalePerXY ;
       EyeZ := EyeZ*ScalePerXY ;
       CenterZ := CenterZ*ScalePerXY ;
       CenterX := CenterX*ScalePerXY ;
       CenterY := CenterY*ScalePerXY ;
     end ;
   L1_POS[2] := (ScalePerXY*IHeight{*ZMagValue})/2 ;
   Form3.Edit27.Text := FloatToStrf(L1_POS[2],ffGeneral,4,3) ;
   
end ;
Form4.Edit8.Text := floatTostrF((StrToFloat(Form4.Edit8.Text) * ScalePerZ),ffGeneral,4,2) ;  // height of shadow square

Screen.Cursor := crDefault ;
end ;  // LoadOrig(Filename : String) ;


Procedure TMainForm.ReInitialize(Var Sender : TObject) ;   // remakes display list of surface and scalebars
begin
XPos := 0 ;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
If (Sender = Form4.RadioButton1) or (Sender = Form4.RadioButton2) or (Sender = Form4.Edit2)  Then
//   *****  (X-Y Scale = half width)   (X-Y Scale = Full-Width)    (Change X-Y Scale text height)
  begin
    ActivateRenderingContext(Canvas.Handle,RC); // make context drawable
    glDeleteLists(SCALE_BAR,3) ;
    ScaleBarList(Sender) ;  // Reload scale bars only
    wglMakeCurrent(0,0); // another way to release control of context
  end
  Else
   begin
     OpenContinue(Sender) ;
   end ;
end ;



procedure OpenContinue(Sender : TObject) ; // implementation
begin
  ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
    glDeleteLists(SURFACELIST,3) ;
    //  glDeleteLists(1,256) ;
    glListSurface(Sender) ; // make the surface list
    StayInPlace := False ;
    FileLoaded := True ;
    glMatrixMode(GL_PROJECTION); // activate projection matrix
    glLoadIdentity;              // set initial state
    If Form1.RadioButton1.Checked Then
      gluPerspective(PerspectiveAngle,MainForm.ClientWidth/MainForm.ClientHeight,10*ScalePerXY,ScalePerXY*10024); // specify perspective params (see OpenGL.hlp
    If Form1.RadioButton2.Checked Then
      glOrtho(-OrthoVarX,OrthoVarX,-OrthoVarY,OrthoVarY,ScalePerXY/100,ScalePerXY*10048)     ;
    glMatrixMode(GL_ModelView);
    glLoadIdentity;
  wglMakeCurrent(0,0); // another way to release control of context
  DispChange := False ;
  MainForm.FormPaint(Sender);   // cause redraw
end ;

procedure TMainForm.Open1Click(Sender: TObject);
begin
  With MainForm.OpenDialog1 DO
    If Execute Then
      begin
        OpenDialog1.InitialDir := ExtractFileDir(FileName) ;
        OrigData := LoadOrig(Filename) ;
        OpenContinue(Sender) ;
      end ;
end;


procedure TMainForm.Lowest1Click(Sender: TObject);
begin
 Lowest1.Checked := True ;
  Resolution := 8 ;
  StayInPlace := True ;
  ReInitialize(Sender) ;
  StayInPlace := False ;
end;

procedure TMainForm.Low1Click(Sender: TObject);
begin
  Low1.Checked := True ;
  Resolution := 4 ;
  StayInPlace := True ;
  ReInitialize(Sender) ;
  StayInPlace := False ;
end;

procedure TMainForm.Medium1Click(Sender: TObject);
begin
  Medium1.Checked := True ;
  Resolution := 2 ;
  StayInPlace := True ;
  ReInitialize(Sender) ;
  StayInPlace := False ;
end;

procedure TMainForm.High1Click(Sender: TObject);
begin
  High1.Checked := True ;
  Resolution := 1 ;
  StayInPlace := True ;
  ReInitialize(Sender) ;
  StayInPlace := False ;
end;


procedure TMainForm.Points1Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;
  StayInPlace := True ;
//  glEnable(GL_POINT_SMOOTH) ;// should this be here?? or before rendering procedure?  - remove from code : unoptimised no HW accel.
  Refresh ;
  StayInPlace := False ;
end;

procedure TMainForm.Line1Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;
//  glEnable(GL_LINE_SMOOTH) ;// should this be here?? or before rendering procedure?  - remove from code : unoptimised no HW accel.
  StayInPlace := True ;
//  Form4.CheckBox15.Checked := True ;   // enable bled function to get AA lines
  Refresh ;
  StayInPlace := False ;
end;

procedure TMainForm.N11Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;

  LastZMagValue := ZmagValue ;
  ZmagValue := 1.0 ;
//  StayInPlace := True ;
//  ReInitialize(Sender) ;
//  StayInPlace := False ;
  Refresh ;
end;

procedure TMainForm.N21Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;

  LastZMagValue := ZmagValue ;
  ZmagValue := 50.0 ;
//  StayInPlace := True ;
//  ReInitialize(Sender) ;
//  StayInPlace := False ;
  Refresh ;
end;

procedure TMainForm.N51Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;

  LastZMagValue := ZmagValue ;
  ZmagValue := 5.0 ;
 // StayInPlace := True ;
 // ReInitialize(Sender) ;
 // StayInPlace := False ;
 Refresh ;
end;

procedure TMainForm.N101Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;

  LastZMagValue := ZmagValue ;
  ZmagValue := 10.0 ;
//  StayInPlace := True ;
//  ReInitialize(Sender) ;
//  StayInPlace := False ;
  Refresh ;
end;

procedure TMainForm.N201Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;

  LastZMagValue := ZmagValue ;
  ZmagValue := 25.0 ;
//  StayInPlace := True ;
//  ReInitialize(Sender) ;
//  StayInPlace := False ;
  Refresh ;
end;


procedure TMainForm.Custom1Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;
  Form2.Visible := True ;
  Form2.Edit1.SetFocus ;
end;


procedure TMainForm.ColorSetup1Click(Sender: TObject);
begin
  Form3.Visible := True ;
  Form3.BringToFront ;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
Var
  TempList : TStrings ;
begin

TempList := TStringList.Create ;
try
  With TempList Do
   begin
    Try
      add(GetCurrentDir) ;   //final directory used
      add(Form3.Edit1.Text) ; //bkg red%
      add(Form3.Edit2.Text) ; //bkg Green%
      Add(Form3.Edit3.Text) ; //bkg Blue%
      Add(FloatToStr(LevelColor[0])) ;
      Add(FloatToStr(LevelColor[1])) ;
      Add(FloatToStr(LevelColor[2])) ;
      Add(FloatToStr(LevelColor[3])) ;
      SaveToFile(HomeDir+ '\initial.ini') ;
    Except
      on EInOutError Do
    end ;
 end ;
Finally
  TempList.Free ;
end ;

end;

procedure TMainForm.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
ZChangeCount := ZChangeCount + 1 ;

If SpeedButton2.Down Then
begin
  If LastZCountPos < UpDown1.Position Then
    EyeZ := EyeZ + ScalePerXY{*ZMagValue}*(ZChangeCount/2)
  Else
  If LastZCountPos > UpDown1.Position Then
    EyeZ := EyeZ - ScalePerXY{*ZMagValue}*(ZChangeCount/2)  ;
end ;

If SpeedButton3.Down Then
begin
If LastZCountPos < UpDown1.Position Then
    CenterZ := CenterZ + ScalePerXY{*ZMagValue}*(ZChangeCount/2)
  Else
    If LastZCountPos > UpDown1.Position Then
       CenterZ := CenterZ - ScalePerXY{*ZMagValue}*(ZChangeCount/2)  ;
end ;
LastZCountPos := UpDown1.Position ;
Refresh ;
end;

procedure TMainForm.glFlat1Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;

Filled1.Checked := True ;
ShadeModelSmooth := False ;
StayInPlace := True ;
Refresh ;
StayInPlace := False ;
end;

procedure TMainForm.glSmooth1Click(Sender: TObject);
begin
With Sender as TMenuItem Do
  Checked := True ;

Filled1.Checked := True ;

ShadeModelSmooth := True ;
StayInPlace := True ;
Refresh ;
StayInPlace := False ;
end;

procedure TMainForm.CheckBox2Click(Sender: TObject);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;

Refresh ;
end;

procedure TMainForm.Copy1Click(Sender: TObject);
Var
  Source1, Dest1 : TRect ;
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;

If Form1.CheckBox3.Checked Then
  begin
    SpeedButton4.Visible := False ;
    SpeedButton3.Visible := False ;
    SpeedButton2.Visible := False ;
    SpeedButton1.Visible := False ;
    UpDown1.Visible := False ;
   // refresh ;
    ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
      SwapBuffers(MainForm.Canvas.Handle) ;// copy back buffer to front
    DeactivateRenderingContext; // release control of context
  end ;

Image1.Width :=  ClientWidth ;
Image1.Height := ClientHeight ;
Image1.Canvas.Create ;
Image1.Picture.Bitmap.Canvas.Create ;
Image1.Picture.Bitmap.Width := Image1.Width   ;
Image1.Picture.Bitmap.Height := Image1.Height ;

Source1.Left := 0 ;
source1.Top := 0 ;
Source1.Bottom := Image1.Height;
source1.Right := Image1.Width ;

Dest1.Left := 0 ;
Dest1.Top := 0 ;
Dest1.Bottom := Image1.Height  ;
Dest1.Right := Image1.Width ;

If form1.Checkbox4.Checked Then // antialias clipboard is selected
  Form1.Button3Click(Sender);

Image1.Picture.Bitmap.Canvas.CopyRect(Dest1,MainForm.Canvas,source1) ;

Clipboard.Assign(Image1.Picture.Bitmap) ;

//Image1.Picture.Bitmap.FreeImage
Image1.Picture.Bitmap.Width := 5 ;    // probabally not the best way to remove previous bitmap data
Image1.Picture.Bitmap.Height := 5 ;   // so previous bitmap does not protude out sides if window is smaller this time round

SpeedButton4.Visible := true ;
SpeedButton3.Visible := true ;
SpeedButton2.Visible := true ;
SpeedButton1.Visible := true ;
UpDown1.Visible := true ;
ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
  SwapBuffers(MainForm.Canvas.Handle) ;// copy back buffer to front
DeactivateRenderingContext; // release control of context
// refresh ;
end ;


procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
angle := 0.0 ;
PriorAngle := 0.0 ;
DirX := 0 ;
DirY := 0 ;
DontRefresh := True ;
MainForm.Refresh ;
// used to change light position interactivly
{Form1.Checkbox1.Checked := True ;
MainForm.Lowest1Click(Sender)  ;

  ZmagValue := 10.0 ;
  StayInPlace := True ;
  ReInitialize(Sender) ;
  StayInPlace := False ;      }
end;


procedure TMainForm.Exit1Click(Sender: TObject);
begin
mainform.Close ;
end;

procedure TMainForm.Perspective1Click(Sender: TObject);
begin
{Form1.Left := MainForm.Left+MainForm.Width ;
Form1.Top := MainForm.Top + 23 ;
Form3.Left := MainForm.Left+MainForm.Width ;
Form3.Top := MainForm.Top  ;  }
Form1.Visible := true ;
Form1.BringToFront ;
end;



procedure TMainForm.SpeedButton1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
DontRefresh := True ;
end;

procedure TMainForm.N3DFont1Click(Sender: TObject);
Var
  FontName : String  ;
  FontSize : ShortInt ;
begin
With Sender as TMenuItem Do
  Checked := True ;
ActivateRenderingContext(Canvas.Handle,RC);
  glDeleteLists(SCALE_BAR,1) ;
  glDeleteLists(1,256) ;
  FontName := MainForm.FontDialog1.Font.Name ;
  FontSize := MainForm.FontDialog1.Font.Size ;
  BuildOutLineFont(FontName, FontSize); // build 3D font
  ScaleBarList(Sender);
wglMakeCurrent(0,0); // another way to release control of context
XPos:= 0;
YPos := 0;
XDown := 0;
YDown := 0;
Refresh;             // cause redraw
end;

procedure TMainForm.BitmapFont1Click(Sender: TObject);
Var
  FontName : String  ;
  FontSize : ShortInt ;
begin
With Sender as TMenuItem Do
  Checked := True ;
ActivateRenderingContext(Canvas.Handle,RC);
  glDeleteLists(SCALE_BAR,1) ;  //  ** delete scale bar list   **
  glDeleteLists(1,256) ;        //  ** delete font glyphs  **
  FontName := MainForm.FontDialog1.Font.Name ;
  FontSize := MainForm.FontDialog1.Font.Size ;
  BuildOutLineFont(FontName, FontSize);
  ScaleBarList(Sender) ;
wglMakeCurrent(0,0); // another way to release control of context
XPos:= 0;
YPos := 0;
XDown := 0;
YDown := 0;
Refresh;             // cause redraw
end;


procedure TMainForm.Font2Click(Sender: TObject);
Var
  FontName : String  ;
  FontSize : ShortInt ;
begin
If FontDialog1.Execute Then
  begin
  ActivateRenderingContext(Canvas.Handle,RC);
    glDeleteLists(SCALE_BAR,1) ;
    glDeleteLists(1,256) ;
    FontName := MainForm.FontDialog1.Font.Name ;
    FontSize := MainForm.FontDialog1.Font.Size ;
    BuildOutLineFont(FontName, FontSize);
    ScaleBarList(Sender) ;
  wglMakeCurrent(0,0); // another way to release control of context
  XPos:= 0;
  YPos := 0;
  XDown := 0;
  YDown := 0;
  Refresh;             // cause redraw
  end ;
end;

procedure TMainForm.Options1Click(Sender: TObject);
begin
Form4.Visible := True ;
Form4.BringToFront ;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 32 then
   begin
     shiftIn := true ;  // key 32 = spacebar
     MainForm.SetFocus ;
   end ;  
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 32 then shiftIn := false ;
end;

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
XPos:= 0;
YPos := 0;
XDown := 0;
YDown := 0;
//DestroyRenderingContext(RC);
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
//Set this application to accept files dragged and dropped from Explorer
  DragAcceptFiles(Handle, True);
  try
  ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
    SwapBuffers(MainForm.Canvas.Handle) ;// copy back buffer to front
  DeactivateRenderingContext; // release control of context
  XPos:= 0;
  YPos := 0;
  XDown := 0;
  YDown := 0;
  DontRefresh := false ;
  LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left ;
except
  on EInvalidOp Do
  end ;
//  DontRefresh:=false ;
end;



procedure TMainForm.wmDropFiles(var Msg: TWMDropFiles); //message WM_DROPFILES;
var
  CFileName      : array[0..MAX_PATH] of Char;
  TempStr : String ;
begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then begin
      TempStr :=  Format('%s', [CFilename]) ;
//      LoadOrig(TempStr) ;
//      ShowMessage(Format('File %s dropped on application', [CFilename]));
//      ShowMessage(inttostr(max_path));
      Msg.Result := 0;
      FileDroped := True ;
      DropedFileName := TempStr ;
      MainForm.OpenDialog1.InitialDir :=  ExtractFileDir(CFileName) ;
 {     Chdir(ExtractFileDir(CFileName)) ;
      if IOResult <> 0 then
        MessageDlg('Cannot find directory', mtWarning, [mbOk], 0);
      SetCurrentDir(ExtractFileDir(CFileName)) ;                  }
    end;
  finally
    DragFinish(Msg.Drop);
    refresh ;
  end;
end;


procedure StereoVision(Sender: TObject);
Var
  LeftRight : Integer ;
  V1, V2, V3 : Array[0..2] of double ;
  N1 : TNormalDataD ;
  Parallax  : GLDouble ;
  Normalize : Bool ;
begin
Normalize := True ;
Parallax := StrToFloat(Form1.Edit8.Text) ;

V1[0] := EyeX ; V1[1] := EyeY ; V1[2] := EyeZ ;
V2[0] := EyeX ; V2[1] := EyeY ; V2[2] := 0 ;
V3[0] := CenterX ; V3[1] := CenterY ; V3[2] := CenterZ ;
N1 := GetNormalD(V1, V2, V3, Normalize) ;

  glDrawBuffer(GL_Back) ; // GL_NONE
  Screen.Cursor := crHourglass ;
  glLoadIdentity ;
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT) ;
  
  for LeftRight := 0 to 1 do
  begin
    glPushMatrix ;
    If LeftRight = 0 then
      begin  // right eye
        If Form1.CheckBox7.Checked Then  glColorMask(GL_FALSE,GL_TRUE,GL_FALSE,GL_TRUE)  // keep on green component
        else glColorMask(GL_FALSE,GL_FALSE,GL_FALSE,GL_TRUE);  // Turn off green component
        gluLookAt(EyeX+(N1[1]*Parallax*ScalePerXY),EyeY+(N1[2]*Parallax*ScalePerXY),EyeZ,CenterX,CenterY,CenterZ,0,0,1); // set up a viewer position and view direction
      end ;

    If LeftRight = 1 Then
      begin  // left eye
        If Form1.CheckBox8.Checked Then glColorMask(GL_TRUE,GL_FALSE,GL_FALSE,GL_TRUE)  // keep on red component
        else glColorMask(GL_FALSE,GL_FALSE,GL_FALSE,GL_TRUE);   // Turn off red component
        gluLookAt(EyeX-(N1[1]*Parallax*ScalePerXY),EyeY-(N1[2]*Parallax*ScalePerXY),EyeZ,CenterX,CenterY,CenterZ,0,0,1); // set up a viewer position and view direction
        glClear(GL_DEPTH_BUFFER_BIT) ;
      end ;

   //   glPolygonMode(GL_BACK,GL_LINE) ;  // GL_FRONT
   //   glPolygonMode(GL_FRONT,GL_FILL) ;  // GL_FRONT
      DisplayObjects(Sender) ;
      DisplayScales(Sender)  ;
    glPopMatrix ;
  end ;
SwapBuffers(MainForm.Canvas.Handle); // copy back buffer to front
Screen.Cursor := crArrow ;
glColorMask(GL_TRUE,GL_TRUE,GL_TRUE,GL_TRUE);
end;


procedure ChangeAlpha(Sender : TObject; AlphaValue : GLFloat) ;
// Changes all alpha values of material properties and light properties
begin
    LM_Amb[3] := AlphaValue ;
    L0_AMBI[3] := AlphaValue ;
    L0_Dif[3] := AlphaValue ;
    L0_Spec[3] := AlphaValue ;
    glLightfv(GL_LIGHT0, GL_AMBIENT, @L0_AMBI[0]) ;
    glLightfv(GL_LIGHT0,GL_DIFFUSE, @L0_Dif[0]) ;
    glLightfv(GL_LIGHT0,GL_SPECULAR, @L0_Spec[0]) ;

    L1_Dif[3] := AlphaValue ;
    L1_Spec[3] := AlphaValue ;
    glLightfv(GL_LIGHT1, GL_AMBIENT, @L0_AMBI[0]) ;
    glLightfv(GL_LIGHT1,GL_DIFFUSE, @L1_Dif[0]) ;
    glLightfv(GL_LIGHT1,GL_SPECULAR, @L1_Spec[0]) ;

    Mat_Amb[3]  := AlphaValue ;
    Mat_Dif[3]  := AlphaValue ;
    Mat_Spec[3] := AlphaValue ;
    Mat_Emi[3]  := AlphaValue;
    glMaterialfv(GL_FRONT,GL_AMBIENT,@Mat_Amb[0]) ;
    glMaterialfv(GL_FRONT,GL_DIFFUSE,@Mat_DIf[0]) ;
    glMaterialfv(GL_FRONT,GL_SPECULAR,@Mat_Spec[0]) ;
    glMaterialfv(GL_FRONT,GL_Emission,@Mat_Emi[0]) ;

    CurrentAlphaValue := AlphaValue ;
end ;


procedure GetColorInfo1(sender : TObject) ; // implementation
begin
// ************* Light0 ******************* //
    L0_AMBI[0] := 0.2 ;
    L0_AMBI[1] := 0.2 ;
    L0_AMBI[2] := 0.2 ;
//    L0_AMBI[3] := 0.0 ;
    L0_Dif[0] := StrToFloat(Form3.Edit21.Text) ;
    L0_Dif[1] := StrToFloat(Form3.Edit21.Text) ;
    L0_Dif[2] := StrToFloat(Form3.Edit21.Text) ;
//    L0_Dif[3] := 0.0 ;
    L0_Spec[0] := StrToFloat(Form3.Edit21.Text) ;
    L0_Spec[1] := StrToFloat(Form3.Edit21.Text) ;
    L0_Spec[2] := StrToFloat(Form3.Edit21.Text) ;
//    L0_Spec[3] := 0.0;

    glLightfv(GL_LIGHT0, GL_AMBIENT, @L0_AMBI[0]) ;
    glLightfv(GL_LIGHT0,GL_DIFFUSE, @L0_Dif[0]) ;
    glLightfv(GL_LIGHT0,GL_SPECULAR, @L0_Spec[0]) ;
    L0_POS[0] := EyeX ;   // *** this is why lighting changes sometimes  *****
    L0_POS[1] := EyeY ;   // *** this is why lighting changes sometimes  *****
    L0_POS[2] := EyeZ ;   // *(MainForm.UpDown1.Position/100)
    If Form3.CheckBox3.Checked Then L0_POS[3] := 1.0 else  L0_POS[3] := 0.0 ; // determines if light is directional(0.0) or positional(1.0)
    L0_Dir[0] := CenterX-EyeX ;
    L0_Dir[1] := CenterY-EyeY ;
    L0_Dir[2] := CenterZ-(EyeZ) ;

    SpotEx := StrToFloat(Form3.Edit23.Text) ;
    SpotCutOff := StrToFloat(Form3.Edit24.Text) ;
    glLightfv(GL_LIGHT0, GL_POSITION, @L0_POS[0]) ;
    glLightfv(GL_LIGHT0,GL_SPOT_DIRECTION, @L0_Dir[0]) ;
    glLightf(GL_LIGHT0, GL_SPOT_EXPONENT,SpotEx); // N.B. Directional light => nulify SpotEx and SpotCutOff
    glLightf(GL_LIGHT0, GL_SPOT_CUTOFF, SpotCutOff) ;
    glLightf(GL_LIGHT0, GL_CONSTANT_ATTENUATION, 0.5);
    glLightf(GL_LIGHT0, GL_LINEAR_ATTENUATION, 0.0);
    glLightf(GL_LIGHT0, GL_QUADRATIC_ATTENUATION, 0.0);
// *********** End Light0 (moving with viewer) ******************* //



// ************* Light1 ********************* //
    L1_Dif[0] := StrToFloat(Form3.Edit22.Text) ;
    L1_Dif[1] := StrToFloat(Form3.Edit22.Text) ;
    L1_Dif[2] := StrToFloat(Form3.Edit22.Text) ;
//    L1_Dif[3] := StrToFloat(Form3.Edit22.Text) ;
    L1_Spec[0] := StrToFloat(Form3.Edit22.Text) ;
    L1_Spec[1] := StrToFloat(Form3.Edit22.Text) ;
    L1_Spec[2] := StrToFloat(Form3.Edit22.Text) ;
//    L1_Spec[3] := 0.0;
    glLightfv(GL_LIGHT1, GL_AMBIENT, @L0_AMBI[0]) ;
    glLightfv(GL_LIGHT1,GL_DIFFUSE, @L1_Dif[0]) ;
    glLightfv(GL_LIGHT1,GL_SPECULAR, @L1_Spec[0]) ;

    L1_POS[0] := 0.0 ;
    L1_POS[1] := StrToFloat(Form3.Edit28.Text) ;
    L1_POS[2] := StrToFloat(Form3.Edit27.Text) ;//(ScalePerXY*IHeight*ZMagValue)/2 ;   // *(MainForm.UpDown1.Position/100)
    If Form3.CheckBox4.Checked Then L1_POS[3] := 1.0 else L1_POS[3] := 0.0 ; // determines if light is directional(0.0) or positional(1.0)
    L1_Dir[0] := 0  ;
    L1_Dir[1] := 0  ;
    L1_Dir[2] := 1 ;
    SpotEx := StrToFloat(Form3.Edit25.Text) ;
    SpotCutOff := StrToFloat(Form3.Edit26.Text) ;
// The default spot cutoff is 180, resulting in uniform light distribution.

    glLightfv(GL_LIGHT1, GL_POSITION, @L1_POS[0]) ;
    glLightfv(GL_LIGHT1,GL_SPOT_DIRECTION, @L1_Dir[0]) ;
    glLightf(GL_LIGHT1, GL_SPOT_EXPONENT,SpotEx);
    glLightf(GL_LIGHT1, GL_SPOT_CUTOFF, SpotCutOff) ;
    glLightf(GL_LIGHT1, GL_CONSTANT_ATTENUATION, 0.5);
    glLightf(GL_LIGHT1, GL_LINEAR_ATTENUATION, 0.0);
    glLightf(GL_LIGHT1, GL_QUADRATIC_ATTENUATION, 0.0);
// If the light is positional, rather than directional, its intensity is attenuated by
// the reciprocal of the sum of: the constant factor, the linear factor times the distance
// between the light and the vertex being lighted, and the  quadratic factor times the
// square of the same distance. The default attenuation factors are (1,0,0), resulting in
// no attenuation.
// ************* End Light1 ******************* //

    LM_Amb[0] := 0.2 ;
    LM_Amb[1] := 0.2;
    LM_Amb[2] := 0.2;
//    LM_Amb[3] := 0.0;
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, @LM_Amb[0]) ;
    glLightModelf(GL_LIGHT_MODEL_LOCAL_VIEWER,1.0) ; // infinite (0.0) or local (1.0) light Model
    glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 0.0 ) ; //  one sided lighting is enabled (0.0)
    // Turns model black when = 1.0 (two sided lighting)

//************************************************************************
//**************** Material Color Properties *****************************
//************************************************************************
    Mat_Amb[0] := StrToFloat(form3.Edit4.Text) ;
    Mat_Amb[1] := StrToFloat(form3.Edit5.Text) ;
    Mat_Amb[2] := StrToFloat(form3.Edit6.Text) ;
    Mat_Amb[3] := 0.0 ; //StrToFloat(form3.Edit7.Text) ;
    Mat_Dif[0] :=  StrToFloat(form3.Edit8.Text) ;
    Mat_Dif[1] := StrToFloat(form3.Edit9.Text);
    Mat_Dif[2] := StrToFloat(form3.Edit10.Text) ;
    Mat_Dif[3] := 0.0 ;// StrToFloat(form3.Edit11.Text) ;
    Mat_Spec[0] := StrToFloat(form3.Edit12.Text) ;
    Mat_Spec[1] := StrToFloat(form3.Edit13.Text);
    Mat_Spec[2] := StrToFloat(form3.Edit14.Text);
    Mat_Spec[3] := 0.0 ;// StrToFloat(form3.Edit15.Text) ;
    Mat_Emi[0] := StrToFloat(form3.Edit16.Text) ;
    Mat_Emi[1] := StrToFloat(form3.Edit17.Text);
    Mat_Emi[2] := StrToFloat(form3.Edit18.Text);
    Mat_Emi[3] := 0.0 ;// StrToFloat(form3.Edit19.Text);
    Shine      := StrToFloat(form3.Edit20.Text) ;
    glMaterialfv(GL_FRONT,GL_AMBIENT,@Mat_Amb[0]) ;
    glMaterialfv(GL_FRONT,GL_DIFFUSE,@Mat_DIf[0]) ;
    glMaterialfv(GL_FRONT,GL_SPECULAR,@Mat_Spec[0]) ;
    glMaterialfv(GL_FRONT,GL_Emission,@Mat_Emi[0]) ;
    glMaterialfv(GL_FRONT, GL_SHININESS,@Shine);
     glFlush();
end ;


procedure TMainForm.UpDown1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
MouseDownBool := True ;
ZChangeCount := 0 ;
end;

procedure TMainForm.UpDown1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseDownBool := False ;
  ZChangeCount := 0 ;
  XPos:= 0;
  YPos := 0;
  XDown := 0;
  YDown := 0;
  Refresh ;
end;


procedure TMainForm.SpeedButton4Click(Sender: TObject);
begin
DirX := 0.0 ;
DirY := 0.0 ;
end;

procedure TMainForm.Stupidlylow1Click(Sender: TObject);
begin
  Stupidlylow1.Checked := True ;
  Resolution := 16 ;
  StayInPlace := True ;
  ReInitialize(Sender) ;
  StayInPlace := False ;
//  Refresh;             // cause redraw
end;

procedure TMainForm.SpeedButton1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
DontRefresh := True ;
end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin
DontRefresh := True ;
end;

procedure TMainForm.Save1Click(Sender: TObject);
begin

With SaveDialog1 do
  If Execute Then
    begin
      InitialDir := ExtractFileDir(MainForm.Caption) ;
      Filename := ExtractFilename(MainForm.Caption) ;
    end ;

end;

procedure TMainForm.TipConvolution1Click(Sender: TObject);
begin
 TipArtefact.Visible := True ;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
PeakStream.Free ; // stream used for high point data from TipArtefact code
OrigData.Free   ;
end;

end.

