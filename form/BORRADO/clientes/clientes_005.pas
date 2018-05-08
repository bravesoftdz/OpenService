unit clientes_005;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  variants, DBGrids, DbCtrls, ExtCtrls, ComCtrls, Grids, utilidades_bd, utilidades_general,
  utilidades_datos_tablas, utilidades_rgtro;

type

  { Tform_clientes_005 }

  Tform_clientes_005 = class(TForm)
    BitBtn_Filtrar: TBitBtn;
    BitBtn_SALIR: TBitBtn;
    BitBtn_Seleccionar: TBitBtn;
    DataSource_Clientes_Envios: TDataSource;
    DBGrid_Principal: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit_Descripcion: TEdit;
    Edit_id: TEdit;
    Edit_Nombre: TEdit;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Memo_Filtros: TMemo;
    Memo_OrderBy: TMemo;
    PageControl_Filtros: TPageControl;
    RadioGroup_Bajas: TRadioGroup;
    SQLQuery_Clientes_Envios: TSQLQuery;
    SQLQuery_Clientes_EnviosChange_Id_User: TLargeintField;
    SQLQuery_Clientes_EnviosChange_WHEN: TDateTimeField;
    SQLQuery_Clientes_EnviosCodigo_Postal: TStringField;
    SQLQuery_Clientes_EnviosDel_Id_User: TLargeintField;
    SQLQuery_Clientes_EnviosDel_WHEN: TDateTimeField;
    SQLQuery_Clientes_EnviosDel_WHY: TStringField;
    SQLQuery_Clientes_EnviosDireccion: TStringField;
    SQLQuery_Clientes_EnviosDireccion_Numero: TStringField;
    SQLQuery_Clientes_EnviosDireccion_Piso_Letra: TStringField;
    SQLQuery_Clientes_EnvioseMail: TStringField;
    SQLQuery_Clientes_EnviosFAX: TStringField;
    SQLQuery_Clientes_Enviosid: TLargeintField;
    SQLQuery_Clientes_Enviosid_clientes: TLargeintField;
    SQLQuery_Clientes_Enviosid_clientes_contactos: TLargeintField;
    SQLQuery_Clientes_Enviosid_paises: TLargeintField;
    SQLQuery_Clientes_Enviosid_poblaciones: TLargeintField;
    SQLQuery_Clientes_Enviosid_provincias: TLargeintField;
    SQLQuery_Clientes_EnviosInsert_Id_User: TLargeintField;
    SQLQuery_Clientes_EnviosInsert_WHEN: TDateTimeField;
    SQLQuery_Clientes_EnviosMovil: TStringField;
    SQLQuery_Clientes_EnviosOT_descripcion_Contacto: TStringField;
    SQLQuery_Clientes_EnviosOT_descripcion_pais: TStringField;
    SQLQuery_Clientes_EnviosOT_descripcion_poblacion: TStringField;
    SQLQuery_Clientes_EnviosOT_descripcion_provincia: TStringField;
    SQLQuery_Clientes_EnviosOT_Direccion_Entera1: TStringField;
    SQLQuery_Clientes_EnviosOT_todos_los_Tfnos1: TStringField;
    SQLQuery_Clientes_EnviosPortes_Pagados_SN: TStringField;
    SQLQuery_Clientes_EnviosTfno_Fijo_1: TStringField;
    SQLQuery_Clientes_EnviosTfno_Fijo_2: TStringField;
    TabSheet_Busqueda_Concreta: TTabSheet;
    TabSheet_Filtros_Generales: TTabSheet;

    procedure Filtrar_Principal_Sin_Preguntar;
    procedure Obligar_como_Filtrado_Principal;
    procedure Presentar_Datos;
    procedure BitBtn_FiltrarClick(Sender: TObject);
    procedure no_Tocar;
    procedure BitBtn_SeleccionarClick(Sender: TObject);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure Seleccionado_Rgtro;
    procedure DBGrid_PrincipalCellClick(Column: TColumn);
    procedure DBGrid_PrincipalDblClick(Sender: TObject);
    procedure DBGrid_PrincipalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid_PrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid_PrincipalKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Filtrar_tablas_ligadas;
    function  Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;
    procedure Refrescar_Registros;
    procedure Cerramos_Tablas;
    procedure Cerramos_Tablas_Ligadas;
    procedure BitBtn_SALIRClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure para_Empezar;
    procedure SQLQuery_Clientes_EnviosAfterPost(DataSet: TDataSet);
    procedure SQLQuery_Clientes_EnviosAfterScroll(DataSet: TDataSet);
    procedure SQLQuery_Clientes_EnviosBeforePost(DataSet: TDataSet);
    procedure SQLQuery_Clientes_EnviosCalcFields(DataSet: TDataSet);

  private
    { private declarations }
    private_Salir_OK : Boolean;
    private_Order_By : array of TOrder_By;
  public
    { public declarations }
    public_Solo_Ver           : Boolean;
    public_Elegimos           : Boolean;
    public_Menu_Worked        : Integer;
    public_Rgtro_Seleccionado : Boolean;
  end;

var
  form_clientes_005: Tform_clientes_005;

implementation

{$R *.lfm}

uses menu, dm_cliente_elegir_direccion_envio;

{ Tform_clientes_005 }

procedure Tform_clientes_005.FormActivate(Sender: TObject);
begin
    If public_Elegimos = true then
    begin
        BitBtn_Seleccionar.Visible := True;

        with Self do
        begin
            Color := $00B9959C;
        end;
    end;

    if public_Solo_Ver = true then no_Tocar;
end;

procedure Tform_clientes_005.BitBtn_SALIRClick(Sender: TObject);
begin
    private_Salir_OK := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}

    Close;
end;

procedure Tform_clientes_005.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    if private_Salir_OK = False then
    begin
        // ***************************************************************************************** //
        // ** Intento BitBtn_SALIR de la aplicación de un modo no permitido.                      ** //
        // ***************************************************************************************** //
        // ** Pero si desde el menu principal está a true la variable public_Salir_Ok, significa  ** //
        // ** que hay que salir si o si pues se pulsó cancelar al preguntar otra vez por la       ** //
        // ** contraseña                                                                          ** //
        // ***************************************************************************************** //
        if form_Menu.public_Salir_OK = False then CloseAction := CloseAction.caNone;
    end else begin
        // ***************************************************************************************** //
        // ** Fue correcto el modo como quiere BitBtn_SALIR de la aplicación                      ** //
        // ***************************************************************************************** //
    end;
end;

procedure Tform_clientes_005.FormCreate(Sender: TObject);
begin
    // ********************************************************************************************* //
    // ** Obligado en cada formulario para no olvidarlo                                           ** //
    // ********************************************************************************************* //
    with Self do
    begin
        Color       := $00C2C29E;
        Position    := poScreenCenter;
        BorderIcons := [];
        BorderStyle := bsSingle;
    end;

    private_Salir_OK := false;

    // ********************************************************************************************* //
    // ** Solo para formularios que traten con datos                                              ** //
    // ********************************************************************************************* //
    public_Solo_Ver                 := false;
    public_Elegimos                 := false;

    public_Rgtro_Seleccionado       := false;
end;

procedure Tform_clientes_005.FormDestroy(Sender: TObject);
begin
    Cerramos_Tablas;
end;

procedure Tform_clientes_005.para_Empezar;
begin
    // ********************************************************************************************* //
    // ** Solo para formularios que traten con datos                                              ** //
    // ********************************************************************************************* //
    if UTI_GEN_Form_Abierto_Ya('DataModule_Cliente_Elegir_Direccion_Envio') = False then
    begin
        DataModule_Cliente_Elegir_Direccion_Envio := TDataModule_Cliente_Elegir_Direccion_Envio.Create(Application);
    end;

    // ********************************************************************************************* //
    // ** Preparamos los diferentes tipos de orden preconfigurados                                ** //
    // ********************************************************************************************* //
    // CLIENTES ENVIOS
    SetLength(private_Order_By, 1);

    private_Order_By[0].Titulo       := 'Por dirección'; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By[0].Memo_OrderBy := 'ce.Direccion ASC, ce.Direccion_Numero ASC,' +
                                              ' ce.Direccion_Piso_Letra ASC, ce.Codigo_Postal ASC,' +
                                              ' ce.id_poblaciones ASC, ce.id_provincias ASC,' +
                                              ' ce.id_paises ASC';

    Memo_OrderBy.Lines.Text := private_Order_By[0].Memo_OrderBy;

    Obligar_como_Filtrado_Principal;

    // ********************************************************************************************* //
    // ** Filtramos los datos                                                                     ** //
    // ********************************************************************************************* //
    Filtrar_Principal_Sin_Preguntar;

    Presentar_Datos;

    // ********************************************************************************************* //
    // ** SOLO PARA ESTE FORM                                                                     ** //
    // ********************************************************************************************* //
    PageControl_Filtros.ActivePage := TabSheet_Busqueda_Concreta;
end;

procedure Tform_clientes_005.SQLQuery_Clientes_EnviosAfterPost(DataSet: TDataSet);
begin
    UTI_RGTRO_Grabar( 'clientes_envios',
                      DataModule_Cliente_Elegir_Direccion_Envio.SQLTransaction_CliEnv,
                      SQLQuery_Clientes_Envios );

    Refrescar_Registros;
end;

procedure Tform_clientes_005.SQLQuery_Clientes_EnviosAfterScroll(DataSet: TDataSet);
begin
    Filtrar_tablas_ligadas;
end;

procedure Tform_clientes_005.SQLQuery_Clientes_EnviosBeforePost(
  DataSet: TDataSet);
begin
    UTI_RGTRO_param_assign_value( SQLQuery_Clientes_Envios );
end;

procedure Tform_clientes_005.SQLQuery_Clientes_EnviosCalcFields(
  DataSet: TDataSet);
begin
    with SQLQuery_Clientes_Envios do
    begin
        // ***************************************************************************************** //
        // ** TELEFONOS                                                                           ** //
        // ***************************************************************************************** //
        FieldByName('OT_todos_los_Tfnos').AsString := '';

        // Tfno_Fijo_1
        if Trim(FieldByName('Tfno_Fijo_1').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_todos_los_Tfnos').AsString) <> '' then
            begin
                FieldByName('OT_todos_los_Tfnos').AsString :=
                      Trim(FieldByName('OT_todos_los_Tfnos').AsString) + ', ';
            end;

            FieldByName('OT_todos_los_Tfnos').AsString :=
                  Trim(FieldByName('OT_todos_los_Tfnos').AsString) + ' ' +
                  Trim(FieldByName('Tfno_Fijo_1').AsString);
        end;

        // Tfno_Fijo_2
        if Trim(FieldByName('Tfno_Fijo_2').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_todos_los_Tfnos').AsString) <> '' then
            begin
                FieldByName('OT_todos_los_Tfnos').AsString :=
                      Trim(FieldByName('OT_todos_los_Tfnos').AsString) + ', ';
            end;

            FieldByName('OT_todos_los_Tfnos').AsString :=
                  Trim(FieldByName('OT_todos_los_Tfnos').AsString) + ' ' +
                  Trim(FieldByName('Tfno_Fijo_2').AsString);
        end;

        // Movil
        if Trim(FieldByName('Movil').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_todos_los_Tfnos').AsString) <> '' then
            begin
                FieldByName('OT_todos_los_Tfnos').AsString :=
                      Trim(FieldByName('OT_todos_los_Tfnos').AsString) + ', ';
            end;

            FieldByName('OT_todos_los_Tfnos').AsString :=
                  Trim(FieldByName('OT_todos_los_Tfnos').AsString) + ' ' +
                  Trim(FieldByName('Movil').AsString);
        end;

        // ***************************************************************************************** //
        // ** DIRECCION ENTERA                                                                    ** //
        // ***************************************************************************************** //
        FieldByName('OT_Direccion_Entera').AsString := '';

        // Direccion
        if Trim(FieldByName('Direccion').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_Direccion_Entera').AsString) <> '' then
            begin
                FieldByName('OT_Direccion_Entera').AsString :=
                      Trim(FieldByName('OT_Direccion_Entera').AsString) + ', ';
            end;

            FieldByName('OT_Direccion_Entera').AsString :=
                  Trim(FieldByName('OT_Direccion_Entera').AsString) + ' ' +
                  Trim(FieldByName('Direccion').AsString);
        end;

        // Direccion_Numero
        if Trim(FieldByName('Direccion_Numero').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_Direccion_Entera').AsString) <> '' then
            begin
                FieldByName('OT_Direccion_Entera').AsString :=
                      Trim(FieldByName('OT_Direccion_Entera').AsString) + ', ';
            end;

            FieldByName('OT_Direccion_Entera').AsString :=
                  Trim(FieldByName('OT_Direccion_Entera').AsString) + ' ' +
                  Trim(FieldByName('Direccion_Numero').AsString);
        end;

        // Direccion_Piso_Letra
        if Trim(FieldByName('Direccion_Piso_Letra').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_Direccion_Entera').AsString) <> '' then
            begin
                FieldByName('OT_Direccion_Entera').AsString :=
                      Trim(FieldByName('OT_Direccion_Entera').AsString) + ', ';
            end;

            FieldByName('OT_Direccion_Entera').AsString :=
                  Trim(FieldByName('OT_Direccion_Entera').AsString) + ' ' +
                  Trim(FieldByName('Direccion_Piso_Letra').AsString);
        end;

        // Codigo_Postal
        if Trim(FieldByName('Codigo_Postal').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_Direccion_Entera').AsString) <> '' then
            begin
                FieldByName('OT_Direccion_Entera').AsString :=
                      Trim(FieldByName('OT_Direccion_Entera').AsString) + ', ';
            end;

            FieldByName('OT_Direccion_Entera').AsString :=
                  Trim(FieldByName('OT_Direccion_Entera').AsString) + ' ' +
                  Trim(FieldByName('Codigo_Postal').AsString);
        end;

        // OT_descripcion_poblacion
        if Trim(FieldByName('OT_descripcion_poblacion').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_Direccion_Entera').AsString) <> '' then
            begin
                FieldByName('OT_Direccion_Entera').AsString :=
                      Trim(FieldByName('OT_Direccion_Entera').AsString) + ', ';
            end;

            FieldByName('OT_Direccion_Entera').AsString :=
                  Trim(FieldByName('OT_Direccion_Entera').AsString) + ' ' +
                  Trim(FieldByName('OT_descripcion_poblacion').AsString);
        end;

        // OT_descripcion_provincia
        if Trim(FieldByName('OT_descripcion_provincia').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_Direccion_Entera').AsString) <> '' then
            begin
                FieldByName('OT_Direccion_Entera').AsString :=
                      Trim(FieldByName('OT_Direccion_Entera').AsString) + ', ';
            end;

            FieldByName('OT_Direccion_Entera').AsString :=
                  Trim(FieldByName('OT_Direccion_Entera').AsString) + ' ' +
                  Trim(FieldByName('OT_descripcion_provincia').AsString);
        end;

        // OT_descripcion_pais
        if Trim(FieldByName('OT_descripcion_pais').AsString) <> '' then
        begin
            if Trim(FieldByName('OT_Direccion_Entera').AsString) <> '' then
            begin
                FieldByName('OT_Direccion_Entera').AsString :=
                      Trim(FieldByName('OT_Direccion_Entera').AsString) + ', ';
            end;

            FieldByName('OT_Direccion_Entera').AsString :=
                  Trim(FieldByName('OT_Direccion_Entera').AsString) + ' ' +
                  Trim(FieldByName('OT_descripcion_pais').AsString);
        end;
    end;
end;

procedure Tform_clientes_005.Cerramos_Tablas;
begin
    Cerramos_Tablas_Ligadas;

    if UTI_TB_Cerrar( DataModule_Cliente_Elegir_Direccion_Envio.SQLConnector_CliEnv,
                      DataModule_Cliente_Elegir_Direccion_Envio.SQLTransaction_CliEnv,
                      SQLQuery_Clientes_Envios ) = false then UTI_GEN_Salir;

    DataModule_Cliente_Elegir_Direccion_Envio.Free;
end;

procedure Tform_clientes_005.Cerramos_Tablas_Ligadas;
begin
    // ********************************************************************************************* //
    // ** ESTE form NO TIENE TABLAS LIGADAS                                                       ** //
    // ********************************************************************************************* //
end;

procedure Tform_clientes_005.Refrescar_Registros;
var var_Lineas_Filtro        : TStrings;
    var_Lineas_OrderBy       : TStrings;

    var_Direccion            : String;
    var_Direccion_Numero     : String;
    var_Direccion_Piso_Letra : String;
    var_Codigo_Postal        : String;
    var_id_poblaciones       : LargeInt;
    var_id_provincias        : Integer;
    var_id_paises            : Integer;

    var_ver_Bajas            : ShortInt;
begin
    // ********************************************************************************************* //
    // ** OJITO ... NO USAR CAMPOS AUTOINCREMENTABLES                                             ** //
    // ********************************************************************************************* //
    var_Direccion            := '';
    var_Direccion_Numero     := '';
    var_Direccion_Piso_Letra := '';
    var_Codigo_Postal        := '';

    var_id_poblaciones       := 0;
    var_id_provincias        := 0;
    var_id_paises            := 0;

    if SQLQuery_Clientes_Envios.RecordCount > 0 then
    begin
        var_Direccion            := SQLQuery_Clientes_Envios.FieldByName('Direccion').AsString;
        var_Direccion_Numero     := SQLQuery_Clientes_Envios.FieldByName('Direccion_Numero').AsString;
        var_Direccion_Piso_Letra := SQLQuery_Clientes_Envios.FieldByName('Direccion_Piso_Letra').AsString;
        var_Codigo_Postal        := SQLQuery_Clientes_Envios.FieldByName('Codigo_Postal').AsString;

        if not SQLQuery_Clientes_Envios.FieldByName('id_poblaciones').IsNull then
        begin
             var_id_poblaciones := SQLQuery_Clientes_Envios.FieldByName('id_poblaciones').Value;
        end;

        if not SQLQuery_Clientes_Envios.FieldByName('id_provincias').IsNull then
        begin
             var_id_provincias := SQLQuery_Clientes_Envios.FieldByName('id_provincias').Value;
        end;

        if not SQLQuery_Clientes_Envios.FieldByName('id_paises').IsNull then
        begin
             var_id_paises := SQLQuery_Clientes_Envios.FieldByName('id_paises').Value;
        end;
    end;

    Filtrar_Principal_Sin_Preguntar;

    if Trim(var_Direccion) <> '' then
    begin
        SQLQuery_Clientes_Envios.Locate( 'Direccion;Direccion_Numero;Direccion_Piso_Letra;Codigo_Postal;id_poblaciones;id_provincias;id_paises',
                                         VarArrayOf( [ var_Direccion,
                                                       var_Direccion_Numero,
                                                       var_Direccion_Piso_Letra,
                                                       var_Codigo_Postal,
                                                       var_id_poblaciones,
                                                       var_id_provincias,
                                                       var_id_paises ] ),
                                         [] );
    end;
end;

procedure Tform_clientes_005.Filtrar_tablas_ligadas;
var var_Lineas_Filtro  : TStrings;
    var_Lineas_OrderBy : TStrings;
begin
    if SQLQuery_Clientes_Envios.RecordCount = 0 then Exit;

    if SQLQuery_Clientes_Envios.State = dsInsert then
    begin
        Cerramos_Tablas_Ligadas;
        Exit;
    end;

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    // ********************************************************************************************* //
    // ** NO HAY TABLAS LIGADAS                                                                   ** //
    // ********************************************************************************************* //

    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;
end;

procedure Tform_clientes_005.DBGrid_PrincipalDblClick(Sender: TObject);
begin
    If public_Elegimos then Seleccionado_Rgtro;
end;

procedure Tform_clientes_005.DBGrid_PrincipalCellClick(Column: TColumn);
begin
    //Filtrar_tablas_ligadas;
end;

procedure Tform_clientes_005.DBGrid_PrincipalDrawColumnCell( Sender: TObject;
                                                          const Rect: TRect;
                                                          DataCol: Integer;
                                                          Column: TColumn;
                                                          State: TGridDrawState);
begin
    UTI_GEN_Dibujar_Grid( Sender, SQLQuery_Clientes_Envios, Rect, DataCol, Column, State );
end;

procedure Tform_clientes_005.DBGrid_PrincipalKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if Key = 13 then
    begin
        If public_Elegimos then Seleccionado_Rgtro;
    end;
end;

procedure Tform_clientes_005.DBGrid_PrincipalKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key = 40) or (key = 38) then
    begin
         //Filtrar_tablas_ligadas;
    end;
end;

function Tform_clientes_005.Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;
var var_Registro_CRUD : TRegistro_CRUD;
    var_ctdad_Rgtros  : Integer;
    var_a_Filtrar     : TStrings;
begin
    var_a_Filtrar := TStringList.Create;
    var_a_Filtrar.Clear;

    var_Registro_CRUD := UTI_DATOS_TABLA_Elegir_Cliente_Direccion_Envio_CRUD;
    var_ctdad_Rgtros  := -1;

    Obligar_como_Filtrado_Principal;

    // ********************************************************************************************* //
    // ** AHORA PONDREMOS EL RESTO DE LOS FILTROS QUE NO SON GENERALES                            ** //
    // ********************************************************************************************* //
    // ** Primero buscaremos en el nombre y apellido el texto a buscar                              ** //
    // ********************************************************************************************* //
    if Trim(Edit_Descripcion.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'ce.Direccion LIKE ' +
                                UTI_GEN_Comillas('%' + Trim(Edit_Descripcion.Text) + '%') );
    end;

    // ********************************************************************************************* //
    // ** Pasamos a filtrar los registros                                                         ** //
    // ********************************************************************************************* //
    Result := UTI_TB_Filtrar( private_Order_By,

                              var_Registro_CRUD.Delete_SQL,
                              var_Registro_CRUD.Update_SQL,
                              var_Registro_CRUD.Insert_SQL,

                              var_ctdad_Rgtros,
                              DataModule_Cliente_Elegir_Direccion_Envio.SQLTransaction_CliEnv,
                              DataModule_Cliente_Elegir_Direccion_Envio.SQLConnector_CliEnv,
                              SQLQuery_Clientes_Envios,

                              var_Registro_CRUD.name_tabla,
                              RadioGroup_Bajas.ItemIndex,

                              var_Registro_CRUD.SELECT_SQL,

                              Memo_Filtros.Lines,
                              Memo_OrderBy.Lines,
                              var_a_Filtrar.Text,

                              param_Cambiamos_Filtro );

    var_a_Filtrar.Free;

    //Filtrar_tablas_ligadas;
end;

procedure Tform_clientes_005.Seleccionado_Rgtro;
begin
    private_Salir_OK          := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}
    public_Rgtro_Seleccionado := true;
    Close;
end;

procedure Tform_clientes_005.BitBtn_SeleccionarClick(Sender: TObject);
begin
    Seleccionado_Rgtro;
end;

procedure Tform_clientes_005.DBNavigator1BeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
    //Filtrar_tablas_ligadas;

    case Button of
        nbRefresh : begin
            Refrescar_Registros;
            Abort;
        end;
    end;
end;

procedure Tform_clientes_005.no_Tocar;
begin
    // No hay nada para no tocar
end;

procedure Tform_clientes_005.BitBtn_FiltrarClick(Sender: TObject);
begin
    if PageControl_Filtros.ActivePage = TabSheet_Busqueda_Concreta then
    begin
        Filtrar_Principal_Sin_Preguntar;
    end else begin
        RadioGroup_Bajas.ItemIndex := Filtrar_Principal( true );
    end;
end;

procedure Tform_clientes_005.Presentar_Datos;
begin
    // No hay nada para presentar
end;

procedure Tform_clientes_005.Obligar_como_Filtrado_Principal;
begin
    UTI_RGTRO_Add_to_Where( true,
                            Memo_Filtros.Lines,
                            'ce.id_clientes = ' + Edit_id.Text );
end;

procedure Tform_clientes_005.Filtrar_Principal_Sin_Preguntar;
begin
    RadioGroup_Bajas.ItemIndex := Filtrar_Principal( false );
end;

end.

