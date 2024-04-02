prompt --application/pages/page_00032
begin
--   Manifest
--     PAGE: 00032
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_flow_imp_page.create_page(
 p_id=>32
,p_name=>'Schichtplanung Archiv'
,p_alias=>'SCHICHTPLANUNG-ARCHIV'
,p_step_title=>'Schichtplanung Archiv'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('// Funktion zum farblichen Formatieren der Zeilen und validieren der anzahle gew\00E4hlter Schichten'),
'function faerbe_zellen_ein_matrix() {',
'  const matrix = $(''#cr_sp_matrix'').last();',
'  const trElements = matrix.find(''tr'');',
'',
'  trElements.each(function(n) {',
'    let count6 = 0;',
'    let count7 = 0;',
'    let count9 = 0;',
'    let count14 = 0;',
'    let count22 = 0;',
'    let count12 = 0;',
'',
'    const tdElements = $($(trElements)[n]).find(''td'');',
'    tdElements.each(function(i) {',
'      const currElement = $($(tdElements)[i]);',
'      const currInputElement = $($($(tdElements)[i]).find(''input''));',
'      const value = currInputElement.val();',
'  ',
unistr('    // z\00E4hlen Anzahl Schicht'),
'    switch(value){',
'        case ''ab6'': count6 = count6 + 1;',
'        break',
'        case ''ab7'': count7 = count7 + 1;',
'        break',
'        case ''ab9'': count9 = count9 + 1;',
'        break',
'        case ''ab14'': count14 = count14 + 1;',
'        break',
'        case ''ab22'': count22 = count22 + 1;',
'        break',
'        case ''12ab10'': count12 = count12 + 1;',
'        break',
'        case ''12ab22'': count12 = count12 + 1;',
'        break',
'    }',
'',
unistr('    // Setzen gez\00E4hlte Eintr\00E4ge'),
'    switch(currElement.attr(''headers'')){',
'        case ''6'': currElement.text(count6);',
'        break',
'        case ''7'': currElement.text(count7);',
'        break',
'        case ''9'': currElement.text(count9);',
'        break',
'        case ''14'': currElement.text(count14);',
'        break',
'        case ''22'': currElement.text(count22);',
'        break',
'        case ''12'': currElement.text(count12);',
'        break',
'        case ''KOMMENTAR'':',
'        const inputField = createInputField(); // Erstellen des leeren Input-Felds',
unistr('          currElement.empty().append(inputField); // Hinzuf\00FCgen des Input-Felds zur Zelle'),
'        break;',
'    }',
'',
'     // input Felder deaktivieren',
'    currInputElement.attr(''disabled'', true);',
'     ',
'    ',
'    // Wochenende und Feiertage anders darstellen',
'    if (currElement.attr(''headers'') === ''DATUM'') {',
'        const dateString = currElement.text();',
'        const dateParts = dateString.split(''.'');',
'        const year = Number(dateParts[2]);',
'        const month = Number(dateParts[1]);',
'        const day = Number(dateParts[0]);',
'        const currDate = new Date(year, month, day);',
'        const currDay = currDate.getDay();',
'        const parmObj = {',
'            x08: dateString',
'        };',
'        if (currDay === 3 || currDay === 2) {',
'            currElement.css("background-color", "#a6a6a6");',
'        }',
'        apex.server.process(''get_Feiertag'', parmObj, {',
'          success: function(data) {',
'            if (data.success) {',
'                currElement.css("background-color", "red");',
'                const combinedText = dateString + '' - '' + data.feiertag_bezeichnung + '' ('' + data.land + '')'';',
'                currElement.text(combinedText);',
'            }',
'          },',
'          error: function(data) {',
'            apex.message.alert(data.err);',
'          }',
'        });',
'    }',
'    ',
'    // Datum Feld exkludieren',
'    if (currElement.attr(''headers'') !== ''DATUM'') { ',
'        // Input Felder Formatieren Liste bei Bedarf erweitern',
'        switch( currInputElement.val() ){',
'            case '''':    currElement.css("background-color", "#f9f9f9");',
'                        currInputElement.css("background-color", "#f9f9f9");',
'                        currInputElement.css("border-style", "none");',
'                break;',
'            case ''ab6'':  currElement.css("background-color", "#ffff00");',
'                         currInputElement.css("background-color", "#ffff00");',
'                         currInputElement.css("border-style", "none");',
'                break;',
'            case ''ab7'':  currElement.css("background-color", "#c6efce");',
'                         currInputElement.css("background-color", "#c6efce");',
'                         currInputElement.css("border-style", "none");',
'                break;',
'            case ''ab9'':  currElement.css("background-color", "#fcd5b4");',
'                         currInputElement.css("background-color", "#fcd5b4");',
'                         currInputElement.css("border-style", "none");',
'                break;',
'            case ''ab14'':  currElement.css("background-color", "#da9694"); ',
'                          currInputElement.css("background-color", "#da9694");',
'                          currInputElement.css("border-style", "none");',
'                break;',
'            case ''ab22'':  currElement.css("background-color", "#a6a6a6");',
'                          currInputElement.css("background-color", "#a6a6a6");',
'                          currInputElement.css("border-style", "none");',
'                break;',
'            case ''12ab10'':  currElement.css("background-color", "#ffc000");',
'                       currInputElement.css("background-color", "#ffc000");',
'                       currInputElement.css("border-style", "none");',
'                break;',
'            case ''12ab22'':  currElement.css("background-color", "#c0504d");',
'                       currInputElement.css("background-color", "#c0504d");',
'                       currInputElement.css("border-style", "none");',
'                break;    ',
'            case ''krank'':  currElement.css("background-color", "#c5d798");',
'                           currInputElement.css("background-color", "#c5d798");',
'                           currInputElement.css("border-style", "none");',
'                break;',
'            case ''urlaub'':  currElement.css("background-color", "#98d046");',
'                            currInputElement.css("background-color", "#98d046");',
'                            currInputElement.css("border-style", "none");   ',
'                break;',
'            case ''schulung'':  currElement.css("background-color", "#3db1f3");',
'                              currInputElement.css("background-color", "#3db1f3");',
'                              currInputElement.css("border-style", "none");',
'                break;',
'            case ''urlaub'':  currElement.css("background-color", "blue");',
'                            currInputElement.css("background-color", "blue");',
'                            currInputElement.css("border-style", "none");',
'                break;',
'            case ''x'':  currElement.css("background-color", "#c7d9f2");',
'                       currInputElement.css("background-color", "#c7d9f2");',
'                       currInputElement.css("border-style", "none");',
'                break;',
'            case ''xweurl'':  currElement.css("background-color", "blue");',
'                            currInputElement.css("background-color", "#blue");',
'                            currInputElement.css("border-style", "none");',
'            break;',
'            default  : currElement.css("background-color", "#f9f9f9");',
'                       currInputElement.css("background-color", "#f9f9f9");',
'                       currInputElement.css("border-style", "none");  ',
'        }',
'    }   ',
'',
'    ',
unistr('        // Farben validierung count Schichten 0 = rot 1 = orange 2,3 = gr\00FCn'),
'        switch(currElement.text()){',
'            case ''0'':    currElement.css("background-color", "#e63e31");',
'                break;',
'            case ''1'':    currElement.css("background-color", "#ffaa00");',
'                break;',
'            case ''2'':    currElement.css("background-color", "#6e9d3c");',
'                break;',
'            case ''3'':    currElement.css("background-color", "#6e9d3c");',
'                break;',
'            case ''4'':    currElement.css("background-color", "#6e9d3c");',
'                break;',
'            case ''5'':    currElement.css("background-color", "#6e9d3c");',
'                break;',
'        }   ',
'    });',
'});    ',
'addValuesComments();   ',
'}',
'',
'function saveMatrix() {',
'  const $matrix = $(''#cr_sp_matrix'').last();',
'  const numRequests = $matrix.find(''tr'').length;',
'  let numResponses = 0;',
'',
'  $matrix.find(''tr'').each(function(n) {',
'    const $row = $(this);',
'    $row.find(''td'').each(function(i) {',
'      const $input = $($row.find(''td'')[i]).find(''input'');',
'      const id = $input.attr(''id'');',
'      if (id && ![''6'', ''7'', ''9'', ''14'', ''22'', ''12''].includes($input.val())) {',
'        const [datum, mitarbeiter_id] = id.split('':'');',
'        const parmObj = {',
'          x01: datum,',
'          x02: mitarbeiter_id,',
'          x03: $input.val()',
'        };',
'        if ($input.val() !== '''') {',
'          apex.server.process(''saveMatrix'', parmObj, {',
'          refreshObject: ''#cr_sp_matrix'',',
'          success: function(data) {',
'            console.log(data);',
'            numResponses++;',
'            if (data.success) {',
'              if (numResponses === numRequests) {',
'                apex.message.alert(''Speichern erfolgreich!'');',
'                return;',
'              }',
'            } ',
'            if (!data.success) {',
'              const errorMsg = `Fehler beim Speichern Mitarbeiter: ${data.mitarbeiter_id} und Schicht: ${data.vorgabe_code_id}`;',
'              apex.message.alert(errorMsg);',
'              return;',
'            } ',
'          },',
'          error: function(data) {',
'            console.log(data);',
'            apex.message.alert(data.x01);',
'            return;',
'          }',
'        });',
'        }',
'      }',
'    });',
'  });',
'}',
'',
'function get_values_copied_row() {',
'  const $table = $(''#report_table_cr_sp_matrix tbody tr:last-child'');',
'  const datum = $table.find(''td:first'').text().trim(); // Get the value of the first cell in the copied row',
'  $table.find(''td:not(:first-child)'').each(function(i) { // Exclude the first cell from being set',
'    const $cell = $(this);',
'      const mitarbeiter_id = $cell.attr(''headers'');',
'      const parmObj = {',
'        x01: datum,',
'        x02: mitarbeiter_id',
'      };',
'      apex.server.process(''get_monat_ma_sum_h'', parmObj, {',
'        refreshObject: ''#report_table_cr_sp_matrix'',',
'        success: function(data) {',
'            if (data.success) {',
'             $cell.text(data.sum);',
'             einfaerben_copied_row();',
'             return;',
'            } ',
'            if (!data.success) {',
'              $cell.text(0);',
'              einfaerben_copied_row();',
'              return;',
'            } ',
'          },',
'          error: function(data) {',
'            console.log(data);',
'            apex.message.alert(data.err);',
'            return;',
'          }',
'      });',
'  });',
'}',
'',
'function einfaerben_copied_row() {',
'  const matrix = $(''#report_table_cr_sp_matrix tbody tr:last-child'');',
'  const datum = matrix.find(''td:first'').text().trim();',
'  const trElements = matrix.find(''td:not(:first-child)'');',
'  trElements.each(function(i) {',
'    const currElement = $(this);',
'    const value = currElement.text();',
'    const id = currElement.attr(''headers'');',
'    if (id !== undefined && currElement) {',
'      const mitarbeiter_id = id;',
'      const parmObj = {',
'        x03: datum,',
'        x04: mitarbeiter_id',
'      };',
'      apex.server.process(''get_limit_h_mitarbeiter'', parmObj, {',
'        refreshObject: ''#report_table_cr_sp_matrix'',',
'        success: function(data) { ',
'          const limit_h = (data.success ? data.limit_h : 0);',
'          if (value <= limit_h) {',
'            currElement.css("background-color", "#94d778");',
'          } else {',
'            currElement.css("background-color", "#e63e31");',
'          }',
'        },',
'        error: function(data) {',
'',
'        }',
'      });',
'    }',
'  });',
'}',
'',
'function save_monat_sum_h() {',
'  const $table = $(''#cr_monat_sum_h'').last();',
'  $table.find(''tr'').each(function(n) {',
'    const $row = $(this);',
'    $row.find(''td'').each(function(i) {',
'      const $input = $($row.find(''td'')[i]).find(''input'');',
'      if ($input.length) {',
'        const [datum, mitarbeiter_id] = $input.attr(''id'').split('':'');',
'        const parmObj = {',
'          x01: datum,',
'          x02: mitarbeiter_id',
'        };',
'        apex.server.process(''get_monat_ma_sum_h'', parmObj, {',
'          refreshObject: ''#cr_monat_sum_h'',',
'          success: function(data) {',
'            $input.val(data.success ? data.sum : 0);',
'            einfaerben_monat_sum_h();',
'          },',
'          error: function(data) {',
'            $input.val(0);',
'            einfaerben_monat_sum_h();',
'          }',
'        });',
'      }',
'    });',
'  });',
'}',
'',
'function einfaerben_monat_sum_h() {',
'  const matrix = $(''#cr_monat_sum_h'').last();',
'  const trElements = matrix.find(''tr'');',
'  trElements.each(function(n) {',
'    const tdElements = $($(trElements)[n]).find(''td'');',
'    tdElements.each(function(i) {',
'        const currElement = $($(tdElements)[i]);',
'        const currInputElement = $($($(tdElements)[i]).find(''input''));',
'        const value = currInputElement.val();',
'        const id = currInputElement.attr(''id'');',
'        if (id != undefined){',
'            const [datum, mitarbeiter_id] = id.split('':'');',
'        const parmObj = {',
'          x01: datum,',
'          x02: mitarbeiter_id',
'        };',
'         apex.server.process(''get_limit_h_mitarbeiter'', parmObj, {',
'          refreshObject: ''#cr_monat_sum_h'',',
'          success: function(data) {',
'            const limit_h = (data.success ? data.limit_h : 0);',
'            if (id != undefined) {',
'            if (value <= limit_h){',
'            currElement.css("background-color", "#94d778");',
'            currInputElement.css("background-color", "#94d778");',
'            currInputElement.css("border-style", "none");',
'            }',
'            else {',
'            currElement.css("background-color", "#e63e31");',
'            currInputElement.css("background-color", "#e63e31");',
'            currInputElement.css("border-style", "none");',
'            }',
'            }',
'          },',
'          error: function(data) {',
'            console.log(data.err)',
'          }',
'        });',
'        } ',
'    });',
'  });       ',
'}',
'',
'function navigate(event) {',
'  const focusedElement = $(event.target);',
'  const parentRow = focusedElement.closest("tr");',
'  const parentTable = parentRow.closest("table");',
'  const rowCount = parentTable.find("tr").length;',
'  const colCount = parentRow.find("td").length;',
'',
'  let currentRowIndex = parentRow.index();',
'  let currentColIndex = parentRow.find("td").index(focusedElement.closest("td"));',
'',
'  switch (event.keyCode) {',
'    case 37: // Left arrow',
'      currentColIndex--;',
'      break;',
'    case 38: // Up arrow',
'      currentRowIndex++;',
'      break;',
'    case 39: // Right arrow',
'      currentColIndex++;',
'      break;',
'    case 40: // Down arrow',
'      currentRowIndex++;',
'      break;',
'    default:',
'      return;',
'  }',
'',
'  currentRowIndex += (event.keyCode === 38 ? -1 : 1);',
'',
'if (currentRowIndex < 0) {',
'  currentRowIndex = 0;',
'} else if (currentRowIndex >= rowCount) {',
'  currentRowIndex = rowCount - 1;',
'}',
'',
'if (currentColIndex < 0) {',
'  currentColIndex = colCount - 1;',
'  currentRowIndex--;',
'} else if (currentColIndex >= colCount) {',
'  currentColIndex = 0;',
'  currentRowIndex++;',
'}',
'',
'if (currentRowIndex < 0) {',
'  currentRowIndex = 0;',
'} else if (currentRowIndex >= rowCount) {',
'  currentRowIndex = rowCount - 1;',
'}',
'',
'const targetElement = parentTable',
'  .find("tr")',
'  .eq(currentRowIndex)',
'  .find("td")',
'  .eq(currentColIndex)',
'  .find("input");',
'',
'targetElement.focus();',
'}',
'',
'function addValuesComments() {',
'  const commentInputs = $(''input[headers="KOMMENTAR"]'');',
'  commentInputs.each(function() {',
'    const inputField = $(this);',
'    const currElement = inputField.closest(''td'');',
'    const datum = currElement.closest(''tr'').find(''td:first'').text().trim();',
'    const inputId = datum + '':Kommentar'';',
'    inputField.attr(''id'', inputId);',
'     // disable input felder kommentar',
'    inputField.attr(''disabled'', true);',
'    currElement.css("background-color", "#79cbff");',
'    inputField.css("background-color", "#79cbff");',
'    inputField.css("border-style", "none");',
'    const parmObj = {',
'      x05: datum',
'    };',
'',
'    apex.server.process(''getComments'', parmObj, {',
'      success: function(data) {',
'          console.log(data);',
'        inputField.val(data.comments);',
unistr('        //einfaerben_copied_row(); // Aktualisieren der Hintergrundfarben nach dem Hinzuf\00FCgen der Werte'),
'      },',
'      error: function(data) {',
'        inputField.val(''-'');',
unistr('        //einfaerben_copied_row(); // Aktualisieren der Hintergrundfarben nach dem Hinzuf\00FCgen der Werte'),
'      }',
'    });',
'  });',
'}',
'',
'function formatDate(date) {',
'  const parts = date.split(''-'');',
'  const day = parts[2].substring(0, parts[2].indexOf(''T''));',
'  const month = parts[1];',
'  const year = parts[0];',
'  return `${day}.${month}.${year}`;',
'}',
'',
'function createInputField() {',
'  const inputField = document.createElement(''input'');',
'  inputField.setAttribute(''type'', ''text'');',
'  inputField.setAttribute(''headers'', ''KOMMENTAR'');',
'  inputField.setAttribute(''name'', ''f01'');',
'  inputField.setAttribute(''size'', ''20'');',
'  inputField.setAttribute(''value'', '''');',
'',
'  return inputField;',
'}',
'',
'function copyLastRowToMatrix() {',
'  // Get the last row of the ''cr_monat_sum_h'' classic report',
'  const $lastRow = $(''#report_table_cr_monat_sum_h tbody tr:last-child'');',
'',
'  // Clone the last row and remove the ID and input fields',
'  const $newRow = $lastRow.clone().removeAttr(''id'').find(''input'').remove().end();',
'',
'  // Add the cloned row to the end of the ''cr_schichtplanung_matrix'' classic report',
'  const $matrixTableBody = $(''#report_table_cr_sp_matrix tbody'');',
'  $matrixTableBody.append($newRow);',
'  ',
'  // Hide Div',
'  $(''#cr_monat_sum_h'').hide();',
'}',
'',
'function toggleMeldungen() {',
'  var monatStatus = apex.item(''P30_MONAT_STATUS'').getValue();',
'  ',
'  // Ausblenden aller Static Regions',
'  $(''#meldung_frei'').hide();',
'  $(''#meldung_archiviert'').hide();',
'  $(''#meldung_geplant'').hide();',
'  ',
'  // Einblenden der entsprechenden Static Region basierend auf dem Monat-Status',
'  if (monatStatus === ''freie planung'') {',
'    $(''#meldung_frei'').show();',
'  } else if (monatStatus === ''archiviert'') {',
'    $(''#meldung_archiviert'').show();',
'  } else if (monatStatus === ''geplant'') {',
'    $(''#meldung_geplant'').show();',
'  }',
'}'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.btn-save {',
'  height: 47px; /* change the height value as needed */',
'  vertical-align: middle; /* align the button with the adjacent element */',
'  padding-top: 10px; /* add some padding to the top of the button for better alignment */',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'03'
,p_last_updated_by=>'SEM'
,p_last_upd_yyyymmddhh24miss=>'20230705105235'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(12495746953036267)
,p_name=>'schichtplanung_matrix'
,p_region_name=>'cr_sp_matrix'
,p_template=>wwv_flow_imp.id(98852972977580474)
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--stacked:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_function_body_language=>'PLSQL'
,p_source=>'return archiv_planung_schichten_matrix_pkg.get_polymorphic_sql(:P32_MONTH);'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P32_MONTH'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(98830315685580465)
,p_plug_query_max_columns=>20
,p_query_headings=>'return archiv_planung_schichten_matrix_pkg.get_polymorphic_headings;'
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>50
,p_query_options=>'GENERIC_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119134995012553644)
,p_query_column_id=>1
,p_column_alias=>'COL01'
,p_column_display_sequence=>10
,p_column_heading=>'Col01'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119134506357553644)
,p_query_column_id=>2
,p_column_alias=>'COL02'
,p_column_display_sequence=>20
,p_column_heading=>'Col02'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119134140155553644)
,p_query_column_id=>3
,p_column_alias=>'COL03'
,p_column_display_sequence=>30
,p_column_heading=>'Col03'
,p_use_as_row_header=>'N'
,p_column_html_expression=>unistr('<span style=\201Ddisplay:block; width:200px\201D>#COL03#</span>')
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119133777423553642)
,p_query_column_id=>4
,p_column_alias=>'COL04'
,p_column_display_sequence=>40
,p_column_heading=>'Col04'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119133318822553642)
,p_query_column_id=>5
,p_column_alias=>'COL05'
,p_column_display_sequence=>50
,p_column_heading=>'Col05'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119132980521553642)
,p_query_column_id=>6
,p_column_alias=>'COL06'
,p_column_display_sequence=>60
,p_column_heading=>'Col06'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119132571216553642)
,p_query_column_id=>7
,p_column_alias=>'COL07'
,p_column_display_sequence=>70
,p_column_heading=>'Col07'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119132189099553642)
,p_query_column_id=>8
,p_column_alias=>'COL08'
,p_column_display_sequence=>80
,p_column_heading=>'Col08'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119131728344553641)
,p_query_column_id=>9
,p_column_alias=>'COL09'
,p_column_display_sequence=>90
,p_column_heading=>'Col09'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119131373348553641)
,p_query_column_id=>10
,p_column_alias=>'COL10'
,p_column_display_sequence=>100
,p_column_heading=>'Col10'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119130909920553641)
,p_query_column_id=>11
,p_column_alias=>'COL11'
,p_column_display_sequence=>110
,p_column_heading=>'Col11'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119130513290553641)
,p_query_column_id=>12
,p_column_alias=>'COL12'
,p_column_display_sequence=>120
,p_column_heading=>'Col12'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119130189145553641)
,p_query_column_id=>13
,p_column_alias=>'COL13'
,p_column_display_sequence=>130
,p_column_heading=>'Col13'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119129734368553641)
,p_query_column_id=>14
,p_column_alias=>'COL14'
,p_column_display_sequence=>140
,p_column_heading=>'Col14'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119129372646553640)
,p_query_column_id=>15
,p_column_alias=>'COL15'
,p_column_display_sequence=>150
,p_column_heading=>'Col15'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119128951907553640)
,p_query_column_id=>16
,p_column_alias=>'COL16'
,p_column_display_sequence=>160
,p_column_heading=>'Col16'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119128598819553640)
,p_query_column_id=>17
,p_column_alias=>'COL17'
,p_column_display_sequence=>170
,p_column_heading=>'Col17'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119128145818553640)
,p_query_column_id=>18
,p_column_alias=>'COL18'
,p_column_display_sequence=>180
,p_column_heading=>'Col18'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119127769731553640)
,p_query_column_id=>19
,p_column_alias=>'COL19'
,p_column_display_sequence=>190
,p_column_heading=>'Col19'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119127358020553640)
,p_query_column_id=>20
,p_column_alias=>'COL20'
,p_column_display_sequence=>200
,p_column_heading=>'Col20'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12499937437036309)
,p_plug_name=>' Filter'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(98856303378580475)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(22156166138560694)
,p_plug_name=>'Monat archiviert'
,p_region_name=>'meldung_archiviert'
,p_parent_plug_id=>wwv_flow_imp.id(12499937437036309)
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--danger:t-Alert--accessibleHeading:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(98889027425580487)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>2
,p_plug_source=>'Dieser Monat ist bereits archiviert.'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(13251376606752373)
,p_name=>'monat_sum_h'
,p_region_name=>'cr_monat_sum_h'
,p_template=>wwv_flow_imp.id(98852972977580474)
,p_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--stacked:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_function_body_language=>'PLSQL'
,p_source=>'return archiv_planung_schichten_matrix_pkg.get_monat_sum_h_sql(:P32_MONTH);'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P32_MONTH'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(98830315685580465)
,p_plug_query_max_columns=>20
,p_query_headings=>'return archiv_planung_schichten_matrix_pkg.get_polymorphic_headings_monat_sum_h;'
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>15
,p_query_options=>'GENERIC_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119145069089553661)
,p_query_column_id=>1
,p_column_alias=>'COL01'
,p_column_display_sequence=>10
,p_column_heading=>'Col01'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119144665306553661)
,p_query_column_id=>2
,p_column_alias=>'COL02'
,p_column_display_sequence=>20
,p_column_heading=>'Col02'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119144262805553661)
,p_query_column_id=>3
,p_column_alias=>'COL03'
,p_column_display_sequence=>30
,p_column_heading=>'Col03'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119143878781553661)
,p_query_column_id=>4
,p_column_alias=>'COL04'
,p_column_display_sequence=>40
,p_column_heading=>'Col04'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119143424050553660)
,p_query_column_id=>5
,p_column_alias=>'COL05'
,p_column_display_sequence=>50
,p_column_heading=>'Col05'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119143022085553660)
,p_query_column_id=>6
,p_column_alias=>'COL06'
,p_column_display_sequence=>60
,p_column_heading=>'Col06'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp.component_end;
end;
/
begin
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119142696778553660)
,p_query_column_id=>7
,p_column_alias=>'COL07'
,p_column_display_sequence=>70
,p_column_heading=>'Col07'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119142261373553660)
,p_query_column_id=>8
,p_column_alias=>'COL08'
,p_column_display_sequence=>80
,p_column_heading=>'Col08'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119141869960553660)
,p_query_column_id=>9
,p_column_alias=>'COL09'
,p_column_display_sequence=>90
,p_column_heading=>'Col09'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119141468050553659)
,p_query_column_id=>10
,p_column_alias=>'COL10'
,p_column_display_sequence=>100
,p_column_heading=>'Col10'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119141021345553659)
,p_query_column_id=>11
,p_column_alias=>'COL11'
,p_column_display_sequence=>110
,p_column_heading=>'Col11'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119140650163553659)
,p_query_column_id=>12
,p_column_alias=>'COL12'
,p_column_display_sequence=>120
,p_column_heading=>'Col12'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119140251226553659)
,p_query_column_id=>13
,p_column_alias=>'COL13'
,p_column_display_sequence=>130
,p_column_heading=>'Col13'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119139805933553659)
,p_query_column_id=>14
,p_column_alias=>'COL14'
,p_column_display_sequence=>140
,p_column_heading=>'Col14'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119139484321553659)
,p_query_column_id=>15
,p_column_alias=>'COL15'
,p_column_display_sequence=>150
,p_column_heading=>'Col15'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119147063167553664)
,p_query_column_id=>16
,p_column_alias=>'COL16'
,p_column_display_sequence=>160
,p_column_heading=>'Col16'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119146606748553662)
,p_query_column_id=>17
,p_column_alias=>'COL17'
,p_column_display_sequence=>170
,p_column_heading=>'Col17'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119146279671553662)
,p_query_column_id=>18
,p_column_alias=>'COL18'
,p_column_display_sequence=>180
,p_column_heading=>'Col18'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119145877248553661)
,p_query_column_id=>19
,p_column_alias=>'COL19'
,p_column_display_sequence=>190
,p_column_heading=>'Col19'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(119145429614553661)
,p_query_column_id=>20
,p_column_alias=>'COL20'
,p_column_display_sequence=>200
,p_column_heading=>'Col20'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(113887652162345606)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98877814156580483)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(98915417889580516)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(98791364244580444)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(119138792874553656)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(12499937437036309)
,p_button_name=>'editMonatStatus'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'Status bearbeiten'
,p_button_redirect_url=>'f?p=&APP_ID.:35:&SESSION.::&DEBUG.:35::'
,p_button_css_classes=>'btn-save'
,p_icon_css_classes=>'fa-edit'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(119137914574553653)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(12499937437036309)
,p_button_name=>'btnSaveMatrix'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconLeft:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_button_css_classes=>'btn-save'
,p_icon_css_classes=>'fa-save'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(119137579057553653)
,p_name=>'P32_MONTH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(12499937437036309)
,p_prompt=>'Monat'
,p_source=>'SELECT TO_CHAR(SYSDATE, ''MON YYYY'') FROM DUAL;'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'MONAT_JAHR_ARCHIV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select monat_jahr d, monat_jahr r',
'from monat_planung',
'where ref_status_id = 4 --Nur archivierte monate anzeigen',
'order by TO_DATE(monat_jahr, ''MON YYYY'') desc',
''))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(98795537782580449)
,p_item_template_options=>'#DEFAULT#:margin-top-none:margin-bottom-md'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(119137195374553648)
,p_name=>'P32_MONAT_STATUS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(12499937437036309)
,p_source=>'return utility_pkg.get_status(:P32_MONTH);'
,p_source_type=>'FUNCTION_BODY'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(119126633763553634)
,p_name=>'onTextfieldLoseFocus'
,p_event_sequence=>80
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'input[type="text"]'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#cr_sp_matrix'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(119126105330553633)
,p_event_id=>wwv_flow_imp.id(119126633763553634)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(12495746953036267)
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('/*Autocomplete Vorgabe_Codes f\00FCr Solution Desk*/'),
'switch($(this.triggeringElement).val()){',
'    case ''6''||''ab6'': $(this.triggeringElement).val(''ab6'');               ',
'    break;',
'    case ''7''||''ab7'': $(this.triggeringElement).val(''ab7'');',
'    break;',
'    case ''9''||''ab9'': $(this.triggeringElement).val(''ab9''); ',
'    break;',
'    case ''14''||''ab14'': $(this.triggeringElement).val(''ab14''); ',
'    break;',
'    case ''22''||''ab22'': $(this.triggeringElement).val(''ab22''); ',
'    break;',
'    case ''k''||''krank'': $(this.triggeringElement).val(''krank''); ',
'    break;',
'    case ''u''||''urlaub'': $(this.triggeringElement).val(''urlaub''); ',
'    break;',
'    case ''s''||''schulung'': $(this.triggeringElement).val(''schulung'');',
'     break;',
'    case ''1210''||''12ab10'': $(this.triggeringElement).val(''12ab10'');',
'     break;',
'    case ''1222''||''12ab22'': $(this.triggeringElement).val(''12ab22'');',
'     break;',
'};',
'setTimeout(() => faerbe_zellen_ein_matrix(), 10);'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(119125727472553632)
,p_name=>'setFarbenPageLoad'
,p_event_sequence=>100
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(119125217050553632)
,p_event_id=>wwv_flow_imp.id(119125727472553632)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'setTimeout(() => { ',
'    faerbe_zellen_ein_matrix();',
'    copyLastRowToMatrix();',
'    get_values_copied_row();',
'}, 1000);',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(119124885261553632)
,p_name=>'onBtnSaveClicked'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(119137914574553653)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(119124352098553631)
,p_event_id=>wwv_flow_imp.id(119124885261553632)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'saveMatrix();',
'get_values_copied_row();'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(119122856625553629)
,p_event_id=>wwv_flow_imp.id(119124885261553632)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
' FOR r_row IN (SELECT ma.mitarbeiter_id FROM mitarbeiter ma WHERE ma.service_team_id = 1 AND ma.aktiv = ''Y'' AND ma.rolle_id = ''MA'')',
'    LOOP',
'    constraints_pkg.pruefe_constraints_ma(r_row.mitarbeiter_id,TO_DATE(:P32_MONTH, ''MON YYYY''));',
'    END LOOP;',
'END;',
'',
'',
''))
,p_attribute_02=>'P32_MONTH'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(119120576386553629)
,p_name=>'onMonthSelected'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P32_MONTH'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(119118617559553627)
,p_event_id=>wwv_flow_imp.id(119120576386553629)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(13251376606752373)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(119120087831553628)
,p_event_id=>wwv_flow_imp.id(119120576386553629)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(12495746953036267)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(119119572500553628)
,p_event_id=>wwv_flow_imp.id(119120576386553629)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'setTimeout(() => { ',
'    faerbe_zellen_ein_matrix();',
'    copyLastRowToMatrix();',
'    get_values_copied_row();',
'}, 3000);'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(119118231153553627)
,p_name=>'navigateKeys'
,p_event_sequence=>140
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'#cr_sp_matrix input'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'keydown'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(119117784798553627)
,p_event_id=>wwv_flow_imp.id(119118231153553627)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'TRIGGERING_ELEMENT'
,p_attribute_01=>'navigate(event);'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(119117323057553627)
,p_name=>'onDialogMonatStatusClose'
,p_event_sequence=>150
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(119138792874553656)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(119116852092553627)
,p_event_id=>wwv_flow_imp.id(119117323057553627)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P32_MONAT_STATUS'
);
wwv_flow_imp.component_end;
end;
/
