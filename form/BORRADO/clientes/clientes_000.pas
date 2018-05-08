unit clientes_000;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, sqldb, db, FileUtil, DateTimePicker, Forms, Controls, Graphics, Dialogs,
    ExtCtrls, Buttons, StdCtrls, DBGrids, DbCtrls, Grids, ComCtrls, variants, utilidades_datos_tablas,
    utilidades_usuarios, utilidades_rgtro, utilidades_bd, utilidades_general, utilidades_forms_Filtrar;

type

    { Tform_clientes_000 }

    Tform_clientes_000 = class(TForm)
      BitBtn_Filtrar: TBitBtn;
        BitBtn_Imprimir: TBitBtn;
        BitBtn_SALIR: TBitBtn;
        BitBtn_Seleccionar: TBitBtn;
        BitBtn_Ver_Situacion_Registro: TBitBtn;
        Boton_Elegir_clientes_tipos: TBitBtn;
        Boton_Elegir_Forma_Pago: TBitBtn;
        Boton_Elegir_Pais: TBitBtn;
        Boton_Elegir_Ruta: TBitBtn;
        Boton_Elegir_Poblacion: TBitBtn;
        Boton_Elegir_Provincia: TBitBtn;
        Boton_Elegir_Actividad: TBitBtn;
        Boton_Elegir_Representante: TBitBtn;
        CheckBox1: TCheckBox;
        ComboBox_Filtros: TComboBox;
        DataSource_Clientes: TDataSource;
        DataSource_Clientes_Contactos: TDataSource;
        DataSource_Clientes_Envios: TDataSource;
        DateTimePicker_Nacido_Desde: TDateTimePicker;
        DateTimePicker_Nacido_Hasta: TDateTimePicker;
        DBGrid_Principal: TDBGrid;
        DBNavigator1: TDBNavigator;
        Edit_Descripcion_clientes_tipos: TEdit;
        Edit_Descripcion_Forma_Pago: TEdit;
        Edit_Descripcion_Pais: TEdit;
        Edit_Descripcion_Ruta: TEdit;
        Edit_Descripcion_Poblacion: TEdit;
        Edit_Descripcion_Provincia: TEdit;
        Edit_Descripcion_Actividad: TEdit;
        Edit_Descripcion_Representante: TEdit;
        Edit_id_clientes_tipos: TEdit;
        Edit_id_Forma_Pago: TEdit;
        Edit_id_paises: TEdit;
        Edit_id_Ruta: TEdit;
        Edit_id_poblaciones: TEdit;
        Edit_id_provincias: TEdit;
        Edit_id_Actividad: TEdit;
        Edit_id_representantes: TEdit;
        Edit_NIF: TEdit;
        Edit_Nombre_Comercial: TEdit;
        Edit_nombre_propietario: TEdit;
        Image_Confirmado: TImage;
        Label10: TLabel;
        Label15: TLabel;
        Label16: TLabel;
        Label45: TLabel;
        Label46: TLabel;
        Label47: TLabel;
        Label48: TLabel;
        Label49: TLabel;
        Label50: TLabel;
        Label51: TLabel;
        Label52: TLabel;
        Label6: TLabel;
        Label7: TLabel;
        Label8: TLabel;
        Label9: TLabel;
        Label_Ctdad_Rgtros: TLabel;
        Label_Fecha2: TLabel;
        Memo_Filtros: TMemo;
        Memo_OrderBy: TMemo;
        PageControl_Filtros: TPageControl;
        RadioGroup_Bajas: TRadioGroup;
        SQLQuery_Clientes: TSQLQuery;
        SQLQuery_ClientesCantidad_Hermanos: TSmallintField;
        SQLQuery_ClientesEstudia_SN: TStringField;
        SQLQuery_ClientesEstudios_Trabajos: TStringField;
        SQLQuery_Clientesid_actividades: TLargeintField;
        SQLQuery_Clientesid_rutas: TLargeintField;
        SQLQuery_ClientesOT_Cuenta_Contable_cliente_tipo: TStringField;
        SQLQuery_ClientesOT_descripcion_actividad: TStringField;
        SQLQuery_ClientesOT_descripcion_ruta: TStringField;
        SQLQuery_ClientesOT_Vencimientos_1_Dias: TSmallintField;
        SQLQuery_ClientesOT_Vencimientos_Cantidad: TSmallintField;
        SQLQuery_ClientesOT_Vencimientos_Dias_Entre: TSmallintField;
        SQLQuery_ClientesPortes_Pagados_SN: TStringField;
        SQLQuery_ClientesTrabaja_SN: TStringField;
        SQLQuery_Clientes_Contactos: TSQLQuery;
        SQLQuery_ClientesActivar_Proximidad_SN: TStringField;
        SQLQuery_ClientesAgrupar_Albaranes_SN: TStringField;
        SQLQuery_ClientesChange_Id_User: TLargeintField;
        SQLQuery_ClientesChange_WHEN: TDateTimeField;
        SQLQuery_ClientesCodigo_Postal: TStringField;
        SQLQuery_ClientesCta_Bco_BIC_SWIFT: TStringField;
        SQLQuery_ClientesCta_Bco_Codigo_Postal: TStringField;
        SQLQuery_ClientesCta_Bco_Cuenta: TStringField;
        SQLQuery_ClientesCta_Bco_Digito_Control: TStringField;
        SQLQuery_ClientesCta_Bco_Direccion: TStringField;
        SQLQuery_ClientesCta_Bco_Direccion_Numero: TStringField;
        SQLQuery_ClientesCta_Bco_Direccion_Piso_Letra: TStringField;
        SQLQuery_ClientesCta_Bco_Entidad: TStringField;
        SQLQuery_ClientesCta_Bco_IBAN: TStringField;
        SQLQuery_ClientesCta_Bco_Mandato_Fecha_de_Firma: TDateTimeField;
        SQLQuery_ClientesCta_Bco_Mandato_Ref: TStringField;
        SQLQuery_ClientesCta_Bco_Sucursal: TStringField;
        SQLQuery_ClientesCuenta_Contable: TStringField;
        SQLQuery_ClientesDel_Id_User: TLargeintField;
        SQLQuery_ClientesDel_WHEN: TDateTimeField;
        SQLQuery_ClientesDel_WHY: TStringField;
        SQLQuery_ClientesDescuento_Comercial_1: TBCDField;
        SQLQuery_ClientesDescuento_Comercial_2: TBCDField;
        SQLQuery_ClientesDescuento_Final: TBCDField;
        SQLQuery_ClientesDescuento_Pronto_Pago: TBCDField;
        SQLQuery_ClientesDireccion: TStringField;
        SQLQuery_ClientesDireccion_Numero: TStringField;
        SQLQuery_ClientesDireccion_Piso_Letra: TStringField;
        SQLQuery_ClienteseMail: TStringField;
        SQLQuery_ClientesFAX: TStringField;
        SQLQuery_ClientesFecha_Nacimiento: TDateTimeField;
        SQLQuery_ClientesForma_pago_Dia_1: TSmallintField;
        SQLQuery_ClientesForma_pago_Dia_2: TSmallintField;
        SQLQuery_ClientesForma_pago_Vacaciones_Dia_Fin: TSmallintField;
        SQLQuery_ClientesForma_pago_Vacaciones_Dia_Inicio: TSmallintField;
        SQLQuery_ClientesForma_pago_Vacaciones_Mes_Fin: TSmallintField;
        SQLQuery_ClientesForma_pago_Vacaciones_Mes_Inicio: TSmallintField;
        SQLQuery_Clientesid: TLargeintField;
        SQLQuery_Clientesid_Agencias_Transporte: TLargeintField;
        SQLQuery_Clientesid_clientes_tipos: TLargeintField;
        SQLQuery_Clientesid_Cta_Bco_pais: TLargeintField;
        SQLQuery_Clientesid_Cta_Bco_poblaciones: TLargeintField;
        SQLQuery_Clientesid_Cta_Bco_provincias: TLargeintField;
        SQLQuery_Clientesid_formas_pago: TLargeintField;
        SQLQuery_Clientesid_paises: TLargeintField;
        SQLQuery_Clientesid_poblaciones: TLargeintField;
        SQLQuery_Clientesid_provincias: TLargeintField;
        SQLQuery_Clientesid_Representantes: TLargeintField;
        SQLQuery_Clientesid_tarifas: TLargeintField;
        SQLQuery_ClientesInsert_Id_User: TLargeintField;
        SQLQuery_ClientesInsert_WHEN: TDateTimeField;
        SQLQuery_ClientesIVA_con_Recargo_SN: TStringField;
        SQLQuery_ClientesIVA_Excluido_SN: TStringField;
        SQLQuery_ClientesMovil: TStringField;
        SQLQuery_Clientesnif_cif: TStringField;
        SQLQuery_Clientesnombre_comercial: TStringField;
        SQLQuery_Clientesnombre_propietario: TStringField;
        SQLQuery_ClientesObservaciones_Comentarios: TStringField;
        SQLQuery_ClientesOT_Cta_Bco_descripcion_pais: TStringField;
        SQLQuery_ClientesOT_Cta_Bco_descripcion_poblacion: TStringField;
        SQLQuery_ClientesOT_Cta_Bco_descripcion_provincia: TStringField;
        SQLQuery_ClientesOT_descripcion_agencia_transporte: TStringField;
        SQLQuery_ClientesOT_descripcion_cliente_tipo: TStringField;
        SQLQuery_ClientesOT_descripcion_forma_pago: TStringField;
        SQLQuery_ClientesOT_descripcion_pais: TStringField;
        SQLQuery_ClientesOT_descripcion_poblacion: TStringField;
        SQLQuery_ClientesOT_descripcion_provincia: TStringField;
        SQLQuery_ClientesOT_descripcion_representante: TStringField;
        SQLQuery_ClientesOT_descripcion_tarifa: TStringField;
        SQLQuery_ClientesOT_Movil_agencia_transporte: TStringField;
        SQLQuery_ClientesOT_Movil_representante: TStringField;
        SQLQuery_ClientesOT_Tfno_Fijo_1_agencia_transporte: TStringField;
        SQLQuery_ClientesOT_Tfno_Fijo_1_representante: TStringField;
        SQLQuery_ClientesOT_todos_los_Tfnos1: TStringField;
        SQLQuery_Clientespagina_web: TStringField;
        SQLQuery_ClientesRetencion: TBCDField;
        SQLQuery_ClientesRiesgo_Acumulado: TBCDField;
        SQLQuery_ClientesRiesgo_Autorizado: TBCDField;
        SQLQuery_ClientesTfno_Fijo_1: TStringField;
        SQLQuery_ClientesTfno_Fijo_2: TStringField;
        SQLQuery_ClientesVencimientos_automaticos_SN: TStringField;
        SQLQuery_Clientes_ContactosCargo_Puesto: TStringField;
        SQLQuery_Clientes_ContactosChange_Id_User: TLargeintField;
        SQLQuery_Clientes_ContactosChange_WHEN: TDateTimeField;
        SQLQuery_Clientes_ContactosDel_Id_User: TLargeintField;
        SQLQuery_Clientes_ContactosDel_WHEN: TDateTimeField;
        SQLQuery_Clientes_ContactosDel_WHY: TStringField;
        SQLQuery_Clientes_ContactoseMail: TStringField;
        SQLQuery_Clientes_ContactosFAX: TStringField;
        SQLQuery_Clientes_ContactosFecha_Nacimiento: TDateTimeField;
        SQLQuery_Clientes_Contactosid: TLargeintField;
        SQLQuery_Clientes_Contactosid_clientes: TLargeintField;
        SQLQuery_Clientes_ContactosInsert_Id_User: TLargeintField;
        SQLQuery_Clientes_ContactosInsert_WHEN: TDateTimeField;
        SQLQuery_Clientes_ContactosMovil: TStringField;
        SQLQuery_Clientes_Contactosnif_cif: TStringField;
        SQLQuery_Clientes_Contactosnombre: TStringField;
        SQLQuery_Clientes_ContactosOT_todos_los_Tfnos1: TStringField;
        SQLQuery_Clientes_Contactospagina_web: TStringField;
        SQLQuery_Clientes_ContactosTfno_Fijo_1: TStringField;
        SQLQuery_Clientes_ContactosTfno_Fijo_2: TStringField;
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

        procedure Boton_Elegir_ActividadClick(Sender: TObject);
        procedure Boton_Elegir_clientes_tiposClick(Sender: TObject);
        procedure Boton_Elegir_Forma_PagoClick(Sender: TObject);
        procedure Boton_Elegir_PaisClick(Sender: TObject);
        procedure Boton_Elegir_RepresentanteClick(Sender: TObject);
        procedure Boton_Elegir_PoblacionClick(Sender: TObject);
        procedure Boton_Elegir_ProvinciaClick(Sender: TObject);
        procedure Boton_Elegir_RutaClick(Sender: TObject);
        procedure ComboBox_FiltrosChange(Sender: TObject);
        procedure Edit_Descripcion_clientes_tiposClick(Sender: TObject);
        procedure Edit_Descripcion_Forma_PagoClick(Sender: TObject);
        procedure Edit_Descripcion_PaisClick(Sender: TObject);
        procedure Edit_Descripcion_PoblacionClick(Sender: TObject);
        procedure Edit_Descripcion_ActividadClick(Sender: TObject);
        procedure Edit_Descripcion_ProvinciaClick(Sender: TObject);
        procedure Edit_Descripcion_RepresentanteClick(Sender: TObject);
        procedure Edit_Descripcion_RutaClick(Sender: TObject);
        procedure Filtrar_Principal_Sin_Preguntar;
        procedure Filtrar_tablas_ligadas;
        function  Filtrar_clientes_envios( param_ver_bajas : ShortInt; param_Cambiamos_Filtro : Boolean; param_Lineas_Filtro, param_Lineas_OrderBy : TStrings ) : ShortInt;
        function  Filtrar_clientes_contactos( param_ver_bajas : ShortInt; param_Cambiamos_Filtro : Boolean; param_Lineas_Filtro, param_Lineas_OrderBy : TStrings ) : ShortInt;
        function  Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;
        procedure FormCreate(Sender: TObject);

        procedure Refrescar_Registros_Contactos;
        procedure Refrescar_Registros_Envios;
        procedure Editar_Registro;
        procedure BitBtn_Ver_Situacion_RegistroClick(Sender: TObject);
        procedure Refrescar_Registros;
        procedure BitBtn_FiltrarClick(Sender: TObject);
        procedure Presentar_Datos;
        procedure no_Tocar;
        procedure BitBtn_ImprimirClick(Sender: TObject);
        procedure Insertar_Registro;
        procedure BitBtn_SeleccionarClick(Sender: TObject);
        procedure DBGrid_PrincipalCellClick(Column: TColumn);
        procedure DBNavigator1BeforeAction(Sender: TObject; Button: TDBNavButtonType);
        procedure Seleccionado_Rgtro;
        procedure DBGrid_PrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure DBGrid_PrincipalKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure BitBtn_SALIRClick(Sender: TObject);
        procedure Cerramos_Tablas;
        procedure Cerramos_Tablas_Ligadas;
        procedure DBGrid_PrincipalDblClick(Sender: TObject);
        procedure DBGrid_PrincipalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
        procedure FormActivate(Sender: TObject);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure para_Empezar;
        procedure FormDestroy(Sender: TObject);
        procedure RadioGroup_BajasClick(Sender: TObject);
        procedure SQLQuery_ClientesAfterPost(DataSet: TDataSet);
        procedure SQLQuery_ClientesAfterScroll(DataSet: TDataSet);
        procedure SQLQuery_ClientesBeforeEdit(DataSet: TDataSet);
        procedure SQLQuery_ClientesBeforePost(DataSet: TDataSet);
        procedure SQLQuery_ClientesCalcFields(DataSet: TDataSet);
        procedure SQLQuery_Clientes_ContactosAfterPost(DataSet: TDataSet);
        procedure SQLQuery_Clientes_ContactosBeforeEdit(DataSet: TDataSet);
        procedure SQLQuery_Clientes_ContactosBeforePost(DataSet: TDataSet);
        procedure SQLQuery_Clientes_ContactosCalcFields(DataSet: TDataSet);
        procedure SQLQuery_Clientes_EnviosAfterPost(DataSet: TDataSet);
        procedure SQLQuery_Clientes_EnviosBeforeEdit(DataSet: TDataSet);
        procedure SQLQuery_Clientes_EnviosBeforePost(DataSet: TDataSet);
        procedure SQLQuery_Clientes_EnviosCalcFields(DataSet: TDataSet);

    private
        { private declarations }
        private_Salir_OK           : Boolean;
        private_Order_By           : array of TOrder_By;
        private_Order_By_contactos : array of TOrder_By;
        private_Order_By_envios    : array of TOrder_By;
    public
        { public declarations }
        public_Solo_Ver           : Boolean;
        public_Elegimos           : Boolean;
        public_Menu_Worked        : Integer;
        public_Rgtro_Seleccionado : Boolean;
    end;

var
    form_clientes_000: Tform_clientes_000;

implementation

{$R *.lfm}

uses dm_clientes, menu, clientes_001;

{ Tform_clientes_000 }

****************************************************************************************************
****************************************************************************************************
****************************************************************************************************
****************************************************************************************************

procedure Tform_clientes_000.Edit_Descripcion_clientes_tiposClick(Sender: TObject);
begin
    Edit_id_clientes_tipos.Text          := '';
    Edit_Descripcion_clientes_tipos.Text := '';
end;

procedure Tform_clientes_000.Boton_Elegir_clientes_tiposClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    var_Registro := UTI_Abrir_Form( true, false, '', 70 );
    if var_Registro.id_1 <> '' then
    begin
        Edit_id_clientes_tipos.Text          := Trim(var_Registro.id_1);
        Edit_Descripcion_clientes_tipos.Text := var_Registro.descripcion_1;
    end;
end;

procedure Tform_clientes_000.Boton_Elegir_Forma_PagoClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    var_Registro := UTI_Abrir_Form( true, false, '', 80 );
    if var_Registro.id_1 <> '' then
    begin
        Edit_id_Forma_Pago.Text          := Trim(var_Registro.id_1);
        Edit_Descripcion_Forma_Pago.Text := var_Registro.descripcion_1;
    end;
end;

procedure Tform_clientes_000.Edit_Descripcion_Forma_PagoClick(Sender: TObject);
begin
    Edit_id_Forma_Pago.Text          := '';
    Edit_Descripcion_Forma_Pago.Text := '';
end;

procedure Tform_clientes_000.Boton_Elegir_RepresentanteClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    var_Registro := UTI_Abrir_Form( true, false, '', 130 );
    if var_Registro.id_1 <> '' then
    begin
        Edit_id_representantes.Text         := Trim(var_Registro.id_1);
        Edit_Descripcion_Representante.Text := var_Registro.descripcion_1;
    end;
end;

procedure Tform_clientes_000.Edit_Descripcion_RepresentanteClick(Sender: TObject);
begin
    Edit_id_representantes.Text         := '';
    Edit_Descripcion_Representante.Text := '';
end;

procedure Tform_clientes_000.Boton_Elegir_ActividadClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    var_Registro := UTI_Abrir_Form( true, false, '', 500 );
    if var_Registro.id_1 <> '' then
    begin
        Edit_id_Actividad.Text          := Trim(var_Registro.id_1);
        Edit_Descripcion_Actividad.Text := var_Registro.descripcion_1;
    end;
end;

procedure Tform_clientes_000.Edit_Descripcion_ActividadClick(Sender: TObject);
begin
    Edit_id_Actividad.Text          := '';
    Edit_Descripcion_Actividad.Text := '';
end;

procedure Tform_clientes_000.Boton_Elegir_RutaClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    var_Registro := UTI_Abrir_Form( true, false, '', 510 );
    if var_Registro.id_1 <> '' then
    begin
        Edit_id_Ruta.Text          := Trim(var_Registro.id_1);
        Edit_Descripcion_Ruta.Text := var_Registro.descripcion_1;
    end;
end;

procedure Tform_clientes_000.Edit_Descripcion_RutaClick(Sender: TObject);
begin
    Edit_id_Ruta.Text          := '';
    Edit_Descripcion_Ruta.Text := '';
end;

procedure Tform_clientes_000.Boton_Elegir_PoblacionClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    var_Registro := UTI_Abrir_Form( true, false, '', 110 );
    if var_Registro.id_1 <> '' then
    begin
        Edit_id_poblaciones.Text        := Trim(var_Registro.id_1);
        Edit_Descripcion_Poblacion.Text := var_Registro.descripcion_1;
    end;
end;

procedure Tform_clientes_000.Edit_Descripcion_PoblacionClick(Sender: TObject);
begin
    Edit_id_poblaciones.Text        := '';
    Edit_Descripcion_Poblacion.Text := '';
end;

procedure Tform_clientes_000.Boton_Elegir_ProvinciaClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    var_Registro := UTI_Abrir_Form( true, false, '', 100 );
    if var_Registro.id_1 <> '' then
    begin
        Edit_id_provincias.Text         := Trim(var_Registro.id_1);
        Edit_Descripcion_Provincia.Text := var_Registro.descripcion_1;
    end;
end;

procedure Tform_clientes_000.Edit_Descripcion_ProvinciaClick(Sender: TObject);
begin
    Edit_id_provincias.Text         := '';
    Edit_Descripcion_Provincia.Text := '';
end;

procedure Tform_clientes_000.Boton_Elegir_PaisClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    var_Registro := UTI_Abrir_Form( true, false, '', 60 );
    if var_Registro.id_1 <> '' then
    begin
        Edit_id_paises.Text        := Trim(var_Registro.id_1);
        Edit_Descripcion_Pais.Text := var_Registro.descripcion_1;
    end;
end;

procedure Tform_clientes_000.Edit_Descripcion_PaisClick(Sender: TObject);
begin
    Edit_id_paises.Text        := '';
    Edit_Descripcion_Pais.Text := '';
end;

procedure Tform_clientes_000.Insertar_Registro;
var var_msg                : TStrings;
    var_Fecha_Hora         : ShortString;
    var_nombre_propietario : String;
begin
    with SQLQuery_Clientes do
    begin
        var_msg := TStringList.Create;

        if UTI_USR_Permiso_SN(public_Menu_Worked, 'A', True) = True then
        begin
            if public_Solo_Ver = True then
            begin
                var_msg.Add(rs_Solo_Visualizar);
                UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
            end else begin
                Insert;

                // ********************************************************************************* //
                // ** CAMPOS QUE SON OBLIGADOS                                                    ** //
                // ********************************************************************************* //
                FieldByName('Vencimientos_automaticos_SN').AsString := 'N';

                FieldByName('IVA_con_Recargo_SN').AsString          := 'N';
                FieldByName('IVA_Excluido_SN').AsString             := 'N';
                FieldByName('Agrupar_Albaranes_SN').AsString        := 'N';
                FieldByName('Activar_Proximidad_SN').AsString       := 'S';

                FieldByName('Riesgo_Autorizado').AsString           := '0';
                FieldByName('Riesgo_Acumulado').AsString            := '0';

                FieldByName('Portes_Pagados_SN').AsString           := 'S';

                // ********************************************************************************* //
                // ** ABRIMOS EL FORM PARA CAPTURAR DATOS                                         ** //
                // ********************************************************************************* //
                Application.CreateForm(Tform_clientes_001, form_clientes_001);

                form_clientes_001.DBGrid_Contactos.Color := clSilver;
                form_clientes_001.DBGrid_Envios.Color    := clSilver;

                form_clientes_001.RadioGroup_Bajas.ItemIndex := RadioGroup_Bajas.ItemIndex;

                form_clientes_001.para_Empezar;

                form_clientes_001.ShowModal;

                // ********************************************************************************* //
                // ** PASAMOS A COMPROBAR DATOS INTRODUCIDOS PARA VER SI GRABAMOS                 ** //
                // ********************************************************************************* //
                if form_clientes_001.public_Pulso_Aceptar = true then
                begin
                    form_clientes_001.Free;

                    var_Fecha_Hora                      := DateTimeToStr(UTI_CN_Fecha_Hora);
                    FieldByName('Insert_WHEN').AsString := var_Fecha_Hora;
                    FieldByName('Insert_Id_User').Value := Form_Menu.public_User;

                    var_nombre_propietario              := FieldByName('nombre_propietario').AsString;

                    UTI_RGTRO_Grabar_Antes( 'clientes', SQLQuery_Clientes );

                    if FieldByName('nombre_propietario').AsString = var_nombre_propietario then
                    begin
                        Editar_Registro;
                    end;
                end else begin
                    // ************************************************************************* //
                    // ** Se pulso cancelar                                                   ** //
                    // ************************************************************************* //
                    form_clientes_001.Free;
                    Cancel;
                end;
            end;
        end;

        var_msg.Free;
    end;
end;

procedure Tform_clientes_000.para_Empezar;
begin
  { ****************************************************************************
    Solo para formularios que traten con datos
    **************************************************************************** }
    if UTI_GEN_Form_Abierto_Ya('DataModule_Clientes') = False then
    begin
        DataModule_Clientes := TDataModule_Clientes.Create(Application);
    end;

  { ****************************************************************************
    Preparamos los diferentes tipos de orden preconfigurados
    **************************************************************************** }
    // CLIENTES
    SetLength(private_Order_By, 4);

    private_Order_By[0].Titulo       := 'Por nombre propietario'; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By[0].Memo_OrderBy := 'cl.nombre_propietario ASC';

    private_Order_By[1].Titulo       := 'Por nombre comercial';
    private_Order_By[1].Memo_OrderBy := 'cl.nombre_comercial ASC';

    private_Order_By[2].Titulo       := 'Por NIF / CIF';
    private_Order_By[2].Memo_OrderBy := 'cl.nif_cif ASC';

    private_Order_By[3].Titulo       := 'Por la id';
    private_Order_By[3].Memo_OrderBy := 'cl.id ASC';

    Memo_OrderBy.Lines.Text          := private_Order_By[0].Memo_OrderBy;

    UTI_TB_Rellenar_ComboBox_Orden( true,
                                    ComboBox_Filtros,
                                    private_Order_By,
                                    0 );
    // CLIENTES_CONTACTOS
    SetLength(private_Order_By_contactos, 1);

    private_Order_By_contactos[0].Titulo       := 'Por nombre'; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By_contactos[0].Memo_OrderBy := 'cc.id_clientes ASC, cc.nombre ASC';

    // CLIENTES_ENVIOS
    SetLength(private_Order_By_envios, 1);

    private_Order_By_envios[0].Titulo       := 'Por dirección'; // El índice 0 siempre será por el que empezará la aplicación y los filtros
    private_Order_By_envios[0].Memo_OrderBy := 'ce.Direccion ASC, ce.Direccion_Numero ASC,' +
                                              ' ce.Direccion_Piso_Letra ASC, ce.Codigo_Postal ASC,' +
                                              ' ce.id_poblaciones ASC, ce.id_provincias ASC,' +
                                              ' ce.id_paises ASC';

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

procedure Tform_clientes_000.BitBtn_ImprimirClick(Sender: TObject);
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

    if Trim(Edit_nombre_propietario.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con a quien facturamos %' +
                            Trim(Edit_nombre_propietario.Text) + '%';
    end;

    if Trim(Edit_Nombre_Comercial.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con nombre comercial %' +
                            Trim(Edit_Nombre_Comercial.Text) + '%';
    end;

    if (not DateTimePicker_Nacido_Hasta.DateIsNull) or
       (not DateTimePicker_Nacido_Desde.DateIsNull) then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', nacidos entre ' +
                            DateToStr(DateTimePicker_Nacido_Desde.Date) +
                            ' y el ' +
                            DateToStr(DateTimePicker_Nacido_Hasta.Date);
    end;

    if Trim(Edit_Descripcion_clientes_tipos.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con tipo de cliente = ' +
                            Trim(Edit_Nombre_Comercial.Text);
    end;

    if Trim(Edit_Descripcion_Forma_Pago.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con forma de pago = ' +
                            Trim(Edit_Descripcion_Forma_Pago.Text);
    end;

    if Trim(Edit_Descripcion_Representante.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con forma de pago = ' +
                            Trim(Edit_Descripcion_Representante.Text);
    end;

    if Trim(Edit_Descripcion_Actividad.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con actividad = ' +
                            Trim(Edit_Descripcion_Actividad.Text);
    end;

    if Trim(Edit_Descripcion_Ruta.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con ruta/zona = ' +
                            Trim(Edit_Descripcion_Ruta.Text);
    end;

    if Trim(Edit_Descripcion_Poblacion.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con población = ' +
                            Trim(Edit_Descripcion_Poblacion.Text);
    end;

    if Trim(Edit_Descripcion_Provincia.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con provincia = ' +
                            Trim(Edit_Descripcion_Provincia.Text);
    end;

    if Trim(Edit_Descripcion_Pais.Text) <> '' then
    begin
        var_Ordenado_por := var_Ordenado_por +
                            ', con país = ' +
                            Trim(Edit_Descripcion_Pais.Text);
    end;

    // ********************************************************************************************* //
    // ** Configuramos la llamada al generador de informes                                        ** //
    // ********************************************************************************************* //
    var_Ficheros := TStringList.Create;

    UTI_GEN_Informes( var_Ordenado_por,
                      SQLQuery_Clientes,
                      DataSource_Clientes,
                      DataSource_Clientes_Contactos,
                      DataSource_Clientes_Envios,
                      Nil,
                      public_Menu_Worked,
                      public_Solo_Ver,
                      '',
                      '',
                      var_Ficheros );

    var_Ficheros.Free;
end;

function Tform_clientes_000.Filtrar_Principal( param_Cambiamos_Filtro : Boolean ) : ShortInt;
var var_Registro_CRUD : TRegistro_CRUD;
    var_ctdad_Rgtros  : Integer;
    var_a_Filtrar     : TStrings;
begin
    var_a_Filtrar := TStringList.Create;
    var_a_Filtrar.Clear;

    var_Registro_CRUD := UTI_DATOS_TABLA_clientes_CRUD(SQLQuery_Clientes);
    var_ctdad_Rgtros  := -1;

    // ********************************************************************************************* //
    // ** AHORA PONDREMOS EL RESTO DE LOS FILTROS QUE NO SON GENERALES                            ** //
    // ********************************************************************************************* //
    // ** Primero buscaremos en a quien facturamos ... nombre_propietario                         ** //
    // ********************************************************************************************* //
    if Trim(Edit_nombre_propietario.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.nombre_propietario LIKE ' +
                                UTI_GEN_Comillas('%' + Trim(Edit_nombre_propietario.Text) + '%')  );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos en el nombre comercial                                                 ** //
    // ********************************************************************************************* //
    if Trim(Edit_Nombre_Comercial.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.nombre_comercial LIKE ' +
                                UTI_GEN_Comillas('%' + Trim(Edit_Nombre_Comercial.Text) + '%')  );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos en el NIF                                                              ** //
    // ********************************************************************************************* //
    if Trim(Edit_NIF.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.nif_cif LIKE ' +
                                UTI_GEN_Comillas('%' + Trim(Edit_NIF.Text) + '%')  );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por la fecha de nacimiento                                             ** //
    // ********************************************************************************************* //
    if (not DateTimePicker_Nacido_Hasta.DateIsNull) and
       (not DateTimePicker_Nacido_Desde.DateIsNull) then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.Fecha_Nacimiento <= ' +
                                UTI_GEN_Comillas( UTI_GEN_Format_Fecha_Hora(DateTimePicker_Nacido_Hasta.Date, false) +
                                                  ' 23:59:59' ) );
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.Fecha_Nacimiento >= ' +
                                UTI_GEN_Comillas( UTI_GEN_Format_Fecha_Hora(DateTimePicker_Nacido_Desde.Date, false) +
                                                  ' 00:00:00' ) );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por EL TIPO DE CLIENTE                                                 ** //
    // ********************************************************************************************* //
    if Trim(Edit_id_clientes_tipos.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.id_clientes_tipos = ' + Trim(Edit_id_clientes_tipos.Text) );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por EL RIESGO SUPERIOR AL AUTORIZADO                                   ** //
    // ********************************************************************************************* //

    // ********************************************************************************************* //
    // ** Ahora buscaremos por la forma de pago                                                   ** //
    // ********************************************************************************************* //
    if Trim(Edit_id_Forma_Pago.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.id_formas_pago = ' + Trim(Edit_id_Forma_Pago.Text) );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por el representante                                                   ** //
    // ********************************************************************************************* //
    if Trim(Edit_id_representantes.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.id_Representantes = ' + Trim(Edit_id_representantes.Text) );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por la actividad                                                       ** //
    // ********************************************************************************************* //
    if Trim(Edit_id_Actividad.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.id_actividades = ' + Trim(Edit_id_Actividad.Text) );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por la ruta                                                            ** //
    // ********************************************************************************************* //
    if Trim(Edit_id_Ruta.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.id_rutas = ' + Trim(Edit_id_Ruta.Text) );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por la población                                                       ** //
    // ********************************************************************************************* //
    if Trim(Edit_id_poblaciones.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.id_poblaciones = ' + Trim(Edit_id_poblaciones.Text) );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por la provincia                                                       ** //
    // ********************************************************************************************* //
    if Trim(Edit_id_provincias.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.id_provincias = ' + Trim(Edit_id_provincias.Text) );
    end;

    // ********************************************************************************************* //
    // ** Ahora buscaremos por el país                                                            ** //
    // ********************************************************************************************* //
    if Trim(Edit_id_paises.Text) <> '' then
    begin
        UTI_RGTRO_Add_to_Where( false,
                                var_a_Filtrar,
                                'cl.id_paises = ' + Trim(Edit_id_paises.Text) );
    end;

    // ********************************************************************************************* //
    // ** Pasamos a filtrar los registros                                                         ** //
    // ********************************************************************************************* //
    Result := UTI_TB_Filtrar( private_Order_By,

                              var_Registro_CRUD.Delete_SQL,
                              var_Registro_CRUD.Update_SQL,
                              var_Registro_CRUD.Insert_SQL,

                              var_ctdad_Rgtros,
                              DataModule_Clientes.SQLTransaction_Clientes,
                              DataModule_Clientes.SQLConnector_Clientes,
                              SQLQuery_Clientes,

                              var_Registro_CRUD.name_tabla,
                              RadioGroup_Bajas.ItemIndex,

                              var_Registro_CRUD.SELECT_SQL,

                              Memo_Filtros.Lines,
                              Memo_OrderBy.Lines,
                              var_a_Filtrar.Text,

                              param_Cambiamos_Filtro );

    var_a_Filtrar.Free;

    Label_Ctdad_Rgtros.Caption := IntToStr(SQLQuery_Clientes.RecordCount);

    if SQLQuery_Clientes.RecordCount = 0 then
    begin
        Cerramos_Tablas_Ligadas;
    end;

    //Filtrar_tablas_ligadas;
end;

procedure Tform_clientes_000.FormActivate(Sender: TObject);
begin
    If public_Elegimos = true then
    begin
        BitBtn_Seleccionar.Visible := True;
        BitBtn_Imprimir.Visible    := False;

        with Self do
        begin
            Color := $00B9959C;
        end;
    end;

    if public_Solo_Ver = true then no_Tocar;
end;

procedure Tform_clientes_000.FormCreate(Sender: TObject);
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

procedure Tform_clientes_000.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    if private_Salir_OK = False then
    begin
            // ************************************************************************************* //
            // ** Intento BitBtn_SALIR de la aplicación de un modo no permitido.                  ** //
            // ************************************************************************************* //
            // Pero si desde el menu principal está a true la variable                            ** //
            // public_Salir_Ok, significa que hay que salir si o si pues se pulsó                 ** //
            // cancelar al preguntar otra vez por la contraseña                                   ** //
            // ************************************************************************************* //
            if form_Menu.public_Salir_OK = False then CloseAction := CloseAction.caNone;
    end else begin
        // ************************************************************************************* //
        // ** Fue correcto el modo como quiere BitBtn_SALIR de la aplicación                  ** //
        // ************************************************************************************* //
    end;
end;

procedure Tform_clientes_000.FormDestroy(Sender: TObject);
begin
    Cerramos_Tablas;
end;

procedure Tform_clientes_000.Cerramos_Tablas;
begin
    Cerramos_Tablas_Ligadas;

    if UTI_TB_Cerrar( DataModule_Clientes.SQLConnector_Clientes,
                      DataModule_Clientes.SQLTransaction_Clientes,
                      SQLQuery_Clientes ) = false then UTI_GEN_Salir;

    DataModule_Clientes.Free;
end;

procedure Tform_clientes_000.Cerramos_Tablas_Ligadas;
begin
    if UTI_TB_Cerrar( DataModule_Clientes.SQLConnector_Clientes_Contactos,
                      DataModule_Clientes.SQLTransaction_Clientes_Contactos,
                      SQLQuery_Clientes_Contactos ) = false then UTI_GEN_Salir;

    if UTI_TB_Cerrar( DataModule_Clientes.SQLConnector_Clientes_Envios,
                      DataModule_Clientes.SQLTransaction_Clientes_Envios,
                      SQLQuery_Clientes_Envios ) = false then UTI_GEN_Salir;
end;

procedure Tform_clientes_000.SQLQuery_ClientesCalcFields(DataSet: TDataSet);
begin
    with SQLQuery_Clientes do
    begin
        // TELEFONOS
        FieldByName('OT_todos_los_Tfnos').AsString := '';

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
    end;
end;

procedure Tform_clientes_000.SQLQuery_Clientes_EnviosCalcFields(DataSet: TDataSet);
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

procedure Tform_clientes_000.SQLQuery_Clientes_ContactosCalcFields(DataSet: TDataSet);
begin
    with SQLQuery_Clientes_Contactos do
    begin
        // TELEFONOS
        FieldByName('OT_todos_los_Tfnos').AsString := '';

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
    end;
end;

procedure Tform_clientes_000.Refrescar_Registros_Contactos;
var var_Lineas_Filtro  : TStrings;
    var_Lineas_OrderBy : TStrings;

    var_nombre         : String;
    var_ver_Bajas      : ShortInt;
begin
    // ********************************************************************************************* //
    // ** Solo si la cabecera está en modo EDIT se abren las tablas hijas                         ** //
    // ********************************************************************************************* //
    if SQLQuery_Clientes.State <> dsEdit then Exit;

    // ********************************************************************************************* //
    // ** OJITO ... NO USAR CAMPOS AUTOINCREMENTABLES                                             ** //
    // ********************************************************************************************* //
    var_nombre := '';

    if SQLQuery_Clientes_Contactos.RecordCount > 0 then
    begin
        var_nombre := SQLQuery_Clientes_Contactos.FieldByName('nombre').Value;
    end;

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    var_Lineas_Filtro.Clear;
    var_Lineas_OrderBy.Clear;

    if Trim(SQLQuery_Clientes.FieldByName('id').AsString) <> '' then
         var_Lineas_Filtro.Add('id_clientes = ' + Trim(SQLQuery_Clientes.FieldByName('id').AsString))
    else var_Lineas_Filtro.Add('id_clientes = Null');

    var_ver_Bajas := RadioGroup_Bajas.ItemIndex;
    if UTI_GEN_Form_Abierto_Ya('form_clientes_001') = true then
    begin
        var_ver_Bajas := form_clientes_001.RadioGroup_Bajas.ItemIndex;
    end;

    Filtrar_clientes_contactos( var_ver_Bajas,
                                false,
                                var_Lineas_Filtro,
                                var_Lineas_OrderBy );

    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;

    if Trim(var_nombre) <> '' then
    begin
         SQLQuery_Clientes_Contactos.Locate( 'nombre',
                                             var_nombre,
                                             [] );
    end;
end;

procedure Tform_clientes_000.Refrescar_Registros_Envios;
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
    // ** Solo si la cabecera está en modo EDIT se abren las tablas hijas                         ** //
    // ********************************************************************************************* //
    if SQLQuery_Clientes.State <> dsEdit then Exit;

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

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    var_Lineas_Filtro.Clear;
    var_Lineas_OrderBy.Clear;

    if Trim(SQLQuery_Clientes.FieldByName('id').AsString) <> '' then
         var_Lineas_Filtro.Add('ce.id_clientes = ' + Trim(SQLQuery_Clientes.FieldByName('id').AsString))
    else var_Lineas_Filtro.Add('ce.id_clientes = Null');

    var_ver_Bajas := RadioGroup_Bajas.ItemIndex;
    if UTI_GEN_Form_Abierto_Ya('form_clientes_001') = true then
    begin
        var_ver_Bajas := form_clientes_001.RadioGroup_Bajas.ItemIndex;
    end;

    Filtrar_clientes_envios( var_ver_Bajas,
                             false,
                             var_Lineas_Filtro,
                             var_Lineas_OrderBy );

    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;

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

procedure Tform_clientes_000.SQLQuery_Clientes_ContactosAfterPost(DataSet: TDataSet);
begin
    UTI_RGTRO_Grabar( 'clientes_contactos', DataModule_Clientes.SQLTransaction_Clientes_Contactos, SQLQuery_Clientes_Contactos );
    Refrescar_Registros_Contactos;
end;

procedure Tform_clientes_000.SQLQuery_Clientes_EnviosAfterPost(DataSet: TDataSet);
begin
    UTI_RGTRO_Grabar( 'clientes_envios', DataModule_Clientes.SQLTransaction_Clientes_Envios, SQLQuery_Clientes_Envios );
    Refrescar_Registros_Envios;
end;

procedure Tform_clientes_000.SQLQuery_ClientesAfterPost(DataSet: TDataSet);
begin
    UTI_RGTRO_Grabar( 'clientes', DataModule_Clientes.SQLTransaction_Clientes, SQLQuery_Clientes );
    Refrescar_Registros;
end;

procedure Tform_clientes_000.SQLQuery_Clientes_ContactosBeforePost(DataSet: TDataSet);
begin
    UTI_RGTRO_param_assign_value( SQLQuery_Clientes_Contactos );
end;

procedure Tform_clientes_000.SQLQuery_Clientes_EnviosBeforePost(DataSet: TDataSet);
begin
    UTI_RGTRO_param_assign_value( SQLQuery_Clientes_Envios );
end;

procedure Tform_clientes_000.SQLQuery_ClientesBeforePost(DataSet: TDataSet);
begin
    UTI_RGTRO_param_assign_value( SQLQuery_Clientes );
end;

procedure Tform_clientes_000.SQLQuery_ClientesAfterScroll(DataSet: TDataSet);
begin
    Filtrar_tablas_ligadas;
end;

procedure Tform_clientes_000.DBGrid_PrincipalDblClick(Sender: TObject);
begin
    If public_Elegimos then
         Seleccionado_Rgtro
    else Editar_Registro;
end;

procedure Tform_clientes_000.DBGrid_PrincipalDrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    UTI_GEN_Dibujar_Grid( Sender, SQLQuery_Clientes, Rect, DataCol, Column, State );
end;

procedure Tform_clientes_000.DBGrid_PrincipalKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if Key = 13 then
    begin
        If public_Elegimos then
             Seleccionado_Rgtro
        else Editar_Registro;
    end;
end;

procedure Tform_clientes_000.DBGrid_PrincipalKeyUp(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if (key = 40) or (key = 38) then
    begin
         //Filtrar_tablas_ligadas;
    end;
end;

procedure Tform_clientes_000.DBGrid_PrincipalCellClick(Column: TColumn);
begin
    //Filtrar_tablas_ligadas;
end;

procedure Tform_clientes_000.BitBtn_SALIRClick(Sender: TObject);
begin
    private_Salir_OK := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}

    Close;
end;

procedure Tform_clientes_000.BitBtn_SeleccionarClick(Sender: TObject);
begin
    Seleccionado_Rgtro;
end;

procedure Tform_clientes_000.Seleccionado_Rgtro;
begin
    private_Salir_OK          := true;  { La pongo a true para controlar el modo de BitBtn_SALIR del programa}
    public_Rgtro_Seleccionado := true;
    Close;
end;

procedure Tform_clientes_000.DBNavigator1BeforeAction(Sender: TObject; Button: TDBNavButtonType);
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
                UTI_RGTRO_Borrar( 'clientes',
                                  SQLQuery_Clientes,
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

procedure Tform_clientes_000.no_Tocar;
begin
    BitBtn_Imprimir.Enabled := False;
end;

procedure Tform_clientes_000.Presentar_Datos;
begin
     /// guardar por lo que pueda pasar
end;

procedure Tform_clientes_000.BitBtn_Ver_Situacion_RegistroClick(Sender: TObject);
begin
    if UTI_USR_Permiso_SN(public_Menu_Worked, '', True) = True then
    begin
        if SQLQuery_Clientes.RecordCount > 0 then
        begin
            UTI_RGTRO_Ver_Estado_Registro( 'clientes',
                                           SQLQuery_Clientes,
                                           DataSource_Clientes,
                                           DBGrid_Principal );
        end;
    end;
end;

procedure Tform_clientes_000.Filtrar_tablas_ligadas;
var var_Lineas_Filtro  : TStrings;
    var_Lineas_OrderBy : TStrings;
begin
    if SQLQuery_Clientes.RecordCount = 0 then Exit;

    if SQLQuery_Clientes.State = dsInsert then
    begin
        Cerramos_Tablas_Ligadas;
        Exit;
    end;

    var_Lineas_Filtro  := TStringList.Create;
    var_Lineas_OrderBy := TStringList.Create;

    // ********************************************************************************************* //
    // ** CLIENTES_CONTACTOS                                                                      ** //
    // ********************************************************************************************* //
    UTI_RGTRO_Add_to_Where( true,
                            var_Lineas_Filtro,
                            'cc.id_clientes = ' + SQLQuery_Clientes.FieldByName('id').AsString );

    var_Lineas_OrderBy.Clear;
    Filtrar_clientes_contactos( RadioGroup_Bajas.ItemIndex,
                                false,
                                var_Lineas_Filtro,
                                var_Lineas_OrderBy );


    // ********************************************************************************************* //
    // ** CLIENTES_ENVIOS                                                                         ** //
    // ********************************************************************************************* //
    UTI_RGTRO_Add_to_Where( true,
                            var_Lineas_Filtro,
                            'ce.id_clientes = ' + SQLQuery_Clientes.FieldByName('id').AsString );

    var_Lineas_OrderBy.Clear;
    Filtrar_clientes_envios( RadioGroup_Bajas.ItemIndex,
                             false,
                             var_Lineas_Filtro,
                             var_Lineas_OrderBy );

    // ********************************************************************************************* //
    // ** BORRAMOS DE MEMORIA EL RESTO DE COSAS A NO UTILIZAR YA                                  ** //
    // ********************************************************************************************* //
    var_Lineas_Filtro.Free;
    var_Lineas_OrderBy.Free;
end;

function Tform_clientes_000.Filtrar_clientes_contactos( param_ver_bajas : ShortInt;
                                                        param_Cambiamos_Filtro : Boolean;
                                                        param_Lineas_Filtro,
                                                        param_Lineas_OrderBy : TStrings ) : ShortInt;
var var_Registro_CRUD : TRegistro_CRUD;
    var_ctdad_Rgtros  : Integer;
begin
    var_Registro_CRUD := UTI_DATOS_TABLA_clientes_contactos_CRUD(SQLQuery_Clientes_Contactos);
    var_ctdad_Rgtros  := -1;

    if Trim(param_Lineas_OrderBy.Text) = '' then
    begin
         param_Lineas_OrderBy.Text := private_Order_By_contactos[0].Memo_OrderBy;
    end;

    Result := UTI_TB_Filtrar( private_Order_By_contactos,

                              var_Registro_CRUD.Delete_SQL,
                              var_Registro_CRUD.Update_SQL,
                              var_Registro_CRUD.Insert_SQL,

                              var_ctdad_Rgtros,
                              DataModule_Clientes.SQLTransaction_Clientes_Contactos,
                              DataModule_Clientes.SQLConnector_Clientes_Contactos,
                              SQLQuery_Clientes_Contactos,

                              var_Registro_CRUD.name_tabla,
                              param_ver_bajas,

                              var_Registro_CRUD.SELECT_SQL,

                              param_Lineas_Filtro,
                              param_Lineas_OrderBy,
                              '',

                              param_Cambiamos_Filtro );
end;

function Tform_clientes_000.Filtrar_clientes_envios( param_ver_bajas : ShortInt;
                                                     param_Cambiamos_Filtro : Boolean;
                                                     param_Lineas_Filtro,
                                                     param_Lineas_OrderBy : TStrings ) : ShortInt;
var var_Registro_CRUD : TRegistro_CRUD;
    var_ctdad_Rgtros  : Integer;
begin
    var_Registro_CRUD := UTI_DATOS_TABLA_clientes_envios_CRUD(SQLQuery_Clientes_Envios);
    var_ctdad_Rgtros  := -1;

    if Trim(param_Lineas_OrderBy.Text) = '' then
    begin
         param_Lineas_OrderBy.Text := private_Order_By_envios[0].Memo_OrderBy;
    end;

    Result := UTI_TB_Filtrar( private_Order_By_envios,

                              var_Registro_CRUD.Delete_SQL,
                              var_Registro_CRUD.Update_SQL,
                              var_Registro_CRUD.Insert_SQL,

                              var_ctdad_Rgtros,
                              DataModule_Clientes.SQLTransaction_Clientes_Envios,
                              DataModule_Clientes.SQLConnector_Clientes_Envios,
                              SQLQuery_Clientes_Envios,

                              var_Registro_CRUD.name_tabla,
                              param_ver_bajas,

                              var_Registro_CRUD.SELECT_SQL,

                              param_Lineas_Filtro,
                              param_Lineas_OrderBy,
                              '',

                              param_Cambiamos_Filtro );
end;

procedure Tform_clientes_000.SQLQuery_ClientesBeforeEdit(DataSet: TDataSet);
begin
    UTI_RGTRO_param_assign_value_Edit( SQLQuery_Clientes );
end;

procedure Tform_clientes_000.SQLQuery_Clientes_ContactosBeforeEdit(DataSet: TDataSet);
begin
    UTI_RGTRO_param_assign_value_Edit( SQLQuery_Clientes_Contactos );
end;

procedure Tform_clientes_000.SQLQuery_Clientes_EnviosBeforeEdit(DataSet: TDataSet);
begin
    UTI_RGTRO_param_assign_value_Edit( SQLQuery_Clientes_Envios );
end;

procedure Tform_clientes_000.Filtrar_Principal_Sin_Preguntar;
begin
    RadioGroup_Bajas.ItemIndex := Filtrar_Principal( false );
end;

procedure Tform_clientes_000.BitBtn_FiltrarClick(Sender: TObject);
begin
    if PageControl_Filtros.ActivePage = TabSheet_Busqueda_Concreta then
    begin
        Filtrar_Principal_Sin_Preguntar;
    end else begin
        RadioGroup_Bajas.ItemIndex := Filtrar_Principal( true );
    end;
end;

procedure Tform_clientes_000.RadioGroup_BajasClick(Sender: TObject);
begin
    Refrescar_Registros;
end;

procedure Tform_clientes_000.Editar_Registro;
var var_msg              : TStrings;
    var_id               : ShortString;
begin
    with SQLQuery_Clientes do
    begin
        var_msg := TStringList.Create;

        if RecordCount > 0 then
        begin
            var_id := FieldByName('id').AsString;

            if UTI_USR_Permiso_SN(public_Menu_Worked, 'M', True) = True then
            begin
                if UTI_RGTRO_isLock( 'clientes',
                                     var_id,
                                     true ) = true then
                begin
                    Exit;
                end else begin
                    if UTI_RGTRO_Lock( 'clientes',
                                       var_id ) = true then
                         Edit
                    else Exit;
                end;

                Application.CreateForm(Tform_clientes_001, form_clientes_001);

                form_clientes_001.RadioGroup_Bajas.ItemIndex := RadioGroup_Bajas.ItemIndex;
                form_clientes_001.public_Menu_Worked         := public_Menu_Worked;

                if public_Solo_Ver = true then
                begin
                    form_clientes_001.public_Solo_Ver := true;
                end;

                form_clientes_001.para_Empezar;

                form_clientes_001.ShowModal;

                if form_clientes_001.public_Pulso_Aceptar = true then
                begin
                    if UTI_DATOS_TABLA_SeCambioAlgoEnRgtro( SQLQuery_Clientes ) = true then
                    begin
                        FieldByName('Change_WHEN').Value    := UTI_CN_Fecha_Hora;
                        FieldByName('Change_Id_User').Value := Form_Menu.public_User;

                        UTI_RGTRO_Grabar_Antes( 'clientes',
                                                SQLQuery_Clientes );
                    end else begin
                        Cancel;
                    end;

                    form_clientes_001.Free;
                end else begin
                    form_clientes_001.Free;
                    Cancel;
                end;

                UTI_RGTRO_UnLock( 'clientes',
                                  var_id );
            end;
        end else begin
            var_msg.Add(rs_no_Hay_Rgtros);
            UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
        end;
    end;

    var_msg.Free;
end;

procedure Tform_clientes_000.ComboBox_FiltrosChange(Sender: TObject);
begin
    Memo_OrderBy.Lines.Clear;
    Memo_OrderBy.Lines.Add( private_Order_By[ComboBox_Filtros.ItemIndex].Memo_OrderBy );
    BitBtn_FiltrarClick(Nil);
end;

procedure Tform_clientes_000.Refrescar_Registros;
var var_nombre_propietario          : String;
    var_Direccion                   : String;
    var_id_poblaciones              : Int64;
    var_id_provincias               : Int64;
    var_id_paises                   : Int64;
    var_IVA_con_Recargo_SN          : ShortString;
    var_IVA_Excluido_SN             : ShortString;
    var_Vencimientos_automaticos_SN : ShortString;
    var_Agrupar_Albaranes_SN        : ShortString;
    var_Activar_Proximidad_SN       : ShortString;
    var_Portes_Pagados_SN           : ShortString;
begin
    with SQLQuery_Clientes do
    begin
        // ********************************************************************************************* //
        // ** OJITO ... NO USAR CAMPOS AUTOINCREMENTABLES                                             ** //
        // ********************************************************************************************* //
        var_nombre_propietario := '';

        if RecordCount > 0 then
        begin
            var_nombre_propietario          := FieldByName('nombre_propietario').AsString;
            var_Direccion                   := FieldByName('Direccion').AsString;
            var_id_poblaciones              := FieldByName('id_poblaciones').Value;
            var_id_provincias               := FieldByName('id_provincias').Value;
            var_id_paises                   := FieldByName('id_paises').Value;

            var_IVA_con_Recargo_SN          := FieldByName('IVA_con_Recargo_SN').AsString;
            var_IVA_Excluido_SN             := FieldByName('IVA_Excluido_SN').AsString;
            var_Vencimientos_automaticos_SN := FieldByName('Vencimientos_automaticos_SN').AsString;
            var_Agrupar_Albaranes_SN        := FieldByName('Agrupar_Albaranes_SN').AsString;
            var_Activar_Proximidad_SN       := FieldByName('Activar_Proximidad_SN').AsString;
            var_Portes_Pagados_SN           := FieldByName('Portes_Pagados_SN').AsString;
        end;

        Filtrar_Principal_Sin_Preguntar;

        if Trim(var_nombre_propietario) <> '' then
        begin
             Locate( 'nombre_propietario;Direccion;id_poblaciones;id_provincias;id_paises;' +
                     'IVA_con_Recargo_SN;IVA_Excluido_SN;' +
                     'Vencimientos_automaticos_SN;Agrupar_Albaranes_SN;' +
                     'Activar_Proximidad_SN;Portes_Pagados_SN',

                     VarArrayOf( [ var_nombre_propietario, var_Direccion, var_id_poblaciones,
                                   var_id_provincias, var_id_paises,
                                   var_IVA_con_Recargo_SN, var_IVA_Excluido_SN,
                                   var_Vencimientos_automaticos_SN, var_Agrupar_Albaranes_SN,
                                   var_Activar_Proximidad_SN, var_Portes_Pagados_SN ] ),

                     [] );
        end;
    end;
end;

end.


