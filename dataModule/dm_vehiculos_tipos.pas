unit dm_vehiculos_tipos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, utilidades_bd, utilidades_general;

type

  { TDataModule_Vehiculos_Tipos }

  TDataModule_Vehiculos_Tipos = class(TDataModule)
    SQLConnector_Vehiculos_Tipos: TSQLConnector;
    SQLTransaction_Vehiculos_Tipos: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DataModule_Vehiculos_Tipos: TDataModule_Vehiculos_Tipos;

implementation

{$R *.lfm}

{ TDataModule_Vehiculos_Tipos }

procedure TDataModule_Vehiculos_Tipos.DataModuleCreate(Sender: TObject);
begin
    if UTI_CN_Connector_Open( SQLTransaction_Vehiculos_Tipos, SQLConnector_Vehiculos_Tipos ) = False then
    begin
        UTI_GEN_Salir;
    end;
end;

end.

