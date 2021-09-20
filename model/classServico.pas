unit classServico;

interface

uses Classe, SysUtils, classFarmaceutico, classPaciente, classServicoItem, System.Classes;

type
  TServico = class(TClasse)
  private
    FFarmaceutico: TFarmaceutico;
    FPaciente: TPaciente;
    FObservacoes: TStringList;
    FItens: TList;
    FValorTotal: Currency;
    procedure SetObservacoes(const Value: TStringList);
    procedure SetFarmaceutico(const Value: TFarmaceutico);
    procedure SetValorTotal(const Value: Currency);
    procedure SetPaciente(const Value: TPaciente);
  public
    constructor Create;
    destructor Destroy;

    property Farmaceutico: TFarmaceutico read FFarmaceutico write SetFarmaceutico;
    property Paciente: TPaciente read FPaciente write SetPaciente;
    property Observacoes: TStringList read FObservacoes write SetObservacoes;
    property Itens: TList read FItens write FItens;
    property ValorTotal: Currency read FValorTotal write SetValorTotal;
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

procedure TServico.SetObservacoes(const Value: TStringList);
begin
  FObservacoes := Value;
end;

procedure TServico.SetPaciente(const Value: TPaciente);
begin
  FPaciente := Value;
end;

procedure TServico.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

end.
