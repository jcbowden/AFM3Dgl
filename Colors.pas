unit Colors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, OpenGL;


procedure FinnalUpdate(Sender : TObject) ; // declaration

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button2: TButton;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit20: TEdit;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    GroupBox4: TGroupBox;
    RadioButton11: TRadioButton;
    RadioButton12: TRadioButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit22: TEdit;
    Edit21: TEdit;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure RadioButton8Click(Sender: TObject);
    procedure RadioButton9Click(Sender: TObject);
    procedure Edit4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit13MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit14MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit15MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit16MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit17MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit18MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit19MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit20MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RadioButton10Click(Sender: TObject);
    procedure Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure RadioButton12Click(Sender: TObject);
    procedure RadioButton11Click(Sender: TObject);
    procedure Edit21MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit21MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit21MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Edit23MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit24MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton11MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit27MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox3Click(Sender: TObject);
  private
    procedure WMMoveWindow(var msg: TWMEraseBkgnd); message WM_MOVE ;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  MouseDownMat : Bool ;
  Mat_Xdown, Mat_Ydown : Single ;
implementation

uses AFM3D, Perspective, ScaleBarOpt;
{$R *.DFM}

procedure  TForm3.WMMoveWindow(var msg: TWMEraseBkgnd);// message WM_MOUSEACTIVATE ;
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
end ;

procedure FinnalUpdate(Sender :TObject) ;
begin
Form3.Refresh ;
ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
    GetColorInfo1(Sender) ;
DeactivateRenderingContext; // release control of context
//MainForm.SetFocus ;
MainForm.Refresh ;
Form3.BringToFront ;
end ;



procedure TForm3.FormCreate(Sender: TObject);
Var
 TempList : TStrings ;
begin
  HomeDir := GetCurrentDir ;
  TempList := TStringList.Create ;
  try
   With TempList Do
    Try
      LoadFromFile(HomeDir+ '\initial.ini') ;
    Except
      on EFOpenError Do
    end ;
{$I-}
  ChDir(TempList.Strings[0]);   //change to directory where last file was opened
  if IOResult <> 0 then
      ChDir(HomeDir);    //if directory not exist then change to program directory
{$I+}
    Edit1.Text := TempList.Strings[1] ;
    Edit2.Text := TempList.Strings[2] ;
    Edit3.Text := TempList.Strings[3] ;

    BKGRed   :=  StrToFloat(Edit1.Text)  ;
    BKGGreen :=  StrToFloat(Edit2.Text)   ;
    BKGBlue  :=  StrToFloat(Edit3.Text)   ;

    LevelColor[0] := StrToFloat(TempList.Strings[4]) ;
    LevelColor[1] := StrToFloat(TempList.Strings[5]) ;
    LevelColor[2] := StrToFloat(TempList.Strings[6]) ;
    LevelColor[3] := StrToFloat(TempList.Strings[7]) ;

  Finally
    TempList.Free ;
  end ;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
Form3.Visible := False ;                                                              
end;

procedure TForm3.RadioButton1Click(Sender: TObject);     //Gold
begin
Edit4.Text := '0.33'  ;Edit5.Text := '0.22' ;Edit6.Text := '0.03' ;Edit7.Text := '1.00' ;
Edit8.Text := '0.78'   ;Edit9.Text := '0.57' ;Edit10.Text := '0.11' ;Edit11.Text := '1.00' ;
Edit12.Text :='0.99'   ;Edit13.Text := '0.94' ;Edit14.Text := '0.81' ;Edit15.Text := '1.00' ;
Edit16.Text := '0.00'  ;Edit17.Text := '0.00' ;Edit18.Text := '0.00' ;Edit19.Text := '0.00' ;
Edit20.Text := '28'  ;
FinnalUpdate(Sender) ;
end ;

procedure TForm3.RadioButton2Click(Sender: TObject);    //Bronze
begin
Edit4.Text := '0.25'  ;Edit5.Text := '0.15' ;Edit6.Text := '0.06' ;Edit7.Text := '1.00' ;
Edit8.Text := '0.40'   ;Edit9.Text := '0.24' ;Edit10.Text := '0.10' ;Edit11.Text := '1.00' ;
Edit12.Text :='0.77'   ;Edit13.Text := '0.46' ;Edit14.Text := '0.20' ;Edit15.Text := '1.00' ;
Edit16.Text := '0.00'  ;Edit17.Text := '0.00' ;Edit18.Text := '0.00' ;Edit19.Text := '0.00' ;
Edit20.Text := '77'  ;
FinnalUpdate(Sender) ;
end;

procedure TForm3.RadioButton3Click(Sender: TObject); //Chrome
begin
Edit4.Text := '0.25'  ;Edit5.Text := '0.25' ;Edit6.Text := '0.25' ;Edit7.Text := '1.00' ;
Edit8.Text := '0.40'   ;Edit9.Text := '0.40' ;Edit10.Text := '0.40' ;Edit11.Text := '1.00' ;
Edit12.Text :='0.77'   ;Edit13.Text := '0.77' ;Edit14.Text := '0.77' ;Edit15.Text := '1.00' ;
Edit16.Text := '0.00'  ;Edit17.Text := '0.00' ;Edit18.Text := '0.00' ;Edit19.Text := '0.00' ;
Edit20.Text := '77'  ;

FinnalUpdate(Sender) ;
end;

procedure TForm3.RadioButton4Click(Sender: TObject);   //Copper
begin
Edit4.Text := '0.23'  ; Edit5.Text := '0.09' ;Edit6.Text := '0.03' ;Edit7.Text := '1.00' ;
Edit8.Text := '0.55'   ;Edit9.Text := '0.21' ;Edit10.Text := '0.07' ;Edit11.Text := '1.00' ;
Edit12.Text :='0.58'   ;Edit13.Text := '0.22' ;Edit14.Text := '0.07' ;Edit15.Text := '1.00' ;
Edit16.Text := '0.00'  ;Edit17.Text := '0.00' ;Edit18.Text := '0.00' ;Edit19.Text := '0.00' ;
Edit20.Text := '51'  ;
FinnalUpdate(Sender) ;
end;

procedure TForm3.RadioButton5Click(Sender: TObject); //Black Plastic
begin
Edit4.Text := '0.00'  ;Edit5.Text := '0.00' ;  Edit6.Text  := '0.00' ; Edit7.Text := '1.0' ;
Edit8.Text := '0.01'   ;Edit9.Text := '0.01' ; Edit10.Text := '0.01' ; Edit11.Text := '1.00' ;
Edit12.Text :='0.50'   ;Edit13.Text := '0.50' ;Edit14.Text := '0.50' ; Edit15.Text := '1.00' ;
Edit16.Text := '0.00'  ;Edit17.Text := '0.00' ;Edit18.Text := '0.00' ; Edit19.Text := '0.00' ;
Edit20.Text := '32'  ;
FinnalUpdate(Sender) ;
end;

procedure TForm3.RadioButton6Click(Sender: TObject); //Emerald
begin
Edit4.Text := '0.02'  ;Edit5.Text := '0.17'   ;Edit6.Text  := '0.02' ; Edit7.Text := '0.55'  ;
Edit8.Text := '0.08'   ;Edit9.Text := '0.61'  ;Edit10.Text := '0.08' ; Edit11.Text := '0.55' ;
Edit12.Text :='0.63'   ;Edit13.Text := '0.73' ;Edit14.Text := '0.63' ; Edit15.Text := '0.55' ;
Edit16.Text := '0.00'  ;Edit17.Text := '0.00' ;Edit18.Text := '0.00'; Edit19.Text := '0.00'  ;
Edit20.Text := '77' ;
FinnalUpdate(Sender) ;
end;

procedure TForm3.RadioButton7Click(Sender: TObject); //Ruby
begin
Edit4.Text := '0.17' ;Edit5.Text := '0.01' ;Edit6.Text := '0.01' ;Edit7.Text := '0.55' ;
Edit8.Text := '0.61'  ;Edit9.Text := '0.04'; Edit10.Text := '0.04' ;Edit11.Text := '0.55' ;
Edit12.Text :='0.73'  ;Edit13.Text := '0.63';Edit14.Text := '0.63' ;Edit15.Text := '0.55' ;
Edit16.Text := '0.00'  ;Edit17.Text := '0.00' ;Edit18.Text := '0.00' ;Edit19.Text := '0.00' ;
Edit20.Text := '77'  ;
FinnalUpdate(Sender) ;
end;

procedure TForm3.RadioButton8Click(Sender: TObject);  //Pearl
begin
Edit4.Text := '0.25'   ;Edit5.Text := '0.21' ; Edit6.Text  := '0.21' ; Edit7.Text  := '0.92' ;
Edit8.Text := '1.00'   ;Edit9.Text := '0.83' ; Edit10.Text := '0.83' ; Edit11.Text := '0.92' ;
Edit12.Text :='0.30'   ;Edit13.Text := '0.30' ;Edit14.Text := '0.30' ; Edit15.Text := '0.92' ;
Edit16.Text := '0.00'  ;Edit17.Text := '0.00' ;Edit18.Text := '0.00' ; Edit19.Text := '0.00' ;
Edit20.Text := '11'  ;
FinnalUpdate(Sender) ;
end;

procedure TForm3.RadioButton9Click(Sender: TObject);  //Pewter
begin
Edit4.Text := '0.11'   ;Edit5.Text := '0.06' ; Edit6.Text  := '0.11' ; Edit7.Text := '1.0' ;
Edit8.Text := '0.43'   ;Edit9.Text := '0.47' ; Edit10.Text := '0.54' ; Edit11.Text := '1.00' ;
Edit12.Text :='0.33'   ;Edit13.Text := '0.33' ;Edit14.Text := '0.52' ; Edit15.Text := '1.00' ;
Edit16.Text := '0.00'  ;Edit17.Text := '0.00' ;Edit18.Text := '0.00' ; Edit19.Text := '0.00' ;
Edit20.Text := '10'  ;
FinnalUpdate(Sender) ;
end;




procedure TForm3.Edit4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Screen.Cursor := crSizeNS ;
MouseDownMat := True ;
end;

procedure TForm3.GroupBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
Screen.Cursor := crDefault ;
end;

procedure TForm3.Edit4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
MouseDownMat := False ;
RadioButton10.OnClick(Sender) ; // updates color matrix with new values (i.e. GetColorInfo1(sender))
RadioButton10.Checked := True ;
//MainForm.SetFocus ;
Form3.BringToFront ;
end;

procedure TForm3.Edit4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit4.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit4.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;     


end;

procedure TForm3.Edit5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit5.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit5.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;     

end;

procedure TForm3.Edit6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit6.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit6.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;
end;

procedure TForm3.Edit7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit7.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit7.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit8.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit8.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit9.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit9.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;     

end;

procedure TForm3.Edit10MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit10.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit10.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit11MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit11.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit11.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit12MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit12.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit12.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit13MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit13.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit13.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit14MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit14.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit14.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit15MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit15.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit15.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit16MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit16.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit16.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit17MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit17.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit17.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit18MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit18.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit18.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit19MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit19.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit19.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit20MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit20.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=128.0)  Then
      begin
        TempFloat := TempFloat + (0.1*(Mat_Ydown-Y)) ;
        If TempFloat > 128.00000 Then TempFloat := 128.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit20.Text := FloatToStrf(TempFloat,ffFixed,3,0) ;
      end ;
   end ;

end;

procedure TForm3.RadioButton10Click(Sender: TObject);
begin
FinnalUpdate(Sender) ;
//MainForm.ReInitialize(Sender) ;
//**** this is not an efficient way to change the current color
//best to update color matrices during change of the material color parameters
// then just refresh screen 
end;

procedure TForm3.Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit1.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit1.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;
end;

procedure TForm3.Edit2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit2.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit2.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    TempFloat := StrToFloat(Edit3.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;
        Edit3.Text := FloatToStrf(TempFloat,ffFixed,2,2) ;
      end ;
   end ;

end;

procedure TForm3.Edit1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
MouseDownMat := False ;
BKGRed   :=  StrToFloat(Edit1.Text)  ;
BKGGreen :=  StrToFloat(Edit2.Text)   ;
BKGBlue  :=  StrToFloat(Edit3.Text)   ;
  XPos := 0 ;
  YPos := 0 ;
  XDown := 0 ;
  YDown := 0 ;
//MainForm.SetFocus ;
MainForm.Refresh ;
Form3.BringToFront ;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
{Form3.Left := MainForm.Left+MainForm.Width ;
Form3.Top := MainForm.Top + 46 ;
Form1.Left := MainForm.Left+MainForm.Width ;
Form1.Top := MainForm.Top  +23 ;
Form4.Left := MainForm.Left+MainForm.Width ;
Form4.Top := MainForm.Top  ;   }
end;



procedure TForm3.RadioButton12Click(Sender: TObject);
begin
If Radiobutton12.Checked Then  // use colored triangles
  begin
    Checkbox1.Enabled := False ;
    CheckBox2.Enabled := False ;
    Checkbox3.Enabled := False ;
    CheckBox4.Enabled := False ;
    Edit21.Enabled := False ;
    Edit22.Enabled := False ;
    Edit23.Enabled := False ;
    Edit24.Enabled := False ;
    Edit25.Enabled := False ;
    Edit26.Enabled := False ;
  end ;
    Screen.Cursor := crHourglass ;
 //   MainForm.SetFocus ;
    MainForm.ReInitialize(Sender) ;
    Form3.BringToFront ;
    Screen.Cursor := crDefault ;
end;

procedure TForm3.RadioButton11Click(Sender: TObject); //
begin
  Screen.Cursor := crHourGlass ;
//  MainForm.SetFocus ;
  MainForm.ReInitialize(Sender) ;
  If Radiobutton11.Checked Then   // use lighting equations
  begin
    Checkbox1.Enabled := True ;
    CheckBox2.Enabled := True ;
    Checkbox3.Enabled := True ;
    CheckBox4.Enabled := True ;
    Edit21.Enabled := True ;
    Edit22.Enabled := True ;
    Edit23.Enabled := True ;
    Edit24.Enabled := True ;
    Edit25.Enabled := True ;
    Edit26.Enabled := True ;
  end ;
  Form3.BringToFront ;
  Screen.Cursor := crDefault ;
end;

procedure TForm3.Edit21MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    If Sender = Edit21 Then TempFloat := StrToFloat(Edit21.Text)
    else
    If Sender = Edit22 Then TempFloat := StrToFloat(Edit22.Text) ;

    If (TempFloat >= 0.0) and (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat > 1.00000 Then TempFloat := 1.0000 ;
        If TempFloat < 0.000 Then TempFloat := 0.000 ;

        If Sender = Edit21 Then
          begin
            Edit21.Text := FloatToStrf(TempFloat,ffFixed,2,2)  ;
          end
        else
        If Sender = Edit22 Then
          begin
            Edit22.Text := FloatToStrf(TempFloat,ffFixed,2,2)  ;
          end
      end ;
  end ;
end ;


procedure TForm3.Edit21MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Screen.Cursor := crSizeNS ;
MouseDownMat := True ;
end;

procedure TForm3.Edit21MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseDownMat := False ;
  XPos := 0 ;
  YPos := 0 ;
  XDown := 0 ;
  YDown := 0 ;
  ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
    GetColorInfo1(Sender) ;
  wglMakeCurrent(0,0); // another way to release control of context
//  MainForm.SetFocus ;
  MainForm.Refresh ;
  Form3.BringToFront ;
end;

procedure TForm3.CheckBox1Click(Sender: TObject);
begin
ActivateRenderingContext(Canvas.Handle,RC); // make context drawable
  If CheckBox1.Checked Then glEnable(GL_LIGHT0)
  else glDisable(GL_LIGHT0) ;
  XPos := 0 ;
  YPos := 0 ;
  XDown := 0 ;
  YDown := 0 ;
  GetColorInfo1(Sender) ;
DeactivateRenderingContext; // release control of context
//  MainForm.SetFocus ;
  MainForm.Refresh ;
  Form3.BringToFront ;
end;

procedure TForm3.CheckBox2Click(Sender: TObject);
begin
ActivateRenderingContext(Canvas.Handle,RC); // make context drawable
  If CheckBox2.Checked Then glEnable(GL_LIGHT1)
  else glDisable(GL_LIGHT1) ;
  XPos := 0 ;
  YPos := 0 ;
  XDown := 0 ;
  YDown := 0 ;
  GetColorInfo1(Sender) ;
DeactivateRenderingContext; // release control of context
//  MainForm.SetFocus ;
  MainForm.Refresh ;
  Form3.BringToFront ;  
end;

procedure TForm3.CheckBox4Click(Sender: TObject);
begin
ActivateRenderingContext(Canvas.Handle,RC); // make context drawable
  If Form3.CheckBox4.Checked Then L1_POS[3] := 1.0 else L1_POS[3] := 0.0 ; // determines if light is directional(0.0) or positional(1.0)
  XPos := 0 ;
  YPos := 0 ;
  XDown := 0 ;
  YDown := 0 ;
DeactivateRenderingContext; // release control of context
MainForm.Refresh ; 
end;

procedure TForm3.Edit23MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    If Sender = Edit23 Then TempFloat := StrToFloat(Edit23.Text)
    else
    If Sender = Edit25 Then TempFloat := StrToFloat(Edit25.Text) ;

    If (TempFloat >= 1.00000) and (TempFloat <=128.0)  Then
      begin
        TempFloat := TempFloat + (0.01*(Mat_Ydown-Y)) ;
        If TempFloat > 128.00000 Then TempFloat := 128.0000 ;
        If TempFloat < 1.000 Then TempFloat := 1.0 ;
      end ;
   If  (TempFloat <=1.0)  Then
      begin
        TempFloat := TempFloat + (0.0001*(Mat_Ydown-Y)) ;
        If TempFloat < 0.000 Then TempFloat := 0 ;
      end ;

      If Sender = Edit23 Then Edit23.Text := FloatToStrf(TempFloat,ffFixed,3,3)  
      else
      If Sender = Edit25 Then Edit25.Text := FloatToStrf(TempFloat,ffFixed,3,3)  ;

  end ;
end ;


procedure TForm3.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//Mat_Ydown := Y ;
end;


procedure TForm3.Edit24MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    If Sender = Edit24 Then TempFloat := StrToFloat(Edit24.Text)
    else
    If Sender = Edit26 Then TempFloat := StrToFloat(Edit26.Text) ;

    If (TempFloat >= 0.00000) and (TempFloat <=180.0)  Then
      begin
        If (Tempfloat = 180.0) and  ((Mat_Ydown-Y) < 0 ) then  TempFloat := 90.0
        else
          begin
            TempFloat := TempFloat + (0.01*(Mat_Ydown-Y)) ;
            If TempFloat > 90.00000 Then TempFloat := 180.0000 ;
            If TempFloat < 0.000 Then TempFloat := 0.0 ;
          end ;
      end ;

      If Sender = Edit24 Then Edit24.Text := FloatToStrf(TempFloat,ffFixed,3,3)
      else
      If Sender = Edit26 Then Edit26.Text := FloatToStrf(TempFloat,ffFixed,3,3)  ;
  end ;
end ;

procedure TForm3.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  XPos := 0 ;
  YPos := 0 ;
  XDown := 0 ;
  YDown := 0 ;
//  MainForm.SetFocus ;
  MainForm.Refresh ;
  Form3.BringToFront ;
end;

procedure TForm3.RadioButton11MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 Form3.BringToFront ;
end;



procedure TForm3.Edit27MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  TempFloat : Single ;
begin
If MouseDownMat Then
  begin
    If Sender = Edit27 Then TempFloat := StrToFloat(Edit27.Text) ;
       TempFloat := TempFloat + (ScalePerXY*(Mat_Ydown-Y)) ;
    If Sender = Edit27 Then Edit27.Text := FloatToStrf(TempFloat,ffFixed,3,3) ;
    If Sender = Edit28 Then TempFloat := StrToFloat(Edit28.Text) ;
       TempFloat := TempFloat + (ScalePerXY*(Mat_Ydown-Y)) ;
    If Sender = Edit28 Then Edit28.Text := FloatToStrf(TempFloat,ffFixed,3,3) ;
  end ;

end ;



procedure TForm3.CheckBox3Click(Sender: TObject);
begin
ActivateRenderingContext(Canvas.Handle,RC); // make context drawable
  If Form3.CheckBox1.Checked Then L0_POS[3] := 1.0 else L0_POS[3] := 0.0 ; // determines if light is directional(0.0) or positional(1.0)
  XPos := 0 ;
  YPos := 0 ;
  XDown := 0 ;
  YDown := 0 ;
DeactivateRenderingContext; // release control of context
//MainForm.SetFocus ;
MainForm.Refresh ;
Form3.BringToFront ;
end;


end.
