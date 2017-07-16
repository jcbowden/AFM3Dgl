unit ZMag;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2 = class(TForm)
    StaticText1: TStaticText;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure WMMoveWindow(var msg: TWMEraseBkgnd); message WM_MOVE ;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses AFM3D;

{$R *.DFM}

procedure  TForm2.WMMoveWindow(var msg: TWMEraseBkgnd);// message WM_MOUSEACTIVATE ;
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
end ;

procedure TForm2.Button1Click(Sender: TObject); // change ZMagValue
begin
Try
  ZMagValue := StrToFloat(Edit1.Text) ;

  LastZMagValue := ZmagValue ;
  Form2.Visible := False ;
  MainForm.Custom1.Caption := {MainForm.Custom1.Caption + } 'Custom ' + ' (× ' +Edit1.Text+ ')' ;
//  MainForm.ReInitialize(Sender) ;
Except on EConvertError Do
  begin
    Messagedlg('Invalid value for Z magnification',MtError,[mbOK],0) ;
    Edit1.Text := '' ;
  end ;  
end ;
  MainForm.Refresh ;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
Form2.Visible := False ;
end;

end.
