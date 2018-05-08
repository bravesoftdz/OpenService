unit almacenes_000;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  utilidades_usuarios, utilidades_general, utilidades_rgtro, utilidades_bd, DBGrids, DbCtrls,
  utilidades_datos_tablas, ExtCtrls, Grids, ComCtrls, utilidades_forms_Filtrar, LCLTranslator;

resourcestring
  rs_BitBtn_ImprimirClick_1 = ', con descripción %';
  rs_BitBtn_ImprimirClick_2 = ', con empresa = ';

  rs_para_Empezar_1         = 'Por la descripción';
  rs_para_Empezar_2         = 'Por la id';

type

  { Tform_almacenes_000 }

  Tform_almacenes_000 = class(TForm)
    BitBtn_Filtrar: TBitBtn;
    BitBtn_Imprimir: TBitBtn;
    BitBtn_SALIR: TBitBtn;
    BitBtn_Seleccionar: TBitBtn;
    BitBtn_Ver_Situacion_Registro: TBitBtn;
    Boton_Elegir_id_Empresas: TBitBtn;
    ComboBox_Filtros: TComboBox;
    DataSource_Almacenes: TDataSource;
    DBGrid_Principal: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit_Descripcion: TEdit;
    Edit_Descripcion_id_Empresas: TEdit;
    Edit_id_Empresas: TEdit;
    Image_Confirmado: TImage;
    Label10: TLabel;
    Label46: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label_Fecha2: TLabel;
    Memo_Filtros: TMemo;
    Memo_OrderBy: TMemo;
    PageControl_Filtros: TPageControl;
    RadioGroup_Bajas: TRadioGroup;
    SQLQuery_Almacenes: TSQLQuery;
    SQLQuery_AlmacenesChange_Id_User: TLargeintField;
    SQLQuery_AlmacenesChange_WHEN: TDateTimeField;
    SQLQuery_AlmacenesCodigo_Postal: TStringField;
    SQLQuery_AlmacenesDel_Id_User: TLargeintField;
    SQLQuery_AlmacenesDel_WHEN: TDateTimeField;
    SQLQuery_AlmacenesDel_WHY: TStringField;
    SQLQuery_Almacenesdescripcion: TStringField;
    SQLQuery_AlmacenesDireccion: TStringField;
    SQLQuery_AlmacenesDireccion_Numero: TStringField;
    SQLQuery_AlmacenesDireccion_Piso_Letra: TStringField;
    SQLQuery_AlmaceneseMail: TStringField;
    SQLQuery_AlmacenesFAX: TStringField;
    SQLQuery_Almacenesid: TLargeintField;
    SQLQuery_Almacenesid_empresas: TLargeintField;
    SQLQuery_Almacenesid_paises: TLargeintField;
    SQLQuery_Almacenesid_poblaciones: TLargeintField;
    SQLQuery_Almacenesid_provincias: TLargeintField;
    SQLQuery_AlmacenesInsert_Id_User: TLargeintField;
    SQLQuery_AlmacenesInsert_WHEN: TDateTimeField;
    SQLQuery_AlmacenesMovil: TStringField;
    SQLQuery_AlmacenesOT_Descripcion_Empresa: TStringField;
    SQLQuery_AlmacenesOT_descripcion_pais: TStringField;
    SQLQuery_AlmacenesOT_descripcion_poblacion: TStringField;
    SQLQuery_AlmacenesOT_descripcion_provincia: TStringField;
    SQLQuery_AlmacenesResponsable: TStringField;
    SQLQuery_AlmacenesTfno_Fijo_1: TStringField;
    SQLQuery_AlmacenesTfno_Fijo_2: TStringField;
    TabSheet_Busqueda_Concreta: TTabSheet;
    TabSheet_Filtros_Generales: TTabSheet;

    procedure Boton_Elegir_id_EmpresasClick(Sender: TObject);
    procedure ComboBox_FiltrosChange(Sender: TObject);
    procedure Edit_Descripcion_id_EmpresasClick(Sender: TObject);
    procedure Filtrar_Principal_Sin_Preguntar;
    procedure Editar_Registro;
    procedure para_Empezar;
    procedure FormCreate(Sender: TObject);
    procedure Presentar_Datos;
    procedure Cerramos_Tablas_Ligadas;
    procedure Cerramos_Tablas;
    procedure Seleccionado_Rgtro;
    procedure Insertar_Registro;
    procedure no_Tocar;
    procedure Filtrar_tablas_ligadas;
    procedure Refrescar_Registros;
    function  Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;
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
    procedure SQLQuery_AlmacenesAfterPost(DataSet: TDataSet);
    procedure SQLQuery_AlmacenesAfterScroll(DataSet: TDataSet);
    procedure SQLQuery_AlmacenesBeforeEdit(DataSet: TDataSet);
    procedure SQLQuery_AlmacenesBeforePost(DataSet: TDataSet);

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
  form_almacenes_000: Tform_almacenes_000;

implementation

{$R *.lfm}

uses dm_almacenes, menu, almacenes_001;

{ Tform_almacenes_000 }

procedure Tform_almacenes_000.FormActivate(Sender: TObject);
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

procedure Tform_almacenes_000.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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

procedure Tform_almacenes_000.FormDestroy(Sender: TObject);
begin
     Cerramos_Tablas;
end;

procedure Tform_almacenes_000.SQLQuery_AlmacenesAfterPost(DataSet: TDataSet);
begin
    UTI_RGTRO_Grabar( 'almacenes',
                      DataModule_Almacenes.SQLTransaction,
                      SQLQuery_Almacenes );

    Refrescar_Registros;
end;

procedure Tform_almacenes_000.SQLQuery_AlmacenesAfterScroll(DataSet: TDataSet);
begin
    Filtrar_tablas_ligadas;
end;

procedure Tform_almacenes_000.SQLQuery_AlmacenesBeforePost(DataSet: TDataSet);
begin
     UTI_RGTRO_param_assign_value( SQLQuery_Almacenes );
end;

procedure Tform_almacenes_000.BitBtn_FiltrarClick(Sender: TObject);
begin
     if PageControl_Filtros.ActivePage = TabSheet_Busqueda_Concreta then
     begin
         Filtrar_Principal_Sin_Preguntar;
     end else begin
         RadioGroup_Bajas.ItemIndex := Filtrar_Principal( true );
     end;
end;

procedure Tform_almacenes_000.RadioGroup_BajasClick(Sender: TObject);
begin
     Refrescar_Registros;
end;

procedure Tform_almacenes_000.BitBtn_SALIRClick(Sender: TObject);
begin
    private_Salir_OK := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}

    Close;
end;

procedure Tform_almacenes_000.DBGrid_PrincipalCellClick(Column: TColumn);
begin
    //Filtrar_tablas_ligadas;
end;

procedure Tform_almacenes_000.DBGrid_PrincipalDblClick(Sender: TObject);
begin
    If public_Elegimos then
         Seleccionado_Rgtro
    else Editar_Registro;
end;

procedure Tform_almacenes_000.DBGrid_PrincipalDrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    UTI_GEN_Dibujar_Grid( Sender, SQLQuery_Almacenes, Rect, DataCol, Column, State );
end;

procedure Tform_almacenes_000.DBGrid_PrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Key = 13 then
    begin
        If public_Elegimos then
             Seleccionado_Rgtro
        else Editar_Registro;
    end;
end;

procedure Tform_almacenes_000.DBGrid_PrincipalKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if (key = 40) or (key = 38) then
    begin
         //Filtrar_tablas_ligadas;
    end;
end;

procedure Tform_almacenes_000.DBNavigator1BeforeAction(Sender: TObject; Button: TDBNavButtonType);
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
            if UTI_USR_Permiso_SN(public_Menu_Worked, 'B', True) = True then
            begin
                UTI_RGTRO_Borrar( 'almacenes',
                                  SQLQuery_Almacenes,
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

procedure Tform_almacenes_000.BitBtn_Ver_Situacion_RegistroClick(Sender: TObject);
begin
    if UTI_USR_Permiso_SN(public_Menu_Worked, '', True) = True then
    begin
        if SQLQuery_Almacenes.RecordCount > 0 then
        begin
            UTI_RGTRO_Ver_Estado_Registro( 'almacenes',
                                           SQLQuery_Almacenes,
                                           DataSource_Almacenes,
                                           DBGrid_Principal );
        end;
    end;
end;

procedure Tform_almacenes_000.BitBtn_ImprimirClick(Sender: TObject);
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
                            rs_BitBtn_ImprimirClick_1 +
                            Trim(Edit_Descripcion.Text) + '%';
    end;

    if Trim(Edit_Descripcion_id_Empresas.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            rs_BitBtn_ImprimirClick_2 +
                            Trim(Edit_Descripcion_id_Empresas.Text);
    end;

    // ********************************************************************************************* //
    // ** Configuramos la llamada al generador de informes                                        ** //
    // ********************************************************************************************* //
    var_Ficheros := TStringList.Create;

    UTI_GEN_Informes( var_Ordenado_por,
                      SQLQuery_Almacenes,
                      DataSource_Almacenes,
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

procedure Tform_almacenes_000.BitBtn_SeleccionarClick(Sender: TObject);
begin
    Seleccionado_Rgtro;
end;

function Tform_almacenes_000.Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;
var var_Registro_CRUD : TRegistro_CRUD;
    var_ctdad_Rgtros  : Integer;
    var_a_Filtrar     : TStrings;
begin
    var_a_Filtrar := TStringList.Create;
    var_a_Filtrar.Clear;

    var_Registro_CRUD := UTI_DATOS_TABLA_almacenes_CRUD;
    var_ctdad_Rgtros  := -1;

    // ********************************************************************************************* //
    // ** AHORA PONDREMOS EL RESTO DE LOS FILTROS QUE NO SON GENERALES                            ** //
    // ********************************************************************************************* //
    // ** Primero buscaremos en el nombre y apellido el texto a buscar                              ** //
    // ********************************************************************************************* //
    if Trim(Edit_Descripcion.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'alm.descripcion LIKE ' +
                                UTI_GEN_Comillas('%' + Trim(Edit_Descripcion.Text) + '%') );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por la empresa                                                         ** //
    // ********************************************************************************************* //
    if Trim(Edit_id_Empresas.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'alm.id_empresas = ' + Trim(Edit_id_Empresas.Text) );
    end;

    // ********************************************************************************************* //
    // ** Pasamos a filtrar los registros                                                         ** //
    // ********************************************************************************************* //
    Result := UTI_TB_Filtrar( private_Order_By,

                              var_Registro_CRUD.Delete_SQL,
                              var_Registro_CRUD.Update_SQL,
                              var_Registro_CRUD.Insert_SQL,

                              var_ctdad_Rgtros,
                              DataModule_Almacenes.SQLTransaction,
                              DataModule_Almacenes.SQLConnector,
                              SQLQuery_Almacenes,

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

procedure Tform_almacenes_000.Refrescar_Registros;
var var_descripcion : String;
begin
    // ********************************************************************************************* //
    // ** OJITO ... NO USAR CAMPOS AUTOINCREMENTABLES                                             ** //
    // ********************************************************************************************* //
    var_descripcion := '';

    if SQLQuery_Almacenes.RecordCount > 0 then
    begin
        var_descripcion := SQLQuery_Almacenes.FieldByName('descripcion').Value;
    end;

    Filtrar_Principal_Sin_Preguntar;

    if Trim(var_descripcion) <> '' then
    begin
        SQLQuery_Almacenes.Locate( 'descripcion',
                                   var_descripcion,
                                   [] );
    end;
end;

procedure Tform_almacenes_000.Filtrar_tablas_ligadas;
var var_Lineas_Filtro  : TStrings;
    var_Lineas_OrderBy : TStrings;
begin
    if SQLQuery_Almacenes.RecordCount = 0 then Exit;

    if SQLQuery_Almacenes.State = dsInsert then
    begin
        Cerramos_Tablas_Ligadas;
        Exit;
    end;

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;
end;

procedure Tform_almacenes_000.no_Tocar;
begin
    BitBtn_Imprimir.Enabled := False;
end;

procedure Tform_almacenes_000.Insertar_Registro;
var var_msg  : TStrings;
    var_Form : Tform_almacenes_001;
begin
    with SQLQuery_Almacenes do
    begin
        var_msg := TStringList.Create;

        if UTI_USR_Permiso_SN(public_Menu_Worked, 'A', True) = True then
        begin
            if public_Solo_Ver = True then
                begin
                    var_msg.Add(rs_Solo_Visualizar);
                    UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
                end
            else
                begin
                    Insert ;

                    var_Form := Tform_almacenes_001.Create(nil);

                    var_Form.para_Empezar;

                    var_Form.ShowModal;
                    if var_Form.public_Pulso_Aceptar = true then
                        begin
                            FieldByName('Insert_WHEN').Value    := UTI_CN_Fecha_Hora;
                            FieldByName('Insert_Id_User').Value := Form_Menu.public_User;

                            UTI_RGTRO_Grabar_Antes( 'almacenes',
                                                    SQLQuery_Almacenes );
                        end
                    else Cancel;

                    var_Form.Free;
                end;
        end;

        var_msg.Free;
    end;
end;

procedure Tform_almacenes_000.Seleccionado_Rgtro;
begin
    private_Salir_OK          := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}
    public_Rgtro_Seleccionado := true;
    Close;
end;

procedure Tform_almacenes_000.Cerramos_Tablas;
begin
    Cerramos_Tablas_Ligadas;

    if UTI_TB_Cerrar( DataModule_Almacenes.SQLConnector,
                      DataModule_Almacenes.SQLTransaction,
                      SQLQuery_Almacenes ) = false then UTI_GEN_Salir;

    DataModule_Almacenes.Free;
end;

procedure Tform_almacenes_000.Cerramos_Tablas_Ligadas;
begin
    { ESTE form NO TIENE TABLAS LIGADAS

        if UTI_TB_Cerrar( DataModule_del_form_000.SQLConnector_de_la_tabla,
                          DataModule_Users.SQLTransaction_de_la_tabla,
                          SQLQuery_la_tabla ) = false then UTI_GEN_Salir;
    }
end;

procedure Tform_almacenes_000.Presentar_Datos;
begin
     /// guardar por lo que pueda pasar
end;

procedure Tform_almacenes_000.FormCreate(Sender: TObject);
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

procedure Tform_almacenes_000.para_Empezar;
begin
  { ****************************************************************************
    Solo para formularios que traten con datos
    **************************************************************************** }
    if UTI_GEN_Form_Abierto_Ya('DataModule_Almacenes') = False then
    begin
        DataModule_Almacenes := TDataModule_Almacenes.Create(Application);
    end;

  { ****************************************************************************
    Preparamos los diferentes tipos de orden preconfigurados
    **************************************************************************** }
    SetLength(private_Order_By, 2);

    private_Order_By[0].Titulo       := rs_para_Empezar_1; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By[0].Memo_OrderBy := 'alm.descripcion ASC';

    private_Order_By[1].Titulo       := rs_para_Empezar_2;
    private_Order_By[1].Memo_OrderBy := 'alm.id ASC';

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

procedure Tform_almacenes_000.SQLQuery_AlmacenesBeforeEdit(DataSet: TDataSet);
begin
    UTI_RGTRO_param_assign_value_Edit( SQLQuery_Almacenes );
end;

procedure Tform_almacenes_000.Editar_Registro;
var var_msg  : TStrings;
    var_Form : Tform_almacenes_001;
    var_id   : ShortString;
begin
    with SQLQuery_Almacenes do
    begin
        var_msg := TStringList.Create;

        if RecordCount > 0 then
            begin
                var_id := FieldByName('id').AsString;

                if UTI_USR_Permiso_SN(public_Menu_Worked, 'M', True) = True then
                begin
                    if UTI_RGTRO_isLock( 'almacenes',
                                         FieldByName('id').AsString,
                                         true ) = true then
                        begin
                            Exit;
                        end
                    else
                        begin
                            if UTI_RGTRO_Lock( 'almacenes',
                                               FieldByName('id').AsString ) = true then
                                 Edit
                            else Exit;
                        end;

                    var_Form := Tform_almacenes_001.Create(nil);

                    var_Form.public_Menu_Worked := public_Menu_Worked;

                    if public_Solo_Ver = true then
                    begin
                        var_Form.public_Solo_Ver := true;
                    end;

                    var_Form.para_Empezar;

                    var_Form.ShowModal;
                    if var_Form.public_Pulso_Aceptar = true then
                        begin
                            if (Trim(Params.ParamByName('COPY_' + 'descripcion').AsString)          <> Trim(FieldByName('descripcion').AsString))          or
                               (Trim(Params.ParamByName('COPY_' + 'Responsable').AsString)          <> Trim(FieldByName('Responsable').AsString))          or
                               (Trim(Params.ParamByName('COPY_' + 'id_empresas').AsString)          <> Trim(FieldByName('id_empresas').AsString))          or
                               (Trim(Params.ParamByName('COPY_' + 'Direccion').AsString)            <> Trim(FieldByName('Direccion').AsString))            or
                               (Trim(Params.ParamByName('COPY_' + 'Direccion_Numero').AsString)     <> Trim(FieldByName('Direccion_Numero').AsString))     or
                               (Trim(Params.ParamByName('COPY_' + 'Direccion_Piso_Letra').AsString) <> Trim(FieldByName('Direccion_Piso_Letra').AsString)) or
                               (Trim(Params.ParamByName('COPY_' + 'Codigo_Postal').AsString)        <> Trim(FieldByName('Codigo_Postal').AsString))        or
                               (Trim(Params.ParamByName('COPY_' + 'id_poblaciones').AsString)       <> Trim(FieldByName('id_poblaciones').AsString))       or
                               (Trim(Params.ParamByName('COPY_' + 'id_provincias').AsString)        <> Trim(FieldByName('id_provincias').AsString))        or
                               (Trim(Params.ParamByName('COPY_' + 'id_paises').AsString)            <> Trim(FieldByName('id_paises').AsString))            or
                               (Trim(Params.ParamByName('COPY_' + 'Tfno_Fijo_1').AsString)          <> Trim(FieldByName('Tfno_Fijo_1').AsString))          or
                               (Trim(Params.ParamByName('COPY_' + 'Tfno_Fijo_2').AsString)          <> Trim(FieldByName('Tfno_Fijo_2').AsString))          or
                               (Trim(Params.ParamByName('COPY_' + 'FAX').AsString)                  <> Trim(FieldByName('FAX').AsString))                  or
                               (Trim(Params.ParamByName('COPY_' + 'Movil').AsString)                <> Trim(FieldByName('Movil').AsString))                or
                               (Trim(Params.ParamByName('COPY_' + 'eMail').AsString)                <> Trim(FieldByName('eMail').AsString))                then
                               begin
                                    FieldByName('Change_WHEN').Value    := UTI_CN_Fecha_Hora;
                                    FieldByName('Change_Id_User').Value := Form_Menu.public_User;

                                    UTI_RGTRO_Grabar_Antes( 'almacenes',
                                                            SQLQuery_Almacenes );
                               end
                            else Cancel;
                        end
                    else Cancel;

                    var_Form.Free;

                    UTI_RGTRO_UnLock( 'almacenes',
                                      var_id );
                end;
            end
        else
            begin
                var_msg.Add(rs_no_Hay_Rgtros);
                UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
            end;
    end;
    var_msg.Free;
end;

procedure Tform_almacenes_000.Filtrar_Principal_Sin_Preguntar;
begin
    RadioGroup_Bajas.ItemIndex := Filtrar_Principal( false );
end;

procedure Tform_almacenes_000.Boton_Elegir_id_EmpresasClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    var_Registro := UTI_Abrir_Form( true, false, '', 250 );
    if var_Registro.id_1 <> '' then
    begin
        Edit_id_Empresas.Text             := Trim(var_Registro.id_1);
        Edit_Descripcion_id_Empresas.Text := var_Registro.descripcion_1;
    end;
end;

procedure Tform_almacenes_000.ComboBox_FiltrosChange(Sender: TObject);
begin
    Memo_OrderBy.Lines.Clear;
    Memo_OrderBy.Lines.Add( private_Order_By[ComboBox_Filtros.ItemIndex].Memo_OrderBy );
    BitBtn_FiltrarClick(Nil);
end;

procedure Tform_almacenes_000.Edit_Descripcion_id_EmpresasClick(Sender: TObject);
begin
    Edit_id_Empresas.Text             := '';
    Edit_Descripcion_id_Empresas.Text := '';
end;

end.


