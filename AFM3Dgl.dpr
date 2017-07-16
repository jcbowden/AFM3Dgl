program AFM3Dgl;

uses
  Forms,
  AFM3D in 'AFM3D.pas' {MainForm},
  ZMag in 'ZMag.pas' {Form2},
  Colors in 'Colors.pas' {Form3},
  Perspective in 'Perspective.pas' {Form1},
  ScaleBarOpt in 'ScaleBarOpt.pas' {Form4},
  glAntiAlias in 'glAntiAlias.pas',
  TipConvolution in 'TipConvolution.pas' {TipArtefact},
  GLObjects in 'GLObjects.pas',
  OpenGL in 'OpenGL.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TTipArtefact, TipArtefact);
  Application.Run;
end.
