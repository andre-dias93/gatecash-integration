program Gatecash;

uses
  Vcl.Forms,
  Gatecash.Sample.Src.SampleIntegration in 'src\Gatecash.Sample.Src.SampleIntegration.pas' {FrmSampleIntegration},
  Gatecash.Integration in '..\src\Gatecash.Integration.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSampleIntegration, FrmSampleIntegration);
  Application.Run;
end.
