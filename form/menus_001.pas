unit menus_001;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ButtonPanel, StdCtrls, DbCtrls,
    db, utilidades_forms_Filtrar, utilidades_general, LCLTranslator;

resourcestring
    rs_Close_1  = '* La descripción';
    rs_Close_2  = '* El código';

type

    { TForm_menus_001 }

    TForm_menus_001 = class(TForm)
        ButtonPanel1: TButtonPanel;
        DBEdit_Codigo: TDBEdit;
        DBEdit_Descripcion: TDBEdit;
        DBEdit_eMail1: TDBEdit;
        GroupBox11: TGroupBox;
        Label1: TLabel;
        Label2: TLabel;
        Label62: TLabel;

        function  Comprobar_No_Tocar( param_Reproducir_Mensajes, param_Ejecutar_No_Tocar : Boolean ) : Boolean;
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure FormCreate(Sender: TObject);
        procedure no_Tocar;
        procedure CancelButtonClick(Sender: TObject);
        procedure FormActivate(Sender: TObject);
        procedure para_Empezar;
        procedure OKButtonClick(Sender: TObject);
        procedure Presentar_Datos;
    private
        { private declarations }
        private_Salir_OK : Boolean;
    public
        { public declarations }
        public_Solo_Ver      : Boolean;
        public_Menu_Worked   : Integer;
        public_Pulso_Aceptar : Boolean;
        public_Record_Rgtro  : TRecord_Rgtro_Comun;
    end;

var
    Form_menus_001: TForm_menus_001;

implementation

{$R *.lfm}

uses menu, menus_000;

{ TForm_menus_001 }

procedure TForm_menus_001.CancelButtonClick(Sender: TObject);
begin
    private_Salir_OK     := True;
    public_Pulso_Aceptar := false;
end;

procedure TForm_menus_001.FormActivate(Sender: TObject);
begin
    If Form_menus_000.public_Elegimos = true then
    begin
        with Self do
        begin
            Color := $00B9959C;
        end;
    end;

    Comprobar_No_Tocar(true, true);
end;

function TForm_menus_001.Comprobar_No_Tocar( param_Reproducir_Mensajes,
                                             param_Ejecutar_No_Tocar : Boolean ) : Boolean;
begin
    Result := false;

    // ********************************************************************************************* //
    // ** Si se llamó para solo verlo, pues no se puede tocar                                     ** //
    // ********************************************************************************************* //
    if public_Solo_Ver = true then
    begin
        Result := true;
        if param_Ejecutar_No_Tocar = true then no_Tocar;
    end;
end;

procedure TForm_menus_001.OKButtonClick(Sender: TObject);
begin
    private_Salir_OK     := true;
    public_Pulso_Aceptar := true;
end;

procedure TForm_menus_001.Presentar_Datos;
begin
     /// guardar por lo que pueda pasar
end;

procedure TForm_menus_001.no_Tocar;
begin
    DBEdit_Codigo.Enabled := False;
end;

procedure TForm_menus_001.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var var_msg : TStrings;
begin
    ButtonPanel1.SetFocus; // Con esto consigo que salga del campo que este y pueda actualizarlo

    var_msg := TStringList.Create;

    if public_Pulso_Aceptar = true then
    begin
        with form_menus_000.SQLQuery_Menus do
        begin
            if Trim(DBEdit_Codigo.Text) = '' then var_msg.Add( rs_Close_2 );

            if Trim(DBEdit_Descripcion.Text) <> '' then
                 FieldByName('Descripcion').asString := AnsiUpperCase(Trim(FieldByName('Descripcion').AsString))
            else var_msg.Add( rs_Close_1 );
        end;
    end;

    if private_Salir_OK = False then
        begin
          { ********************************************************************
            Intento BitBtn_SALIR de la aplicación de un modo no permitido.
            ********************************************************************
            Pero si desde el menu principal está a true la variable
            public_Salir_Ok, significa que hay que salir si o si pues se pulsó
            cancelar al preguntar otra vez por la contraseña
            ******************************************************************** }
            if form_Menu.public_Salir_OK = False then CloseAction := caNone;
        end
    else
        begin
          { ********************************************************************
            Fue correcto el modo como quiere salir de la aplicación
            ********************************************************************
            Comprobaremos si no se generó algún error por falta de completar
            algun campo y si se salió con el botón Ok o Cancel
            ******************************************************************** }
            if (Trim(var_msg.Text) <> '') and (public_Pulso_Aceptar = true) then
                begin
                    UTI_GEN_Aviso(true, var_msg, rs_Falta, True, False);
                    // var_msg.Free;
                    CloseAction := caNone;
                end
            else
                begin
                    // var_msg.Free;
                    CloseAction := caFree;
                end;
        end;

    var_msg.Free;
end;

procedure TForm_menus_001.FormCreate(Sender: TObject);
begin
    { ****************************************************************************
      Obligado en cada formulario para no olvidarlo
      **************************************************************************** }
      with Self do
      begin
          Color       := $00C2C29E;
          Position    := poScreenCenter;
          BorderIcons := [];
          BorderStyle := bsSingle;
      end;

      private_Salir_OK := false;
    { **************************************************************************** }

    { ****************************************************************************
      Solo para formularios que traten con datos
      **************************************************************************** }
      public_Solo_Ver := false;
end;

procedure TForm_menus_001.para_Empezar;
begin
  { ****************************************************************************
    Solo para formularios que traten con datos
    **************************************************************************** }
    with form_menus_000.SQLQuery_Menus do
    begin
        public_Record_Rgtro := UTI_Guardar_Datos_Registro( FieldByName('id').AsString,
                                                           '',
                                                           '',
                                                           FieldByName('Descripcion').AsString,
                                                           '',
                                                           '' );
    end;

    Presentar_Datos;
end;

end.

