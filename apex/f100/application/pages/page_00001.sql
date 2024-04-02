prompt --application/pages/page_00001
begin
--   Manifest
--     PAGE: 00001
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
 p_id=>1
,p_name=>'Startseite'
,p_alias=>'STARTSEITE'
,p_step_title=>'Startseite'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function setRowBackgroundColors() {',
'    // Den Interactive Grid-Bezeichner ersetzen (z.B. "meine_schichten")',
'    var gridId = "meine_schichten";',
'    ',
'    // Rufen Sie das Interactive Grid Widget ab',
'    var ig$ = apex.jQuery("#" + gridId);',
'    ',
unistr('    // \00DCberpr\00FCfen Sie, ob das Interactive Grid initialisiert wurde'),
'    if (ig$ && ig$.interactiveGrid) {',
'        // Rufen Sie das aktuelle Grid-View-Modell ab',
'        var model = ig$.interactiveGrid("getViews", "grid").model;',
'',
'        // Schleife durch die Zeilen im Modell',
'        model.forEach(function(row) {',
unistr('            // Hier nehmen wir an, dass die FARBCODE_HEX-Spalte die Farbcodes im Hexadezimalformat enth\00E4lt'),
'            var hexColor = row.get("FARBCODE_HEX");',
'            console.log(hexColor);',
unistr('            // \00DCberpr\00FCfen, ob ein g\00FCltiger Hexadezimalwert vorliegt (z.B. "#RRGGBB" oder "#RRGGBBAA")'),
'            if (/^#[0-9A-F]{6}$/i.test(hexColor) || /^#[0-9A-F]{8}$/i.test(hexColor)) {',
unistr('                // Wenn ein g\00FCltiger Hexadezimalwert vorliegt, setzen Sie die Hintergrundfarbe der Zeile'),
'                row.node$().css("background-color", hexColor);',
'            }',
'        });',
'    }',
'}',
'',
'',
unistr('// Funktion zum farblichen Formatieren der Zeilen und validieren der anzahle gew\00E4hlter Schichten'),
'function faerbe_zellen_ein_matrix() {',
'  const matrix = $(''#cr_sp_matrix'').last();',
'  const trElements = matrix.find(''tr'');',
'    const appUser = apex.item("P25_MITARBEITER_ID").getValue();',
'    const status = apex.item("P25_MONAT_STATUS").getValue(); ',
'',
'  trElements.each(function(n) {',
'    let count6 = 0;',
'    let count7 = 0;',
'    let count9 = 0;',
'    let count14 = 0;',
'    let count22 = 0;',
'    let count12 = 0;',
'    const rowDatum = $(this).find(''td:first'').text().trim(); // Datum der aktuellen Zeile',
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
'    // Deaktivieren input fields falls monat geplant',
'      if (currElement.attr(''headers'') !== appUser || status === ''geplant'') {',
'        currInputElement.attr(''disabled'', true);',
'      } else {',
'        currInputElement.removeAttr(''disabled'');',
'      }',
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
'        const linkIconField = createLinkIconField(rowDatum); ',
'          currElement.empty().append(linkIconField);',
'        break;',
'    }',
'',
'',
'   // Wochenende und Feiertage anders darstellen',
'    if (currElement.attr(''headers'') === ''DATUM'') {',
'        const dateString = currElement.text();',
'        const dateParts = dateString.split(''.'');',
'        const year = Number(dateParts[2]);',
'        const month = Number(dateParts[1]) - 1; ',
'        const day = Number(dateParts[0]);',
'        const currDate = new Date(year, month, day);',
'        const currDay = currDate.getDay(); ',
unistr('        if (currDay === 0 || currDay === 6) { // \00DCberpr\00FCfen, ob der Tag ein Samstag oder Sonntag ist'),
'            currElement.css("background-color", "#a6a6a6");',
'        }',
'        const parmObj = {',
'            x08: dateString',
'        };',
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
'    if (currElement.attr(''headers'') !== ''DATUM'' && currElement.attr(''headers'') !== ''RB'' && currElement.attr(''headers'') !== ''KOMMENTAR'') { ',
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
'            case ''6'':    currElement.css("background-color", "#6e9d3c");',
'                break;',
'            case ''7'':    currElement.css("background-color", "#6e9d3c");',
'                break;',
'        }',
'        ',
'    });',
'});',
'get_comment_count();',
'}',
'',
'function addInputToRBColumn() {',
'  const rbColumnDataCells = $(''#cr_sp_matrix td[headers="RB"]''); // Die Daten-Zellen der "RB" Spalte',
'',
unistr('  // Schleife \00FCber alle Daten-Zellen der "RB" Spalte'),
'  rbColumnDataCells.each(function(index) {',
'    const rbColumnDataCell = $(this);',
'',
unistr('    // Textfeld erstellen und zu Zelle hinzuf\00FCgen'),
'    const textField = $(''<input type="text" readonly>'');',
'    textField.css("border-style", "none");',
'    textField.css("width", "50px");',
'    rbColumnDataCell.empty().append(textField);',
'  });',
'}',
'',
'function createLinkIconField(rowDatum) {',
'  const link = `javascript:openModalDialog(''${rowDatum}'')`;',
'  const linkIcon = $(''<a></a>'').attr(''href'', link).addClass(''dialog-link'');',
'  const icon = $(''<span></span>'').addClass(''fa fa-comment-o'');',
'  linkIcon.append(icon);',
'  return linkIcon;',
'}',
'',
'function get_comment_count() {',
'  const matrix = $(''#cr_sp_matrix'').last();',
'  const trElements = matrix.find(''tr'');',
'',
'  trElements.each(function(n) {',
'    const tdElements = $(this).find(''td'');',
'',
'    tdElements.each(function(i) {',
'      const currElement = $(this);',
'',
'      if (currElement.attr(''headers'') === ''KOMMENTAR'') {',
'        const rowDatum = $(this).closest(''tr'').find(''td:first'').text().trim();',
'',
'        // AJAX-Prozess aufrufen',
'        const parmObj = {',
'          x01: rowDatum',
'        };',
'',
'        apex.server.process(''get_comment_count'', parmObj, {',
'          success: function(data) {',
'            console.log(data);',
'            if (data.comment_count >= 1) {',
'              const icon = currElement.find(''.fa'');',
'              icon.removeClass(''fa-comment-o'');',
'              icon.addClass(''fa-comment'');',
'            }',
'          },',
'          error: function(errorThrown) {',
'            console.log(''AJAX error:'', errorThrown);',
'          }',
'        });',
'      }',
'    });',
'  });',
'}',
'',
'function openModalDialog(rowDatum) {',
'    const parmObj = {',
'            x01: rowDatum',
'          };',
'    apex.server.process(''open_modal_dialog'',parmObj, {',
'    success: function(data) {',
'      var dialogUrl = data.dialog_url;',
'      console.log(data.dialog_url);',
'      eval(dialogUrl);',
'    },',
'    error: function(xhr, textStatus, errorThrown) {',
'      console.log(''AJAX error:'', errorThrown);',
'    }',
'  });',
'}',
'',
'function saveMatrixMitarbeiter() {',
'  const $matrix = $(''#cr_sp_matrix'').last();',
'  const numRequests = $matrix.find(''tr'').length;',
'  let numResponses = 0;',
'',
'  $matrix.find(''tr'').each(function(n) {',
'    const $row = $(this);',
'    $row.find(''td'').each(function(i) {',
'      const $input = $($row.find(''td'')[i]).find(''input'');',
'      const id = $input.attr(''id'');',
'      if (id && ![''6'', ''7'', ''9'', ''14'', ''22'', ''12''].includes($input.val()) && $input.attr(''headers'') !== ''KOMMENTAR'') {',
'        const [datum, mitarbeiter_id] = id.split('':'');',
'        const parmObj = {',
'          x01: datum,',
'          x02: mitarbeiter_id,',
'          x03: $input.val()',
'        };',
'        console.log(parmObj);',
'          apex.server.process(''save_matrix_mitarbeiter'', parmObj, {',
'          success: function(data) {',
'            numResponses++;',
'            if (data.success) {',
'                console.log(data);',
'              if (numResponses === numRequests) {',
'                apex.message.alert(''Speichern erfolgreich!'');',
'                return;',
'              }',
'            } ',
'            if (!data.success) {',
'              const formattedDate = formatDate(data.datum);',
'              const errorMsg = `Fehler beim Speichern! Mitarbeiter: ${data.mitarbeiter_id}, Schicht: ${data.vorgabe_code_id}, Datum: ${formattedDate}`;',
'              apex.message.alert(errorMsg);',
'              return;',
'            } ',
'          },',
'          error: function(data) {',
'            console.log(data);',
'          }',
'        });',
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
'function get_values_copied_row() {',
'    const $table = $(''#report_table_cr_sp_matrix tbody tr:last-child'');',
'    const datum = $table.find(''td:first'').text().trim(); // Zelle Datum',
'    ',
unistr('    // Z\00E4hler f\00FCr abgeschlossene AJAX-Aufrufe'),
'    let ajaxCompletedCounter = 0;',
'',
unistr('    // Anzahl der durchzuf\00FChrenden AJAX-Aufrufe (Anzahl der Zellen minus die Datumsspalte)'),
'    const totalAjaxCalls = $table.find(''td:not(:first-child)'').length;',
'',
'    $table.find(''td:not(:first-child)'').each(function(i) { // erste Zelle Datum ignorieren',
'        const $cell = $(this);',
'        const mitarbeiter_id = $cell.attr(''headers'');',
'        const parmObj = {',
'            x01: datum,',
'            x02: mitarbeiter_id',
'        };',
'        ',
'        apex.server.process(''get_day_ma_sum_h'', parmObj, {',
'           // refreshObject: ''#report_table_cr_sp_matrix'',',
'            success: function(data) {',
'                if (data.success) {',
'                    console.log(data);',
'                    $cell.text(data.sum);',
'                } else {',
'                    $cell.text(0);',
'                }',
'',
unistr('                // Z\00E4hler erh\00F6hen'),
'                ajaxCompletedCounter++;',
'',
unistr('                // \00DCberpr\00FCfen, ob alle AJAX-Aufrufe abgeschlossen sind'),
'                if (ajaxCompletedCounter === totalAjaxCalls) {',
'                    //einfaerben_copied_row();',
'                }',
'            },',
'            error: function(data) {',
'                console.log(data);',
'                apex.message.alert(data.err);',
'',
unistr('                // Z\00E4hler erh\00F6hen, auch wenn ein Fehler aufgetreten ist'),
'                ajaxCompletedCounter++;',
'',
unistr('                // \00DCberpr\00FCfen, ob alle AJAX-Aufrufe abgeschlossen sind'),
'                if (ajaxCompletedCounter === totalAjaxCalls) {',
'                    //einfaerben_copied_row();',
'                }',
'            }',
'        });',
'    });',
'}',
'',
'',
'function einfaerben_copied_row() {',
'  const matrix = $(''#report_table_cr_sp_matrix tbody tr:last-child'');',
'  const datum = matrix.find(''td:first'').text().trim();',
'  const trElements = matrix.find(''td:not(:first-child)'');',
'  trElements.each(function(i) {',
'    const currElement = $(this);',
'    const value = parseInt(currElement.text(), 10);',
'    const id = currElement.attr(''headers'');',
'    if (id !== undefined && currElement) {',
'      const mitarbeiter_id = id;',
'      const parmObj = {',
'        x03: datum,',
'        x04: mitarbeiter_id',
'      };',
'      apex.server.process(''get_limit_h_mitarbeiter'', parmObj, {',
'        //refreshObject: ''#report_table_cr_sp_matrix'',',
'        success: function(data) { ',
'          const limit_h = (data.success ? parseInt(data.limit_h, 10) : 0);',
'          console.log(value);',
'          console.log(limit_h);',
'         if (value < limit_h) {',
'                            currElement.css("background-color", "#FFFF00");  // Gelb',
'         } else if (value === limit_h) {',
unistr('                            currElement.css("background-color", "#94d778");  // Gr\00FCn'),
'         } else {',
'                            currElement.css("background-color", "#e63e31");  // Rot',
'        }',
'        },',
'        error: function(data) {',
'             console.log(data.err);',
'        }',
'      });',
'    }',
'  });',
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
'function copyLastRowToMatrix() {',
'  // Get the last row of the ''cr_monat_sum_h'' classic report',
'  const $lastRow = $(''#report_table_cr_monat_sum_h tbody tr:last-child'');',
'',
'  // Clone the last row and remove the ID and input fields',
'  //const $newRow = $lastRow.clone().removeAttr(''id'').find(''input'').remove().end();',
'',
'  // Add the cloned row to the end of the ''cr_schichtplanung_matrix'' classic report',
'  //const $matrixTableBody = $(''#report_table_cr_sp_matrix tbody'');',
'  //const $matrixRows = $matrixTableBody.find(''tr'');',
'  //const lastRowIndex = $matrixRows.length - 1; // Get the index of the last row',
'',
'  // Append the cloned row after the last row of the matrix',
'  //$matrixRows.eq(lastRowIndex).after($newRow);',
'  ',
'  // Hide Div',
'  //$(''#cr_monat_sum_h'').hide();',
'}',
'',
'',
'function toggleMeldungen() {',
'  var monatStatus = apex.item(''P25_MONAT_STATUS'').getValue();',
'  ',
'  // Ausblenden aller Static Regions',
'  $(''#meldung_frei'').hide();',
'  $(''#meldung_archiviert'').hide();',
'  $(''#meldung_geplant'').hide();',
'  $(''#cr_monat_sum_h'').hide();',
'  ',
'  // Einblenden der entsprechenden Static Region basierend auf dem Monat-Status',
'  if (monatStatus === ''freie planung'') {',
'    $(''#meldung_frei'').show();',
'  } else if (monatStatus === ''archiviert'') {',
'    $(''#meldung_archiviert'').show();',
'  } else if (monatStatus === ''geplant'') {',
'    $(''#meldung_geplant'').show();',
'  }',
'}',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.center-content {',
'  display: flex;',
'  justify-content: center;',
'  align-items: center;',
'  height: 100%; ',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'13'
,p_last_updated_by=>'APK'
,p_last_upd_yyyymmddhh24miss=>'20240126102733'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(127462677661244846)
,p_plug_name=>'Startseite'
,p_region_template_options=>'t-BreadcrumbRegion--useRegionTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98877814156580483)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(98915417889580516)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(98791364244580444)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(122848881414482884)
,p_plug_name=>'Banner'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(98852972977580474)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div style="text-align:center;">',
'  <h1>Guten Tag &P1_VORNAME.. Datum  &P1_SYSDATE.</h1>',
'</div>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(100192284392627747)
,p_plug_name=>'centered'
,p_region_css_classes=>'center-content'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98846167001580472)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(100192107670627746)
,p_plug_name=>'rows'
,p_parent_plug_id=>wwv_flow_imp.id(100192284392627747)
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(98856303378580475)
,p_plug_display_sequence=>10
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(123905783272009874)
,p_plug_name=>'Meine Schichten'
,p_region_name=>'meine_schichten'
,p_parent_plug_id=>wwv_flow_imp.id(100192107670627746)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(98852972977580474)
,p_plug_display_sequence=>20
,p_query_type=>'TABLE'
,p_query_table=>'MEINE_SCHICHTEN_V'
,p_query_where=>wwv_flow_string.join(wwv_flow_t_varchar2(
'mitarbeiter_id = :APP_USER',
'',
''))
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Meine Schichten'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(123904643401009863)
,p_name=>'PLANUNG_SCHICHTEN_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PLANUNG_SCHICHTEN_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(123904543985009862)
,p_name=>'DATUM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DATUM'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Datum'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(123904473072009861)
,p_name=>'WOCHENTAG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WOCHENTAG'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Wochentag'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>2
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(123904352699009860)
,p_name=>'SERVICE_TEAM_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SERVICE_TEAM_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(123904257969009859)
,p_name=>'STARTZEIT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STARTZEIT'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Start'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
,p_format_mask=>'HH24:MI'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(123904153470009858)
,p_name=>'ENDZEIT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ENDZEIT'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Ende'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
,p_format_mask=>'HH24:MI'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(123903958414009856)
,p_name=>'MITARBEITER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MITARBEITER_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>20
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(99296061658398492)
,p_name=>'VORGABE_FARBCODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VORGABE_FARBCODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Vorgabe Farbcode'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>50
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(99295779484398489)
,p_name=>'VORGABE_CODE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VORGABE_CODE_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Typ'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(123904715413009864)
,p_internal_uid=>139363287643971130
,p_is_editable=>false
,p_lazy_loading=>true
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>false
,p_show_toolbar=>false
,p_toolbar_buttons=>null
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>false
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
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
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(123024970041568918)
,p_interactive_grid_id=>wwv_flow_imp.id(123904715413009864)
,p_static_id=>'1402431'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(123024712273568917)
,p_report_id=>wwv_flow_imp.id(123024970041568918)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(123024265120568914)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(123904643401009863)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(123023323721568909)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(123904543985009862)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>124
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(123022431398568907)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(123904473072009861)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>96
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(123021562865568905)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(123904352699009860)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(123020612809568902)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(123904257969009859)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>483
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(123019752028568900)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(123904153470009858)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>418.8000030517578
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(123017980104568896)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(123903958414009856)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(99288407524316005)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(99296061658398492)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(99281776666119544)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(99295779484398489)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(56775015088351)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>40
,p_name=>'1/2'
,p_background_color=>'#ffffff'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'1/2'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(56219352088351)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>35
,p_name=>'12ab22'
,p_background_color=>'#c0504d'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'12ab22'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(55737677088351)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>30
,p_name=>'12ab10'
,p_background_color=>'#ffc000'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'12ab10'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(55280636088351)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>25
,p_name=>'x'
,p_background_color=>'#c7d9f2'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'x'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(54721296088351)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>20
,p_name=>'urlaub'
,p_background_color=>'#98d046'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'urlaub'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(54255082088350)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>15
,p_name=>'krank'
,p_background_color=>'#c5d798'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'krank'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(53715164088350)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>9.375
,p_name=>'ab22'
,p_background_color=>'#a6a6a6'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'ab22'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(53193927088350)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>8.75
,p_name=>'ab14'
,p_background_color=>'#da9694'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'ab14'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(52762981088350)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>7.5
,p_name=>'ab9'
,p_background_color=>'#fcd5b4'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'ab9'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(43640627058434)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>10
,p_name=>'ab7'
,p_background_color=>'#c6efce'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'ab7'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_ig_report_highlight(
 p_id=>wwv_flow_imp.id(11961443049008)
,p_view_id=>wwv_flow_imp.id(123024712273568917)
,p_execution_seq=>5
,p_name=>'ab6'
,p_background_color=>'#ffff00'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_imp.id(99295779484398489)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'ab6'
,p_is_enabled=>true
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(185550482309981779)
,p_name=>'schichtplanung_matrix'
,p_region_name=>'cr_sp_matrix'
,p_parent_plug_id=>wwv_flow_imp.id(100192107670627746)
,p_template=>wwv_flow_imp.id(98852972977580474)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--stacked:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_function_body_language=>'PLSQL'
,p_source=>'return planung_schichten_matrix_pkg.get_matrix_day_sql(:P1_SYSDATE);'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P1_SYSDATE'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(98830315685580465)
,p_plug_query_max_columns=>28
,p_query_headings=>'return planung_schichten_matrix_pkg.get_polymorphic_headings;'
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>50
,p_query_options=>'GENERIC_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99800574400055593)
,p_query_column_id=>1
,p_column_alias=>'COL01'
,p_column_display_sequence=>10
,p_column_heading=>'Col01'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99800187395055589)
,p_query_column_id=>2
,p_column_alias=>'COL02'
,p_column_display_sequence=>20
,p_column_heading=>'Col02'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99799773058055589)
,p_query_column_id=>3
,p_column_alias=>'COL03'
,p_column_display_sequence=>30
,p_column_heading=>'Col03'
,p_use_as_row_header=>'N'
,p_column_html_expression=>unistr('<span style=\201Ddisplay:block; width:200px\201D>#COL03#</span>')
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99799351390055589)
,p_query_column_id=>4
,p_column_alias=>'COL04'
,p_column_display_sequence=>40
,p_column_heading=>'Col04'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99798943277055588)
,p_query_column_id=>5
,p_column_alias=>'COL05'
,p_column_display_sequence=>50
,p_column_heading=>'Col05'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99798592340055588)
,p_query_column_id=>6
,p_column_alias=>'COL06'
,p_column_display_sequence=>60
,p_column_heading=>'Col06'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99798154880055588)
,p_query_column_id=>7
,p_column_alias=>'COL07'
,p_column_display_sequence=>70
,p_column_heading=>'Col07'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99797796439055588)
,p_query_column_id=>8
,p_column_alias=>'COL08'
,p_column_display_sequence=>80
,p_column_heading=>'Col08'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99797321000055588)
,p_query_column_id=>9
,p_column_alias=>'COL09'
,p_column_display_sequence=>90
,p_column_heading=>'Col09'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99796951294055588)
,p_query_column_id=>10
,p_column_alias=>'COL10'
,p_column_display_sequence=>100
,p_column_heading=>'Col10'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99796600028055587)
,p_query_column_id=>11
,p_column_alias=>'COL11'
,p_column_display_sequence=>110
,p_column_heading=>'Col11'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99796189634055587)
,p_query_column_id=>12
,p_column_alias=>'COL12'
,p_column_display_sequence=>120
,p_column_heading=>'Col12'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99795716591055587)
,p_query_column_id=>13
,p_column_alias=>'COL13'
,p_column_display_sequence=>130
,p_column_heading=>'Col13'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99795379401055587)
,p_query_column_id=>14
,p_column_alias=>'COL14'
,p_column_display_sequence=>140
,p_column_heading=>'Col14'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99794994896055587)
,p_query_column_id=>15
,p_column_alias=>'COL15'
,p_column_display_sequence=>150
,p_column_heading=>'Col15'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99794592347055586)
,p_query_column_id=>16
,p_column_alias=>'COL16'
,p_column_display_sequence=>160
,p_column_heading=>'Col16'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99794174520055586)
,p_query_column_id=>17
,p_column_alias=>'COL17'
,p_column_display_sequence=>170
,p_column_heading=>'Col17'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99793798646055586)
,p_query_column_id=>18
,p_column_alias=>'COL18'
,p_column_display_sequence=>180
,p_column_heading=>'Col18'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99793319753055585)
,p_query_column_id=>19
,p_column_alias=>'COL19'
,p_column_display_sequence=>190
,p_column_heading=>'Col19'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99792968263055585)
,p_query_column_id=>20
,p_column_alias=>'COL20'
,p_column_display_sequence=>250
,p_column_heading=>'Col20'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99792552947055585)
,p_query_column_id=>21
,p_column_alias=>'COL21'
,p_column_display_sequence=>260
,p_column_heading=>'Col21'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99792180120055585)
,p_query_column_id=>22
,p_column_alias=>'COL22'
,p_column_display_sequence=>270
,p_column_heading=>'Col22'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99791717777055585)
,p_query_column_id=>23
,p_column_alias=>'COL23'
,p_column_display_sequence=>280
,p_column_heading=>'Col23'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99791330931055585)
,p_query_column_id=>24
,p_column_alias=>'COL24'
,p_column_display_sequence=>290
,p_column_heading=>'Col24'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99790954552055585)
,p_query_column_id=>25
,p_column_alias=>'COL25'
,p_column_display_sequence=>300
,p_column_heading=>'Col25'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99790517504055584)
,p_query_column_id=>26
,p_column_alias=>'COL26'
,p_column_display_sequence=>310
,p_column_heading=>'Col26'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99790164882055584)
,p_query_column_id=>27
,p_column_alias=>'COL27'
,p_column_display_sequence=>320
,p_column_heading=>'Col27'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99789790526055584)
,p_query_column_id=>28
,p_column_alias=>'COL28'
,p_column_display_sequence=>330
,p_column_heading=>'Col28'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(186323240747808695)
,p_name=>'monat_sum_h'
,p_region_name=>'cr_monat_sum_h'
,p_template=>wwv_flow_imp.id(98852972977580474)
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--stacked:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_function_body_language=>'PLSQL'
,p_source=>'return planung_sum_h_matrix_pkg.get_monat_sum_h_sql(:P1_MONTH);'
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P1_MONTH'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(98830315685580465)
,p_plug_query_max_columns=>20
,p_query_headings=>'return planung_sum_h_matrix_pkg.get_polymorphic_headings_monat_sum_h;'
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>15
,p_query_options=>'GENERIC_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(99783481895944804)
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
 p_id=>wwv_flow_imp.id(99783065015944801)
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
 p_id=>wwv_flow_imp.id(99782663183944801)
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
 p_id=>wwv_flow_imp.id(99782238346944801)
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
 p_id=>wwv_flow_imp.id(99781844673944801)
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
 p_id=>wwv_flow_imp.id(99781459490944801)
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
 p_id=>wwv_flow_imp.id(99781041226944800)
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
 p_id=>wwv_flow_imp.id(99780608620944800)
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
 p_id=>wwv_flow_imp.id(99780299177944800)
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
 p_id=>wwv_flow_imp.id(99779842413944800)
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
 p_id=>wwv_flow_imp.id(99779488741944800)
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
 p_id=>wwv_flow_imp.id(99779016004944800)
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
 p_id=>wwv_flow_imp.id(99778683536944800)
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
 p_id=>wwv_flow_imp.id(99778248009944799)
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
 p_id=>wwv_flow_imp.id(99777835051944799)
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
 p_id=>wwv_flow_imp.id(99777434913944799)
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
 p_id=>wwv_flow_imp.id(99777006660944799)
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
 p_id=>wwv_flow_imp.id(99776678211944799)
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
 p_id=>wwv_flow_imp.id(99776300103944799)
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
 p_id=>wwv_flow_imp.id(99775885236944798)
,p_query_column_id=>20
,p_column_alias=>'COL20'
,p_column_display_sequence=>200
,p_column_heading=>'Col20'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(122849684836482892)
,p_name=>'P1_VORNAME'
,p_item_sequence=>60
,p_source=>'select vorname from mitarbeiter where mitarbeiter_id = :APP_USER'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(122847810349482874)
,p_name=>'P1_ROLLE_ID'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(122846480118482860)
,p_name=>'P1_SYSDATE'
,p_item_sequence=>70
,p_source=>'select sysdate from dual'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(122848061781482876)
,p_name=>'setItemPageload'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(122847972904482875)
,p_event_id=>wwv_flow_imp.id(122848061781482876)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_mitarbeiter_id Mitarbeiter.mitarbeiter_id%type;',
'    l_vorname Mitarbeiter.vorname%type;',
'    l_nachname Mitarbeiter.nachname%type;',
'    l_email_adresse Mitarbeiter.email_adresse%type;',
'    l_handynummer Mitarbeiter.handynummer%type;',
'    l_service_team_id Mitarbeiter.service_team_id%type;',
'    l_rolle_id Mitarbeiter.rolle_id%type;',
'begin',
'    select mitarbeiter_id, vorname, nachname, email_adresse, handynummer, service_team_id, rolle_id',
'    into l_mitarbeiter_id, l_vorname, l_nachname, l_email_adresse, l_handynummer, l_service_team_id, l_rolle_id',
'    from mitarbeiter',
'    where mitarbeiter_id = :APP_USER;',
'',
'    apex_util.set_session_state(''P1_VORNAME'', l_vorname);',
'    apex_util.set_session_state(''P1_ROLLE_ID'', l_rolle_id);',
'',
'    --apex_util.set_session_state(''P28_AKTIV'', l_aktiv);',
unistr('    -- leere Datens\00E4tze f\00FCr Drag and Drop Funktionalit\00E4t Kalender werden ermittelt und geupdated'),
'    --utility_pkg.update_planung_schichten_zeitraum();',
'exception',
'    when no_data_found then',
'        apex_debug.message(''No data found for user '' || :APP_USER);',
'end;'))
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(122847493670482870)
,p_event_id=>wwv_flow_imp.id(122848061781482876)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P1_VORNAME'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(122847767139482873)
,p_event_id=>wwv_flow_imp.id(122848061781482876)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//authorizeUser();',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(99786948744967570)
,p_name=>'setFarbenPageLoad'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(99785596546967567)
,p_event_id=>wwv_flow_imp.id(99786948744967570)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'faerbe_zellen_ein_matrix();',
'copyLastRowToMatrix();',
'//get_values_copied_row();',
'',
''))
);
wwv_flow_imp.component_end;
end;
/
