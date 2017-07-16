unit FileInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ComCtrls, StdCtrls;

type
  TForm4 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    StringGrid1: TStringGrid;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CheckBox6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses emissionGL, ColorsEM;

{$R *.DFM}

procedure TForm4.StringGrid1Click(Sender: TObject);
Var
  TempRow : Integer ;
begin

If CheckBox6.Checked = false Then   // display single spectra that was highlited
  begin
    if checkbox7.Checked = false then  // then do not keep current perspecive
      begin
        If StringGrid1.Objects[1,StringGrid1.Selection.Top] is TSpectraRanges Then
          begin
            Form1.UpdateViewRange() ;  // updates  OrthoVarXMax, OrthoVarXMin, OrthoVarYMax, OrthoVarYMin. Used when XY data is modified
            EyeX := 0 ;
            EyeY := 0 ;
            CenterX := 0 ;
            CenterY := 0 ;
          end ;
      end ;
  end ;

  TempRow := StringGrid1.Selection.Top ;
  Form1.Caption := StringGrid1.Cells[1,TempRow] ;
  Form2.Label28.Caption := StringGrid1.Cells[1,TempRow] ;
  Form2.Label28.Hint := Form2.Label28.Caption ;
  If StringGrid1.Objects[1,StringGrid1.Selection.Top] is TSpectraRanges Then
    begin
     CurrentFileName := TSpectraRanges(StringGrid1.Objects[1,StringGrid1.Selection.Top]).filename ;  // CurrentFileName not used at present
 //    Image1.Picture.Bitmap.Free ;
     Form2.Image1.Picture.Bitmap.Assign(TSpectraRanges(StringGrid1.Objects[1,TempRow]).FColorBitmap) ;
    end ;
  Form1.FormResize(Sender) ;
end;

procedure TForm4.StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  If  (Col = 0) and (Row < StringGrid1.RowCount-1) Then
   begin
     if (StringGrid1.Objects[1,Row] IS TSpectraRanges) then
       StringGrid1.Canvas.Draw(Rect.Left,Rect.Top, TBitmap(StringGrid1.Objects[Col,Row])) ;
   end ;
end;

procedure TForm4.CheckBox6Click(Sender: TObject);
begin
StringGrid1Click(Sender) ;
end;

end.
