unit ScaleBarOpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TForm4 = class(TForm)
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    GroupBox3: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    GroupBox4: TGroupBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    Edit2: TEdit;
    GroupBox5: TGroupBox;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Label2: TLabel;
    Edit6: TEdit;
    Label4: TLabel;
    CheckBox15: TCheckBox;
    Edit7: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox1: TGroupBox;
    CheckBox16: TCheckBox;
    Edit8: TEdit;
    Label3: TLabel;
    RadioButton5: TRadioButton;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Edit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox5Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Edit2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    procedure WMMoveWindow(var msg: TWMEraseBkgnd); message WM_MOVE ;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation


uses AFM3D, Perspective, Colors, OpenGL ;

{$R *.DFM}

procedure  TForm4.WMMoveWindow(var msg: TWMEraseBkgnd);// message WM_MOUSEACTIVATE ;
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
end ;

procedure TForm4.FormActivate(Sender: TObject);
begin
{Form4.Left := MainForm.Left+MainForm.Width ;
Form4.Top := MainForm.Top + 46 ;
Form3.SendToBack ;
Form3.Left := MainForm.Left+MainForm.Width ;
Form3.Top := MainForm.Top  ;
Form1.Left := MainForm.Left+MainForm.Width ;
Form1.Top := MainForm.Top + 23 ;  }
end;

procedure TForm4.Edit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Screen.Cursor := crSizeNS ;
MouseDownMat := True ;
end;

procedure TForm4.Edit1MouseUp(Sender: TObject; Button: TMouseButton;
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
form4.BringToFront ;
end;

procedure TForm4.Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit1.Text) ;
    TempFloat := TempFloat + ((ScalePerZ*3)*(Mat_Ydown-Y)) ;
    Edit1.Text := FloatToStrf(TempFloat,ffFixed,4,3) ;
   end ;

end;


procedure TForm4.CheckBox5Click(Sender: TObject);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
//MainForm.SetFocus ;
MainForm.Refresh ;
end;

procedure TForm4.RadioButton1Click(Sender: TObject);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
MainForm.ReInitialize(Sender) ;
MainForm.Refresh ;
end;



procedure TForm4.Edit2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    If Sender = Edit2 Then
    TempFloat := StrToFloat(Edit2.Text)
    else
    If Sender = Edit8 Then
    TempFloat := StrToFloat(Edit8.Text)
    else
    If Sender = Edit1 Then
    TempFloat := StrToFloat(Edit1.Text) ;
    
    TempFloat := TempFloat + ((ScalePerZ*3)*(Mat_Ydown-Y)) ;

    If Sender = Edit2 Then
        Edit2.Text := FloatToStrf(TempFloat,ffFixed,4,3)
    else
      If Sender = Edit8 Then
        Edit8.Text := FloatToStrf(TempFloat,ffFixed,4,3) 
    else
      If Sender = Edit1 Then
        Edit1.Text := FloatToStrf(TempFloat,ffFixed,4,3) ;

   end ;
end;

procedure TForm4.Edit3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    If Sender = Edit3 Then TempFloat := StrToFloat(Edit3.Text)
    else
    If Sender = Edit4 Then TempFloat := StrToFloat(Edit4.Text)
    else
    If Sender = Edit5 Then TempFloat := StrToFloat(Edit5.Text) 
    else
    If Sender = Edit6 Then TempFloat := StrToFloat(Edit6.Text)
    else
    If Sender = Edit7 Then TempFloat := StrToFloat(Edit7.Text) ;

    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;

        If Sender = Edit3 Then
         begin
          Edit3.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
          If RadioButton3.Checked Then TextColor[0]:=TempFloat
          else If RadioButton4.Checked Then BarColor[0] := TempFloat  else LevelColor[0] := TempFloat ;
         end
        else
        If Sender = Edit4 Then
         begin
           Edit4.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
           If RadioButton3.Checked Then TextColor[1]:=TempFloat
          else If RadioButton4.Checked Then BarColor[1] := TempFloat  else LevelColor[1] := TempFloat ;
         end
        else
        If Sender = Edit5 Then
          begin
            Edit5.Text := FloatToStrf(TempFloat,ffFixed,2,2)  ;
            If RadioButton3.Checked Then TextColor[2]:=TempFloat
          else If RadioButton4.Checked Then BarColor[2] := TempFloat  else LevelColor[2] := TempFloat ;
          end
        else
        If Sender = Edit6 Then
          begin
            Edit6.Text := FloatToStrf(TempFloat,ffFixed,2,2)  ;
            If RadioButton3.Checked Then TextColor[3]:=TempFloat
          else If RadioButton4.Checked Then BarColor[3] := TempFloat  else LevelColor[3] := TempFloat ;
          end ;
        If Sender = Edit7 Then
          begin
            Edit7.Text := FloatToStrf(TempFloat,ffFixed,2,2)  ;
          end
      end ;
   end ;
end;

procedure TForm4.RadioButton3Click(Sender: TObject);
begin
If RadioButton3.Checked Then
begin
  Edit3.Text := FloatToStr(TextColor[0]) ;
  Edit4.Text := FloatToStr(TextColor[1]) ;
  Edit5.Text := FloatToStr(TextColor[2]) ;
  Edit6.Text := FloatToStr(TextColor[3]) ;
end  ;

end;

procedure TForm4.RadioButton4Click(Sender: TObject);
begin
If RadioButton4.Checked Then
begin
  Edit3.Text := FloatToStr(BarColor[0]) ;
  Edit4.Text := FloatToStr(BarColor[1]) ;
  Edit5.Text := FloatToStr(BarColor[2]) ;
  Edit6.Text := FloatToStr(BarColor[3]) ;
end ;
end;


procedure TForm4.FormCreate(Sender: TObject);
begin
// Form4.Visible := True ;
end;

procedure TForm4.CheckBox15Click(Sender: TObject);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
//MainForm.SetFocus ;
MainForm.Refresh ;
form4.BringToFront ;
{If CheckBox15.Checked Then
  Edit6.Enabled := True
else
  Edit6.Enabled := False ;  }
end;





procedure TForm4.CheckBox16Click(Sender: TObject);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
MainForm.Refresh ;
form4.BringToFront ;
end;

procedure TForm4.RadioButton5Click(Sender: TObject);
begin
If RadioButton5.Checked Then
begin
  Edit3.Text := FloatToStr(LevelColor[0]) ;
  Edit4.Text := FloatToStr(LevelColor[1]) ;
  Edit5.Text := FloatToStr(LevelColor[2]) ;
  Edit6.Text := FloatToStr(LevelColor[3]) ;
end ;
end;

procedure TForm4.RadioButton3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
// MainForm.SetFocus ;
end;

procedure TForm4.CheckBox5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
form4.BringToFront ;
end;

end.
