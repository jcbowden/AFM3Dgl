unit Perspective;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Edit4: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Image1: TImage;
    StaticText1: TStaticText;
    CheckBox3: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Button3: TButton;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    TrackBar1: TTrackBar;
    CheckBox10: TCheckBox;
    Edit8: TEdit;
    procedure Edit4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure Edit8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox5Click(Sender: TObject);
//    procedure Button4Click(Sender: TObject);
  private
    procedure WMMoveWindow(var msg: TWMEraseBkgnd); message WM_MOVE ;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MouseDownPerspective : bool ;
//  AntiAliasPressed : bool ;
implementation

Uses
  AFM3D, Colors, ScaleBarOpt, OpenGL, glAntiAlias ;

{$R *.DFM}
procedure  TForm1.WMMoveWindow(var msg: TWMEraseBkgnd);// message WM_MOUSEACTIVATE ;
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
end ;

{procedure TMainForm.WMSMButtonDown(var msg: TWMEraseBkgnd); // message=WM_ACTIVATEAPP
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
end ;

procedure TMainForm.WMSMButtonUp(var msg: TWMEraseBkgnd);  // message=WM_EXITSIZEMOVE
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
MainForm.Refresh ;
end ;          }

procedure TForm1.Edit4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownPerspective Then
  begin
    TempFloat := StrToFloat(Edit4.Text) ;
    If (TempFloat >= 0) and (TempFloat <= 360)  Then
      begin
        TempFloat := TempFloat + (0.1*(-Y)) ;
        If TempFloat > 360.0 Then TempFloat := 0.0000 ;
        If TempFloat < 0.000 Then TempFloat := 360.000 ;
        Edit4.Text := FloatToStrf(TempFloat,ffFixed,3,0) ;
      end ;
   end ;
end;

procedure TForm1.Edit4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
Screen.Cursor := crSizeNS ;
MouseDownPerspective := True ;
end;

procedure TForm1.Edit4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
PerspectiveAngle := StrToFloat(Edit4.Text) ;
MouseDownPerspective := False ;
//MainForm.SetFocus ;
MainForm.FormResize(Sender) ;
Form1.BringToFront ;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.CheckBox1.Checked := False ;
  PerspectiveAngle := StrToInt(Edit4.Text) ;
//  AntiAliasPressed := False ;
end;



procedure TForm1.Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var  
  TempFloat : Single ;
begin
If MouseDownPerspective Then
  begin
    TempFloat := StrToFloat(Edit1.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <= 3)  Then
      begin
        TempFloat := TempFloat + (0.001*(-Y)) ;
        If TempFloat > 3.0 Then TempFloat := 3.0000 ;
        If TempFloat < 0.100 Then TempFloat := 0.100 ;
        Edit1.Text := FloatToStrf(TempFloat,ffFixed,3,2) ;
      end ;
   end ;

end;

procedure TForm1.Edit1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  TempFloat : Single ;
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;

TempFloat :=  MainForm.Image1.Width/MainForm.Image1.Height ; // =aspect ratio
if MainForm.Image1.Width <= MainForm.Image1.Height Then
   begin
     OrthoVarX := StrToFloat(Edit1.Text)*256*ScalePerXY ;   // get rid of this one //** need to change this to get screen aspect ratio correct **
     OrthoVarY := StrToFloat(Edit1.Text)*256*ScalePerXY*TempFloat ;
   end
else
   begin
     OrthoVarX := StrToFloat(Edit1.Text)*256*ScalePerXY*TempFloat ;
     OrthoVarY := StrToFloat(Edit1.Text)*256*ScalePerXY ; // get rid of this one
   end ;
MouseDownPerspective := False ;
//MainForm.SetFocus ;
MainForm.FormResize(Sender) ;
Form1.BringToFront ;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
Var
  TempFloat : Single ;
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
TempFloat := MainForm.Image1.Height/MainForm.Image1.Width ;
if MainForm.Image1.Width <= MainForm.Image1.Height Then
   begin
     OrthoVarX := StrToFloat(Edit1.Text)*256*ScalePerXY*TempFloat ;
     OrthoVarY := StrToFloat(Edit1.Text)*256*ScalePerXY ;
   end
else
   begin
     OrthoVarX := StrToFloat(Edit1.Text)*256*ScalePerXY ;
     OrthoVarY := StrToFloat(Edit1.Text)*256*ScalePerXY*TempFloat ;
   end ;
//MainForm.SetFocus ;
MainForm.FormResize(Sender) ;
Form1.BringToFront ;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
PerspectiveAngle := StrToFloat(Edit4.Text) ;
//MainForm.SetFocus ;
MainForm.FormResize(Sender) ;
Form1.BringToFront ;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Form1.Close ;
end;




procedure TForm1.Button1Click(Sender: TObject);  // reset view to original position
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
 If MainForm.SpeedButton3.Down Then
   begin
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
    CenterZ :=  0.0 ; //(ScalePerZ*(DataOrig[255,255]+32768)) ;
   end ;
 If MainForm.SpeedButton2.Down Then
   begin
    EyeX := 0 ;
    EyeY := 0 ;
    EyeZ :=  (IHeight*ScalePerXY{*ZMagValue})/2 +( ScalePerXY*IHeight) ;  //ZScaleHeight + (ZScaleHeight*0.3) ;
   end ;

  MainForm.Refresh ;
end;

procedure TForm1.Button3Click(Sender: TObject); // AntiAlias
Var
StopTime, StartTime : DWord ;
jitter, TempInt : Integer ;
TempStr : String ;
JitArray : array[0..8, 0..1] of GLDouble ;
//ErrorCode : GLenum ;
TempFloat1, OrthoX, OrthoY : Single ;
begin
StartTime := GetTickCount ;
TempStr := MainForm.StatusBar1.Panels.Items[2].Text ;
TempInt := Pos(' ', TempStr) ;
TempStr := Copy(TempStr,1,TempInt) ;
TempFloat1 := ( (1/StrToFloat(TempStr))* 9) ;
If TempFloat1 > 20.0 Then
 begin
    If (MessageDlg('This option could take over ' +FloatToStrf(TempFloat1,ffGeneral,4,1)+' seconds, do you want to continue?',mtConfirmation,[mbYes,mbNo],0))<>IDYES Then
      abort ;
 end ;
MainForm.StatusBar1.Panels.Items[0].Text := 'Total time = '+FloatToStrf(TempFloat1,ffGeneral,4,1)+ ' seconds for 9 render passes' ;

If RadioButton1.Checked Then // perspective projection anti-alias code
  begin
   JitArray[0,0] := 0.5 ;
   JitArray[0,1] := 0.5 ;
   JitArray[1,0] := 0.166666666666 ;
   JitArray[1,1] := 0.944444444444 ;
   JitArray[2,0] := 0.5 ;
   JitArray[2,1] := 0.1666666666666 ;
   JitArray[3,0] := 0.5 ;
   JitArray[3,1] := 0.83333333333333 ;
   JitArray[4,0] := 0.16666666666666 ;
   JitArray[4,1] := 0.2777777777777 ;
   JitArray[5,0] := 0.8333333333333 ;
   JitArray[5,1] := 0.3888888888888 ;
   JitArray[6,0] := 0.1666666666666 ;
   JitArray[6,1] := 0.6111111111111 ;
   JitArray[7,0] := 0.8333333333333 ;
   JitArray[7,1] := 0.7222222222222 ;
   JitArray[8,0] := 0.8333333333333 ;
   JitArray[8,1] := 0.0555555555555 ;
 end
 else
   begin  // not RadioButton1.Checked Then  orthographic projection anti-alias code
     JitArray[0,0] := 0.6666666666666 / 2 ;
     JitArray[0,1] := -0.888888888888 / 2 ;
     JitArray[1,0] := -0.666666666666 / 2;
     JitArray[1,1] := 0.888888888888 / 2;
     JitArray[2,0] := 0 ;
     JitArray[2,1] := -0.6666666666666 / 2;
     JitArray[3,0] := 0.0 ;
     JitArray[3,1] := 0.6666666666666 / 2;
     JitArray[4,0] := -0.666666666666/ 2;
     JitArray[4,1] := -0.444444444444/ 2 ;
     JitArray[5,0] := 0.6666666666666 / 2;
     JitArray[5,1] := -0.666666666666/ 2 ;
     JitArray[6,0] := -0.666666666666 / 2;
     JitArray[6,1] := 0.222222222222 / 2;
     JitArray[7,0] := 0.6666666666666 / 2 ;
     JitArray[7,1] := 0.4444444444444 / 2 ;
     JitArray[8,0] := 0.0 ;  // keep last values as zero so as to remove need to reset Orthographic projection
     JitArray[8,1] := 0.0 ;
   end ;


ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
glDrawBuffer(GL_Back) ;

Screen.Cursor := crHourglass ;
glClearAccum(0.0,0.0,0.0,0.0) ;
glClear(GL_ACCUM_BUFFER_BIT) ;
glLoadIdentity ;

If RadioButton1.Checked Then // perspective projection anti-alias code
begin
  for jitter := 0 to 8 do
  begin
    // this function in glAntiAlias.pas, ClientHeight-19 because of status bar is included???
    GLAccumPerspective(MainForm.ClientWidth, Mainform.ClientHeight-19, StrToFloat(Edit4.Text),MainForm.ClientWidth/Mainform.ClientHeight,ScalePerXY*10,ScalePerXY*10024,JitArray[jitter,0],JitArray[jitter,1],0.0,0.0,1.0) ;
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT) ;
    gluLookAt(EyeX,EyeY,EyeZ,CenterX,CenterY,CenterZ,0,0,1); // set up a viewer position and view direction
    If Form4.CheckBox15.Checked then  // use blend function (scales drawn first)
        begin
         glEnable(GL_BLEND) ;
         ChangeAlpha(Sender,BarColor[3])  ;
         glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA) ;    //   GL_SRC_ALPHA  GL_ONE_MINUS_SRC_ALPHA  }
         DisplayScales(Sender) ;  // display scale bars and then XYZ pointer values (when spacebar pressed)
         ChangeAlpha(Sender,StrToFloat(Form4.Edit7.Text)) ;
         DisplayObjects(Sender) ;  // main rendering of surface
         ChangeAlpha(Sender,1.0) ;
        end
        else  // do not use blend function (and scales drawn last, due to no depth testing)
          begin
            glDisable(GL_BLEND) ;
            If Form4.CheckBox16.Checked Then ShowRedSquare() ;
            DisplayObjects(Sender) ;  // main rendering of surface
            If Not Form4.CheckBox18.Checked Then glClear(GL_DEPTH_BUFFER_BIT) ;
            DisplayScales(Sender) ;  // display scale bars and then XYZ pointer values (when spacebar pressed)
          end ;
    if jitter = 0 then
      glAccum(GL_LOAD, 1/9)
    else
      glAccum(GL_ACCUM, 1/9) ;
    DeactivateRenderingContext; // need to do this or only a single render is done before swapbuffer
      MainForm.StatusBar1.Panels.Items[0].Text := IntToStr(jitter+1) + ' of 9 render passes' ;
    ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable  
  end ;
end ;
If RadioButton2.Checked Then  // Orthographic projection AntiAlias
begin
  for jitter := 1 to 9 do
  begin
   { glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT) ;
    glLoadIdentity ;
    gluLookAt(EyeX,EyeY,EyeZ,CenterX,CenterY,CenterZ,0,0,1); // set up a viewer position and view direction    }
    glPushMatrix ;
   {   glTranslatef(((JitArray[jitter-1,0]*4*OrthoVarX)/MainForm.ClientWidth),
                   ((JitArray[jitter-1,1]*4*OrthoVarY)/MainForm.ClientHeight-19),0.0) ;   }
      OrthoX := ((JitArray[jitter-1,0]*2*OrthoVarX)/MainForm.ClientWidth) ;  //amount to jitter in X direction
      OrthoY := ((JitArray[jitter-1,1]*2*OrthoVarY)/MainForm.ClientHeight) ; //amount to jitter in Y direction

          //   glViewport(0,0,Mainform.ClientWidth,MainForm.Height-19); // specify a viewport (has not necessarily to be the entire window)
             glMatrixMode(GL_PROJECTION); // activate projection matrix
             glLoadIdentity;              // set initial state
             //*** this does the jittering, seems faster than the glTranslate technique
             glOrtho(-OrthoVarX+OrthoX,OrthoVarX+OrthoX,-OrthoVarY+OrthoY,OrthoVarY+OrthoY,ScalePerXY/100,ScalePerXY*10048)   ;
             glMatrixMode(GL_ModelView);
             glLoadIdentity;
             glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT) ;
             glLoadIdentity ;
             gluLookAt(EyeX,EyeY,EyeZ,CenterX,CenterY,CenterZ,0,0,1); // set up a viewer position and view direction

      If Form4.CheckBox15.Checked then  //*** use blend function (scales drawn first)
        begin
         glEnable(GL_BLEND) ;
         ChangeAlpha(Sender,BarColor[3])  ;
         glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA) ;    //   GL_SRC_ALPHA  GL_ONE_MINUS_SRC_ALPHA  }
         DisplayScales(Sender) ;  // display scale bars and then XYZ pointer values (when spacebar pressed)
         ChangeAlpha(Sender,StrToFloat(Form4.Edit7.Text)) ;
         DisplayObjects(Sender) ;  // main rendering of surface
         ChangeAlpha(Sender,1.0) ;
        end
        else  //*** do not use blend function (and scales drawn last, due to no depth testing)
          begin
            glDisable(GL_BLEND) ;
            If Form4.CheckBox16.Checked Then ShowRedSquare() ;
            DisplayObjects(Sender) ;  // main rendering of surface
            If Not Form4.CheckBox18.Checked Then glClear(GL_DEPTH_BUFFER_BIT) ;
            DisplayScales(Sender)   // display scale bars and then XYZ pointer values (when spacebar pressed)
          end ;
    glPopMatrix ;
    if jitter = 1 then
      glAccum(GL_LOAD, 1/9)
    else
      glAccum(GL_ACCUM, 1/9) ;

    DeactivateRenderingContext; // need to do this or only a single render is done before swapbuffer
      MainForm.StatusBar1.Panels.Items[0].Text := IntToStr(jitter+1) + ' of 9 render passes' ;
    ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
  end ;

end ; // Orthographic projection AntiAlias

StopTime := GetTickCount ;
MainForm.StatusBar1.Panels.Items[0].Text := ' Final transfer (' + FloatToStrf((StopTime-StartTime)/1000,ffGeneral,5,3)+ ' seconds actual, ' +FloatToStrf(TempFloat1,ffGeneral,4,1)+' calculated)'  ;
glAccum(GL_Return,1.0) ;
SwapBuffers(MainForm.Canvas.Handle); // copy back buffer to front
glDrawBuffer(GL_Back) ; // GL_NONE
Screen.Cursor := crArrow ;
DeactivateRenderingContext; // release control of context
end;


procedure TForm1.CheckBox4Click(Sender: TObject);
Var
TempFloat1 : Single ;
TempStr : String ;
TempInt : Integer ;
begin
If CheckBox4.Checked Then
Begin
TempStr := MainForm.StatusBar1.Panels.Items[1].Text ;
TempInt := Pos(' ', TempStr) ;
TempStr := Copy(TempStr,1,TempInt) ;
TempFloat1 := ((  (1/StrToFloat(TempStr)) + (1/StrToFloat(TempStr)) ) * 12) ;
If TempFloat1 > 20.0 Then
 begin
   If (MessageDlg('This option could take over ' +FloatToStrf(TempFloat1,ffGeneral,4,1)+' seconds, do you want to continue?',mtConfirmation,[mbYes,mbNo],0))<>IDYES Then
     CheckBox4.Checked := False ;
   end ;
 end ;

end;




procedure TForm1.CheckBox6Click(Sender: TObject);
begin
If Checkbox6.Checked Then
MainForm.StatusBar1.Panels.Items[0].Text := 'green filter over right eye'  ;
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
//MainForm.SetFocus ;
MainForm.refresh ;
Form1.BringToFront ;
end;



procedure TForm1.CheckBox9Click(Sender: TObject);

begin
ActivateRenderingContext(Canvas.Handle,RC); // make context drawable
If CheckBox9.Checked Then // glEnable(GL_FOG) - seen Form.Refresh code
  begin
    TrackBar1.Enabled := True  ;
   end 
else
  begin
   TrackBar1.Enabled := False ;
     glDisable(GL_FOG) ;
  end ;
DeactivateRenderingContext; // release control of context
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
//MainForm.SetFocus ;
MainForm.Refresh ;
Form1.BringToFront ;
end;

procedure TForm1.CheckBox10Click(Sender: TObject);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
//MainForm.SetFocus ;
MainForm.Refresh ;
Form1.BringToFront ;
end;


procedure TForm1.Edit8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
MouseDownMat := False ;
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
//MainForm.SetFocus ;
MainForm.Refresh ;
Screen.Cursor := crDefault ;
Form1.BringToFront ;
end;

procedure TForm1.Edit8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
 Var
 TempFloat : GLFloat ; 
begin
If MouseDownMat Then
  begin
    If Sender = Edit8 Then
    TempFloat := StrToFloat(Edit8.Text)  ;
    TempFloat := TempFloat + ((ScalePerZ/2)*(Mat_Ydown-Y)) ;
    If Sender = Edit8 Then
        Edit8.Text := FloatToStrf(TempFloat,ffFixed,4,3) ;
   end ;

end;

procedure TForm1.Edit8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Screen.Cursor := crSizeNS ;
MouseDownMat := True ;
end;

procedure TForm1.CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

// MainForm.SetFocus ;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
//MainForm.SetFocus ;
MainForm.ReInitialize(Sender) ;
MainForm.Refresh ;
Form1.BringToFront ;
end;

end.
