unit articulos_familias_000;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
    DbCtrls, ExtCtrls, DBGrids, utilidades_rgtro, utilidades_general, utilidades_bd,
    utilidades_datos_tablas, Grids, ComCtrls, utilidades_usuarios, variants, LCLTranslator;

resourcestring
  rs_para_Empezar_1 = 'Por descripción';
  rs_para_Empezar_2 = 'Por el código de tarifa';
  rs_para_Empezar_3 = 'Por el código de terminal';
  rs_para_Empezar_4 = 'Por descripción';

  rs_BitBtn_ImprimirClick_1 = ', con descripción %';

  rs_DBNavigator1BeforeAction_1 = 'Esta familia de artículos, tiene asignadas otras familias como subfamilias suyas.';
  rs_DBNavigator1BeforeAction_2 = 'Hasta que no se las quite, no podrá borrar esta familia.';

  rs_error = 'ERROR ... ';

  rs_Insertar_Registro_1 = 'Familia de artículo repetida.';

  rs_Editar_Registro_1 = 'Tipo de artículo repetido.';

type

    { Tform_articulos_familias_000 }

    Tform_articulos_familias_000 = class(TForm)
      BitBtn_Filtrar: TBitBtn;
        BitBtn_Imprimir: TBitBtn;
        BitBtn_SALIR: TBitBtn;
        BitBtn_Seleccionar: TBitBtn;
        BitBtn_Ver_Situacion_Registro: TBitBtn;
        ComboBox_Filtros: TComboBox;
        DataSource_ArtFam: TDataSource;
        DataSource_ArtFam_SubFamilias: TDataSource;
        DataSource_ArtFam_Tarifas: TDataSource;
        DataSource_ArtFam_Terminales: TDataSource;
        DBGrid_Principal: TDBGrid;
        DBNavigator1: TDBNavigator;
        Edit_Descripcion: TEdit;
        Image_Confirmado: TImage;
        Label6: TLabel;
        Label7: TLabel;
        Label8: TLabel;
        Label_Fecha2: TLabel;
        Memo_Filtros: TMemo;
        Memo_OrderBy: TMemo;
        PageControl_Filtros: TPageControl;
        RadioGroup_Bajas: TRadioGroup;
        SQLQuery_Articulos_Familias: TSQLQuery;

          SQLQuery_Articulos_FamiliasAplicar_beneficio_en_tantoporciento_o_Importe: TStringField;
          SQLQuery_Articulos_FamiliasChange_Id_User: TLargeintField;
          SQLQuery_Articulos_FamiliasChange_WHEN: TDateTimeField;
        SQLQuery_Articulos_FamiliasComision: TBCDField;
        SQLQuery_Articulos_FamiliasCuenta_Contable_Compras: TStringField;
        SQLQuery_Articulos_FamiliasCuenta_Contable_Ventas: TStringField;
        SQLQuery_Articulos_FamiliasDel_Id_User: TLargeintField;
        SQLQuery_Articulos_FamiliasDel_WHEN: TDateTimeField;
        SQLQuery_Articulos_FamiliasDel_WHY: TStringField;
        SQLQuery_Articulos_Familiasdescripcion: TStringField;
        SQLQuery_Articulos_Familiasid_articulos_familias: TLargeintField;
        SQLQuery_Articulos_Familiasid_grupos_cocina: TLargeintField;
        SQLQuery_Articulos_Familiasid_impresoras: TLargeintField;
        SQLQuery_Articulos_FamiliasInsert_Id_User: TLargeintField;
        SQLQuery_Articulos_FamiliasInsert_WHEN: TDateTimeField;

          SQLQuery_Articulos_FamiliasMinimo_Variacion_Actualizar_en_tanto_por_ciento: TBCDField;

            SQLQuery_Articulos_FamiliasOT_descripcion_familia_superior: TStringField;
          SQLQuery_Articulos_FamiliasOT_descripcion_grupo_cocina: TStringField;

            SQLQuery_Articulos_FamiliasOT_descripcion_impresora_comandas: TStringField;
        SQLQuery_Articulos_FamiliasVentas_por_peso_SN: TStringField;
        SQLQuery_Articulos_FamiliasVisualizar_en_terminales_SN: TStringField;
        SQLQuery_Articulos_Familias_SubFamilias: TSQLQuery;
        SQLQuery_Articulos_Familiasid: TLargeintField;

        SQLQuery_Articulos_Familias_SubFamiliasChange_Id_User: TLargeintField;
        SQLQuery_Articulos_Familias_SubFamiliasChange_WHEN: TDateTimeField;
        SQLQuery_Articulos_Familias_SubFamiliasComision: TBCDField;
        SQLQuery_Articulos_Familias_SubFamiliasCuenta_Contable_Compras: TStringField;
        SQLQuery_Articulos_Familias_SubFamiliasCuenta_Contable_Ventas: TStringField;
        SQLQuery_Articulos_Familias_SubFamiliasDel_Id_User: TLargeintField;
        SQLQuery_Articulos_Familias_SubFamiliasDel_WHEN: TDateTimeField;
        SQLQuery_Articulos_Familias_SubFamiliasDel_WHY: TStringField;
        SQLQuery_Articulos_Familias_SubFamiliasdescripcion: TStringField;
        SQLQuery_Articulos_Familias_SubFamiliasid: TLargeintField;
        SQLQuery_Articulos_Familias_SubFamiliasid_articulos_familias: TLargeintField;
        SQLQuery_Articulos_Familias_SubFamiliasInsert_Id_User: TLargeintField;
        SQLQuery_Articulos_Familias_SubFamiliasInsert_WHEN: TDateTimeField;

        SQLQuery_Articulos_Familias_SubFamiliasMinimo_Variacion_Actualizar_en_tanto_por_ciento: TBCDField;
        SQLQuery_Articulos_Familias_SubFamiliasOT_descripcion_familia_superior: TStringField;
        SQLQuery_Articulos_Familias_SubFamiliasVentas_por_peso_SN: TStringField;
        SQLQuery_Articulos_Familias_SubFamiliasVisualizar_en_terminales_SN: TStringField;
        SQLQuery_Articulos_Familias_Tarifas: TSQLQuery;
        SQLQuery_Articulos_Familias_TarifasBeneficio: TBCDField;
        SQLQuery_Articulos_Familias_TarifasChange_Id_User: TLargeintField;
        SQLQuery_Articulos_Familias_TarifasChange_WHEN: TDateTimeField;
        SQLQuery_Articulos_Familias_TarifasDel_Id_User: TLargeintField;
        SQLQuery_Articulos_Familias_TarifasDel_WHEN: TDateTimeField;
        SQLQuery_Articulos_Familias_TarifasDel_WHY: TStringField;
        SQLQuery_Articulos_Familias_TarifasDescuento: TBCDField;
        SQLQuery_Articulos_Familias_Tarifasid: TLargeintField;

          SQLQuery_Articulos_Familias_Tarifasid_articulos_familias: TLargeintField;
          SQLQuery_Articulos_Familias_Tarifasid_tarifas: TLargeintField;
          SQLQuery_Articulos_Familias_TarifasInsert_Id_User: TLargeintField;
          SQLQuery_Articulos_Familias_TarifasInsert_WHEN: TDateTimeField;

            SQLQuery_Articulos_Familias_TarifasOT_descripcion_tarifa: TStringField;
        SQLQuery_Articulos_Familias_Terminales: TSQLQuery;
        SQLQuery_Articulos_Familias_TerminalesChange_Id_User: TLargeintField;
        SQLQuery_Articulos_Familias_TerminalesChange_WHEN: TDateTimeField;
        SQLQuery_Articulos_Familias_TerminalesDel_Id_User: TLargeintField;
        SQLQuery_Articulos_Familias_TerminalesDel_WHEN: TDateTimeField;
        SQLQuery_Articulos_Familias_TerminalesDel_WHY: TStringField;
        SQLQuery_Articulos_Familias_Terminalesid: TLargeintField;
        SQLQuery_Articulos_Familias_Terminalesid_articulos_familias: TLargeintField;
        SQLQuery_Articulos_Familias_Terminalesid_terminales: TLargeintField;
        SQLQuery_Articulos_Familias_TerminalesInsert_Id_User: TLargeintField;
        SQLQuery_Articulos_Familias_TerminalesInsert_WHEN: TDateTimeField;
        SQLQuery_Articulos_Familias_TerminalesOT_descripcion_terminal: TStringField;
        SQLQuery_Articulos_Familias_TerminalesVisualizar_en_terminal_SN: TStringField;
        TabSheet_Busqueda_Concreta: TTabSheet;
        TabSheet_Filtros_Generales: TTabSheet;

        procedure ComboBox_FiltrosChange(Sender: TObject);
        procedure Filtrar_Principal_Sin_Preguntar;
        procedure Editar_Registro;
        procedure FormCreate(Sender: TObject);
        procedure Insertar_Registro;
        procedure BitBtn_FiltrarClick(Sender: TObject);
        procedure BitBtn_Ver_Situacion_RegistroClick(Sender: TObject);
        procedure no_Tocar;
        procedure Presentar_Datos;
        procedure BitBtn_ImprimirClick(Sender: TObject);
        procedure BitBtn_SeleccionarClick(Sender: TObject);
        procedure DBNavigator1BeforeAction(Sender: TObject; Button: TDBNavButtonType);
        procedure Seleccionado_Rgtro;
        procedure BitBtn_SALIRClick(Sender: TObject);
        procedure DBGrid_PrincipalCellClick(Column: TColumn);
        procedure DBGrid_PrincipalDblClick(Sender: TObject);
        procedure DBGrid_PrincipalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
        procedure DBGrid_PrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure DBGrid_PrincipalKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

        procedure Filtrar_tablas_ligadas;
        function  Filtrar_Articulos_Familias_SubFamilias( param_ver_bajas : ShortInt; param_Cambiamos_Filtro : Boolean; param_Lineas_Filtro, param_Lineas_OrderBy : TStrings ) : ShortInt;
        function  Filtrar_Articulos_Familias_Tarifas( param_ver_bajas : ShortInt; param_Cambiamos_Filtro : Boolean; param_Lineas_Filtro, param_Lineas_OrderBy : TStrings ) : ShortInt;
        function  Filtrar_Articulos_Familias_Terminales( param_ver_bajas : ShortInt; param_Cambiamos_Filtro : Boolean; param_Lineas_Filtro, param_Lineas_OrderBy : TStrings ) : ShortInt;
        function  Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;

        procedure Refrescar_Registros_Terminales;
        procedure Refrescar_Registros_Tarifas;
        procedure Refrescar_Registros_SubFamilias;
        procedure Refrescar_Registros;
        procedure Cerramos_Tablas;
        procedure Cerramos_Tablas_Ligadas;
        procedure FormActivate(Sender: TObject);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure para_Empezar;
        procedure FormDestroy(Sender: TObject);
        procedure RadioGroup_BajasClick(Sender: TObject);
        procedure SQLQuery_Articulos_FamiliasAfterPost(DataSet: TDataSet);
        procedure SQLQuery_Articulos_FamiliasAfterScroll(DataSet: TDataSet);
        procedure SQLQuery_Articulos_FamiliasBeforeEdit(DataSet: TDataSet);
        procedure SQLQuery_Articulos_FamiliasBeforePost(DataSet: TDataSet);
        procedure SQLQuery_Articulos_FamiliasCalcFields(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_SubFamiliasAfterPost(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_SubFamiliasBeforeEdit(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_SubFamiliasBeforePost(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_SubFamiliasCalcFields(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_TarifasAfterPost(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_TarifasBeforeEdit(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_TarifasBeforePost(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_TarifasCalcFields(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_TerminalesAfterPost(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_TerminalesBeforeEdit(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_TerminalesBeforePost(DataSet: TDataSet);
        procedure SQLQuery_Articulos_Familias_TerminalesCalcFields(DataSet: TDataSet);
    private
        { private declarations }
        private_Salir_OK             : Boolean;
        private_Order_By             : array of TOrder_By;
        private_Order_By_tarifas     : array of TOrder_By;
        private_Order_By_terminales  : array of TOrder_By;
        private_Order_By_subfamilias : array of TOrder_By;
    public
        { public declarations }
        public_Solo_Ver           : Boolean;
        public_Elegimos           : Boolean;
        public_Menu_Worked        : Integer;
        public_Rgtro_Seleccionado : Boolean;
    end;

var
    form_articulos_familias_000: Tform_articulos_familias_000;

implementation

{$R *.lfm}

uses dm_articulos_familias, menu, articulos_familias_001;

{ Tform_articulos_familias_000 }

procedure Tform_articulos_familias_000.FormActivate(Sender: TObject);
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

procedure Tform_articulos_familias_000.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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

procedure Tform_articulos_familias_000.FormCreate(Sender: TObject);
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

procedure Tform_articulos_familias_000.FormDestroy(Sender: TObject);
begin
    Cerramos_Tablas;
end;

procedure Tform_articulos_familias_000.RadioGroup_BajasClick(Sender: TObject);
begin
     Refrescar_Registros;
end;

procedure Tform_articulos_familias_000.Cerramos_Tablas;
begin
    Cerramos_Tablas_Ligadas;

    if UTI_TB_Cerrar( DataModule_Articulos_Familias.SQLConnector_ArtFam,
                      DataModule_Articulos_Familias.SQLTransaction_ArtFam,
                      SQLQuery_Articulos_Familias ) = false then UTI_GEN_Salir;

    DataModule_Articulos_Familias.Free;
end;

procedure Tform_articulos_familias_000.Cerramos_Tablas_Ligadas;
begin
    if UTI_TB_Cerrar( DataModule_Articulos_Familias.SQLConnector_ArtFamSubFamilias,
                      DataModule_Articulos_Familias.SQLTransaction_ArtFamSubFamilias,
                      SQLQuery_Articulos_Familias_SubFamilias ) = false then UTI_GEN_Salir;

    if UTI_TB_Cerrar( DataModule_Articulos_Familias.SQLConnector_ArtFamTarifas,
                      DataModule_Articulos_Familias.SQLTransaction_ArtFamTarifas,
                      SQLQuery_Articulos_Familias_Tarifas ) = false then UTI_GEN_Salir;

    if UTI_TB_Cerrar( DataModule_Articulos_Familias.SQLConnector_ArtFamTerminales,
                      DataModule_Articulos_Familias.SQLTransaction_ArtFamTerminales,
                      SQLQuery_Articulos_Familias_Terminales ) = false then UTI_GEN_Salir;
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_FamiliasCalcFields(DataSet: TDataSet);
begin
    // ********************************************************************************************* //
    // ** PARA DAR VALOR A CAMPOS CALCULADOS                                                      ** //
    // ********************************************************************************************* //
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_SubFamiliasCalcFields(DataSet: TDataSet);
begin
    // ********************************************************************************************* //
    // ** PARA DAR VALOR A CAMPOS CALCULADOS                                                      ** //
    // ********************************************************************************************* //
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_TarifasCalcFields(
    DataSet: TDataSet);
begin
    // ********************************************************************************************* //
    // ** PARA DAR VALOR A CAMPOS CALCULADOS                                                      ** //
    // ********************************************************************************************* //
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_TerminalesCalcFields(
    DataSet: TDataSet);
begin
    // ********************************************************************************************* //
    // ** PARA DAR VALOR A CAMPOS CALCULADOS                                                      ** //
    // ********************************************************************************************* //
end;

procedure Tform_articulos_familias_000.Refrescar_Registros_SubFamilias;
var var_Lineas_Filtro         : TStrings;
    var_Lineas_OrderBy        : TStrings;
    var_ver_Bajas             : ShortInt;

    var_id_personal_familias : LargeInt;
    var_descripcion           : String;
begin
    // ********************************************************************************************* //
    // ** Solo si la cabecera está en modo EDIT se abren las tablas hijas                         ** //
    // ********************************************************************************************* //
    if SQLQuery_Articulos_Familias.State <> dsEdit then Exit;

    // ********************************************************************************************* //
    // ** OJITO ... NO USAR CAMPOS AUTOINCREMENTABLES                                             ** //
    // ********************************************************************************************* //
    var_descripcion           := '';
    var_id_personal_familias := 0;

    if SQLQuery_Articulos_Familias_SubFamilias.RecordCount > 0 then
    begin
        var_descripcion := SQLQuery_Articulos_Familias_SubFamilias.FieldByName('descripcion').Value;

        if not SQLQuery_Articulos_Familias_SubFamilias.FieldByName('id_articulos_familias').IsNull then
        begin
            var_id_personal_familias := SQLQuery_Articulos_Familias_SubFamilias.FieldByName('id_articulos_familias').Value;
        end;
    end;

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    var_Lineas_Filtro.Clear;
    var_Lineas_OrderBy.Clear;

    if Trim(SQLQuery_Articulos_Familias.FieldByName('id').AsString) <> '' then
         var_Lineas_Filtro.Add('sub.id_articulos_familias = ' + Trim(SQLQuery_Articulos_Familias.FieldByName('id').AsString))
    else var_Lineas_Filtro.Add('sub.id_articulos_familias = Null');

    var_ver_Bajas := RadioGroup_Bajas.ItemIndex;
    if UTI_GEN_Form_Abierto_Ya('form_articulos_familias_001') = true then
    begin
        var_ver_Bajas := form_articulos_familias_001.RadioGroup_Bajas.ItemIndex;
    end;

    Filtrar_Articulos_Familias_SubFamilias( var_ver_Bajas,
                                            false,
                                            var_Lineas_Filtro,
                                            var_Lineas_OrderBy );

    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;

    if Trim(var_descripcion) <> '' then
    begin
        SQLQuery_Articulos_Familias_SubFamilias.Locate( 'descripcion;id_articulos_familias',
                                                        VarArrayOf( [ var_descripcion,
                                                                      var_id_personal_familias ] ),
                                                        [] );
    end;
end;

procedure Tform_articulos_familias_000.Refrescar_Registros_Tarifas;
var var_Lineas_Filtro         : TStrings;
    var_Lineas_OrderBy        : TStrings;
    var_ver_Bajas             : ShortInt;

    var_id_personal_familias : LargeInt;
    var_id_tarifas            : LargeInt;
begin
    // ********************************************************************************************* //
    // ** Solo si la cabecera está en modo EDIT se abren las tablas hijas                         ** //
    // ********************************************************************************************* //
    if SQLQuery_Articulos_Familias.State <> dsEdit then Exit;

    // ********************************************************************************************* //
    // ** OJITO ... NO USAR CAMPOS AUTOINCREMENTABLES                                             ** //
    // ********************************************************************************************* //
    var_id_personal_familias := 0;
    var_id_tarifas            := 0;

    if SQLQuery_Articulos_Familias_Tarifas.RecordCount > 0 then
    begin
        if not SQLQuery_Articulos_Familias_Tarifas.FieldByName('id_articulos_familias').IsNull then
        begin
             var_id_personal_familias := SQLQuery_Articulos_Familias_Tarifas.FieldByName('id_articulos_familias').Value;
        end;

        if not SQLQuery_Articulos_Familias_Tarifas.FieldByName('id_tarifas').IsNull then
        begin
             var_id_tarifas := SQLQuery_Articulos_Familias_Tarifas.FieldByName('id_tarifas').Value;
        end;
    end;

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    var_Lineas_Filtro.Clear;
    var_Lineas_OrderBy.Clear;

    if Trim(SQLQuery_Articulos_Familias.FieldByName('id').AsString) <> '' then
         var_Lineas_Filtro.Add('ta.id_articulos_familias = ' + Trim(SQLQuery_Articulos_Familias.FieldByName('id').AsString))
    else var_Lineas_Filtro.Add('ta.id_articulos_familias = Null');

    var_ver_Bajas := RadioGroup_Bajas.ItemIndex;
    if UTI_GEN_Form_Abierto_Ya('form_articulos_familias_001') = true then
    begin
        var_ver_Bajas := form_articulos_familias_001.RadioGroup_Bajas.ItemIndex;
    end;

    Filtrar_Articulos_Familias_Tarifas( var_ver_Bajas,
                                        false,
                                        var_Lineas_Filtro,
                                        var_Lineas_OrderBy );

    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;

    if var_id_tarifas <> 0 then
    begin
        SQLQuery_Articulos_Familias_Tarifas.Locate( 'id_articulos_familias;id_tarifas',
                                                    VarArrayOf( [ var_id_personal_familias,
                                                                  var_id_tarifas ] ),
                                                    [] );
    end;
end;

procedure Tform_articulos_familias_000.Refrescar_Registros_Terminales;
var var_Lineas_Filtro        : TStrings;
    var_Lineas_OrderBy       : TStrings;
    var_ver_Bajas            : ShortInt;

    var_id_personal_familias : LargeInt;
    var_id_terminales        : LargeInt;
begin
    // ********************************************************************************************* //
    // ** Solo si la cabecera está en modo EDIT se abren las tablas hijas                         ** //
    // ********************************************************************************************* //
    if SQLQuery_Articulos_Familias.State <> dsEdit then Exit;

    // ********************************************************************************************* //
    // ** OJITO ... NO USAR CAMPOS AUTOINCREMENTABLES                                             ** //
    // ********************************************************************************************* //
    var_id_personal_familias := 0;
    var_id_terminales         := 0;

    if SQLQuery_Articulos_Familias_Terminales.RecordCount > 0 then
    begin
        if not SQLQuery_Articulos_Familias_Terminales.FieldByName('id_articulos_familias').IsNull then
        begin
             var_id_personal_familias := SQLQuery_Articulos_Familias_Terminales.FieldByName('id_articulos_familias').Value;
        end;

        if not SQLQuery_Articulos_Familias_Terminales.FieldByName('id_terminales').IsNull then
        begin
             var_id_terminales := SQLQuery_Articulos_Familias_Terminales.FieldByName('id_terminales').Value;
        end;
    end;

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    var_Lineas_Filtro.Clear;
    var_Lineas_OrderBy.Clear;

    if Trim(SQLQuery_Articulos_Familias.FieldByName('id').AsString) <> '' then
         var_Lineas_Filtro.Add('te.id_articulos_familias = ' + Trim(SQLQuery_Articulos_Familias.FieldByName('id').AsString))
    else var_Lineas_Filtro.Add('te.id_articulos_familias = Null');

    var_ver_Bajas := RadioGroup_Bajas.ItemIndex;
    if UTI_GEN_Form_Abierto_Ya('form_articulos_familias_001') = true then
    begin
        var_ver_Bajas := form_articulos_familias_001.RadioGroup_Bajas.ItemIndex;
    end;

    Filtrar_Articulos_Familias_Terminales( var_ver_Bajas,
                                           false,
                                           var_Lineas_Filtro,
                                           var_Lineas_OrderBy );

    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;

    if var_id_terminales <> 0 then
    begin
        SQLQuery_Articulos_Familias_Terminales.Locate( 'id_articulos_familias;id_terminales',
                                                       VarArrayOf( [ var_id_personal_familias,
                                                                     var_id_terminales ] ),
                                                       [] );
    end;
end;

procedure Tform_articulos_familias_000.Refrescar_Registros;
var var_descripcion : String;
begin
    // ********************************************************************************************* //
    // ** OJITO ... NO USAR CAMPOS AUTOINCREMENTABLES                                             ** //
    // ********************************************************************************************* //
    var_descripcion := '';

    if SQLQuery_Articulos_Familias.RecordCount > 0 then
    begin
        var_descripcion := SQLQuery_Articulos_Familias.FieldByName('descripcion').asString;
    end;

    Filtrar_Principal_Sin_Preguntar;

    if Trim(var_descripcion) <> '' then
    begin
         SQLQuery_Articulos_Familias.Locate('descripcion', var_descripcion, []);
    end;
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_FamiliasAfterPost(DataSet: TDataSet);
begin
    UTI_RGTROS_Grabar( 'articulos_familias',
                       DataModule_Articulos_Familias.SQLTransaction_ArtFam,
                       SQLQuery_Articulos_Familias,
                       false {Devolver_hacemos_commit_alFinalizar} );

    Refrescar_Registros;
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_SubFamiliasAfterPost(DataSet: TDataSet);
begin
    UTI_RGTROS_Grabar( 'articulos_familias',
                       DataModule_Articulos_Familias.SQLTransaction_ArtFamSubFamilias,
                       SQLQuery_Articulos_Familias_SubFamilias,
                       false {Devolver_hacemos_commit_alFinalizar} );

    Refrescar_Registros_SubFamilias;
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_TarifasAfterPost(DataSet: TDataSet);
begin
    UTI_RGTROS_Grabar( 'articulos_familias_tarifas',
                       DataModule_Articulos_Familias.SQLTransaction_ArtFamTarifas,
                       SQLQuery_Articulos_Familias_Tarifas,
                       false {Devolver_hacemos_commit_alFinalizar} );

    Refrescar_Registros_Tarifas;
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_TerminalesAfterPost(
    DataSet: TDataSet);
begin
    UTI_RGTROS_Grabar( 'articulos_familias_terminales',
                       DataModule_Articulos_Familias.SQLTransaction_ArtFamTerminales,
                       SQLQuery_Articulos_Familias_Terminales,
                       false {Devolver_hacemos_commit_alFinalizar} );

    Refrescar_Registros_Terminales;
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_FamiliasAfterScroll(DataSet: TDataSet);
begin
    Filtrar_tablas_ligadas;
end;

procedure Tform_articulos_familias_000.Filtrar_tablas_ligadas;
var
  var_Lineas_Filtro  : TStrings;
  var_Lineas_OrderBy : TStrings;
  var_SQL_ADD        : TStrings;
begin
    var_SQL_ADD := TStringList.Create;

    if SQLQuery_Articulos_Familias.RecordCount = 0 then Exit;

    if SQLQuery_Articulos_Familias.State = dsInsert then
    begin
        Cerramos_Tablas_Ligadas;
        Exit;
    end;

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    // ********************************************************************************************* //
    // ** SUBFAMILIAS                                                                             ** //
    // ********************************************************************************************* //
    var_SQL_ADD.Clear;
    var_SQL_ADD.Add( 'sub.id_articulos_familias = ' + SQLQuery_Articulos_Familias.FieldByName('id').AsString );
    UTI_TB_SQL_ADD( true,
                    var_Lineas_Filtro,
                    var_SQL_ADD );

    var_Lineas_OrderBy.Clear;
    Filtrar_Articulos_Familias_SubFamilias( RadioGroup_Bajas.ItemIndex,
                                            false,
                                            var_Lineas_Filtro,
                                            var_Lineas_OrderBy );

    // ********************************************************************************************* //
    // ** TARIFAS                                                                                 ** //
    // ********************************************************************************************* //
    var_SQL_ADD.Clear;
    var_SQL_ADD.Add( 'ta.id_articulos_familias = ' + SQLQuery_Articulos_Familias.FieldByName('id').AsString );
    UTI_TB_SQL_ADD( true,
                    var_Lineas_Filtro,
                    var_SQL_ADD );

    var_Lineas_OrderBy.Clear;
    Filtrar_Articulos_Familias_Tarifas( RadioGroup_Bajas.ItemIndex,
                                        false,
                                        var_Lineas_Filtro,
                                        var_Lineas_OrderBy );

    // ********************************************************************************************* //
    // ** TERMINALES                                                                              ** //
    // ********************************************************************************************* //
    var_SQL_ADD.Clear;
    var_SQL_ADD.Add( 'te.id_articulos_familias = ' + SQLQuery_Articulos_Familias.FieldByName('id').AsString );
    UTI_TB_SQL_ADD( true,
                    var_Lineas_Filtro,
                    var_SQL_ADD );

    var_Lineas_OrderBy.Clear;
    Filtrar_Articulos_Familias_Terminales( RadioGroup_Bajas.ItemIndex,
                                           false,
                                           var_Lineas_Filtro,
                                           var_Lineas_OrderBy );

    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;
    var_SQL_ADD.Free;
end;

function Tform_articulos_familias_000.Filtrar_Articulos_Familias_SubFamilias( param_ver_bajas : ShortInt;
                                                                              param_Cambiamos_Filtro : Boolean;
                                                                              param_Lineas_Filtro,
                                                                              param_Lineas_OrderBy : TStrings ) : ShortInt;
var
  var_a_Filtrar_Plus : TStrings;
begin
  var_a_Filtrar_Plus := TStringList.Create;
  var_a_Filtrar_Plus.Clear;

  if Trim(param_Lineas_OrderBy.Text) = '' then
  begin
    param_Lineas_OrderBy.Text := private_Order_By_subfamilias[0].Memo_OrderBy;
  end;

  { NO OLVIDEMOS que los campos que empiezan por OT_ son campos que pertenecen a otras tablas(JOIN de la SELECT)
    y que por lo se debe de permitir modificarlos en ningún módulo }

  Result := UTI_TB_Filtrar( private_Order_By_subfamilias,

                            // Delete_SQL,
                            '',

                            // Update_SQL,
                            UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Articulos_Familias_SubFamilias,
                                                          'articulos_familias',
                                                          'u' ),

                            // Insert_SQL,
                            UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Articulos_Familias_SubFamilias,
                                                          'articulos_familias',
                                                          'i' ),

                            // var_ctdad_Rgtros,
                            -1,

                            DataModule_Articulos_Familias.SQLTransaction_ArtFamSubFamilias,
                            DataModule_Articulos_Familias.SQLConnector_ArtFamSubFamilias,
                            SQLQuery_Articulos_Familias_SubFamilias,

                            // name_tabla,
                            'sub',

                            param_ver_bajas,

                            // SELECT_SQL,
                            'SELECT sub.*,' + ' ' +
                                   'afs.descripcion AS OT_descripcion_familia_superior' + ' ' +
                            'FROM articulos_familias AS sub' + ' ' +

                            'LEFT JOIN articulos_familias AS afs' + ' ' +
                            'ON sub.id_articulos_familias = afs.id' + ' ',

                            param_Lineas_Filtro,
                            param_Lineas_OrderBy,
                            var_a_Filtrar_Plus,

                            param_Cambiamos_Filtro,
                            false,   // param_ver_SQL_despues_Abrir : Boolean;
                            true ); // no cerramos la conexión ... param_no_Cerrar_Conexion : Boolean {= false}

  var_a_Filtrar_Plus.Free;
end;

function Tform_articulos_familias_000.Filtrar_Articulos_Familias_Tarifas( param_ver_bajas : ShortInt;
                                                                          param_Cambiamos_Filtro : Boolean;
                                                                          param_Lineas_Filtro,
                                                                          param_Lineas_OrderBy : TStrings ) : ShortInt;
var
  var_a_Filtrar_Plus : TStrings;
begin
  var_a_Filtrar_Plus := TStringList.Create;
  var_a_Filtrar_Plus.Clear;

  if Trim(param_Lineas_OrderBy.Text) = '' then
  begin
    param_Lineas_OrderBy.Text := private_Order_By_tarifas[0].Memo_OrderBy;
  end;

  { NO OLVIDEMOS que los campos que empiezan por OT_ son campos que pertenecen a otras tablas(JOIN de la SELECT)
    y que por lo se debe de permitir modificarlos en ningún módulo }

  Result := UTI_TB_Filtrar( private_Order_By_tarifas,

                            // Delete_SQL,
                            '',

                            // Update_SQL,
                            UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Articulos_Familias_Tarifas,
                                                          'articulos_familias_tarifas',
                                                          'u' ),

                            // Insert_SQL,
                            UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Articulos_Familias_Tarifas,
                                                          'articulos_familias_tarifas',
                                                          'i' ),

                            // var_ctdad_Rgtros,
                            -1,

                            DataModule_Articulos_Familias.SQLTransaction_ArtFamTarifas,
                            DataModule_Articulos_Familias.SQLConnector_ArtFamTarifas,
                            SQLQuery_Articulos_Familias_Tarifas,

                            // name_tabla,
                            'ta',

                            param_ver_bajas,

                            // SELECT_SQL,
                            'SELECT ta.*,' + ' ' +
                                   't.descripcion AS OT_descripcion_tarifa' + ' ' +
                            'FROM articulos_familias_tarifas AS ta' + ' ' +

                            'LEFT JOIN tarifas AS t' + ' ' +
                            'ON ta.id_tarifas = t.id' + ' ',

                            param_Lineas_Filtro,
                            param_Lineas_OrderBy,
                            var_a_Filtrar_Plus,

                            param_Cambiamos_Filtro,
                            false,   // param_ver_SQL_despues_Abrir : Boolean;
                            true ); // no cerramos la conexión ... param_no_Cerrar_Conexion : Boolean {= false}

  var_a_Filtrar_Plus.Free;
end;

procedure Tform_articulos_familias_000.para_Empezar;
begin
  { ****************************************************************************
    Solo para formularios que traten con datos
    **************************************************************************** }
    if UTI_GEN_Form_Abierto_Ya('DataModule_Articulos_Familias') = False then
    begin
        DataModule_Articulos_Familias := TDataModule_Articulos_Familias.Create(Application);
    end;

  { ****************************************************************************
    Preparamos los diferentes tipos de orden preconfigurados
    **************************************************************************** }
    // ARTICULOS FAMILIAS
    SetLength(private_Order_By, 1);

    private_Order_By[0].Titulo       := rs_para_Empezar_1; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By[0].Memo_OrderBy := 'af.descripcion ASC';

    Memo_OrderBy.Lines.Text          := private_Order_By[0].Memo_OrderBy;

    UTI_TB_Rellenar_ComboBox_Orden( true,
                                    ComboBox_Filtros,
                                    private_Order_By,
                                    0 );

    // ARTICULOS FAMILIAS TARIFAS
    SetLength(private_Order_By_tarifas, 1);

    private_Order_By_tarifas[0].Titulo       := rs_para_Empezar_2; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By_tarifas[0].Memo_OrderBy := 'ta.id_articulos_familias ASC, ta.id_tarifas ASC';

    // ARTICULOS FAMILIAS TERMINALES
    SetLength(private_Order_By_terminales, 1);

    private_Order_By_terminales[0].Titulo       := rs_para_Empezar_3; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By_terminales[0].Memo_OrderBy := 'te.id_articulos_familias ASC, te.id_terminales ASC';

    // ARTICULOS FAMILIAS SUBFAMILIAS
    SetLength(private_Order_By_subfamilias, 1);

    private_Order_By_subfamilias[0].Titulo       := rs_para_Empezar_4; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By_subfamilias[0].Memo_OrderBy := 'sub.id_articulos_familias ASC, sub.descripcion ASC';

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

function Tform_articulos_familias_000.Filtrar_Articulos_Familias_Terminales( param_ver_bajas : ShortInt;
                                                                             param_Cambiamos_Filtro : Boolean;
                                                                             param_Lineas_Filtro,
                                                                             param_Lineas_OrderBy : TStrings ) : ShortInt;
var
  var_a_Filtrar_Plus : TStrings;
begin
  var_a_Filtrar_Plus := TStringList.Create;
  var_a_Filtrar_Plus.Clear;

  if Trim(param_Lineas_OrderBy.Text) = '' then
  begin
    param_Lineas_OrderBy.Text := private_Order_By_terminales[0].Memo_OrderBy;
  end;

  { NO OLVIDEMOS que los campos que empiezan por OT_ son campos que pertenecen a otras tablas(JOIN de la SELECT)
    y que por lo se debe de permitir modificarlos en ningún módulo }

  Result := UTI_TB_Filtrar( private_Order_By_terminales,

                            // Delete_SQL,
                            '',

                            // Update_SQL,
                            UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Articulos_Familias_Terminales,
                                                          'articulos_familias_terminales',
                                                          'u' ),

                            // Insert_SQL,
                            UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Articulos_Familias_Terminales,
                                                          'articulos_familias_terminales',
                                                          'i' ),

                            // var_ctdad_Rgtros,
                            -1,

                            DataModule_Articulos_Familias.SQLTransaction_ArtFamTerminales,
                            DataModule_Articulos_Familias.SQLConnector_ArtFamTerminales,
                            SQLQuery_Articulos_Familias_Terminales,

                            // name_tabla,
                            'te',

                            param_ver_bajas,

                            // SELECT_SQL,
                            'SELECT te.*,' + ' ' +
                                   't.descripcion AS OT_descripcion_terminal' + ' ' +
                            'FROM articulos_familias_terminales AS te' + ' ' +

                            'LEFT JOIN terminales AS t' + ' ' +
                            'ON te.id_terminales = t.id' + ' ',

                            param_Lineas_Filtro,
                            param_Lineas_OrderBy,
                            var_a_Filtrar_Plus,

                            param_Cambiamos_Filtro,
                            false,   // param_ver_SQL_despues_Abrir : Boolean;
                            true ); // no cerramos la conexión ... param_no_Cerrar_Conexion : Boolean {= false}

  var_a_Filtrar_Plus.Free;
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_FamiliasBeforePost(DataSet: TDataSet);
begin
    UTI_RGTROS_guardar_valorCampo_BoforePost( SQLQuery_Articulos_Familias );
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_SubFamiliasBeforePost(
    DataSet: TDataSet);
begin
    UTI_RGTROS_guardar_valorCampo_BoforePost( SQLQuery_Articulos_Familias_SubFamilias );
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_TarifasBeforePost(
    DataSet: TDataSet);
begin
    UTI_RGTROS_guardar_valorCampo_BoforePost( SQLQuery_Articulos_Familias_Tarifas );
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_TerminalesBeforePost(
    DataSet: TDataSet);
begin
    UTI_RGTROS_guardar_valorCampo_BoforePost( SQLQuery_Articulos_Familias_Terminales );
end;

procedure Tform_articulos_familias_000.DBGrid_PrincipalDblClick(Sender: TObject);
begin
    If public_Elegimos then
         Seleccionado_Rgtro
    else Editar_Registro;
end;

procedure Tform_articulos_familias_000.DBGrid_PrincipalDrawColumnCell(Sender: TObject;
    const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    UTI_GEN_Dibujar_Grid( Sender, SQLQuery_Articulos_Familias, Rect, DataCol, Column, State );
end;

procedure Tform_articulos_familias_000.DBGrid_PrincipalKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if Key = 13 then
    begin
        If public_Elegimos then
             Seleccionado_Rgtro
        else Editar_Registro;
    end;
end;

procedure Tform_articulos_familias_000.DBGrid_PrincipalKeyUp(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if (key = 40) or (key = 38) then
    begin
         //Filtrar_tablas_ligadas;
    end;
end;

procedure Tform_articulos_familias_000.DBGrid_PrincipalCellClick(Column: TColumn);
begin
    //Filtrar_tablas_ligadas;
end;

procedure Tform_articulos_familias_000.BitBtn_SALIRClick(Sender: TObject);
begin
    private_Salir_OK := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}

    Close;
end;

procedure Tform_articulos_familias_000.Seleccionado_Rgtro;
begin
    private_Salir_OK          := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}
    public_Rgtro_Seleccionado := true;
    Close;
end;

procedure Tform_articulos_familias_000.BitBtn_SeleccionarClick(Sender: TObject);
begin
    Seleccionado_Rgtro;
end;

procedure Tform_articulos_familias_000.BitBtn_ImprimirClick(Sender: TObject);
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

    // ********************************************************************************************* //
    // ** Configuramos la llamada al generador de informes                                        ** //
    // ********************************************************************************************* //
    var_Ficheros := TStringList.Create;

    UTI_GEN_Informes( var_Ordenado_por,
                      SQLQuery_Articulos_Familias,
                      DataSource_ArtFam,
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

procedure Tform_articulos_familias_000.no_Tocar;
begin
    BitBtn_Imprimir.Enabled := False;
end;

procedure Tform_articulos_familias_000.Presentar_Datos;
begin
     /// guardar por lo que pueda pasar
end;

procedure Tform_articulos_familias_000.BitBtn_FiltrarClick(Sender: TObject);
begin
    if PageControl_Filtros.ActivePage = TabSheet_Busqueda_Concreta then
    begin
        Filtrar_Principal_Sin_Preguntar;
    end else begin
        RadioGroup_Bajas.ItemIndex := Filtrar_Principal( true );
    end;
end;

procedure Tform_articulos_familias_000.BitBtn_Ver_Situacion_RegistroClick(Sender: TObject);
begin
    if UTI_USR_Permiso_SN(public_Menu_Worked, '', True) = True then
    begin
        if SQLQuery_Articulos_Familias.RecordCount > 0 then
        begin
            UTI_RGTRO_Ver_Estado_Registro( 'articulos_familias',
                                           SQLQuery_Articulos_Familias,
                                           DataSource_ArtFam,
                                           DBGrid_Principal );
        end;
    end;
end;

procedure Tform_articulos_familias_000.DBNavigator1BeforeAction(Sender: TObject;
    Button: TDBNavButtonType);
var var_id          : ShortString;
    var_dar_de_Baja : Boolean;
    var_msg         : TStrings;
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
                if SQLQuery_Articulos_Familias_SubFamilias.RecordCount = 0 then
                    begin
                        var_id := SQLQuery_Articulos_Familias.FieldByName('id').AsString;

                        var_dar_de_Baja := true;
                        if not SQLQuery_Articulos_Familias.FieldByName('Del_WHEN').isNull then
                        begin
                            var_dar_de_Baja := false;
                        end;

                        UTI_RGTRO_Borrar( 'articulos_familias',
                                          SQLQuery_Articulos_Familias,
                                          public_Solo_Ver,
                                          public_Menu_Worked );
                    end
                else
                    begin
                        var_msg := TStringList.Create;
                        var_msg.Add(rs_DBNavigator1BeforeAction_1);
                        var_msg.Add(rs_DBNavigator1BeforeAction_2);
                        UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
                        var_msg.Free;
                    end;
            end;

            Abort;
        end;

        nbRefresh : begin
            Refrescar_Registros;
            Abort;
        end;
    end;
end;

procedure Tform_articulos_familias_000.Insertar_Registro;
var
  var_Campos_para_Existe_ya : Array of TCampos_para_Existe_ya;
  var_msg                   : TStrings;
  var_Fecha_Hora            : ShortString;
  var_record_Existe         : Trecord_Existe;
  var_descripcion           : ShortString;

begin
    with SQLQuery_Articulos_Familias do
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
                    Insert;

                    //Filtrar_tablas_ligadas;

                    FieldByName('Visualizar_en_terminales_SN').AsString := 'N';
                    FieldByName('Ventas_por_peso_SN').AsString          := 'N';

                    Application.CreateForm(Tform_articulos_familias_001, form_articulos_familias_001);

                    form_articulos_familias_001.DBGrid_Tarifas.Color     := clSilver;
                    form_articulos_familias_001.DBGrid_Terminales.Color  := clSilver;
                    form_articulos_familias_001.DBGrid_SubFamilias.Color := clSilver;

                    form_articulos_familias_001.RadioGroup_Bajas.ItemIndex := RadioGroup_Bajas.ItemIndex;

                    form_articulos_familias_001.para_Empezar;

                    form_articulos_familias_001.ShowModal;

                    if form_articulos_familias_001.public_Pulso_Aceptar = true then
                        begin
                            SetLength(var_Campos_para_Existe_ya, 1);

                            var_Campos_para_Existe_ya[0].Campo_Valor  := FieldByName('descripcion').AsString;
                            var_Campos_para_Existe_ya[0].Campo_Nombre := 'descripcion';
                            var_Campos_para_Existe_ya[0].Campo_Tipo   := 1; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                            var_record_Existe := UTI_RGTRO_Existe_Ya( 'articulos_familias',                          // param_nombre_tabla
                                                                      'ORDER BY articulos_familias.descripcion ASC', // param_order_by
                                                                      '',                                            // param_id_a_no_traer ... Estoy insertando
                                                                      var_Campos_para_Existe_ya );                   // param_Campos_para_Existe_ya

                            if var_record_Existe.Fallo_en_Conexion_BD = true then
                                begin
                                    form_articulos_familias_001.Free;
                                    Cancel;
                                end
                            else
                                begin
                                    if var_record_Existe.Existe = false then
                                        begin
                                            form_articulos_familias_001.Free;

                                            var_descripcion                     := FieldByName('descripcion').AsString;

                                            var_Fecha_Hora                      := DateTimeToStr(UTI_CN_Fecha_Hora);
                                            FieldByName('Insert_WHEN').AsString := var_Fecha_Hora;
                                            FieldByName('Insert_Id_User').Value := Form_Menu.public_User;

                                            UTI_RGTRO_Grabar_Antes( 'articulos_familias',
                                                                    SQLQuery_Articulos_Familias );

                                            // ***************************************************** //
                                            // ** Refresco el resto de tablas ligadas porque han  ** //
                                            // ** sido creadas automáticamente                    ** //
                                            // ***************************************************** //
                                            Filtrar_tablas_ligadas;

                                            Editar_Registro;
                                        end
                                    else
                                        begin
                                            form_articulos_familias_001.Free;
                                            Cancel;
                                            var_msg.Clear;
                                            var_msg.Add(rs_Insertar_Registro_1);

                                            if UpperCase(var_record_Existe.deBaja) = 'S' then
                                            begin
                                                var_msg.Add(rs_Rgtro_Borrado);
                                            end;

                                            UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                                        end;
                                end;
                        end
                    else
                        begin
                            form_articulos_familias_001.Free;
                            Cancel;
                        end;
                end;
        end;

        var_msg.Free;
    end;
end;

function Tform_articulos_familias_000.Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;
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
        var_SQL_ADD.Add( 'af.descripcion LIKE ' + UTI_GEN_Comillas('%' + Trim(Edit_Descripcion.Text) + '%') );
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
                              UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Articulos_Familias,
                                                            'articulos_familias',
                                                            'u' ),

                              // Insert_SQL,
                              UTI_DATOS_TABLA_Rellenar_SQL( SQLQuery_Articulos_Familias,
                                                            'articulos_familias',
                                                            'i' ),

                              // var_ctdad_Rgtros,
                              -1,

                              DataModule_Articulos_Familias.SQLTransaction_ArtFam,
                              DataModule_Articulos_Familias.SQLConnector_ArtFam,
                              SQLQuery_Articulos_Familias,

                              // name_tabla,
                              'af',

                              RadioGroup_Bajas.ItemIndex,

                              // SELECT_SQL,
                              'SELECT af.*,' + ' ' +
                                     'g.descripcion AS OT_descripcion_grupo_cocina,' + ' ' +
                                     'im.descripcion AS OT_descripcion_impresora_comandas,' + ' ' +
                                     'afs.descripcion AS OT_descripcion_familia_superior' + ' ' +

                              'FROM articulos_familias AS af' + ' ' +

                              'LEFT JOIN grupos_cocina AS g' + ' ' +
                              'ON af.id_grupos_cocina = g.id' + ' ' +

                              'LEFT JOIN grupos_cocina AS im' + ' ' +
                              'ON af.id_impresoras = im.id' + ' ' +

                              'LEFT JOIN articulos_familias AS afs' + ' ' +
                              'ON af.id_articulos_familias = afs.id' + ' ',

                              Memo_Filtros.Lines,
                              Memo_OrderBy.Lines,
                              var_a_Filtrar,

                              param_Cambiamos_Filtro,
                              false,   // param_ver_SQL_despues_Abrir : Boolean;
                              true ); // no cerramos la conexión ... param_no_Cerrar_Conexion : Boolean {= false}

    var_a_Filtrar.Free;

    if SQLQuery_Articulos_Familias.RecordCount = 0 then
    begin
        Cerramos_Tablas_Ligadas;
    end;

    //Filtrar_tablas_ligadas;
    var_SQL_ADD.Free;
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_FamiliasBeforeEdit(DataSet: TDataSet);
begin
    UTI_RGTROS_guardar_valorCampo_BoforeEdit( SQLQuery_Articulos_Familias );
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_TarifasBeforeEdit(DataSet: TDataSet);
begin
    UTI_RGTROS_guardar_valorCampo_BoforeEdit( SQLQuery_Articulos_Familias_Tarifas );
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_SubFamiliasBeforeEdit(DataSet: TDataSet);
begin
    UTI_RGTROS_guardar_valorCampo_BoforeEdit( SQLQuery_Articulos_Familias_SubFamilias );
end;

procedure Tform_articulos_familias_000.SQLQuery_Articulos_Familias_TerminalesBeforeEdit(DataSet: TDataSet);
begin
    UTI_RGTROS_guardar_valorCampo_BoforeEdit( SQLQuery_Articulos_Familias_Terminales );
end;

procedure Tform_articulos_familias_000.Editar_Registro;
var
  var_Campos_para_Existe_ya : Array of TCampos_para_Existe_ya;
  var_msg                   : TStrings;
  var_record_Existe         : Trecord_Existe;
  var_id                    : ShortString;

begin
    with SQLQuery_Articulos_Familias do
    begin
        var_msg := TStringList.Create;

        if RecordCount > 0 then
            begin
                var_id := FieldByName('id').AsString;

                if UTI_USR_Permiso_SN(public_Menu_Worked, 'M', True) = True then
                begin
                    if UTI_RGTRO_isLock( 'articulos_familias',
                                         FieldByName('id').AsString,
                                         true ) = true then
                        begin
                            Exit;
                        end
                    else
                        begin
                            if UTI_RGTRO_Lock( 'articulos_familias',
                                               FieldByName('id').AsString ) = true then
                                 Edit
                            else Exit;
                        end;

                    Application.CreateForm(Tform_articulos_familias_001, form_articulos_familias_001);

                    form_articulos_familias_001.RadioGroup_Bajas.ItemIndex := RadioGroup_Bajas.ItemIndex;
                    form_articulos_familias_001.public_Menu_Worked         := public_Menu_Worked;

                    if public_Solo_Ver = true then
                    begin
                        form_articulos_familias_001.public_Solo_Ver := true;
                    end;

                    form_articulos_familias_001.para_Empezar;

                    form_articulos_familias_001.ShowModal;

                    if form_articulos_familias_001.public_Pulso_Aceptar = true then
                        begin
                            SetLength(var_Campos_para_Existe_ya, 1);

                            var_Campos_para_Existe_ya[0].Campo_Valor  := FieldByName('descripcion').AsString;
                            var_Campos_para_Existe_ya[0].Campo_Nombre := 'descripcion';
                            var_Campos_para_Existe_ya[0].Campo_Tipo   := 1; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                            var_record_Existe := UTI_RGTRO_Existe_Ya( 'articulos_familias',                          // param_nombre_tabla
                                                                      'ORDER BY articulos_familias.descripcion ASC', // param_order_by
                                                                      FieldByName('id').AsString,                    // param_id_a_no_traer ... Estoy insertando
                                                                      var_Campos_para_Existe_ya );                   // param_Campos_para_Existe_ya

                            if var_record_Existe.Fallo_en_Conexion_BD = true then
                                begin
                                    form_articulos_familias_001.Free;
                                    Cancel;
                                end
                            else
                                begin
                                    if var_record_Existe.Existe = false then
                                        begin
                                            if UTI_DATOS_TABLA_SeCambioAlgoEnRgtro( SQLQuery_Articulos_Familias ) = true then
                                               begin
                                                    FieldByName('Change_WHEN').Value    := UTI_CN_Fecha_Hora;
                                                    FieldByName('Change_Id_User').Value := Form_Menu.public_User;

                                                    UTI_RGTRO_Grabar_Antes( 'articulos_familias',
                                                                            SQLQuery_Articulos_Familias );
                                               end
                                            else Cancel;
                                            form_articulos_familias_001.Free;
                                        end
                                    else
                                        begin
                                            form_articulos_familias_001.Free;
                                            Cancel;
                                            var_msg.Clear;
                                            var_msg.Add(rs_Editar_Registro_1);

                                            if UpperCase(var_record_Existe.deBaja) = 'S' then
                                            begin
                                                var_msg.Add(rs_Rgtro_Borrado);
                                            end;

                                            UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                                        end;
                                end;
                        end
                    else
                        begin
                            form_articulos_familias_001.Free;
                            Cancel;
                        end;

                    UTI_RGTRO_UnLock( 'articulos_familias',
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

procedure Tform_articulos_familias_000.Filtrar_Principal_Sin_Preguntar;
begin
    RadioGroup_Bajas.ItemIndex := Filtrar_Principal( false );
end;

procedure Tform_articulos_familias_000.ComboBox_FiltrosChange(Sender: TObject);
begin
    Memo_OrderBy.Lines.Clear;
    Memo_OrderBy.Lines.Add( private_Order_By[ComboBox_Filtros.ItemIndex].Memo_OrderBy );
    BitBtn_FiltrarClick(Nil);
end;

end.


