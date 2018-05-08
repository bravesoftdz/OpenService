unit dm_articulos_elegir;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, sqldb, mysql56conn, FileUtil, utilidades_general,
    utilidades_bd;

type

    { TDataModule_Articulos_Elegir }

    TDataModule_Articulos_Elegir = class(TDataModule)
        SQLConnector_Art_Elegir: TSQLConnector;
        SQLTransaction_Art_Elegir: TSQLTransaction;
        procedure DataModuleCreate(Sender: TObject);
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    DataModule_Articulos_Elegir: TDataModule_Articulos_Elegir;

implementation

{$R *.lfm}

{ TDataModule_Articulos_Elegir }

procedure TDataModule_Articulos_Elegir.DataModuleCreate(Sender: TObject);
begin
    if UTI_CN_Connector_Open( SQLTransaction_Art_Elegir, SQLConnector_Art_Elegir ) = False then UTI_GEN_Salir;
end;

end.

