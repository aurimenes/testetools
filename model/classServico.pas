unit classServico;

interface

uses Classe, SysUtils, classFarmaceutico, classPaciente, System.Classes;

type
  TServico = class(TClasse)
  private
    FID: Integer;
    FFarmaceutico: TFarmaceutico;
    FPaciente: TPaciente;
    FObservacoes: TStringList;
    FItens: TList;
    FValorTotal: Currency;
    procedure SetObservacoes(const Value: TStringList);
    procedure SetItens(const Value: TList);
    procedure SetFarmaceutico(const Value: TFarmaceutico);
  public
    constructor Create;
    destructor Destroy;

    procedure SetPaciente(Id: Integer);

    property Id: Integer read FID;
    property Farmaceutico: TFarmaceutico read FFarmaceutico;
    property Paciente: TPaciente read FPaciente;
    property Observacoes: TStringList read FObservacoes write SetObservacoes;
    property Itens: TList read FItens write SetItens;
    property ValorTotal: Currency read FValorTotal;
  end;

implementation

{ TServicos }

constructor TServico.Create;
begin
  FFarmaceutico := TFarmaceutico.Create;
  FPaciente := TPaciente.Create;
  FObservacoes := TStringList.Create;
  FITens := TList.Create;
end;

destructor TServico.Destroy;
begin
  FObservacoes.Free;
  FFarmaceutico.Free;
  FPaciente.Free;
  FItens.Free;
end;

procedure TServico.SetFarmaceutico(const Value: TFarmaceutico);
begin
  FFarmaceutico := Value;
end;

procedure TServico.SetItens(const Value: TList);
begin
  FItens := Value;
end;

procedure TServico.SetObservacoes(const Value: TStringList);
begin
  FObservacoes := Value;
end;

procedure TServico.SetPaciente(Id: Integer);
begin

end;

end.