unit plantilla_001;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ButtonPanel, ExtCtrls,
  utilidades_general, utilidades_forms_Filtrar;

type

  { Tform_plantilla_001 }

  Tform_plantilla_001 = class(TForm)
    ButtonPanel1: TButtonPanel;
    Panel_Ficha: TPanel;

    procedure CancelButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure Cambiar_Titulo_Form;

  private
    { private declarations }
    private_Salir_OK : Boolean;

    function  Comprobar_No_Tocar( p_Reproducir_Mensajes, p_Ejecutar_No_Tocar : Boolean ) : Boolean;
    procedure no_Tocar;
    procedure Presentar_Datos;
    procedure ValidarExit(var p_msg : TStrings);

  public
    { public declarations }
    public_Solo_Ver      : Boolean;
    public_Pulso_Aceptar : Boolean;
    public_Record_Rgtro  : TRecord_Rgtro_Comun;

    procedure para_Empezar;

  end;

var
  form_plantilla_001: Tform_plantilla_001;

implementation

{$R *.lfm}

uses menu, plantilla_000;

{ Tform_plantilla_001 }

procedure Tform_plantilla_001.FormCreate(Sender: TObject);
begin
  Cambiar_Titulo_Form;
  form_plantilla_000.Cambiar_Estilo_Form;

  private_Salir_OK := false;

  public_Solo_Ver := false;
end;

procedure Tform_plantilla_001.FormActivate(Sender: TObject);
begin
  If form_plantilla_000.public_Elegimos = true then
  begin
    with Self do
    begin
      Color := $00B9959C;
    end;
  end;

  Comprobar_No_Tocar(true, true);
end;

function Tform_plantilla_001.Comprobar_No_Tocar( p_Reproducir_Mensajes,
                                                 p_Ejecutar_No_Tocar : Boolean ) : Boolean;
begin
  Result := false;

  // ********************************************************************************************* //
  // ** Si se llamó para solo verlo, pues no se puede tocar                                     ** //
  // ********************************************************************************************* //
  if public_Solo_Ver = true then
  begin
    Result := true;

    if p_Ejecutar_No_Tocar = true then
    begin
      no_Tocar;
    end;
  end;
end;

procedure Tform_plantilla_001.OKButtonClick(Sender: TObject);
begin
  private_Salir_OK     := True;
  public_Pulso_Aceptar := true;
end;

procedure Tform_plantilla_001.CancelButtonClick(Sender: TObject);
begin
  private_Salir_OK     := True;
  public_Pulso_Aceptar := false;
end;

procedure Tform_plantilla_001.no_Tocar;
begin
  Panel_Ficha.Enabled := false;
end;

procedure Tform_plantilla_001.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var var_msg : TStrings;
begin
  ButtonPanel1.SetFocus; // Con esto consigo que salga del campo que este y pueda actualizarlo

  var_msg := TStringList.Create;

  if public_Pulso_Aceptar = true then
  begin
    ValidarExit(var_msg);
  end;

  if private_Salir_OK = False then
  begin
    // ********************************************************************************************* //
    // ** Intento BitBtn_SALIR de la aplicación de un modo no permitido.                          ** //
    // ********************************************************************************************* //
    // ** Pero si desde el menu principal está a true la variable public_Salir_Ok, significa      ** //
    // ** que hay que salir si o si pues se pulsó cancelar al preguntar otra vez por la pwd       ** //
    // ********************************************************************************************* //
    if form_Menu.public_Salir_OK = False then
    begin
      CloseAction := caNone;
    end;
  end else begin
    // ********************************************************************************************* //
    // ** Fue correcto el modo como quiere salir de la aplicación                                 ** //
    // ********************************************************************************************* //
    // ** Comprobaremos si no se generó algún error por falta de completar algun campo y si se    ** //
    // ** salió con el botón Ok o Cancel                                                          ** //
    // ********************************************************************************************* //
    if (Trim(var_msg.Text) <> '')    and
       (public_Pulso_Aceptar = true) then
    begin
      UTI_GEN_Aviso(true, var_msg, rs_Falta, True, False);
      CloseAction := caNone;
    end else begin
      CloseAction := caFree;
    end;
  end;

  var_msg.Free;
end;

procedure Tform_plantilla_001.para_Empezar;
begin
    // ********************************************************************************************* //
    // ** Solo para formularios que traten con datos                                              ** //
    // ********************************************************************************************* //
    with form_plantilla_000.SQLQuery_Principal do
    begin
        public_Record_Rgtro := UTI_Guardar_Datos_Registro( FieldByName('id').AsString,
                                                           FieldByName('id_menus').AsString,
                                                           '',
                                                           FieldByName('nombre_fichero').AsString,
                                                           FieldByName('descripcion').AsString,
                                                           '');
    end;

    Presentar_Datos;
end;



// ################################################################################################# //
// ## Procedures o functions que habrá que crearlas en el form hijo como overwrite                ## //
// ################################################################################################# //
procedure Tform_plantilla_001.Cambiar_Titulo_Form;
begin
  { jerofa Hacer algo parecido a lo de abajo pero en plan hereditario con su inherited y todo

  Self.Caption := 'Ficha de ... ';
  }
end;

procedure Tform_plantilla_001.Presentar_Datos;
begin
  { jerofa Hacer algo parecido a lo de abajo pero en plan hereditario con su inherited y todo

  with form_plantilla_000.SQLQuery_Principal do
  begin
    Edit_Descripcion_Menu.Text := FieldByName('OT_Descripcion_Menu').AsString;
  end;
  }
end;

procedure Tform_plantilla_001.ValidarExit(var p_msg : TStrings);
begin
  { jerofa Hacer algo parecido a lo de abajo pero en plan hereditario con su inherited y todo

  with form_plantilla_000.SQLQuery_Principal do
  begin
    if Trim(FieldByName('nombre_fichero').AsString) = '' then
    begin
      p_msg.Add( '* El nombre de fichero.' );
    end;

    if Trim(FieldByName('id_menus').AsString) = '' then
    begin
      p_msg.Add( '* El módulo al que pertenece.' );
    end;

    if Trim(FieldByName('descripcion').AsString) = '' then
    begin
      p_msg.Add( '* La descripción del informe.' );
    end;
  end;
  }
end;

end.

