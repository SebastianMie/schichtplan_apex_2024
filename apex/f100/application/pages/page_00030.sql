prompt --application/pages/page_00030
begin
--   Manifest
--     PAGE: 00030
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
 p_id=>30
,p_name=>'Schichtplanung'
,p_alias=>'SCHICHTPLANUNG1'
,p_step_title=>'Schichtplanung'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function saveMatrixMitarbeiter() {',
'    const $matrix = $(''#cr_sp_matrix'').last();',
'    let numRequests = 0; // Anzahl der Anfragen',
'    let numResponses = 0; // Anzahl der Antworten',
'    ',
'    $matrix.find(''tr'').each(function() {',
'        const $row = $(this);',
'        const columnData = [];',
'',
'        $row.find(''td'').each(function() {',
'            const $input = $(this).find(''input'');',
'            const id = $input.attr(''id'');',
'',
'            if (id && ![''6'', ''7'', ''9'', ''14'', ''22'', ''12''].includes($input.val())) {',
'                const [datum, currentUser] = id.split('':'');',
'                const value = $input.val();',
'                columnData.push({ datum, currentUser, value });',
'            }',
'        });',
'        ',
'        if (columnData.length > 0) {',
'            const jsonData = columnData ;',
'            const parmObj = { x01: JSON.stringify(jsonData) }; // JSON-String erstellen',
'           ',
'            numRequests++;',
'            apex.server.process(''save_matrix_mitarbeiter'', parmObj, {',
'                success: function(data) {',
'                    numResponses++;',
'                    if (numResponses === numRequests) {',
'                        apex.message.alert(''Speichern erfolgreich!'');',
'                    }',
'                    else {',
'                        if (data.missing_entries != ''[]'') {',
unistr('                            apex.message.alert(''Fehlerhafte Eintr\00E4ge: '' + data.missing_entries);'),
'                        } ',
'                    }',
'                },',
'                error: function(xhr, status, errorThrown) {',
'                    console.log(''AJAX error:'', errorThrown);',
'                }',
'            });',
'        }',
'    }); ',
'}',
'',
'function lock_matrix() {',
'    const matrix = $(''#cr_sp_matrix'').last();',
'    matrix.find(''input'').prop(''disabled'', true);',
'    $(''#saveMatrix'').prop(''disabled'', true); // Deaktiviere den Button mit der statischen ID saveMatrix',
'}',
'',
unistr('// Funktion zum farblichen Formatieren der Zeilen und validieren der anzahle gew\00E4hlter Schichten'),
'function faerbe_zellen_ein_matrix() {',
'  const matrix = $(''#cr_sp_matrix'').last();',
'  const trElements = matrix.find(''tr'');',
'',
'  trElements.each(function(n) {',
'    const firstColumnHeader = $(this).find(''td:first'').attr(''headers'');',
'    if (firstColumnHeader !== ''MONAT'') {',
'    let count6 = 0;',
'    let count7 = 0;',
'    let count9 = 0;',
'    let count14 = 0;',
'    let count22 = 0;',
'    let count12ab10 = 0;',
'    let count12ab22 = 0;',
'    ',
'    const rowDatum = $(this).find(''td:first'').text().trim(); // Datum der aktuellen Zeile',
'    const tdElements = $($(trElements)[n]).find(''td'');',
'    const dateString = $(tdElements[0]).text(); ',
'    const dateParts = dateString.split(''.'');',
'    const year = Number(dateParts[2]);',
'    const month = Number(dateParts[1]) - 1;',
'    const day = Number(dateParts[0]);',
'    const currDate = new Date(year, month, day);',
unistr('    let currDay = currDate.getDay(); // Initialisieren der aktuellen Wochentag f\00FCr die Zeile'),
'',
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
'        case ''12ab10'': count12ab10 = count12ab10 + 1;',
'        break',
'        case ''12ab22'': count12ab22 = count12ab22 + 1;',
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
'        case ''1210'': currElement.text(count12ab10);',
'        break',
'        case ''1222'': currElement.text(count12ab22);',
'        break',
'        case ''KOMMENTAR'':',
'        const linkIconField = createLinkIconField(rowDatum); ',
'          currElement.empty().append(linkIconField);',
'        break;',
'    }',
'',
'   // Wochenende und Feiertage anders darstellen',
'    if (currElement.attr(''headers'') === ''DATUM'') {',
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
'    if (currElement.attr(''headers'') !== ''DATUM'' && currElement.attr(''headers'') !== ''KOMMENTAR'') { ',
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
'    ',
unistr('    // Farbenvalidierung basierend auf den Anforderungen f\00FCr jede Wochentagsschicht'),
'    switch(currElement.attr(''headers'')){',
'        case ''6'': ',
'            if (count6 >= 1 && (currDay >= 1 && currDay <= 5) || (currDay === 6 || currDay === 0)) // Eine 6-Uhr-Schicht von Montag bis Freitag',
unistr('                currElement.css("background-color", "#6e9d3c"); // gr\00FCn'),
'            else if (count6 < 1 || (count6 > 1 && (currDay === 0 || currDay === 6))) // Weniger als eine 6-Uhr-Schicht oder mehr als eine 6-Uhr-Schicht am Wochenende',
'                currElement.css("background-color", "#ffaa00"); // orange',
'            break;',
'        case ''7'': ',
'            if (count7 >= 2 && (currDay >= 1 && currDay <= 5) || (currDay === 6 || currDay === 0)) // Zwei 7-Uhr-Schichten von Montag bis Freitag',
unistr('                currElement.css("background-color", "#6e9d3c"); // gr\00FCn'),
'            else ',
'            //if ((count7 !== 2 && count7 !== 0) || (count7 === 1 && (currDay === 0 || currDay === 6))) // Weniger oder mehr als zwei 7-Uhr-Schichten oder 7-Uhr-Schicht am Wochenende',
'                currElement.css("background-color", "#ffaa00"); // orange',
'            break;',
'        case ''9'': ',
'            if (count9 >= 0 && (currDay >= 1 && currDay <= 5) || (currDay === 6 || currDay === 0)) // 9-Uhr-Schichten sind freiwillig, also egal',
unistr('                currElement.css("background-color", "#6e9d3c"); // gr\00FCn'),
'            else if (count9 >= 1 && (currDay === 0 || currDay === 6)) // Weniger oder mehr als zwei 7-Uhr-Schichten oder 7-Uhr-Schicht am Wochenende',
'                currElement.css("background-color", "#ffaa00"); // orange',
'            break;',
'        case ''14'': ',
'            if (count14 >= 2 && (currDay >= 1 && currDay <= 5) || (currDay === 6 || currDay === 0)) // Zwei oder keine 14-Uhr-Schichten von Montag bis Freitag',
unistr('                currElement.css("background-color", "#6e9d3c"); // gr\00FCn'),
'            else if (count14 <= 2 || (count14 > 1 && (currDay === 0 || currDay === 6))) // Weniger oder mehr als zwei 14-Uhr-Schichten oder 14-Uhr-Schicht am Wochenende',
'                currElement.css("background-color", "#ffaa00"); // orange',
'            break;',
'        case ''22'': ',
'            if (count22 >= 1 && (currDay >= 1 && currDay <= 5) || (currDay === 6 || currDay === 0)) // Eine 22-Uhr-Schicht von Montag bis Freitag',
unistr('                currElement.css("background-color", "#6e9d3c"); // gr\00FCn'),
'            else ',
'                currElement.css("background-color", "#ffaa00"); // orange',
'            break;',
'        case ''1222'': ',
'            if (count22 >= 1 && (currDay === 5 || currDay === 6) || (currDay !== 6 || currDay !== 0)) // Eine 12ab22 am Freitag und Samstag',
unistr('                currElement.css("background-color", "#6e9d3c"); // gr\00FCn'),
'            else if (count12ab22 >= 1 && (currDay !== 5 || currDay !== 6)) // Mehr als eine 12ab22 oder nicht am Freitag und Samstag',
'                currElement.css("background-color", "#ffaa00"); // orange',
'            break;',
'        case ''1210'': ',
'            if (count12ab10 >= 1 && (currDay === 6 || currDay === 0) || (currDay !== 6 || currDay !== 0)) // Eine 12ab10 am Samstag und Sonntag',
unistr('                currElement.css("background-color", "#6e9d3c"); // gr\00FCn'),
'            else if (count12ab10 >= 1 && (currDay !== 6 || currDay !== 0)) // Mehr als eine 12ab10 oder nicht am Samstag und Sonntag',
'                currElement.css("background-color", "#ffaa00"); // orange',
'            break;',
'    }',
'    });',
'    }',
'});',
'get_comment_count();',
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
'    const firstColumnHeader = $(this).find(''td:first'').attr(''headers'');',
unistr('    if (firstColumnHeader !== ''MONAT'') { // Zeilen mit Header "MONAT" ausschlie\00DFen'),
'    const tdElements = $(this).find(''td'');',
'',
'    tdElements.each(function(i) {',
'      const currElement = $(this);',
'      if (currElement.attr(''headers'') === ''KOMMENTAR'') {',
'        const rowDatum = $(this).closest(''tr'').find(''td:first'').text().split(''-'')[0].trim();',
'        // AJAX-Prozess aufrufen',
'        const parmObj = {',
'          x01: rowDatum',
'        };',
'',
'        apex.server.process(''get_comment_count'', parmObj, {',
'          success: function(data) {',
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
'    }',
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
'      eval(dialogUrl);',
'    },',
'    error: function(xhr, textStatus, errorThrown) {',
'      console.log(''AJAX error:'', errorThrown);',
'    }',
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
'        apex.server.process(''get_monat_ma_sum_h'', parmObj, {',
'           // refreshObject: ''#report_table_cr_sp_matrix'',',
'            success: function(data) {',
'                if (data.success) {',
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
'                    einfaerben_copied_row();',
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
'                    einfaerben_copied_row();',
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
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.btn-save {',
'  height: 47px; /* change the height value as needed */',
'  vertical-align: middle; /* align the button with the adjacent element */',
'  padding-top: 10px; /* add some padding to the top of the button for better alignment */',
'}',
'',
'.center-content {',
'  display: flex;',
'  justify-content: center;',
'  align-items: center;',
unistr('  height: 100%; /* oder setzen Sie eine spezifische H\00F6he */'),
'}',
'',
'.distribute-evenly {',
'  display: flex;',
'  justify-content: space-between;',
'}',
'',
''))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'18'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20240419151445'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(109888311019054592)
,p_plug_name=>'centered'
,p_region_css_classes=>'center-content'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98846167001580472)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(131617792446390951)
,p_plug_name=>' Filter'
,p_parent_plug_id=>wwv_flow_imp.id(109888311019054592)
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(98856303378580475)
,p_plug_display_sequence=>20
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(131621982930390993)
,p_name=>'schichtplanung_matrix'
,p_region_name=>'cr_sp_matrix'
,p_parent_plug_id=>wwv_flow_imp.id(131617792446390951)
,p_template=>wwv_flow_imp.id(98852972977580474)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--stacked:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_function_body_language=>'PLSQL'
,p_source=>'return planung_schichten_matrix_pkg.get_polymorphic_sql(:P30_MONAT);'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P30_MONAT'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(98830315685580465)
,p_plug_query_max_columns=>28
,p_query_headings=>'return planung_schichten_matrix_pkg.get_polymorphic_headings(:P30_MONAT);'
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>50
,p_query_options=>'GENERIC_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(131621024102390984)
,p_query_column_id=>1
,p_column_alias=>'COL01'
,p_column_display_sequence=>10
,p_column_heading=>'Col01'
,p_use_as_row_header=>'N'
,p_report_column_width=>100
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(131620910458390983)
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
 p_id=>wwv_flow_imp.id(131620816271390982)
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
 p_id=>wwv_flow_imp.id(131620780304390981)
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
 p_id=>wwv_flow_imp.id(131620612564390980)
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
 p_id=>wwv_flow_imp.id(131620580699390979)
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
 p_id=>wwv_flow_imp.id(131620501172390978)
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
 p_id=>wwv_flow_imp.id(131620337652390977)
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
 p_id=>wwv_flow_imp.id(131620294919390976)
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
 p_id=>wwv_flow_imp.id(131620170605390975)
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
 p_id=>wwv_flow_imp.id(131620012474390974)
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
 p_id=>wwv_flow_imp.id(131619998945390973)
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
 p_id=>wwv_flow_imp.id(131619806619390972)
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
 p_id=>wwv_flow_imp.id(131619759605390971)
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
 p_id=>wwv_flow_imp.id(131619649339390970)
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
 p_id=>wwv_flow_imp.id(131619518745390969)
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
 p_id=>wwv_flow_imp.id(131619454775390968)
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
 p_id=>wwv_flow_imp.id(131619313923390967)
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
 p_id=>wwv_flow_imp.id(131619270046390966)
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
 p_id=>wwv_flow_imp.id(118456578390285544)
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
 p_id=>wwv_flow_imp.id(116947397095009087)
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
 p_id=>wwv_flow_imp.id(116947222169009086)
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
 p_id=>wwv_flow_imp.id(116947174754009085)
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
 p_id=>wwv_flow_imp.id(116947061264009084)
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
 p_id=>wwv_flow_imp.id(116946942011009083)
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
 p_id=>wwv_flow_imp.id(116946887375009082)
,p_query_column_id=>26
,p_column_alias=>'COL26'
,p_column_display_sequence=>310
,p_column_heading=>'Col26'
,p_use_as_row_header=>'N'
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
 p_id=>wwv_flow_imp.id(116946747532009081)
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
 p_id=>wwv_flow_imp.id(116946667201009080)
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
 p_id=>wwv_flow_imp.id(130866353276674887)
,p_name=>'monat_sum_h'
,p_region_name=>'cr_monat_sum_h'
,p_parent_plug_id=>wwv_flow_imp.id(131617792446390951)
,p_template=>wwv_flow_imp.id(98852972977580474)
,p_display_sequence=>60
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--stacked:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_function_body_language=>'PLSQL'
,p_source=>'return planung_sum_h_matrix_pkg.get_monat_sum_h_sql(:P30_MONAT);'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P30_MONAT'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(98830315685580465)
,p_plug_query_max_columns=>20
,p_query_headings=>'return planung_sum_h_matrix_pkg.get_polymorphic_headings_monat_sum_h(:P30_MONAT);'
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>15
,p_query_options=>'GENERIC_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(130864666738674870)
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
 p_id=>wwv_flow_imp.id(130864591866674869)
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
 p_id=>wwv_flow_imp.id(130864492830674868)
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
 p_id=>wwv_flow_imp.id(130864387268674867)
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
 p_id=>wwv_flow_imp.id(130864249080674866)
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
 p_id=>wwv_flow_imp.id(130864107224674865)
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
 p_id=>wwv_flow_imp.id(130864060767674864)
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
 p_id=>wwv_flow_imp.id(130863989941674863)
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
 p_id=>wwv_flow_imp.id(130863891876674862)
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
 p_id=>wwv_flow_imp.id(130863797591674861)
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
 p_id=>wwv_flow_imp.id(130863654345674860)
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
 p_id=>wwv_flow_imp.id(130863543473674859)
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
 p_id=>wwv_flow_imp.id(130863465931674858)
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
 p_id=>wwv_flow_imp.id(130863390868674857)
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
 p_id=>wwv_flow_imp.id(130863249407674856)
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
 p_id=>wwv_flow_imp.id(130863178077674855)
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
 p_id=>wwv_flow_imp.id(130863007217674854)
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
 p_id=>wwv_flow_imp.id(130862960996674853)
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
 p_id=>wwv_flow_imp.id(130862879735674852)
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
 p_id=>wwv_flow_imp.id(130862758937674851)
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
 p_id=>wwv_flow_imp.id(109888133654054590)
,p_plug_name=>'row container'
,p_parent_plug_id=>wwv_flow_imp.id(131617792446390951)
,p_region_css_classes=>'distribute-evenly'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noBorder'
,p_plug_template=>wwv_flow_imp.id(98882280679580484)
,p_plug_display_sequence=>20
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(121963492472866585)
,p_plug_name=>'Meldung vorhanden'
,p_region_name=>'meldung_vorhanden'
,p_parent_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning:t-Alert--accessibleHeading:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(98889027425580487)
,p_plug_display_sequence=>130
,p_plug_new_grid_row=>false
,p_plug_source=>'Mindestens eine Meldung vorhanden.'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT *',
'FROM meldungen_mitarbeiter_v',
'WHERE to_char(DATUM, ''MON YYYY'') = :P30_MONAT;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(121961563744866566)
,p_plug_name=>'Monat archiviert'
,p_region_name=>'meldung_archiviert'
,p_parent_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--danger:t-Alert--accessibleHeading:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(98889027425580487)
,p_plug_display_sequence=>120
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_source=>'Dieser Monat ist bereits archiviert.'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--pruefen ob monat status archiviert',
'SELECT *',
'FROM monat_planung',
'WHERE monat_jahr = :P30_MONAT',
'and status_id = 4'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15480608926035512)
,p_plug_name=>'Monat geplant'
,p_region_name=>'meldung_geplant'
,p_parent_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning:t-Alert--accessibleHeading:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(98889027425580487)
,p_plug_display_sequence=>110
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_source=>'Dieser Monat ist bereits geplant.'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--pruefen ob monat status geplant',
'SELECT *',
'FROM monat_planung',
'WHERE monat_jahr = :P30_MONAT',
'and status_id = 3'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15492803090337350)
,p_plug_name=>'freie Planung'
,p_region_name=>'meldung_frei'
,p_parent_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--info:t-Alert--accessibleHeading:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(98889027425580487)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>2
,p_plug_source=>'Dieser Monat befindet sich in der freien Planung.'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--pruefen ob monat status freie planung',
'SELECT *',
'FROM monat_planung',
'WHERE monat_jahr = :P30_MONAT',
'and status_id = 1'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(21320870233063471)
,p_plug_name=>'meldungen_mitarbeiter'
,p_parent_plug_id=>wwv_flow_imp.id(131617792446390951)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:margin-top-md'
,p_plug_template=>wwv_flow_imp.id(98884152106580485)
,p_plug_display_sequence=>50
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT MITARBEITER_ID,',
'       DATUM,',
'       BESCHREIBUNG,',
'       CASE',
'       WHEN kategorie = ''WAR'' THEN ''<i class="fa fa-exclamation-triangle-o"></i>''',
'       ELSE ''<i class="fa fa-info-o"></i>''',
'       END AS KATEGORIE',
'  FROM MELDUNGEN_MITARBEITER_V',
'  WHERE to_char(DATUM, ''MON YYYY'') = :P30_MONAT',
'  '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P30_MONAT'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'meldungen_mitarbeiter'
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
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(21321775426063480)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Keine Meldungen vorhanden'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_enable_mail_download=>'Y'
,p_owner=>'SEM'
,p_internal_uid=>284589778483044474
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(119099452536434648)
,p_db_column_name=>'KATEGORIE'
,p_display_order=>10
,p_column_identifier=>'D'
,p_column_label=>'Kategorie'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(119100632445434650)
,p_db_column_name=>'MITARBEITER_ID'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'MA'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(119100230952434649)
,p_db_column_name=>'DATUM'
,p_display_order=>40
,p_column_identifier=>'B'
,p_column_label=>'Datum'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(119099831951434648)
,p_db_column_name=>'BESCHREIBUNG'
,p_display_order=>50
,p_column_identifier=>'C'
,p_column_label=>'Beschreibung'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(22131240832604105)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1412322'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'KATEGORIE:MITARBEITER_ID:DATUM:BESCHREIBUNG:'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(30230077721081654)
,p_plug_name=>'Schichtplanung'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useRegionTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98877814156580483)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(98915417889580516)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(98791364244580444)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(99080105646343958)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_button_name=>'dec_monat'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_imp.id(98793446976580446)
,p_button_image_alt=>'-'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'btn-save'
,p_icon_css_classes=>'fa-minus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(99079809483341356)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_button_name=>'inc_monat'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_imp.id(98793446976580446)
,p_button_image_alt=>'+'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'btn-save'
,p_icon_css_classes=>'fa-plus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(131617494133390948)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_button_name=>'GenerateEmptyRows'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'Zeilen generieren'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_button_css_classes=>'btn-save'
,p_icon_css_classes=>'fa-table-plus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(115749917467113749)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_button_name=>'VORGABE_CODES'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'Vorgabe Codes'
,p_button_redirect_url=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.:50::'
,p_button_css_classes=>'btn-save'
,p_icon_css_classes=>'fa-list'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(131618485586390958)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_button_name=>'SaveMatrix'
,p_button_static_id=>'saveMatrix'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconLeft:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'btn-save'
,p_icon_css_classes=>'fa-save'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(127144286308831365)
,p_name=>'P30_MONAT_STATUS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(131617792446390951)
,p_source=>'return utility_pkg.get_status(:P30_MONAT);'
,p_source_type=>'FUNCTION_BODY'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112328783804561513)
,p_name=>'P30_EDIT_MONAT_STATUS'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Status bearbeiten'
,p_source=>'return utility_pkg.get_status(:P30_MONAT);'
,p_source_type=>'FUNCTION_BODY'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'MONAT_STATUS'
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(98795537782580449)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(99081297603353255)
,p_name=>'P30_MONAT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(109888133654054590)
,p_prompt=>'Monat'
,p_placeholder=>'Mon Jahr'
,p_source=>'SELECT TO_CHAR(SYSDATE, ''MON YYYY'') FROM DUAL;'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_named_lov=>'MONAT JAHR ALL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select monat_jahr d, monat_jahr r',
'from monat_planung',
'order by TO_DATE(monat_jahr, ''MON YYYY'')',
''))
,p_cSize=>30
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(98795537782580449)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(96698257719484661)
,p_name=>'onTextfieldChange'
,p_event_sequence=>80
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'input[type="text"]'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#cr_sp_matrix'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(96697752740484660)
,p_event_id=>wwv_flow_imp.id(96698257719484661)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(131621982930390993)
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
'setTimeout(() => {',
'    faerbe_zellen_ein_matrix();',
'    //get_values_copied_row();',
'}, 10);'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(96700505955484662)
,p_name=>'setFarbenPageLoad'
,p_event_sequence=>100
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(131618339211390957)
,p_event_id=>wwv_flow_imp.id(96700505955484662)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'faerbe_zellen_ein_matrix();',
'copyLastRowToMatrix();',
'get_values_copied_row();',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(131618274737390956)
,p_name=>'onBtnSaveClicked'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(131618485586390958)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(131618129396390955)
,p_event_id=>wwv_flow_imp.id(131618274737390956)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'saveMatrixMitarbeiter();',
'get_values_copied_row();'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(121963355752866584)
,p_event_id=>wwv_flow_imp.id(131618274737390956)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
' FOR r_row IN (SELECT ma.mitarbeiter_id FROM mitarbeiter ma WHERE ma.service_team_id = 1 AND ma.aktiv = ''Y'' AND ma.rolle_id = ''MA'')',
'    LOOP',
'    constraints_pkg.pruefe_constraints_ma(r_row.mitarbeiter_id,TO_DATE(:P30_MONAT, ''MON YYYY''));',
'    END LOOP;',
'END;',
'',
'',
''))
,p_attribute_02=>'P30_MONAT'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(121962685556866577)
,p_event_id=>wwv_flow_imp.id(131618274737390956)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(21320870233063471)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(121960736337866558)
,p_event_id=>wwv_flow_imp.id(131618274737390956)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(121963492472866585)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(131617212995390946)
,p_name=>'onGenerateRowsClicked'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(131617494133390948)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(131617170092390945)
,p_event_id=>wwv_flow_imp.id(131617212995390946)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
' datum_bis date;',
'begin',
' datum_bis := ADD_MONTHS(TO_DATE(:P30_MONAT, ''MON YYYY''), 1) - 1 + 31; ',
' utility_pkg.generate_dates_for_ma(datum_bis);',
'END;'))
,p_attribute_02=>'P30_MONAT'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(131617030352390944)
,p_event_id=>wwv_flow_imp.id(131617212995390946)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(131621982930390993)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(130866893064674892)
,p_name=>'onMonthSelected'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P30_MONTH'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(112327794443561503)
,p_event_id=>wwv_flow_imp.id(130866893064674892)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(115749807133113748)
,p_name=>'onMatrixAfterRefresh'
,p_event_sequence=>140
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(131621982930390993)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(121960853073866559)
,p_event_id=>wwv_flow_imp.id(115749807133113748)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(21320870233063471)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(109887166317054580)
,p_event_id=>wwv_flow_imp.id(115749807133113748)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_count NUMBER;',
'BEGIN',
'    SELECT COUNT(*)',
'    INTO l_count',
'    FROM meldungen_mitarbeiter_v',
'    WHERE to_char(DATUM, ''MON YYYY'') = :P30_MONAT;',
'    ',
'    IF l_count > 0 THEN',
'        apex_util.set_session_state(''P30_DISPLAY_MELDUNG'', ''SHOW'');',
'    ELSE',
'        apex_util.set_session_state(''P30_DISPLAY_MELDUNG'', ''HIDE'');',
'    END IF;',
'END;',
''))
,p_attribute_02=>'P30_MONAT'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(109886966479054578)
,p_event_id=>wwv_flow_imp.id(115749807133113748)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var displayValue = apex.item(''P30_DISPLAY_MELDUNG'').getValue();',
'console.log(displayValue);',
'if (displayValue === ''SHOW'') {',
'    $(''#meldung_vorhanden'').show();',
'}',
'if (displayValue === ''HIDE'') {',
'  $(''#meldung_vorhanden'').hide();',
'} ',
'',
'',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(109888420482054593)
,p_event_id=>wwv_flow_imp.id(115749807133113748)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'faerbe_zellen_ein_matrix();',
'copyLastRowToMatrix();',
'get_values_copied_row();'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(130862521101674849)
,p_name=>'navigateKeys'
,p_event_sequence=>150
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'input'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'keydown'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(130862447066674848)
,p_event_id=>wwv_flow_imp.id(130862521101674849)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'TRIGGERING_ELEMENT'
,p_attribute_01=>'navigate(event);'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(100192831840627753)
,p_name=>'onStatusSelected'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P30_EDIT_MONAT_STATUS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(100192645530627751)
,p_event_id=>wwv_flow_imp.id(100192831840627753)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'   status_id number; ',
'BEGIN',
'',
'   UPDATE monat_planung',
'   SET status_id = :P30_EDIT_MONAT_STATUS',
'   WHERE monat_jahr = :P30_MONAT; ',
'',
'   COMMIT; ',
'EXCEPTION',
'   WHEN OTHERS THEN',
'      ROLLBACK; ',
'      DBMS_OUTPUT.PUT_LINE(''Fehler: '' || SQLERRM);',
'END;',
''))
,p_attribute_02=>'P30_EDIT_MONAT_STATUS,P30_MONAT'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(100192765386627752)
,p_event_id=>wwv_flow_imp.id(100192831840627753)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(99081017170347392)
,p_name=>'onMonatChange'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P30_MONAT'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'focusout'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(99080604227347380)
,p_event_id=>wwv_flow_imp.id(99081017170347392)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
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
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(99294196302398473)
,p_name=>'inc_monat'
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(99079809483341356)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(99293804095398470)
,p_event_id=>wwv_flow_imp.id(99294196302398473)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN ',
':P30_MONAT := TO_CHAR(ADD_MONTHS(TO_DATE(:P30_MONAT, ''MON YYYY''), 1), ''MON YYYY'');',
'END;'))
,p_attribute_02=>'P30_MONAT'
,p_attribute_03=>'P30_MONAT'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(99293629228398468)
,p_event_id=>wwv_flow_imp.id(99294196302398473)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(99293944173398471)
,p_name=>'dec_monat'
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(99080105646343958)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(99294034225398472)
,p_event_id=>wwv_flow_imp.id(99293944173398471)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN ',
':P30_MONAT := TO_CHAR(ADD_MONTHS(TO_DATE(:P30_MONAT, ''MON YYYY''), -1), ''MON YYYY'');',
'END;'))
,p_attribute_02=>'P30_MONAT'
,p_attribute_03=>'P30_MONAT'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(99293719351398469)
,p_event_id=>wwv_flow_imp.id(99293944173398471)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp.component_end;
end;
/
