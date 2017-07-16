unit ViewPort;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Edit4: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    Edit1: TEdit;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MouseDownPerspective : bool ;
implementation

Uses
  AFM3D ;

{$R *.DFM}


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
MainForm.FormResize(Sender) ;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PerspectiveAngle := StrToInt(Edit4.Text) ;

end;



procedure TForm1.Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var  
  TempFloat : Single ;
begin
If MouseDownPerspective Then
  begin
    TempFloat := StrToFloat(Edit1.Text) ;
    If (TempFloat >= 0.0) and (TempFloat <= 10)  Then
      begin
        TempFloat := TempFloat + (0.001*(-Y)) ;
        If TempFloat > 10.0 Then TempFloat := 10.0000 ;
        If TempFloat < 0.100 Then TempFloat := 0.100 ;
        Edit1.Text := FloatToStrf(TempFloat,ffFixed,3,2) ;
      end ;
   end ;

end;

procedure TForm1.Edit1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
XPos := 0;
YPos := 0 ;
XDown := 0 ;
YDown := 0 ;
OrthoVar := StrToFloat(Edit1.Text)*256*ScalePerXY ;
MouseDownPerspective := False ;
MainForm.FormResize(Sender) ;
end;

end.
