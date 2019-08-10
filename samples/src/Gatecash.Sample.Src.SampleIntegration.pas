unit Gatecash.Sample.Src.SampleIntegration;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmSampleIntegration = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  end;

var
  FrmSampleIntegration: TFrmSampleIntegration;

implementation

{$R *.dfm}

uses Gatecash.Integration;


procedure TFrmSampleIntegration.Button1Click(Sender: TObject);
begin
  ShowMessage(IntToResponse(GATECASH_InicializaEx('.', '127.0.0.1', 2)).ToText);
end;

procedure TFrmSampleIntegration.Button2Click(Sender: TObject);
begin
  ShowMessage(IntToResponse(GATECASH_AbrePdvEx('Andre Dias', '25')).ToText);
end;

procedure TFrmSampleIntegration.Button3Click(Sender: TObject);
begin
  ShowMessage(IntToResponse(GATECASH_InformaOperador('Andre Dias', '25')).ToText);
end;

procedure TFrmSampleIntegration.Button4Click(Sender: TObject);
begin
   ShowMessage(IntToResponse(GATECASH_Finaliza).ToText);
end;

end.
