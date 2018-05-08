unit empresas_000;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  utilidades_usuarios, utilidades_general, utilidades_rgtro, utilidades_bd, DBGrids, DbCtrls,
  utilidades_datos_tablas, ExtCtrls, Grids, ComCtrls;

type

  { Tform_empresas_000 }

  Tform_empresas_000 = class(TForm)
    BitBtn_Filtrar: TBitBtn;
    BitBtn_Imprimir: TBitBtn;
    BitBtn_SALIR: TBitBtn;
    BitBtn_Seleccionar: TBitBtn;
    BitBtn_Ver_Situacion_Registro: TBitBtn;
    ComboBox_Filtros: TComboBox;
    DataSource_Empresas: TDataSource;
    DBGrid_Principal: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit_Descripcion: TEdit;
    Image_Confirmado: TImage;
    Label10: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label_Ctdad_Rgtros: TLabel;
    Label_Fecha2: TLabel;
    Memo_Filtros: TMemo;
    Memo_OrderBy: TMemo;
    PageControl_Filtros: TPageControl;
    RadioGroup_Bajas: TRadioGroup;
    SQLQuery_Empresas: TSQLQuery;
    SQLQuery_EmpresasChange_Id_User: TLargeintField;
    SQLQuery_EmpresasChange_WHEN: TDateTimeField;
    SQLQuery_EmpresasCodigo_Postal: TStringField;
    SQLQuery_EmpresasDel_Id_User: TLargeintField;
    SQLQuery_EmpresasDel_WHEN: TDateTimeField;
    SQLQuery_EmpresasDel_WHY: TStringField;
    SQLQuery_EmpresasDireccion: TStringField;
    SQLQuery_EmpresasDireccion_Numero: TStringField;
    SQLQuery_EmpresasDireccion_Piso_Letra: TStringField;
    SQLQuery_EmpresaseMail: TStringField;
    SQLQuery_EmpresasFAX: TStringField;
    SQLQuery_Empresasid: TLargeintField;
    SQLQuery_Empresasid_paises: TLargeintField;
    SQLQuery_Empresasid_poblaciones: TLargeintField;
    SQLQuery_Empresasid_provincias: TLargeintField;
    SQLQuery_EmpresasInsert_Id_User: TLargeintField;
    SQLQuery_EmpresasInsert_WHEN: TDateTimeField;
    SQLQuery_EmpresasMovil: TStringField;
    SQLQuery_Empresasnif_cif: TStringField;
    SQLQuery_Empresasnombre_comercial: TStringField;
    SQLQuery_EmpresasNumero_Abono: TLargeintField;
    SQLQuery_EmpresasNumero_Abono_Compras: TLargeintField;
    SQLQuery_EmpresasNumero_Albaran: TLargeintField;
    SQLQuery_EmpresasNumero_Albaran_Compras: TLargeintField;
    SQLQuery_EmpresasNumero_Factura: TLargeintField;
    SQLQuery_EmpresasNumero_Factura_Compras: TLargeintField;
    SQLQuery_EmpresasNumero_Pedido: TLargeintField;
    SQLQuery_EmpresasNumero_Pedido_Compras: TLargeintField;
    SQLQuery_EmpresasNumero_Presupuesto: TLargeintField;
    SQLQuery_EmpresasNumero_Presupuesto_Compras: TLargeintField;
    SQLQuery_EmpresasObservaciones_Comentarios: TStringField;
    SQLQuery_EmpresasOT_descripcion_pais: TStringField;
    SQLQuery_EmpresasOT_descripcion_poblacion: TStringField;
    SQLQuery_EmpresasOT_descripcion_provincia: TStringField;
    SQLQuery_Empresaspagina_web: TStringField;
    SQLQuery_EmpresasResponsable: TStringField;
    SQLQuery_EmpresasSerie_Abono: TStringField;
    SQLQuery_EmpresasSerie_Abono_Compras: TStringField;
    SQLQuery_EmpresasSerie_Albaran: TStringField;
    SQLQuery_EmpresasSerie_Albaran_Compras: TStringField;
    SQLQuery_EmpresasSerie_Factura: TStringField;
    SQLQuery_EmpresasSerie_Factura_Compras: TStringField;
    SQLQuery_EmpresasSerie_Pedido: TStringField;
    SQLQuery_EmpresasSerie_Pedido_Compras: TStringField;
    SQLQuery_EmpresasSerie_Presupuesto: TStringField;
    SQLQuery_EmpresasSerie_Presupuesto_Compras: TStringField;
    SQLQuery_EmpresasTfno_Fijo_1: TStringField;
    SQLQuery_EmpresasTfno_Fijo_2: TStringField;
    TabSheet_Busqueda_Concreta: TTabSheet;
    TabSheet_Filtros_Generales: TTabSheet;

    procedure ComboBox_FiltrosChange(Sender: TObject);
    procedure Filtrar_Principal_Sin_Preguntar;
    procedure Editar_Registro;
    procedure para_Empezar;
    function  Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;
    procedure FormCreate(Sender: TObject);
    procedure Presentar_Datos;
    procedure Cerramos_Tablas_Ligadas;
    procedure Cerramos_Tablas;
    procedure Seleccionado_Rgtro;
    procedure Insertar_Registro;
    procedure no_Tocar;
    procedure Filtrar_tablas_ligadas;
    procedure Refrescar_Registros;
    procedure BitBtn_FiltrarClick(Sender: TObject);
    procedure BitBtn_ImprimirClick(Sender: TObject);
    procedure BitBtn_SALIRClick(Sender: TObject);
    procedure BitBtn_SeleccionarClick(Sender: TObject);
    procedure BitBtn_Ver_Situacion_RegistroClick(Sender: TObject);
    procedure DBGrid_PrincipalCellClick(Column: TColumn);
    procedure DBGrid_PrincipalDblClick(Sender: TObject);
    procedure DBGrid_PrincipalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid_PrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid_PrincipalKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroup_BajasClick(Sender: TObject);
    procedure SQLQuery_EmpresasAfterPost(DataSet: TDataSet);
    procedure SQLQuery_EmpresasAfterScroll(DataSet: TDataSet);
    procedure SQLQuery_EmpresasBeforeEdit(DataSet: TDataSet);
    procedure SQLQuery_EmpresasBeforePost(DataSet: TDataSet);

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
  form_empresas_000: Tform_empresas_000;

implementation

{$R *.lfm}

uses dm_empresas, menu, empresas_001;

{ Tform_empresas_000 }

procedure Tform_empresas_000.FormActivate(Sender: TObject);
begin
     If public_Elegimos = true then
     begin
         BitBtn_Seleccionar.Visible := True;
         BitBtn_Imprimir.Visible  := False;

         with Self do
         begin
             Color := $00B9959C;
         end;
     end;

     if public_Solo_Ver = true then no_Tocar;
end;

procedure Tform_empresas_000.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
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
             Fue correcto el modo como quiere BitBtn_SALIR de la aplicación
             ******************************************************************** }
         end;
end;

procedure Tform_empresas_000.FormDestroy(Sender: TObject);
begin
     Cerramos_Tablas;
end;

procedure Tform_empresas_000.SQLQuery_EmpresasAfterPost(DataSet: TDataSet);
begin
    UTI_RGTROS_Grabar( 'empresas',
                       DataModule_Empresas.SQLTransaction,
                       SQLQuery_Empresas,
                       false {Devolver_hacemos_commit_alFinalizar} );

    Refrescar_Registros;
end;

procedure Tform_empresas_000.SQLQuery_EmpresasAfterScroll(DataSet: TDataSet);
begin
    Filtrar_tablas_ligadas;
end;

procedure Tform_empresas_000.SQLQuery_EmpresasBeforePost(DataSet: TDataSet);
begin
     UTI_RGTROS_guardar_valorCampo_BoforePost( SQLQuery_Empresas );
end;

procedure Tform_empresas_000.BitBtn_FiltrarClick(Sender: TObject);
begin
     if PageControl_Filtros.ActivePage = TabSheet_Busqueda_Concreta then
     begin
         Filtrar_Principal_Sin_Preguntar;
     end else begin
         RadioGroup_Bajas.ItemIndex := Filtrar_Principal( true );
     end;
end;

procedure Tform_empresas_000.RadioGroup_BajasClick(Sender: TObject);
begin
     Refrescar_Registros;
end;

procedure Tform_empresas_000.BitBtn_SALIRClick(Sender: TObject);
begin
    private_Salir_OK := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}

    Close;
end;

procedure Tform_empresas_000.DBGrid_PrincipalCellClick(Column: TColumn);
begin
    //Filtrar_tablas_ligadas;
end;

procedure Tform_empresas_000.DBGrid_PrincipalDblClick(Sender: TObject);
begin
    If public_Elegimos then
         Seleccionado_Rgtro
    else Editar_Registro;
end;

procedure Tform_empresas_000.DBGrid_PrincipalDrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    UTI_GEN_Dibujar_Grid( Sender, SQLQuery_Empresas, Rect, DataCol, Column, State );
end;

procedure Tform_empresas_000.DBGrid_PrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Key = 13 then
    begin
        If public_Elegimos then
             Seleccionado_Rgtro
        else Editar_Registro;
    end;
end;

procedure Tform_empresas_000.DBGrid_PrincipalKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if (key = 40) or (key = 38) then
    begin
         //Filtrar_tablas_ligadas;
    end;
end;

procedure Tform_empresas_000.DBNavigator1BeforeAction(Sender: TObject; Button: TDBNavButtonType);
begin
    //Filtrar_tablas_ligadas;

    case Button of
        nbInsert : begin
            Insertar_Registro;
            Abort;
        end;

        nbEdit : begin
            Editar_Registro;
            Abort;
        end;

        nbDelete : begin
            if UTI_USR_Permiso_SN(public_Menu_Worked, 'B', true) = True then
            begin
                UTI_RGTRO_Borrar( 'empresas',
                                  SQLQuery_Empresas,
                                  public_Solo_Ver,
                                  public_Menu_Worked );
            end;
            Abort;
        end;

        nbRefresh : begin
            Refrescar_Registros;
            Abort;
        end;
    end;
end;

procedure Tform_empresas_000.BitBtn_Ver_Situacion_RegistroClick(Sender: TObject);
begin
    if UTI_USR_Permiso_SN(public_Menu_Worked, '', true) = True then
    begin
        if SQLQuery_Empresas.RecordCount > 0 then
        begin
            UTI_RGTRO_Ver_Estado_Registro( 'empresas',
                                           SQLQuery_Empresas,
                                           DataSource_Empresas,
                                           DBGrid_Principal );
        end;
    end;
end;

procedure Tform_empresas_000.BitBtn_ImprimirClick(Sender: TObject);
var var_Ficheros     : TStrings;
    var_Ordenado_por : String;
begin
    // ********************************************************************************************* //
    // ** Configuramos el título del listado                                                      ** //
    // ********************************************************************************************* //
    var_Ordenado_por := rs_Filtros_Otros_1 +
                        Trim(ComboBox_Filtros.Text);

    if Trim(Memo_Filtros.Lines.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            rs_Filtros_Otros_2 +
                            Trim(Memo_Filtros.Lines.Text);
    end;

    if Trim(Edit_Descripcion.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con descripción %' +
                            Trim(Edit_Descripcion.Text) + '%';
    end;

    // ********************************************************************************************* //
    // ** Configuramos la llamada al generador de informes                                        ** //
    // ********************************************************************************************* //
    var_Ficheros := TStringList.Create;

    UTI_GEN_Informes( var_Ordenado_por,
                      SQLQuery_Empresas,
                      DataSource_Empresas,
                      Nil,
                      Nil,
                      Nil,
                      public_Menu_Worked,
                      public_Solo_Ver,
                      '',
                      '',
                      var_Ficheros );

    var_Ficheros.Free;
end;

procedure Tform_empresas_000.BitBtn_SeleccionarClick(Sender: TObject);
begin
    Seleccionado_Rgtro;
end;

procedure Tform_empresas_000.Refrescar_Registros;
var var_nombre_comercial : String;
begin
    // ********************************************************************************************* //
    // ** OJITO ... NO USAR CAMPOS AUTOINCREMENTABLES                                             ** //
    // ********************************************************************************************* //
    var_nombre_comercial := '';

    if SQLQuery_Empresas.RecordCount > 0 then
    begin
        var_nombre_comercial := SQLQuery_Empresas.FieldByName('nombre_comercial').Value;
    end;

    Filtrar_Principal_Sin_Preguntar;

    if Trim(var_nombre_comercial) <> '' then
    begin
        SQLQuery_Empresas.Locate( 'nombre_comercial',
                                  var_nombre_comercial,
                                  [] );
    end;
end;

procedure Tform_empresas_000.Filtrar_tablas_ligadas;
var var_Lineas_Filtro  : TStrings;
    var_Lineas_OrderBy : TStrings;
begin
    if SQLQuery_Empresas.RecordCount = 0 then Exit;

    if SQLQuery_Empresas.State = dsInsert then
    begin
        Cerramos_Tablas_Ligadas;
        Exit;
    end;

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;
end;

procedure Tform_empresas_000.no_Tocar;
begin
    BitBtn_Imprimir.Enabled := False;
end;

procedure Tform_empresas_000.Insertar_Registro;
var var_msg  : TStrings;
    var_Form : Tform_empresas_001;
begin
    with SQLQuery_Empresas do
    begin
        var_msg := TStringList.Create;

        if UTI_USR_Permiso_SN(public_Menu_Worked, 'A', true) = True then
        begin
            if public_Solo_Ver = True then
            begin
                var_msg.Add(rs_Solo_Visualizar);
                UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
            end else begin
                Insert;

                var_Form := Tform_empresas_001.Create(nil);

                var_Form.para_Empezar;

                var_Form.ShowModal;
                if var_Form.public_Pulso_Aceptar = true then
                begin
                    FieldByName('Insert_WHEN').Value    := UTI_CN_Fecha_Hora;
                    FieldByName('Insert_Id_User').Value := Form_Menu.public_User;

                    UTI_RGTRO_Grabar_Antes( 'empresas', SQLQuery_Empresas );
                end else begin
                    Cancel;
                end;

                var_Form.Free;
            end;
        end;

        var_msg.Free;
    end;
end;

procedure Tform_empresas_000.Seleccionado_Rgtro;
begin
    private_Salir_OK          := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}
    public_Rgtro_Seleccionado := true;
    Close;
end;

procedure Tform_empresas_000.Cerramos_Tablas;
begin
    Cerramos_Tablas_Ligadas;

    if UTI_TB_Cerrar( DataModule_Empresas.SQLConnector,
                      DataModule_Empresas.SQLTransaction,
                      SQLQuery_Empresas ) = false then UTI_GEN_Salir;

    DataModule_Empresas.Free;
end;

procedure Tform_empresas_000.Cerramos_Tablas_Ligadas;
begin
    { ESTE form NO TIENE TABLAS LIGADAS

        if UTI_TB_Cerrar( DataModule_del_form_000.SQLConnector_de_la_tabla,
                          DataModule_Users.SQLTransaction_de_la_tabla,
                          SQLQuery_la_tabla ) = false then UTI_GEN_Salir;
    }
end;

procedure Tform_empresas_000.Presentar_Datos;
begin
     /// guardar por lo que pueda pasar
end;

procedure Tform_empresas_000.FormCreate(Sender: TObject);
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

    { ****************************************************************************
      Solo para formularios que traten con datos
      **************************************************************************** }
      public_Solo_Ver                 := false;
      public_Elegimos                 := false;

      public_Rgtro_Seleccionado       := false;
end;

procedure Tform_empresas_000.para_Empezar;
begin
  { ****************************************************************************
    Solo para formularios que traten con datos
    **************************************************************************** }
    if UTI_GEN_Form_Abierto_Ya('DataModule_Empresas') = False then
    begin
        DataModule_Empresas := TDataModule_Empresas.Create(Application);
    end;

  { ****************************************************************************
    Preparamos los diferentes tipos de orden preconfigurados
    **************************************************************************** }
    SetLength(private_Order_By, 2);

    private_Order_By[0].Titulo       := 'Por el nombre de la empresa'; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By[0].Memo_OrderBy := 'e.nombre_comercial ASC';

    private_Order_By[1].Titulo       := 'Por la id';
    private_Order_By[1].Memo_OrderBy := 'e.id ASC';

    Memo_OrderBy.Lines.Text          := private_Order_By[0].Memo_OrderBy;

    UTI_TB_Rellenar_ComboBox_Orden( true,
                                    ComboBox_Filtros,
                                    private_Order_By,
                                    0 );

  { ****************************************************************************
    Filtramos los datos
    **************************************************************************** }
    Filtrar_Principal_Sin_Preguntar;

    Presentar_Datos;

    // ********************************************************************************************* //
    // ** SOLO PARA ESTE FORM                                                                     ** //
    // ********************************************************************************************* //
    PageControl_Filtros.ActivePage := TabSheet_Busqueda_Concreta;
end;

procedure Tform_empresas_000.SQLQuery_EmpresasBeforeEdit(DataSet: TDataSet);
begin
    UTI_RGTROS_guardar_valorCampo_BoforeEdit( SQLQuery_Empresas );
end;

procedure Tform_empresas_000.Editar_Registro;
var var_msg  : TStrings;
    var_Form : Tform_empresas_001;
    var_id   : ShortString;
begin
    with SQLQuery_Empresas do
    begin
        var_msg := TStringList.Create;

        if RecordCount > 0 then
        begin
            var_id := FieldByName('id').AsString;

            if UTI_USR_Permiso_SN(public_Menu_Worked, 'M', true) = True then
            begin
                if UTI_RGTRO_isLock( 'empresas',
                                     FieldByName('id').AsString,
                                     true ) = true then
                begin
                    Exit;
                end else begin
                    if UTI_RGTRO_Lock( 'empresas',
                                       FieldByName('id').AsString ) = true then
                         Edit
                    else Exit;
                end;

                var_Form := Tform_empresas_001.Create(nil);

                var_Form.public_Menu_Worked := public_Menu_Worked;

                if public_Solo_Ver = true then
                begin
                    var_Form.public_Solo_Ver := true;
                end;

                var_Form.para_Empezar;

                var_Form.ShowModal;
                if var_Form.public_Pulso_Aceptar = true then
                begin
                    if UTI_DATOS_TABLA_SeCambioAlgoEnRgtro( SQLQuery_Empresas ) = true then
                    begin
                        FieldByName('Change_WHEN').Value    := UTI_CN_Fecha_Hora;
                        FieldByName('Change_Id_User').Value := Form_Menu.public_User;

                        UTI_RGTRO_Grabar_Antes( 'empresas', SQLQuery_Empresas );
                    end else begin
                        Cancel;
                    end;
                end else begin
                    Cancel;
                end;

                var_Form.Free;

                UTI_RGTRO_UnLock( 'empresas',
                                  var_id );
            end;
        end  else begin
            var_msg.Add(rs_no_Hay_Rgtros);
            UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
        end;
    end;
    var_msg.Free;
end;

function Tform_empresas_000.Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;
var
  var_a_Filtrar : TStrings;
  var_SQL_ADD   : TStrings;
begin
    var_SQL_ADD   := TStringList.Create;
    var_a_Filtrar := TStringList.Create;
    var_a_Filtrar.Clear;

    // ********************************************************************************************* //
    // ** AHORA PONDREMOS EL RESTO DE LOS FILTROS QUE NO SON GENERALES                            ** //
    // ********************************************************************************************* //
    // ** Primero buscaremos en el nombre y apellido el texto a buscar                              ** //
    // ********************************************************************************************* //
    if Trim(Edit_Descripcion.Text) <> '' then
    begin
        var_SQL_ADD.Clear;
        var_SQL_ADD.Add( 'e.nombre_comercial LIKE ' + UTI_GEN_Comillas('%' + Trim(Edit_Descripcion.Text) + '%') );
        UTI_TB_SQL_ADD( false,
                        var_a_Filtrar,
                        var_SQL_ADD );
    end;

    { NO OLVIDEMOS que los campos que empiezan por OT_ son campos que pertenecen a otras tablas(JOIN de la SELECT)
      y que por lo se debe de permitir modificarlos en ningún módulo }

    Result := UTI_TB_Filtrar( private_Order_By,

                              // Delete_SQL,
                              '',

                              // Update_SQL,
                              UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Empresas,
                                                            'empresas',
                                                            'u' ),

                              // Insert_SQL,
                              UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Empresas,
                                                            'empresas',
                                                            'i' ),

                              // var_ctdad_Rgtros,
                              -1,

                              DataModule_Empresas.SQLTransaction,
                              DataModule_Empresas.SQLConnector,
                              SQLQuery_Empresas,

                              // name_tabla,
                              'e',

                              RadioGroup_Bajas.ItemIndex,

                              // SELECT_SQL,
                              'SELECT e.*,' + ' ' +

                                     'pb.descripcion AS OT_descripcion_poblacion,' + ' ' +
                                     'pr.descripcion AS OT_descripcion_provincia,' + ' ' +
                                     'ps.descripcion AS OT_descripcion_pais' + ' ' +

                              'FROM empresas AS e' + ' ' +

                              'LEFT JOIN poblaciones AS pb' + ' ' +
                              'ON e.id_poblaciones = pb.id' + ' ' +

                              'LEFT JOIN provincias AS pr' + ' ' +
                              'ON e.id_provincias = pr.id' + ' ' +

                              'LEFT JOIN paises AS ps' + ' ' +
                              'ON e.id_paises = ps.id' + ' ',

                              Memo_Filtros.Lines,
                              Memo_OrderBy.Lines,
                              var_a_Filtrar,

                              param_Cambiamos_Filtro,
                              false,   // param_ver_SQL_despues_Abrir : Boolean;
                              true ); // jerofa no cerramos la conexión ... param_no_Cerrar_Conexion : Boolean {= false}

    var_a_Filtrar.Free;

    Label_Ctdad_Rgtros.Caption := IntToStr(SQLQuery_Empresas.RecordCount);

    //Filtrar_tablas_ligadas;
    var_SQL_ADD.Free;
end;

procedure Tform_empresas_000.Filtrar_Principal_Sin_Preguntar;
begin
    RadioGroup_Bajas.ItemIndex := Filtrar_Principal( false );
end;

procedure Tform_empresas_000.ComboBox_FiltrosChange(Sender: TObject);
begin
    Memo_OrderBy.Lines.Clear;
    Memo_OrderBy.Lines.Add( private_Order_By[ComboBox_Filtros.ItemIndex].Memo_OrderBy );
    BitBtn_FiltrarClick(Nil);
end;

end.


