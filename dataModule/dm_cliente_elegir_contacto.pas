unit dm_cliente_elegir_contacto;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, sqldb, FileUtil, utilidades_bd, utilidades_general;

type

    { TDataModule_Cliente_Elegir_Contacto }

    TDataModule_Cliente_Elegir_Contacto = class(TDataModule)
        SQLConnector_CliContactos: TSQLConnector;
        SQLTransaction_CliContactos: TSQLTransaction;
        procedure DataModuleCreate(Sender: TObject);
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    DataModule_Cliente_Elegir_Contacto: TDataModule_Cliente_Elegir_Contacto;

implementation

{$R *.lfm}

{ TDataModule_Cliente_Elegir_Contacto }

procedure TDataModule_Cliente_Elegir_Contacto.DataModuleCreate(Sender: TObject);
begin
    if UTI_CN_Connector_Open( SQLTransaction_CliContactos,
                              SQLConnector_CliContactos ) = False then
    begin
        UTI_GEN_Salir;
    end;
end;

end.

