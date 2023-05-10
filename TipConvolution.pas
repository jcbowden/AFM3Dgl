unit TipConvolution;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, OpenGL, Math, UITypes;

type
  TTipArtefact = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    Label7: TLabel;
    Edit3: TEdit;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit4: TEdit;
    Label13: TLabel;
    Label9: TLabel;
    Edit5: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit6: TEdit;
    CheckBox5: TCheckBox;
    Button3: TButton;
    Edit7: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit8: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    procedure WMMoveWindow(var msg: TWMEraseBkgnd); message WM_MOVE ;
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TMemBuffer = class(TObject)
  private
    FMemStream: TMemoryStream;   // MemoryStream to hold single line of data
  public
    RowNumber : Integer ; // Number to identify age of list (when > TipHeight then replace data with new line data)
    constructor Create; // found in implementation part below
    destructor Destroy; // found in implementation part below
    property MemStream: TMemoryStream read FMemStream write FMemStream ;
  end;

var
  TipArtefact: TTipArtefact;
  TWidth, THeight : Integer ;  // tip dimension in pixels
  ProcessContinue : Bool ;

implementation

uses AFM3D, Colors;

constructor TMemBuffer.Create;
begin
  inherited;
  FMemStream := TMemoryStream.Create;
end;

destructor TMemBuffer.Destroy;
begin
  FMemStream.Free;
  inherited;
end;

{$R *.DFM}

procedure  TTipArtefact.WMMoveWindow(var msg: TWMEraseBkgnd);// message WM_MOUSEACTIVATE ;
begin
DontRefresh:=true ;
LastTopPos:= MainForm.Top  ; LastLeftPos := MainForm.Left  ;
end ;

procedure TTipArtefact.Button1Click(Sender: TObject);
Var
  TempFloat1 : Single ;
begin
TempFloat1 := StrToFloat(Edit1.Text)/ScalePerXY ;
If (round(TempFloat1)) >= 3 Then
begin
  Label3.Caption := IntToStr(round(TempFloat1)) + ' pixels'   ;
  TWidth := round(TempFloat1) ;
end
else
begin
  MessageDlg('tip is less than 3 pixels wide, will not process',mtError,[mbOK],0) ;
  Exit ;
end ;

TempFloat1 := StrToFloat(Edit2.Text)/ScalePerXY ;
If (round(TempFloat1)) >= 3 Then
begin
  Label4.Caption := IntToStr(round(TempFloat1)) + ' pixels'   ;
  THeight := round(TempFloat1) ;
end
else
begin
  MessageDlg('tip is less than 3 pixels high, will not process',mtError,[mbOK],0) ;
  ProcessContinue := true ;
end ;

end;

procedure TTipArtefact.FormCreate(Sender: TObject);
begin
  ProcessContinue := False ;
end;

procedure TTipArtefact.Button2Click(Sender: TObject);
Var
 XX, YY, X1, Y1, YYY, XXX, ZZZ, Counter, ListItemNumber, IHeight2, IWidth2 : Integer ;
 ABC1, ABC2, LowLineNumber, TempInt1 : Integer ;
 TempSmall1, TipCenterValue, NumberEqual, NumOver, NumOverNew : Integer ;
 TempFloat1, TempFloat2, TempFloat3, TempFloat4, TempFloat5 : Single ;
 TempSmall2, TempSmall3 : SmallInt ;
 Imagedata, OrigData2, PeakData, PeakStats : TMemoryStream ;
 BufList : TList ;
 BiggestOld, BiggestNew : Array[1..2] of Integer ;
 TempBuff : Array[0..511] of Integer ;
 SmallIntBuff : Array[0..511] of SmallInt ;
 TempStart, TempStop : DWord ;
 Point1, Point2 : TxyzArrayS ;
 Distance1, MinDist, MinDist2, TempNoise  : Single ;
 AddToStream : Bool ;
 TempStr1 : String ;
 TempStrList : TStringList ;
begin
If not ProcessContinue Then
Begin
try
TempStart := GetTickCount ;
IHeight2  := (IHeight+1)  ;
IWidth2   := (IWidth+1 )  ;

ImageData := TMemoryStream.Create ;
OrigData2  := TMemoryStream.Create ;
PeakData  := TMemoryStream.Create ;
PeakStats := TMemoryStream.Create ;
TempStrList := TStringList.Create ;

PeakStream.Clear ;
ImageData.SetSize(IHeight2*IWidth2*2) ;  // size of data in bytes
OrigData2.SetSize(512*512*4)  ;
PeakData.SetSize(12*655536)  ;

NumberEqual := 0 ;
NumOver     := 0 ;
NumOverNew  := 0 ;

TempFloat1  := StrToFloat(Edit3.Text) ;  // minimum height of peak

Edit4.Text := Trim(Edit4.text) ;         // maximum height of peak
If Edit4.Text <> '' Then
 TempFloat2  := StrToFloat(Edit4.Text)
else
 begin
   TempFloat2 := (MaxZ-MinZ) * ScalePerZ ; // default is maximum Z scale id text = 0, NAN
   Edit4.Text := FloatToStrF(TempFloat2,ffGeneral,4,4) ;
 end ;

Edit5.Text := Trim(Edit5.text) ;
If Edit5.Text <> '' Then
  MinDist := abs(StrToFloat(Edit5.Text)) // minimum separation to alow designation as seperate peaks
else
  begin
    MinDist := 0 ;
    Edit4.Text := FloatToStrF(MinDist,ffGeneral,4,4) ;
  end ;

TempNoise := StrToFloat(Edit6.Text) ;


X1 := (THeight div 2) +1 ;
Y1 := (TWidth  div 2) +1 ;

OrigData.Seek(0,soFromBeginning) ;
OrigData2.Seek(0,soFromBeginning) ;
For XX := 0 to IHeight Do
For YY := 0 to IWidth do
  begin
    OrigData.ReadBuffer(TempSmall2,2) ;
    TempInt1 := TempSmall2 ;
    OrigData2.WriteBuffer(TempInt1,4) ;
  end ;
OrigData2.Seek(0,soFromBeginning) ;
BufList := TList.Create ;
BufList.Capacity := THeight ;
For XX := 0 to THeight-1 Do  // Algorithm part 0 - create buffers and read in data (THeight=Tip Height)
  begin
    BufList.Add(TMemBuffer.Create) ;
    OrigData2.Read(TempBuff,2048)   ;  // 2048 = 512*4  *** should make this general for ant image width.***
    TMemBuffer(BufList.Items[XX]).MemStream.SetSize(2048) ;
    TMemBuffer(BufList.Items[XX]).MemStream.Seek(0,SoFromBeginning) ;
    TMemBuffer(BufList.Items[XX]).MemStream.WriteBuffer(TempBuff,2048) ;
    TMemBuffer(BufList.Items[XX]).RowNumber := XX + 1 ;
    TMemBuffer(BufList.Items[XX]).MemStream.Seek(0,soFromBeginning) ;  // set pointer to start of buffer
  end ;

ImageData.Seek(0,soFromBeginning) ;
For XX := 0 to X1-1 do ; // Algorithm part 1 - write rows of unchanged pixels
  begin
    TMemBuffer(BufList.Items[XX]).MemStream.ReadBuffer(TempBuff,2048) ;
    For YY := 0 to 511 do SmallIntBuff[YY] := TempBuff[YY] ;
      ImageData.WriteBuffer(SmallIntBuff,1024) ;
  end ;

For ZZZ := 0 to (Theight-1) Do // set all line buffers to start of data
  begin
    TMemBuffer(BufList.Items[ZZZ]).MemStream.Seek(0,soFromBeginning) ;
  end ;

If CheckBox3.Checked Then
   Randomize ;            

ListItemNumber := Y1-1 ;  // start of lists is halfway across width of tip
For YY := Y1 to (IHeight2-(THeight-Y1)) do // Algorithm part 2 - start of iterative collection of highest value
  begin
     If ListItemNumber >= BufList.Count-1 Then // current TMemBuffer being written to = ListItemNumber
       ListItemNumber := 0
     else
       ListItemNumber := ListItemNumber + 1 ;  // determines TMembuffer used for current (being written to) row of image data

     For XX := 1 to (X1-1) do  // (start of line processing) Algorithm part 2a  - read in unchanged edge pixels into final image
       begin
         TMemBuffer(BufList.Items[ListItemNumber]).MemStream.Read(TempSmall1,4) ;
         TempSmall2 := TempSmall1 ;
         ImageData.Write(TempSmall2,2) ;
         TMemBuffer(BufList.Items[ListItemNumber]).MemStream.Seek(0,soFromBeginning) ; // set data pointer back to zero
       end ;

     BiggestOld[1] := -32768 ;
         For YYY := 0 to THeight-1 do  // move down buffers (Subtract 1 due to TList index starting at 0 )
           begin
             For XXX := 1 to TWidth do  // Algorithm part 2b2 - read in width of tip
               begin
                 TMemBuffer(BufList.Items[YYY]).MemStream.Read(TempSmall1,4) ;  // read integer into buffer (Tempsmall1)
                 If TempSmall1 > BiggestOld[1] Then
                   begin
                     BiggestOld[1] := TempSmall1 ;
                     BiggestOld[2] := XXX*4      ;  // position along MemoryStream (in bytes) ;
                   end ;
               end ;
           end ; // For YYY := 1 to THeight do



     For XX := X1 to (IWidth2-(TWidth-X1)) do  // (incremental processing) Algorithm part 2b - move 'tip' across row
       begin
           BiggestNew[1] := -32768 ;
           For YYY := 0 to THeight-1 do  // B1: Find new highest from new data
             begin
               TMemBuffer(BufList.Items[YYY]).MemStream.Read(TempSmall1,4) ;
               If TempSmall1 > BiggestNew[1] then
                  begin
                    BiggestNew[1] := TempSmall1 ;
                    BiggestNew[2] := TMemBuffer(BufList.Items[YYY]).MemStream.Position - 4      ;  // position along MemoryStream (in bytes) ;
                  end ;
             end ;  // end B1: Find new highest from new data

           TempInt1 := TMemBuffer(BufList.Items[ListItemNumber]).MemStream.Position ;

           If biggestOld[2] >= (TempInt1-(TWidth*4) ) then   // B2 - see if old biggest is within new tip area
             begin // B2Y
                If BiggestNew[1] > BiggestOld[1] then
                  begin // B3Y
                    BiggestOld[1] := BiggestNew[1] ;
                    BiggestOld[2] := BiggestNew[2] ;
                  end ;
              //else do nothing // B3N
             end
           else // B2N
             begin
               BiggestOld[1] := BiggestNew[1] ;
               BiggestOld[2] := BiggestNew[2] ;
             end ;

           //*** collect stats on how many surface points equal the highest point  ***//
           TMemBuffer(BufList.Items[ListItemNumber]).MemStream.Seek((XX-1)*4,soFromBeginning) ; //XX = position of center of tip
           TMemBuffer(BufList.Items[ListItemNumber]).MemStream.Read(TipCenterValue,4) ;
           TMemBuffer(BufList.Items[ListItemNumber]).MemStream.Seek(TempInt1,soFromBeginning) ;  // put pointer back
           If (TipCenterValue = BiggestOld[1]) Then
             begin
               NumberEqual := NumberEqual + 1 ;
              If ( BiggestOld[1] > (MinZ+ (TempFloat1/ScalePerZ) )) and (BiggestOld[1] < (MinZ+ (TempFloat2/ScalePerZ)) ) Then
                begin
                  NumOver := NumOver + 1 ;
                  Point1[1] := ScalePerXY*(XX-(IWidth2 div 2)); Point1[2]:= ScalePerXY*(YY-(IHeight2 div 2)); Point1[3] := BiggestOld[1]  ;
                  PeakData.Write(Point1[1],12) ;
                end ;
             end ;
           If CheckBox3.Checked Then
             begin
            //   Randomize ;
               BiggestOld[1] :=  BiggestOld[1] + round(ScalePerZ *TempNoise* random) ;
               If  BiggestOld[1] > 32767 then   BiggestOld[1] := 32767 - round(ScalePerZ *TempNoise* random) ; ;
             end ;
          //*** end collect stats on how many surface points equal the highest point  ***//

        TempSmall2 := BiggestOld[1] ;  // B4
        ImageData.WriteBuffer(TempSmall2,2) ; // add biggest to new image   // Label6.Caption := 'Biggest ' + IntToStr(TempSmall2) ;
       end ;  // (end incremental processing) end Algorithm part 2b - move 'tip' across row


     TMemBuffer(BufList.Items[ListItemNumber]).MemStream.Seek(-(4*(TWidth-X1)),soFromCurrent) ;
     For XX := 1 to (TWidth-X1) do  // Algorithm part 2e  - write final unchanged right edge pixels into final image
       begin
         TMemBuffer(BufList.Items[ListItemNumber]).MemStream.ReadBuffer(TempSmall1,4) ;
         TempSmall2 := TempSmall1 ;
         ImageData.WriteBuffer(TempSmall2,2) ;
       end ;
     ABC2 := MaxInt ;
     For ZZZ := 0 to (Theight-1) Do //iterate through list to find oldest buffer data (lowest line number)
       begin
           ABC1 := TMemBuffer(BufList.Items[ZZZ]).RowNumber ;
           If ABC1 < ABC2 Then
             begin
               LowLineNumber := ZZZ ;  // LowLineNumber = Tlist item number needed to be replaced
               ABC2 := ABC1 ;
             end ;
       end ;
       TMemBuffer(BufList.Items[LowLineNumber]).MemStream.Clear ; // clear data, write new line of data, update line number
       OrigData2.Read(TempBuff,2048)   ;
       TMemBuffer(BufList.Items[LowLineNumber]).MemStream.Write(TempBuff,2048) ;   // had error when WriteBuffer used???
       TMemBuffer(BufList.Items[LowLineNumber]).RowNumber :=(YY + (THeight-Y1) + 1) ;
       TMemBuffer(BufList.Items[LowLineNumber]).MemStream.Seek(0,soFromBeginning) ;  // set pointer to start of buffer
      For ZZZ := 0 to (Theight-1) Do // set all buffers to start of data
       begin
         TMemBuffer(BufList.Items[ZZZ]).MemStream.Seek(0,soFromBeginning) ;
       end ;
    ProgressBar1.Position := round(((YY-Y1)/(IHeight2-THeight)) * 100 )  ;
  end ; //  YY := Y1 to (IHeight2-(THeight-Y1)) do // end Algorithm part 2

For YY := (IHeight2-(THeight-Y1)) to IHeight2 do   // write final (THeight-Y1) rows of unchanged data
  begin
     For XX := 0 to THeight-1 Do
       begin
          If TMemBuffer(BufList.Items[XX]).RowNumber = YY then
            begin
              TMemBuffer(BufList.Items[XX]).MemStream.ReadBuffer(TempBuff,2048) ;
              For YYY := 0 to 511 do SmallIntBuff[YYY] := TempBuff[YYY] ;
                ImageData.WriteBuffer(SmallintBuff,1024) ;   // write final rows of unchanged data
            end ;
       end ;
  end ;

TempStop := GetTickCount ;
try
  begin
      TempFloat1 := (TempStop-TempStart)/1000 ;
      Label11.Caption := 'Time = ' + FloatToStrF(TempFloat1,ffGeneral,4,5) ;
 end ;
Except on EInvalidOp do
end ;
////////////////////////
///// Remove lowest points within close proximity and points without close neighbours in new Stream
////////////////////////
// PeakStream.Clear ; put this earlier on in procedure
PeakData.Seek(0,soFromBeginning) ;
MinDist2 := (ScalePerXY*IWidth)/3 ;
For XX := 1 to NumOver-1 Do
  begin
    AddToStream := True ;
    PeakData.Seek((XX-1)*12,soFromBeginning) ;
    PeakData.Read(Point1[1],12) ;
    For YY := (XX+1) to NumOver-1 Do
      begin
            PeakData.Seek((YY-1)*12,soFromBeginning) ;
            PeakData.Read(Point2[1],12) ;
            Distance1 := Sqrt(Sqr(Point1[1]-Point2[1])+sqr(Point1[2]-Point2[2])+sqr(Point1[3]-Point2[3])) ;
            If Distance1 < MinDist Then
              begin
                If Point1[3] <= Point2[3] then  // don't add point1 to PeakStream
                  begin
                    AddToStream := False ;
                    break ;
                  end ;
                end ;
            If Checkbox2.Checked Then  // dont add if point lies along same row (removes spike features)
              begin
                If (Point1[2] = Point2[2]) and (Distance1 < MinDist2) then  // don't add point1 to PeakStream
                  begin
                    AddToStream := False ;
                    break ;
                  end ;
              end
      end ;
    If AddToStream  Then
      begin
        PeakStream.SetSize(PeakStream.Size+12) ;
        NumOverNew := NumOverNew +  1  ;
        PeakStream.Write(Point1[1],12)  ;
      end ;
    ProgressBar1.Position := round((XX/(NumOver-1))* 100 )  ;
  end ; // For XX := 1 to NumOver-1 Do

////////////////
//// Remove peaks along same X positon ** most likely due to noise spike **
///////////////

///////////////////////////////////////////////////////////////////////////////
////  Get Stats and create GL list of point
///////////////////////////////////////////////////////////////////////////////
If NumOverNew > 0 Then  // this ends at end of glList making code
begin
///**** Get stats on peaks found ****////
If CheckBox1.Checked Then
begin
PeakStream.Seek(0,SoFromBeginning);
For XX := 1 to  NumOverNew do
  begin
    AddToStream := True ;
    PeakStream.Read(Point1[1],12) ;
    If Peakstats.Size > 0 then
    begin
    For YY := 1 to (Peakstats.Size div 8) do
      begin
        PeakStats.Seek(((YY-1)*8),SoFromBeginning) ;
        PeakStats.Read(TempInt1,4)    ;
        PeakStats.Read(TempFloat3, 4) ;
        If TempFloat3 = Point1[3] then
          begin
             TempInt1 := TempInt1 + 1 ;
             PeakStats.Seek(-8,SoFromCurrent) ;
             PeakStats.Write(TempInt1,4) ;
             AddToStream := False ;
             Break ;
          end ;
      end ;
    end ; // If Peakstats.Size > 0 then
    If AddToStream  Then
      begin
        PeakStats.SetSize(PeakStats.Size+8) ;
        TempInt1 := 1 ;
        PeakStats.Write(TempInt1,4)  ;
        PeakStats.Write(Point1[3],4)  ;
      end ;
  end ;
PeakStats.Seek(0,SoFromBeginning) ;
For XX := 1 to  (Peakstats.Size div 8) do
  begin
    PeakStats.Read(TempInt1,4)    ;
    PeakStats.Read(TempFloat3, 4) ;
    TempStr1 := FloatToStrF((({ZMagValue*}ScalePerZ*(TempFloat3+32767))-({ZMagValue * }ScalePerZ * (MinZ+32767))), ffGeneral,5,5  ) + ',' + InttoStr(TempInt1) ;
    TempStrList.Add(TempStr1) ;
  end ;

Memo1.Lines.Add(extractfilename('*****'+MainForm.Caption)) ;
//memo1.Text := TempStrL.Text ;
For XX := 0 to TempStrList.Count-1 do
begin
   Memo1.Lines.Add(TempStrList.Strings[XX]) ;
 // Memo1.Lines.Strings[XX] := TempStrList.Strings[XX] ;
end ;
end ;// if CheckBox1.Checked (get statistics)

///*** Create GLList containing peak points for display on surface rendering ***///
  TempFloat2 := {ZMagValue * }ScalePerZ * (MinZ+32767) ;
  PeakStream.Seek(0,soFromBeginning) ;
  ActivateRenderingContext(MainForm.Canvas.Handle,RC); // make context drawable
  glDeleteLists(PEAKPOINTS,1) ;
  glNewList(PEAKPOINTS, GL_COMPILE);
        glDisable(GL_LIGHTING) ;
        glEnable(GL_POINT_SMOOTH) ;
        glPointSize(5) ;
        glColor3f(1.0,0.0,0.0) ;
        For YY := 0 to NumOver Do
          begin
             PeakStream.Read(Point1[1],12) ;
             Point1[3] := (({ZMagValue*}ScalePerZ*(Point1[3]+32767))-TempFloat2) + (ScalePerZ*200) ;
             glBegin(GL_POINTS) ;
               glVertex3f(Point1[2],Point1[1],Point1[3]) ;
             glEnd() ;
          end ;
        glEnable(GL_LIGHTING) ;
        If form3.CheckBox1.Checked Then  glEnable(GL_LIGHT0) else glDisable(GL_LIGHT0)  ;
        If form3.CheckBox2.Checked Then glEnable(GL_LIGHT1)  else glDisable(GL_LIGHT1)  ;
        glDisable(GL_POINT_SMOOTH) ;
    glEndList();
  wglMakeCurrent(0,0); // another way to release control of context
end ;


TempStart := GetTickCount ;
try
  begin
      TempFloat1 := (TempStart-TempStop)/1000 ;
      Label11.Caption := Label11.Caption + ' + ' + FloatToStrF(TempFloat1,ffGeneral,4,5) ;
 end ;
Except on EInvalidOp do
end ;


Label7.Caption := 'Total peaks = ' + IntToStr(NumberEqual) ;
Label15.Caption := 'Peaks per µm² = ' + FloatToStrF( (  NumOverNew/ (   ((ScalePerXY/1000)*(IWidth2))*((ScalePerXY/1000)*(IHeight2)) )    ), ffGeneral, 4,4 )  ;
Label10.Caption := 'Peaks = '+ IntToStr(NumOverNew)+ ' ('+ IntToStr(NumOver) +') peaks over ' + Edit3.Text + ' nm' ;
OrigData2.Clear ;
//OrigData2.SetSize(IHeight2*IWidth2*2) ;  not needed due to LoadFromFile setting it to fit file size exactly
OrigData2.LoadFromFile(MainForm.Caption) ;
Origdata2.Seek(8192,soFromBeginning) ;
ImageData.Seek(0,soFromBeginning) ;
For YY := 0 to IHeight Do
For XX := 0 to IWidth Do
  begin
    ImageData.ReadBuffer(TempSmall2,2) ;
    OrigData2.WriteBuffer(TempSmall2,2) ;
  end ;


If CheckBox5.Checked then  // calculate deflection image
  begin
    ImageData.Seek(0,soFromBeginning) ;
    For XX := 0 to IHeight do
      Begin
         ImageData.Read(TempSmall2,2) ;
         For YY := 0 to (IWidth-1) do
           begin
             ImageData.Read(TempSmall3,2) ;
             try
             TempSmall2 := TempSmall2-TempSmall3 ;
             except on ERangeError do
               TempSmall2 := 0 ;
             end ;
             ImageData.Seek(-4,soFromCurrent) ;
             ImageData.Write(TempSmall2,2) ;
             TempSmall2 := TempSmall3 ;
             ImageData.Seek(2,SoFromCurrent) ;
           end ;
         ImageData.Seek(-2,SoFromCurrent) ;
         ImageData.Write(TempSmall2,2) ;
      end ;
    Origdata2.Seek(532480,soFromBeginning) ;
    ImageData.Seek(0,soFromBeginning) ;
      For YY := 0 to IHeight Do
      For XX := 0 to IWidth Do
        begin
          ImageData.ReadBuffer(TempSmall2,2) ;
          TempSmall2 := -1*TempSmall2 ;
          OrigData2.WriteBuffer(TempSmall2,2) ;
        end ;
  end ;


Beep ;
With MainForm.SaveDialog1 do
begin
  InitialDir := ExtractFileDir(MainForm.Caption) ;
  Filename := ExtractFilename(MainForm.Caption) ;
  If Execute Then
    begin
      OrigData2.SaveToFile(filename) ;
    end ;
end ;

finally
 For XX := 0 to THeight-1 Do  // Algorithm part 0 - create buffers and read in data
  begin
    TMemBuffer(BufList.Items[XX]).free ;  // set pointer to start of buffer
  end ;
  ImageData.Free   ;
  OrigData2.Free    ;
  PeakData.Free    ;
  TempStrList.Free ;
  BufList.Free     ;
  ProgressBar1.Position := 0 ;
end ; // try.. finally block
end ; // If not ProcessContinue
end; // end of procedure TTipArtefact.FormCreate(Sender: TObject);





procedure TTipArtefact.Button3Click(Sender: TObject);
Var
Imagedata, OrigData2, TempStream1 : TMemoryStream ;
XX, YY, IHeight2, IWidth2 : Integer ;
MaxAngle : Single ;
MaxInt, IterationX, MaxIteration : Integer ;
SmallAr : Array[0..3] of SmallInt ;
{FileStr1 : TFileStream ;}
TempSmall1, TempSmall2, TempSmall3 : SmallInt ;
SpikePresent : bool ;
begin
try
  SpikePresent := True ;
  IHeight2   := (IHeight+1)  ;
  IWidth2    := (IWidth+1 )  ;
  ImageData  := TMemoryStream.Create ;
  OrigData2   := TMemoryStream.Create ;
  TempStream1 := TMemoryStream.Create ;

  ImageData.SetSize(IHeight2*IWidth2*2) ;
  TempStream1.SetSize(IHeight2*2) ;

{ try
  FileStr1   := TFileStream.Create(MainForm.Caption,fmOpenReadWrite) ;
  OrigData.SetSize(IHeight2*IWidth2*2) ;
  FileStr1.Seek(DataOffset,soFromBeginning) ; // DataOffset is defined in AFM file and is in bytes
  For XX := 1 to (DataLength div 2) do        // DataLength is defined in AFM file and is in bytes
    begin
       FileStr1.Read(TempSmall1,2) ;
       OrigData.Write(TempSmall1,2) ;
    end ;
  finally
    FileStr1.Free ;
  end ; // finally   }
  OrigData2.SetSize(IHeight2*IWidth2*2) ;
  For XX := 1 to (DataLength div 2) do // DataLength is defined in AFM file and is in bytes
    begin
       OrigData.Read(TempSmall1,2) ;
       OrigData2.Write(TempSmall1,2) ;
    end ;

  MaxAngle := StrToFloat(Edit7.Text)              ;
  MaxAngle := Tan((MaxAngle*3.141592654)/180)     ;
  MaxInt := Round((MaxAngle*ScalePerXY)/ScalePerZ);
  MaxIteration := StrToInt(Edit8.Text)          ;
  IterationX := 1 ;

while ((IterationX <= MaxIteration) and (SpikePresent=True)) do
begin
  SpikePresent := false ;
  ImageData.Seek(0,soFromBeginning) ;
  For YY := 0 to IWidth do
    begin
      TempStream1.Seek(0,soFromBeginning) ;
      OrigData2.Seek(YY*2,soFromBeginning) ;
      For XX := 1 to IHeight2 Do
        begin
          OrigData2.Read(TempSmall1,2) ;
          OrigData2.Seek(((XX*IWidth2)+YY)*2,soFromBeginning) ;
          TempStream1.Write(TempSmall1,2) ;
        end ;
      TempStream1.Seek(0,soFromBeginning) ;
      TempStream1.Read(TempSmall1,2) ;
      ImageData.Write(TempSmall1,2)  ;
      For XX := 1 to IHeight2-2 do
        begin
          TempStream1.Seek(((XX-1)*2),soFromBeginning) ;              //     If (SmallAr[2]<=SmallAr[1]) then  // step back down
          TempStream1.Read(SmallAr[0],8) ;                            //       begin  [][][][]
          If (SmallAr[0]-SmallAr[1]) < (-1*MaxInt) then // step up    //         ImageData.Write(SmallAr[0],2) ;
            begin                                                     //        end
              SpikePresent := true ;
              ImageData.Write(SmallAr[0],2) ;                        //      else    // step up again
            end
          else                                                        //        If SmallAr[3] < SmallAr[2] then   // step down
          If ((SmallAr[0]-SmallAr[1]) > MaxInt) then  // step down    //          begin
            begin                                                     //            ImageData.Write(SmallAr[0],2) ;
               SpikePresent := true ;                                 //           end
               If SmallAr[2] >= SmallAr[1] then   // step back up     //         else
                 begin                                                //           ImageData.Write(SmallAr[0],2) ;  // step up
                   ImageData.Write(SmallAr[1],2) ;                    //        end ;
                 end                                                  //     begin
               else   // step down again
                 begin
                   If SmallAr[3] > SmallAr[2] then  // next on step up
                     begin
                      ImageData.Write(SmallAr[2],2) ;
                     end
                  else
                     begin                           // next on another step down
                       ImageData.Write(SmallAr[3],2) ;
                     end
                 end ;
            end
          else
             ImageData.Write(SmallAr[1],2) ;
        end ;
      ImageData.Write(SmallAr[3],2)  ;
      ProgressBar1.Position := round((YY/IWidth2)* 100 )  ;
    end ;

 If SpikePresent then // this rotates data and inverts/mirrors
 begin
 OrigData2.Seek(0,soFromBeginning) ;
 For XX := 0  to IWidth  Do
 For YY := 0  to IHeight Do
  begin
    ImageData.Seek(((YY*IWidth2)+XX)*2,soFromBeginning) ;   // try -2*XX*YY,soFromEnd and look for the patterns
    ImageData.ReadBuffer(TempSmall1,2)   ;
    OrigData2.WriteBuffer(TempSmall1,2)   ;  // writes new 16 bit data to original (global) data buffer
  end ;
  end ;

  IterationX := IterationX + 1 ;
end ;

If SpikePresent then messagedlg('spike still present',mtInformation,[mbOK],0) ;



 TempStream1.LoadFromFile(MainForm.Caption) ;
 TempStream1.Seek(DataOffset,soFromBeginning) ;
 ImageData.Seek(0,soFromBeginning) ;
 For XX := 0  to IWidth  Do
 For YY := 0  to IHeight Do
  begin
    ImageData.Seek(((YY*IWidth2)+XX)*2,soFromBeginning) ;   // try -2*XX*YY,soFromEnd and look for the patterns
    ImageData.ReadBuffer(TempSmall1,2)   ;
    TempStream1.WriteBuffer(TempSmall1,2)   ;
  end ;

 TempStream1.Seek(DataOffset,soFromBeginning) ;
 ImageData.Seek(0,soFromBeginning) ;
 For XX := 0  to IWidth  Do
 For YY := 0  to IHeight Do
  begin
    TempStream1.ReadBuffer(TempSmall1,2)   ;
    ImageData.WriteBuffer(TempSmall1,2)   ;
  end ;

If CheckBox5.Checked then  // calculate deflection image
  begin
    ImageData.Seek(0,soFromBeginning) ;
    For XX := 0 to IHeight do
      Begin
         ImageData.Read(TempSmall2,2) ;
         For YY := 0 to (IWidth-1) do
           begin
             ImageData.Read(TempSmall3,2) ;
             TempSmall2 := TempSmall2-TempSmall3 ;
             ImageData.Seek(-4,soFromCurrent) ;
             ImageData.Write(TempSmall2,2) ;
             TempSmall2 := TempSmall3 ;
             ImageData.Seek(2,SoFromCurrent) ;
           end ;
         ImageData.Seek(-2,SoFromCurrent) ;
         ImageData.Write(TempSmall2,2) ;
      end ;
    TempStream1.Seek(532480,soFromBeginning) ;
    ImageData.Seek(0,soFromBeginning) ;
      For XX := 0  to IWidth  Do
      For YY := 0  to IHeight Do
        begin
          ImageData.ReadBuffer(TempSmall2,2) ;
          TempSmall2 := -1*TempSmall2 ;
          TempStream1.WriteBuffer(TempSmall2,2) ;
        end ;
  end ;

 ProgressBar1.Position := 0 ; 
 With MainForm.SaveDialog1 do
   begin
     InitialDir := ExtractFileDir(MainForm.Caption) ;
     Filename := ExtractFilename(MainForm.Caption) ;
     If Execute Then
       begin
         TempStream1.SaveToFile(filename) ;
       end ;
   end ;

finally
  ImageData.Free   ;
//  OrigData.Free    ;
  TempStream1.Free  ;
end ; // finally

end;




end.
