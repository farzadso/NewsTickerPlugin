set define off
set verify off
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end;
/
 
--       AAAA       PPPPP   EEEEEE  XX      XX
--      AA  AA      PP  PP  EE       XX    XX
--     AA    AA     PP  PP  EE        XX  XX
--    AAAAAAAAAA    PPPPP   EEEE       XXXX
--   AA        AA   PP      EE        XX  XX
--  AA          AA  PP      EE       XX    XX
--  AA          AA  PP      EEEEEE  XX      XX
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Oracle user APEX_040200 or as the owner (parsing schema) of the application.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,2590603961614917));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin 

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'en'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2012.01.01');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_flow_id := nvl(wwv_flow_application_install.get_application_id,565);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
null;
 
end;
/

prompt  ...ui types
--
 
begin
 
null;
 
end;
/

prompt  ...plugins
--
--application/shared_components/plugins/item_type/com_jafr_news_ticker
 
begin
 
wwv_flow_api.create_plugin (
  p_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_type => 'ITEM TYPE'
 ,p_name => 'COM.JAFR.NEWS.TICKER'
 ,p_display_name => 'News Ticker 1.0'
 ,p_supported_ui_types => 'DESKTOP'
 ,p_image_prefix => '#PLUGIN_PREFIX#'
 ,p_plsql_code => 
'FUNCTION f_render_news_ticker ('||unistr('\000a')||
'    p_item                IN apex_plugin.t_page_item,'||unistr('\000a')||
'    p_plugin              IN apex_plugin.t_plugin,'||unistr('\000a')||
'    p_value               IN VARCHAR2,'||unistr('\000a')||
'    p_is_readonly         IN BOOLEAN,'||unistr('\000a')||
'    p_is_printer_friendly IN BOOLEAN )'||unistr('\000a')||
'    RETURN apex_plugin.t_page_item_render_result '||unistr('\000a')||
'    '||unistr('\000a')||
'  AS  '||unistr('\000a')||
'    -- APEX information'||unistr('\000a')||
'    v_app_id    apex_applications.application_id%TYPE := v(''A'||
'PP_ID'');'||unistr('\000a')||
'    v_page_id   apex_application_pages.page_id%TYPE := v(''APP_PAGE_ID'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    -- Main plug-in variables'||unistr('\000a')||
'    v_result    apex_plugin.t_page_item_render_result; -- Result object to be returned'||unistr('\000a')||
'    v_page_item_name    VARCHAR2(100);  -- Item name (different from ID)'||unistr('\000a')||
'    v_html  VARCHAR2(4000); -- Used for temp HTML'||unistr('\000a')||
'    v_css   VARCHAR2(4000); -- Used for CSS'||unistr('\000a')||
'    v_settings  VARCHAR2(4000'||
'); --Used for plugin settings'||unistr('\000a')||
'    '||unistr('\000a')||
'    -- Application Plugin Attributes'||unistr('\000a')||
'    '||unistr('\000a')||
'    '||unistr('\000a')||
'    -- Item Plugin Attributes'||unistr('\000a')||
'    v_title apex_application_page_items.attribute_01%type := p_item.attribute_01; -- The title of the Unordered List <ul>'||unistr('\000a')||
'    v_list_item_1  apex_application_page_items.attribute_02%type := p_item.attribute_02; -- List Item 1 <li>'||unistr('\000a')||
'    v_list_item_2  apex_application_page_items.attribute_'||
'03%type := p_item.attribute_03; -- List Item 2 <li>'||unistr('\000a')||
'    v_list_item_3  apex_application_page_items.attribute_04%type := p_item.attribute_04; -- List Item 3 <li>'||unistr('\000a')||
'    v_random    apex_application_page_items.attribute_05%type := p_item.attribute_05; --Whether to display the items in a random order or not'||unistr('\000a')||
'    v_itemSpeed    apex_application_page_items.attribute_06%type := p_item.attribute_06; -- Delay'||
' between displaying list items'||unistr('\000a')||
'    v_cursorSpeed   apex_application_page_items.attribute_07%type := p_item.attribute_07; -- Cursor speed for displaying characters'||unistr('\000a')||
'    v_pauseOnHover  apex_application_page_items.attribute_08%type := p_item.attribute_08; -- Pause on Hover'||unistr('\000a')||
'    v_fade  apex_application_page_items.attribute_09%type := p_item.attribute_09; -- Fade Effect'||unistr('\000a')||
'    v_fontSize  apex_application'||
'_page_items.attribute_10%type := p_item.attribute_10; -- Font Size'||unistr('\000a')||
'    v_color    apex_application_page_items.attribute_11%type := p_item.attribute_11; -- List Items Colour'||unistr('\000a')||
''||unistr('\000a')||
'    -- Other variables'||unistr('\000a')||
'    '||unistr('\000a')||
'  BEGIN'||unistr('\000a')||
'    -- Debug information (if app is being run in debug mode)'||unistr('\000a')||
'    IF apex_application.g_debug THEN'||unistr('\000a')||
'      apex_plugin_util.debug_page_item (p_plugin                => p_plugin,'||unistr('\000a')||
'               '||
'                         p_page_item             => p_item,'||unistr('\000a')||
'                                        p_value                 => p_value,'||unistr('\000a')||
'                                        p_is_readonly           => p_is_readonly,'||unistr('\000a')||
'                                        p_is_printer_friendly   => p_is_printer_friendly);'||unistr('\000a')||
'    END IF;'||unistr('\000a')||
'    '||unistr('\000a')||
'    -- handle read only and printer friendly'||unistr('\000a')||
'    IF p_is_readonly OR p_is_'||
'printer_friendly THEN'||unistr('\000a')||
'      -- omit hidden field if necessary'||unistr('\000a')||
'      apex_plugin_util.print_hidden_if_readonly (p_item_name             => p_item.name,'||unistr('\000a')||
'                                                 p_value                 => p_value,'||unistr('\000a')||
'                                                 p_is_readonly           => p_is_readonly,'||unistr('\000a')||
'                                                 p_is_printer_friendly   '||
'=> p_is_printer_friendly);'||unistr('\000a')||
'      -- omit display span with the value'||unistr('\000a')||
'      apex_plugin_util.print_display_only (p_item_name          => p_item.NAME,'||unistr('\000a')||
'                                           p_display_value      => p_value,'||unistr('\000a')||
'                                           p_show_line_breaks   => FALSE,'||unistr('\000a')||
'                                           p_escape             => TRUE, -- this is recommended to he'||
'lp prevent XSS'||unistr('\000a')||
'                                           p_attributes         => p_item.element_attributes);'||unistr('\000a')||
'    ELSE'||unistr('\000a')||
'      -- Not read only'||unistr('\000a')||
'      -- Get name. Used in the "name" form element attribute which is different than the "id" attribute '||unistr('\000a')||
'      v_page_item_name := apex_plugin.get_input_name_for_page_item (p_is_multi_value => FALSE);'||unistr('\000a')||
'      '||unistr('\000a')||
'      -- SET VALUES'||unistr('\000a')||
''||unistr('\000a')||
'      '||unistr('\000a')||
'      -- OUTPUT'||unistr('\000a')||
'      '||
''||unistr('\000a')||
'      '||unistr('\000a')||
''||unistr('\000a')||
'      -- Print News Ticker'||unistr('\000a')||
'      '||unistr('\000a')||
'      -- Different List Item Variations'||unistr('\000a')||
'      IF v_list_item_2 IS NULL AND v_list_item_3 IS NULL THEN'||unistr('\000a')||
'      v_html := ''<div class="%ID%">'||unistr('\000a')||
'                    <strong>%TITLE%: </strong>'||unistr('\000a')||
'                        <ul>'||unistr('\000a')||
'                            <li>%LIST_ITEM1%</li>'||unistr('\000a')||
'                        </ul>'||unistr('\000a')||
'                 </div>'';'||unistr('\000a')||
'      v_html := REPLACE(v_html, ''%LIS'||
'T_ITEM1%'', sys.htf.escape_sc(v_list_item_1));'||unistr('\000a')||
'      END IF;'||unistr('\000a')||
'      '||unistr('\000a')||
'      IF v_list_item_3 IS NULL THEN'||unistr('\000a')||
'      v_html := ''<div class="%ID%">'||unistr('\000a')||
'                    <strong>%TITLE%: </strong>'||unistr('\000a')||
'                        <ul>'||unistr('\000a')||
'                            <li>%LIST_ITEM1%</li>'||unistr('\000a')||
'                            <li>%LIST_ITEM2%</li>'||unistr('\000a')||
'                        </ul>'||unistr('\000a')||
'                 </div>''; '||unistr('\000a')||
'      v_html := REPLACE(v_ht'||
'ml, ''%LIST_ITEM1%'', sys.htf.escape_sc(v_list_item_1));'||unistr('\000a')||
'      v_html := REPLACE(v_html, ''%LIST_ITEM2%'', sys.htf.escape_sc(v_list_item_2));'||unistr('\000a')||
'      END IF;'||unistr('\000a')||
'      '||unistr('\000a')||
'      IF v_list_item_2 IS NOT NULL AND v_list_item_3 IS NOT NULL THEN '||unistr('\000a')||
'      v_html := ''<div class="%ID%">'||unistr('\000a')||
'                    <strong>%TITLE%: </strong>'||unistr('\000a')||
'                        <ul>'||unistr('\000a')||
'                            <li>%LIST_ITEM1%</li>'||unistr('\000a')||
'        '||
'                    <li>%LIST_ITEM2%</li>'||unistr('\000a')||
'                            <li>%LIST_ITEM3%</li>'||unistr('\000a')||
'                        </ul>'||unistr('\000a')||
'                 </div>''; '||unistr('\000a')||
'      v_html := REPLACE(v_html, ''%LIST_ITEM1%'', sys.htf.escape_sc(v_list_item_1));'||unistr('\000a')||
'      v_html := REPLACE(v_html, ''%LIST_ITEM2%'', sys.htf.escape_sc(v_list_item_2));'||unistr('\000a')||
'      v_html := REPLACE(v_html, ''%LIST_ITEM3%'', sys.htf.escape_sc(v_list_item_3));'||unistr('\000a')||
'  '||
'    END IF;'||unistr('\000a')||
'      -- Set the title and HTML Class'||unistr('\000a')||
'      v_html := REPLACE(v_html, ''%ID%'', p_item.name);'||unistr('\000a')||
'      v_html := REPLACE(v_html, ''%TITLE%'', sys.htf.escape_sc(v_title));'||unistr('\000a')||
'   '||unistr('\000a')||
'     '||unistr('\000a')||
'      --Setting the Style Sheet'||unistr('\000a')||
'      v_css  := ''<style>.%ID% {'||unistr('\000a')||
'      width: 1000px;'||unistr('\000a')||
'      margin: 10px auto;'||unistr('\000a')||
'      font-size: %fontSize%;'||unistr('\000a')||
'      color: %color%;'||unistr('\000a')||
'      }'||unistr('\000a')||
'           '||unistr('\000a')||
'      .%ID% div {'||unistr('\000a')||
'      display: '||
'inline-block;'||unistr('\000a')||
'      word-wrap: break-word;'||unistr('\000a')||
'      }</style>'';'||unistr('\000a')||
'          '||unistr('\000a')||
'      v_css := REPLACE(v_css, ''%ID%'', p_item.name);'||unistr('\000a')||
'      v_css := REPLACE(v_css, ''%fontSize%'', v_fontSize);'||unistr('\000a')||
'      v_css := REPLACE(v_css, ''%color%'', v_color);'||unistr('\000a')||
'      '||unistr('\000a')||
'      --The actual printing itself'||unistr('\000a')||
'      sys.htp.p(v_css);'||unistr('\000a')||
'      sys.htp.p(v_html);'||unistr('\000a')||
'       '||unistr('\000a')||
''||unistr('\000a')||
'      -- JAVASCRIPT'||unistr('\000a')||
''||unistr('\000a')||
'      -- Load javascript Libraries'||unistr('\000a')||
'      apex_j'||
'avascript.add_library (p_name => ''jquery.ticker'', p_directory => p_plugin.file_prefix, p_version => null); -- Load jquery.ticker.js'||unistr('\000a')||
'          '||unistr('\000a')||
'      -- Initialize the News Ticker'||unistr('\000a')||
'     '||unistr('\000a')||
'      --Set Settings'||unistr('\000a')||
'      IF v_fade IS NULL THEN'||unistr('\000a')||
'          v_fade := ''true'';'||unistr('\000a')||
'      END IF;'||unistr('\000a')||
'      IF v_pauseOnHover IS NULL THEN'||unistr('\000a')||
'          v_pauseOnHover := ''true'';'||unistr('\000a')||
'      END IF;'||unistr('\000a')||
'      v_settings := ''$.fn.ticker.def'||
'aults = {'||unistr('\000a')||
'                    random:        %RANDOM%, // Whether to display ticker items in a random order'||unistr('\000a')||
'                    itemSpeed:     %itemSpeed%000,  // The pause on each ticker item before being replaced (miliseconds)'||unistr('\000a')||
'                    cursorSpeed:   %cursorSpeed%,    // Speed at which the characters are typed'||unistr('\000a')||
'                    pauseOnHover:  %pauseOnHover%,  // Whether to pause whe'||
'n the mouse hovers over the ticker'||unistr('\000a')||
'                    finishOnHover: false,  // Whether or not to complete the ticker item instantly when moused over'||unistr('\000a')||
'                    cursorOne:     "_",   // The symbol for the first part of the cursor'||unistr('\000a')||
'                    cursorTwo:     "-",   // The symbol for the second part of the cursor'||unistr('\000a')||
'                    fade:          %fade%,  // Whether to fade between'||
' ticker items or not'||unistr('\000a')||
'                    fadeInSpeed:   600,   // Speed of the fade-in animation'||unistr('\000a')||
'                    fadeOutSpeed:  300    // Speed of the fade-out animation'||unistr('\000a')||
'                };'';'||unistr('\000a')||
'      v_settings := REPLACE(v_settings, ''%RANDOM%'', v_random);'||unistr('\000a')||
'      v_settings := REPLACE(v_settings, ''%itemSpeed%'', v_itemSpeed);'||unistr('\000a')||
'      v_settings := REPLACE(v_settings, ''%cursorSpeed%'', v_cursorSpeed);'||unistr('\000a')||
''||
'      v_settings := REPLACE(v_settings, ''%pauseOnHover%'', v_pauseOnHover);'||unistr('\000a')||
'      v_settings := REPLACE(v_settings, ''%fade%'', v_fade);'||unistr('\000a')||
'      apex_javascript.add_onload_code (p_code => v_settings);'||unistr('\000a')||
'      '||unistr('\000a')||
'      -- Start the ticker'||unistr('\000a')||
'      v_html := ''$(".%ID%").ticker();'';'||unistr('\000a')||
'      v_html := REPLACE(v_html, ''%ID%'', p_item.name);'||unistr('\000a')||
'      apex_javascript.add_onload_code (p_code => v_html);'||unistr('\000a')||
'      '||unistr('\000a')||
'      -- Tel'||
'l apex that this field is navigable'||unistr('\000a')||
'      v_result.is_navigable := FALSE;'||unistr('\000a')||
''||unistr('\000a')||
'    END IF; -- f_render_from_to_datepicker'||unistr('\000a')||
'    '||unistr('\000a')||
'    RETURN v_result;'||unistr('\000a')||
'  END f_render_news_ticker;'||unistr('\000a')||
'  '
 ,p_render_function => 'f_render_news_ticker'
 ,p_substitute_attributes => true
 ,p_subscribe_plugin_settings => true
 ,p_help_text => '<div>'||unistr('\000a')||
'	jQuery Ticker</div>'||unistr('\000a')||
'<div>'||unistr('\000a')||
'	&nbsp;</div>'||unistr('\000a')||
'<div>'||unistr('\000a')||
'	A lightweight jQuery plugin for animating a simple news ticker</div>'||unistr('\000a')||
'<div>'||unistr('\000a')||
'	&nbsp;</div>'||unistr('\000a')||
'<div>'||unistr('\000a')||
'	Thanks to BenjaminRH for the jQuery Code</div>'||unistr('\000a')||
'<div>'||unistr('\000a')||
'	&nbsp;</div>'||unistr('\000a')||
'<div>'||unistr('\000a')||
'	JAFR - www.jafr.co</div>'||unistr('\000a')||
''
 ,p_version_identifier => '1.0'
 ,p_about_url => 'http://www.jafr.co'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278254825176473259 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 1
 ,p_display_sequence => 10
 ,p_prompt => 'Title'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => true
 ,p_default_value => 'Title'
 ,p_is_translatable => false
 ,p_help_text => 'The title of the News Ticker.'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278255621726474766 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 2
 ,p_display_sequence => 20
 ,p_prompt => 'List Item 1'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => true
 ,p_is_translatable => false
 ,p_help_text => 'Content of the first news item - Necessary'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278256117628476730 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 3
 ,p_display_sequence => 30
 ,p_prompt => 'List Item 2'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => false
 ,p_is_translatable => false
 ,p_help_text => 'Content of the second news item - Optional'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278257510727479947 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 4
 ,p_display_sequence => 40
 ,p_prompt => 'List Item 3'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => false
 ,p_is_translatable => false
 ,p_help_text => 'Content of the third news item - Optional'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278257907277481502 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 5
 ,p_display_sequence => 50
 ,p_prompt => 'Random'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => false
 ,p_default_value => 'false'
 ,p_is_translatable => false
 ,p_help_text => 'Whether to display ticker items in a random order or not'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278258305983482110 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278257907277481502 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Yes'
 ,p_return_value => 'true'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278258704689482726 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278257907277481502 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'No'
 ,p_return_value => 'false'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278261626674487678 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 6
 ,p_display_sequence => 60
 ,p_prompt => 'Switch Speed'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => false
 ,p_default_value => '3'
 ,p_is_translatable => false
 ,p_help_text => 'The pause on each ticker item before being replaced (seconds)'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278261924733488565 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278261626674487678 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => '1'
 ,p_return_value => '1'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278262423870488990 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278261626674487678 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => '2'
 ,p_return_value => '2'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278262823007489411 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278261626674487678 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 30
 ,p_display_value => '3'
 ,p_return_value => '3'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278263222145489786 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278261626674487678 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 40
 ,p_display_value => '5'
 ,p_return_value => '5'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278263721282490257 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278261626674487678 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 50
 ,p_display_value => '10'
 ,p_return_value => '10'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278264120204490682 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278261626674487678 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 60
 ,p_display_value => '20'
 ,p_return_value => '20'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278264819341491142 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278261626674487678 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 70
 ,p_display_value => '30'
 ,p_return_value => '30'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278266608774496027 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 7
 ,p_display_sequence => 70
 ,p_prompt => 'Cursor Speed'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => false
 ,p_default_value => '50'
 ,p_is_translatable => false
 ,p_help_text => 'Speed at which the characters are typed'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278267007480496638 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278266608774496027 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Very Slow'
 ,p_return_value => '200'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278267506186497177 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278266608774496027 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Slow'
 ,p_return_value => '100'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278267904676497922 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278266608774496027 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 30
 ,p_display_value => 'Normal'
 ,p_return_value => '50'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278268503167498585 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278266608774496027 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 40
 ,p_display_value => 'Fast'
 ,p_return_value => '30'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278269202304499008 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278266608774496027 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 50
 ,p_display_value => 'Very Fast'
 ,p_return_value => '10'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278270028171502167 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 8
 ,p_display_sequence => 80
 ,p_prompt => 'Pause On Hover'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => false
 ,p_is_translatable => false
 ,p_help_text => 'Whether to pause when the mouse hovers over the ticker'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278270426230503064 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278270028171502167 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Yes'
 ,p_return_value => 'true'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278270924073504119 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278270028171502167 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'No'
 ,p_return_value => 'false'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278271617603507081 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 9
 ,p_display_sequence => 90
 ,p_prompt => 'Fade'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => false
 ,p_is_translatable => false
 ,p_help_text => 'Whether to fade between ticker items or not'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278271915231508242 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278271617603507081 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'No'
 ,p_return_value => 'false'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278272609624510824 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 10
 ,p_display_sequence => 100
 ,p_prompt => 'Font Size'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => false
 ,p_is_translatable => false
 ,p_help_text => 'Set Font Size'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278273008330511442 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278272609624510824 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Smallest'
 ,p_return_value => 'smallest'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278273407036512039 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278272609624510824 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Small'
 ,p_return_value => 'small'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278273904880513034 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278272609624510824 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 30
 ,p_display_value => 'Large'
 ,p_return_value => 'large'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278274402507514088 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278272609624510824 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 40
 ,p_display_value => 'X-Large'
 ,p_return_value => 'x-large'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278274800782514942 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278272609624510824 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 50
 ,p_display_value => 'XX-Large'
 ,p_return_value => '	xx-large'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 11
 ,p_display_sequence => 110
 ,p_prompt => 'Colour'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => false
 ,p_is_translatable => false
 ,p_help_text => 'Set Colour'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278276522983519777 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Aqua'
 ,p_return_value => 'aqua'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278277221689520381 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Aquamarine'
 ,p_return_value => 'aquamarine'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278277819963521234 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 30
 ,p_display_value => 'Blisque'
 ,p_return_value => 'blisque'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278278418669521849 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 40
 ,p_display_value => 'Blue'
 ,p_return_value => 'blue'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278278817375522380 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 50
 ,p_display_value => 'Blue (Violet)'
 ,p_return_value => 'blueviolet'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278279216081522969 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 60
 ,p_display_value => 'Blue (Cadet)'
 ,p_return_value => 'cadetblue'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278279615003523506 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 70
 ,p_display_value => 'Blue (CornFlower)'
 ,p_return_value => 'cornflowerblue'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278280213925524036 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 80
 ,p_display_value => 'Blue (Dark)'
 ,p_return_value => 'darkblue'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278280812415524670 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 90
 ,p_display_value => 'Brown'
 ,p_return_value => 'brown'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278281710906525408 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 100
 ,p_display_value => 'Burlywood'
 ,p_return_value => 'burlywood'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278282209827525939 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 110
 ,p_display_value => 'Chartreuse'
 ,p_return_value => 'chartreuse'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278282608533526497 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 120
 ,p_display_value => 'Chocolate'
 ,p_return_value => 'chocolate'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278283003573528766 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 130
 ,p_display_value => 'Coral'
 ,p_return_value => 'coral'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278283402495529278 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 140
 ,p_display_value => 'Crimson'
 ,p_return_value => 'crimson'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278284001417529828 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 150
 ,p_display_value => 'Cyan'
 ,p_return_value => 'cyan'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278284500338530315 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 160
 ,p_display_value => 'Cyan (Dark)'
 ,p_return_value => 'darkcyan'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278285131812530874 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 170
 ,p_display_value => 'Deep Skyblue'
 ,p_return_value => 'deepskyblue'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278285530734531453 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 180
 ,p_display_value => 'Gold'
 ,p_return_value => 'gold'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278285929224532113 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 190
 ,p_display_value => 'Gray'
 ,p_return_value => 'gray'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278286327930532683 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 200
 ,p_display_value => 'Green'
 ,p_return_value => 'green'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278286726636533349 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 210
 ,p_display_value => 'Lime'
 ,p_return_value => 'lime'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278287224480534285 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 220
 ,p_display_value => 'Lime Green'
 ,p_return_value => 'limegreen'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278287623402534796 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 230
 ,p_display_value => 'Maroon'
 ,p_return_value => 'maroon'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278288022108535359 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 240
 ,p_display_value => 'Olive'
 ,p_return_value => 'olive'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278288421029535930 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 250
 ,p_display_value => 'Orange'
 ,p_return_value => 'orange'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278288919088536833 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 260
 ,p_display_value => 'Purple'
 ,p_return_value => 'purple'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278289317794537388 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 270
 ,p_display_value => 'Pink'
 ,p_return_value => 'pink'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278289916716537953 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 280
 ,p_display_value => 'Pink (Deep)'
 ,p_return_value => 'deeppink'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278290415206538603 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 290
 ,p_display_value => 'Pink (Hot)'
 ,p_return_value => 'hotpink'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278291013697539258 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 300
 ,p_display_value => 'Red'
 ,p_return_value => 'red'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 278291412619539815 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 278276224277519159 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 310
 ,p_display_value => 'Tomato'
 ,p_return_value => 'tomato'
  );
null;
 
end;
/

 
begin
 
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A210A202A206A5175657279205469636B657220506C7567696E2076312E322E310A202A2068747470733A2F2F6769746875622E636F6D2F42656E6A616D696E52482F6A71756572792D7469636B65720A202A0A202A20436F70797269676874203230';
wwv_flow_api.g_varchar2_table(2) := '31342042656E6A616D696E204861727269730A202A2052656C656173656420756E64657220746865204D4954206C6963656E73650A202A2F0A2866756E6374696F6E282429207B0A0A202020202F2F20546865207469636B657220706C7567696E0A2020';
wwv_flow_api.g_varchar2_table(3) := '2020242E666E2E7469636B6572203D2066756E6374696F6E286F7074696F6E7329207B0A20202020202020202F2F20457874656E64206F75722064656661756C7473207769746820757365722D737065636966696564206F7074696F6E730A2020202020';
wwv_flow_api.g_varchar2_table(4) := '202020766172206F707473203D20242E657874656E64287B7D2C20242E666E2E7469636B65722E64656661756C74732C206F7074696F6E73293B0A0A20202020202020202F2F2048616E646C652065616368206F662074686520676976656E20636F6E74';
wwv_flow_api.g_varchar2_table(5) := '61696E6572730A202020202020202072657475726E20746869732E656163682866756E6374696F6E202829207B0A2020202020202020202020202F2F20536574757020746865207469636B657220656C656D656E74730A20202020202020202020202076';
wwv_flow_api.g_varchar2_table(6) := '6172207469636B6572436F6E7461696E6572203D20242874686973293B2020202020202020202020202020202020202020202F2F204F757465722D6D6F7374207469636B657220636F6E7461696E65720A20202020202020202020202076617220686561';
wwv_flow_api.g_varchar2_table(7) := '646C696E65436F6E7461696E65723B20202020202020202020202020202020202020202020202020202020202F2F20496E6E657220686561646C696E6520636F6E7461696E65720A20202020202020202020202076617220686561646C696E65456C656D';
wwv_flow_api.g_varchar2_table(8) := '656E7473203D207469636B6572436F6E7461696E65722E66696E6428276C6927293B202F2F204F726967696E616C20686561646C696E6520656C656D656E74730A20202020202020202020202076617220686561646C696E6573203D205B5D3B20202020';
wwv_flow_api.g_varchar2_table(9) := '202020202020202020202020202020202020202020202020202020202F2F204C697374206F6620616C6C2074686520686561646C696E65730A20202020202020202020202076617220686561646C696E655461674D6170203D207B7D3B20202020202020';
wwv_flow_api.g_varchar2_table(10) := '20202020202020202020202020202020202020202F2F204D6170732074686520696E6465786573206F66207468652048544D4C207461677320696E2074686520686561646C696E657320746F2074686520686561646C696E6520696E6465780A20202020';
wwv_flow_api.g_varchar2_table(11) := '2020202020202020766172206F7574657254696D656F757449643B20202020202020202020202020202020202020202020202020202020202020202F2F2053746F72657320746865206F75746572207469636B65722074696D656F757420696420666F72';
wwv_flow_api.g_varchar2_table(12) := '207061757365730A20202020202020202020202076617220696E6E657254696D656F757449643B20202020202020202020202020202020202020202020202020202020202020202F2F2053746F7265732074686520696E6E6572207469636B6572207469';
wwv_flow_api.g_varchar2_table(13) := '6D656F757420696420666F72207061757365730A2020202020202020202020207661722063757272656E74486561646C696E65203D20303B2020202020202020202020202020202020202020202020202020202F2F2054686520696E646578206F662074';
wwv_flow_api.g_varchar2_table(14) := '68652063757272656E7420686561646C696E6520696E20746865206C697374206F6620686561646C696E65730A2020202020202020202020207661722063757272656E74486561646C696E65506F736974696F6E203D20303B2020202020202020202020';
wwv_flow_api.g_varchar2_table(15) := '20202020202020202F2F2054686520696E646578206F66207468652063757272656E742063686172616374657220696E207468652063757272656E7420686561646C696E650A2020202020202020202020207661722066697273744F757465725469636B';
wwv_flow_api.g_varchar2_table(16) := '203D20747275653B202020202020202020202020202020202020202020202020202F2F20576865746865722074686973206973207468652066697273742074696D6520646F696E6720746865206F75746572207469636B0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(17) := '766172206669727374496E6E65725469636B203D20747275653B202020202020202020202020202020202020202020202020202F2F20576865746865722074686973206973207468652066697273742074696D6520646F696E672074686520696E6E6572';
wwv_flow_api.g_varchar2_table(18) := '207469636B20696E20746869732072656E646974696F6E206F6620746865206F75746572206F6E650A0A20202020202020202020202076617220616C6C6F77656454616773203D205B2761272C202762272C20277374726F6E67272C20277370616E272C';
wwv_flow_api.g_varchar2_table(19) := '202769272C2027656D272C202775275D3B0A0A202020202020202020202020696620286F7074732E66696E6973684F6E486F766572207C7C206F7074732E70617573654F6E486F76657229207B0A202020202020202020202020202020202F2F20536574';
wwv_flow_api.g_varchar2_table(20) := '7570206D6F6E69746F72696E6720686F7665722073746174650A202020202020202020202020202020207469636B6572436F6E7461696E65722E72656D6F7665436C6173732827686F76657227293B0A202020202020202020202020202020207469636B';
wwv_flow_api.g_varchar2_table(21) := '6572436F6E7461696E65722E686F7665722866756E6374696F6E2829207B0A2020202020202020202020202020202020202020242874686973292E746F67676C65436C6173732827686F76657227293B0A202020202020202020202020202020207D293B';
wwv_flow_api.g_varchar2_table(22) := '0A2020202020202020202020207D0A0A2020202020202020202020202F2F205361766520616C6C2074686520686561646C696E6520746578740A20202020202020202020202076617220682C206C3B0A202020202020202020202020686561646C696E65';
wwv_flow_api.g_varchar2_table(23) := '456C656D656E74732E656163682866756E6374696F6E2028696E6465782C20656C656D656E7429207B0A2020202020202020202020202020202068203D2073747269705461677328242874686973292E68746D6C28292C20616C6C6F7765645461677329';
wwv_flow_api.g_varchar2_table(24) := '3B202F2F20537472697020616C6C206275742074686520616C6C6F77656420746167730A202020202020202020202020202020206C203D206C6F63617465546167732868293B202F2F2047657420746865206C6F636174696F6E73206F66207468652061';
wwv_flow_api.g_varchar2_table(25) := '6C6C6F77656420746167730A2020202020202020202020202020202068203D207374726970546167732868293B202F2F2052656D6F766520616C6C206F66207468652048544D4C20746167732066726F6D2074686520686561646C696E650A2020202020';
wwv_flow_api.g_varchar2_table(26) := '2020202020202020202020686561646C696E65732E707573682868293B202F2F204164642074686520686561646C696E6520746F2074686520686561646C696E6573206C6973740A20202020202020202020202020202020686561646C696E655461674D';
wwv_flow_api.g_varchar2_table(27) := '61705B686561646C696E65732E6C656E677468202D20315D203D206C3B202F2F204173736F63696174652074686520746167206D617020776974682074686520686561646C696E650A2020202020202020202020207D293B0A0A20202020202020202020';
wwv_flow_api.g_varchar2_table(28) := '20202F2F2052616E646F6D697A653F0A202020202020202020202020696620286F7074732E72616E646F6D292073687566666C65417272617928686561646C696E6573293B0A0A2020202020202020202020202F2F204E6F772064656C65746520616C6C';
wwv_flow_api.g_varchar2_table(29) := '2074686520656C656D656E747320616E64206164642074686520686561646C696E6520636F6E7461696E65720A2020202020202020202020207469636B6572436F6E7461696E65722E66696E642827756C27292E616674657228273C6469763E3C2F6469';
wwv_flow_api.g_varchar2_table(30) := '763E27292E72656D6F766528293B0A202020202020202020202020686561646C696E65436F6E7461696E6572203D207469636B6572436F6E7461696E65722E66696E64282764697627293B0A0A2020202020202020202020202F2F2046756E6374696F6E';
wwv_flow_api.g_varchar2_table(31) := '20746F2061637475616C6C7920646F20746865206F75746572207469636B65722C20616E642068616E646C652070617573696E670A20202020202020202020202066756E6374696F6E206F757465725469636B2829207B0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(32) := '202020206669727374496E6E65725469636B203D20747275653B0A0A202020202020202020202020202020206966202866697273744F757465725469636B29207B0A202020202020202020202020202020202020202066697273744F757465725469636B';
wwv_flow_api.g_varchar2_table(33) := '203D2066616C73653B0A2020202020202020202020202020202020202020696E6E65725469636B28293B0A202020202020202020202020202020202020202072657475726E3B0A202020202020202020202020202020207D0A0A20202020202020202020';
wwv_flow_api.g_varchar2_table(34) := '2020202020206F7574657254696D656F75744964203D2073657454696D656F75742866756E6374696F6E202829207B0A2020202020202020202020202020202020202020696620286F7074732E70617573654F6E486F766572202626207469636B657243';
wwv_flow_api.g_varchar2_table(35) := '6F6E7461696E65722E686173436C6173732827686F766572272929207B0A2020202020202020202020202020202020202020202020202F2F205573657220697320686F766572696E67206F76657220746865207469636B657220616E6420706175736520';
wwv_flow_api.g_varchar2_table(36) := '6F6E20686F76657220697320656E61626C65640A202020202020202020202020202020202020202020202020636C65617254696D656F757428696E6E657254696D656F75744964293B0A2020202020202020202020202020202020202020202020206F75';
wwv_flow_api.g_varchar2_table(37) := '7465725469636B28293B0A20202020202020202020202020202020202020202020202072657475726E3B0A20202020202020202020202020202020202020207D0A0A2020202020202020202020202020202020202020696E6E65725469636B28293B0A20';
wwv_flow_api.g_varchar2_table(38) := '2020202020202020202020202020207D2C206F7074732E6974656D5370656564293B0A2020202020202020202020207D0A0A2020202020202020202020202F2F2046756E6374696F6E20746F2068616E646C6520746865207469636B696E6720666F7220';
wwv_flow_api.g_varchar2_table(39) := '696E646976696475616C20686561646C696E65730A20202020202020202020202066756E6374696F6E20696E6E65725469636B2829207B0A20202020202020202020202020202020696620286669727374496E6E65725469636B29207B0A202020202020';
wwv_flow_api.g_varchar2_table(40) := '20202020202020202020202020206669727374496E6E65725469636B203D2066616C73653B0A20202020202020202020202020202020202020207469636B28293B0A202020202020202020202020202020202020202072657475726E3B0A202020202020';
wwv_flow_api.g_varchar2_table(41) := '202020202020202020207D0A0A202020202020202020202020202020206966202863757272656E74486561646C696E65506F736974696F6E203E20686561646C696E65735B63757272656E74486561646C696E655D2E6C656E67746829207B0A20202020';
wwv_flow_api.g_varchar2_table(42) := '20202020202020202020202020202020616476616E636528293B0A202020202020202020202020202020202020202072657475726E3B0A202020202020202020202020202020207D0A0A20202020202020202020202020202020696620286F7074732E66';
wwv_flow_api.g_varchar2_table(43) := '696E6973684F6E486F766572202626206F7074732E70617573654F6E486F766572202626207469636B6572436F6E7461696E65722E686173436C6173732827686F76657227292026262063757272656E74486561646C696E65506F736974696F6E203C3D';
wwv_flow_api.g_varchar2_table(44) := '20686561646C696E65735B63757272656E74486561646C696E655D2E6C656E67746829207B0A20202020202020202020202020202020202020202F2F204C6574277320717569636B6C7920636F6D706C6574652074686520686561646C696E650A202020';
wwv_flow_api.g_varchar2_table(45) := '20202020202020202020202020202020202F2F2054686973206973206F757473696465207468652074696D656F757420626563617573652077652077616E7420746F20646F207468697320696E7374616E746C7920776974686F75742074686520706175';
wwv_flow_api.g_varchar2_table(46) := '73650A0A20202020202020202020202020202020202020202F2F205570646174652074686520746578740A2020202020202020202020202020202020202020686561646C696E65436F6E7461696E65722E68746D6C2867657443757272656E745469636B';
wwv_flow_api.g_varchar2_table(47) := '2829293B0A20202020202020202020202020202020202020202F2F20416476616E6365206F757220706F736974696F6E0A202020202020202020202020202020202020202063757272656E74486561646C696E65506F736974696F6E202B3D20313B0A0A';
wwv_flow_api.g_varchar2_table(48) := '2020202020202020202020202020202020202020696E6E65725469636B28293B0A202020202020202020202020202020202020202072657475726E3B0A202020202020202020202020202020207D0A20202020202020202020202020202020656C736520';
wwv_flow_api.g_varchar2_table(49) := '7B0A20202020202020202020202020202020202020202F2F2048616E646C65206173206E6F726D616C0A2020202020202020202020202020202020202020696E6E657254696D656F75744964203D2073657454696D656F75742866756E6374696F6E2028';
wwv_flow_api.g_varchar2_table(50) := '29207B0A202020202020202020202020202020202020202020202020696620286F7074732E70617573654F6E486F766572202626207469636B6572436F6E7461696E65722E686173436C6173732827686F766572272929207B0A20202020202020202020';
wwv_flow_api.g_varchar2_table(51) := '2020202020202020202020202020202020202F2F205573657220697320686F766572696E67206F76657220746865207469636B657220616E64207061757365206F6E20686F76657220697320656E61626C65640A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(52) := '202020202020202020202020636C65617254696D656F757428696E6E657254696D656F75744964293B0A20202020202020202020202020202020202020202020202020202020696E6E65725469636B28293B0A2020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(53) := '202020202020202020202072657475726E3B0A2020202020202020202020202020202020202020202020207D0A0A2020202020202020202020202020202020202020202020207469636B28293B0A20202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(54) := '2020616476616E636528293B0A20202020202020202020202020202020202020207D2C206F7074732E637572736F725370656564293B0A202020202020202020202020202020207D0A2020202020202020202020207D0A0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(55) := '66756E6374696F6E20616476616E63652829207B0A202020202020202020202020202020202F2F20416476616E636520686561646C696E6520616E642072657365742063686172616374657220706F736974696F6E2C2069662069742773206174207468';
wwv_flow_api.g_varchar2_table(56) := '6520656E64206F66207468652063757272656E7420686561646C696E650A202020202020202020202020202020206966202863757272656E74486561646C696E65506F736974696F6E203E20686561646C696E65735B63757272656E74486561646C696E';
wwv_flow_api.g_varchar2_table(57) := '655D2E6C656E67746829207B202F2F203E206865726520616E64206E6F74203D3D206265636175736520746865207469636B657220637572736F722074616B657320616E206578747261206C6F6F700A2020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(58) := '63757272656E74486561646C696E65202B3D20313B0A202020202020202020202020202020202020202063757272656E74486561646C696E65506F736974696F6E203D20303B0A0A20202020202020202020202020202020202020202F2F205265736574';
wwv_flow_api.g_varchar2_table(59) := '2074686520686561646C696E6520616E642063686172616374657220706F736974696F6E73206966207765277665206379636C6564207468726F75676820616C6C2074686520686561646C696E65730A2020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(60) := '6966202863757272656E74486561646C696E65203D3D20686561646C696E65732E6C656E677468292063757272656E74486561646C696E65203D20303B0A0A20202020202020202020202020202020202020202F2F2053544F5021205765277665206164';
wwv_flow_api.g_varchar2_table(61) := '76616E636564206120686561646C696E652E204E6F77207765206A757374206E65656420746F2070617573652E0A2020202020202020202020202020202020202020636C65617254696D656F757428696E6E657254696D656F75744964293B0A20202020';
wwv_flow_api.g_varchar2_table(62) := '20202020202020202020202020202020636C65617254696D656F7574286F7574657254696D656F75744964293B0A20202020202020202020202020202020202020206F757465725469636B28293B0A202020202020202020202020202020207D0A202020';
wwv_flow_api.g_varchar2_table(63) := '2020202020202020207D0A0A2020202020202020202020202F2F20446F2074686520696E646976696475616C207469636B730A20202020202020202020202066756E6374696F6E207469636B2829207B0A202020202020202020202020202020202F2F20';
wwv_flow_api.g_varchar2_table(64) := '4E6F77206C657427732075706461746520746865207469636B65722077697468207468652063757272656E74207469636B20737472696E670A202020202020202020202020202020206966202863757272656E74486561646C696E65506F736974696F6E';
wwv_flow_api.g_varchar2_table(65) := '203D3D3D2030202626206F7074732E6661646529207B0A2020202020202020202020202020202020202020636C65617254696D656F757428696E6E657254696D656F75744964293B0A0A20202020202020202020202020202020202020202F2F20416E69';
wwv_flow_api.g_varchar2_table(66) := '6D61746520746865207472616E736974696F6E206966206974277320656E61626C65640A2020202020202020202020202020202020202020686561646C696E65436F6E7461696E65722E666164654F7574286F7074732E666164654F757453706565642C';
wwv_flow_api.g_varchar2_table(67) := '2066756E6374696F6E202829207B0A2020202020202020202020202020202020202020202020202F2F204E6F772069742773206661646564206F75742C206C65742773207570646174652074686520746578740A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(68) := '2020202020202020686561646C696E65436F6E7461696E65722E68746D6C2867657443757272656E745469636B2829293B0A2020202020202020202020202020202020202020202020202F2F20416E64206661646520696E0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(69) := '20202020202020202020202020686561646C696E65436F6E7461696E65722E66616465496E286F7074732E66616465496E53706565642C2066756E6374696F6E202829207B0A202020202020202020202020202020202020202020202020202020202F2F';
wwv_flow_api.g_varchar2_table(70) := '20416476616E6365206F757220706F736974696F6E0A2020202020202020202020202020202020202020202020202020202063757272656E74486561646C696E65506F736974696F6E202B3D20313B0A2020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(71) := '20202020202020202F2F20416E64206E6F7720776527726520696E2C206C6574277320737461727420746865207468696E67206F666620616761696E20776974686F7574207468652064656C61790A202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(72) := '20202020202020696E6E65725469636B28293B0A2020202020202020202020202020202020202020202020207D293B0A20202020202020202020202020202020202020207D293B0A202020202020202020202020202020207D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(73) := '202020202020656C7365207B0A20202020202020202020202020202020202020202F2F205570646174652074686520746578740A2020202020202020202020202020202020202020686561646C696E65436F6E7461696E65722E68746D6C286765744375';
wwv_flow_api.g_varchar2_table(74) := '7272656E745469636B2829293B0A20202020202020202020202020202020202020202F2F20416476616E6365206F757220706F736974696F6E0A202020202020202020202020202020202020202063757272656E74486561646C696E65506F736974696F';
wwv_flow_api.g_varchar2_table(75) := '6E202B3D20313B0A2020202020202020202020202020202020202020636C65617254696D656F757428696E6E657254696D656F75744964293B0A2020202020202020202020202020202020202020696E6E65725469636B28293B0A202020202020202020';
wwv_flow_api.g_varchar2_table(76) := '202020202020207D0A2020202020202020202020207D0A0A2020202020202020202020202F2F20476574207468652063757272656E74207469636B20737472696E670A20202020202020202020202066756E6374696F6E2067657443757272656E745469';
wwv_flow_api.g_varchar2_table(77) := '636B2829207B0A2020202020202020202020202020202076617220637572736F722C20692C206A2C206C6F636174696F6E3B0A20202020202020202020202020202020737769746368202863757272656E74486561646C696E65506F736974696F6E2025';
wwv_flow_api.g_varchar2_table(78) := '203229207B0A20202020202020202020202020202020202020206361736520313A0A202020202020202020202020202020202020202020202020637572736F72203D206F7074732E637572736F724F6E653B0A2020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(79) := '20202020202020627265616B3B0A20202020202020202020202020202020202020206361736520303A0A202020202020202020202020202020202020202020202020637572736F72203D206F7074732E637572736F7254776F3B0A202020202020202020';
wwv_flow_api.g_varchar2_table(80) := '202020202020202020202020202020627265616B3B0A202020202020202020202020202020207D0A0A202020202020202020202020202020202F2F20446F6E277420646973706C61792074686520637572736F7220746869732077617320746865206C61';
wwv_flow_api.g_varchar2_table(81) := '737420636861726163746572206F662074686520686561646C696E650A202020202020202020202020202020206966202863757272656E74486561646C696E65506F736974696F6E203E3D20686561646C696E65735B63757272656E74486561646C696E';
wwv_flow_api.g_varchar2_table(82) := '655D2E6C656E6774682920637572736F72203D2027273B0A0A202020202020202020202020202020202F2F2047656E65726174652074686520686561646C696E650A2020202020202020202020202020202076617220686561646C696E65203D2027273B';
wwv_flow_api.g_varchar2_table(83) := '0A20202020202020202020202020202020766172206F70656E656454616773203D205B5D3B0A20202020202020202020202020202020666F72202869203D20303B2069203C2063757272656E74486561646C696E65506F736974696F6E3B20692B2B2920';
wwv_flow_api.g_varchar2_table(84) := '7B0A20202020202020202020202020202020202020206C6F636174696F6E203D206E756C6C3B0A20202020202020202020202020202020202020202F2F20436865636B20746F207365652069662074686572652773206D65616E7420746F206265206120';
wwv_flow_api.g_varchar2_table(85) := '746167206174207468697320696E6465780A2020202020202020202020202020202020202020666F7220286A203D20303B206A203C20686561646C696E655461674D61705B63757272656E74486561646C696E655D2E6C656E6774683B206A2B2B29207B';
wwv_flow_api.g_varchar2_table(86) := '0A2020202020202020202020202020202020202020202020202F2F2046696E64206120746167206D617070656420746F2074686973206C6F636174696F6E2C206966206F6E65206578697374730A20202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(87) := '202069662028686561646C696E655461674D61705B63757272656E74486561646C696E655D5B6A5D20262620686561646C696E655461674D61705B63757272656E74486561646C696E655D5B6A5D2E7374617274203D3D3D206929207B0A202020202020';
wwv_flow_api.g_varchar2_table(88) := '202020202020202020202020202020202020202020206C6F636174696F6E203D20686561646C696E655461674D61705B63757272656E74486561646C696E655D5B6A5D3B202F2F20497420646F6573206578697374210A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(89) := '202020202020202020202020202020627265616B3B0A2020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020207D0A0A2020202020202020202020202020202020202020696620286C6F636174';
wwv_flow_api.g_varchar2_table(90) := '696F6E29207B0A2020202020202020202020202020202020202020202020202F2F20416464207468652074616720746F2074686520686561646C696E650A202020202020202020202020202020202020202020202020686561646C696E65202B3D206C6F';
wwv_flow_api.g_varchar2_table(91) := '636174696F6E2E7461673B0A0A2020202020202020202020202020202020202020202020202F2F204E6F77206465616C2077697468207468652074616720666F722070726F7065722048544D4C0A20202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(92) := '20206966202821206C6F636174696F6E2E73656C66436C6F73696E6729207B0A20202020202020202020202020202020202020202020202020202020696620286C6F636174696F6E2E7461672E636861724174283129203D3D3D20272F2729207B0A2020';
wwv_flow_api.g_varchar2_table(93) := '2020202020202020202020202020202020202020202020202020202020206F70656E6564546167732E706F7028293B0A202020202020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(94) := '202020202020656C7365207B0A20202020202020202020202020202020202020202020202020202020202020206F70656E6564546167732E70757368286C6F636174696F6E2E6E616D65293B0A2020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(95) := '20202020207D0A2020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020207D0A0A20202020202020202020202020202020202020202F2F20416464207468652063686172616374657220746F20';
wwv_flow_api.g_varchar2_table(96) := '74686520686561646C696E650A2020202020202020202020202020202020202020686561646C696E65202B3D20686561646C696E65735B63757272656E74486561646C696E655D5B695D3B0A202020202020202020202020202020207D0A0A2020202020';
wwv_flow_api.g_varchar2_table(97) := '20202020202020202020202F2F204E6F7720636C6F73652074686520746167732C206966207765206E65656420746F202862656361757365206974206861736E27742066696E6973686564207769746820616C6C20746865207465787420696E20746865';
wwv_flow_api.g_varchar2_table(98) := '20746167290A20202020202020202020202020202020666F72202869203D20303B2069203C206F70656E6564546167732E6C656E6774683B20692B2B29207B0A2020202020202020202020202020202020202020686561646C696E65202B3D20273C2F27';
wwv_flow_api.g_varchar2_table(99) := '202B206F70656E6564546167735B695D202B20273E273B0A202020202020202020202020202020207D0A0A2020202020202020202020202020202072657475726E20686561646C696E65202B20637572736F723B0A2020202020202020202020207D0A0A';
wwv_flow_api.g_varchar2_table(100) := '2020202020202020202020202F2F2053746172742069740A2020202020202020202020206F757465725469636B28293B0A20202020202020207D293B0A202020207D3B0A0A202020202F2A2A0A20202020202A2052616E646F6D697A6520617272617920';
wwv_flow_api.g_varchar2_table(101) := '656C656D656E74206F7264657220696E2D706C6163652E0A20202020202A205573696E67204669736865722D59617465732073687566666C6520616C676F726974686D2E0A20202020202A2F0A2020202066756E6374696F6E2073687566666C65417272';
wwv_flow_api.g_varchar2_table(102) := '617928617272617929207B0A2020202020202020666F7220287661722069203D2061727261792E6C656E677468202D20313B2069203E20303B20692D2D29207B0A202020202020202020202020766172206A203D204D6174682E666C6F6F72284D617468';
wwv_flow_api.g_varchar2_table(103) := '2E72616E646F6D2829202A202869202B203129293B0A2020202020202020202020207661722074656D70203D2061727261795B695D3B0A20202020202020202020202061727261795B695D203D2061727261795B6A5D3B0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(104) := '61727261795B6A5D203D2074656D703B0A20202020202020207D0A202020202020202072657475726E2061727261793B0A202020207D0A0A202020202F2A2A0A20202020202A20537472697020616C6C2048544D4C20746167732066726F6D2061207374';
wwv_flow_api.g_varchar2_table(105) := '72696E672E0A20202020202A20416E206172726179206F66207361666520746167732063616E206265207061737365642C2077686963682077696C6C206E6F742062650A20202020202A2073747269707065642066726F6D2074686520737472696E6720';
wwv_flow_api.g_varchar2_table(106) := '77697468207468652072657374206F662074686520746167732E0A20202020202A2F0A2020202066756E6374696F6E2073747269705461677328746578742C20736166655461677329207B0A20202020202020207361666554616773203D207361666554';
wwv_flow_api.g_varchar2_table(107) := '616773207C7C205B5D3B0A20202020202020207661722074616773203D202F3C5C2F3F285B612D7A5D5B612D7A302D395D2A295C625B5E3E5D2A3E2F696D673B0A202020202020202076617220636F6D6D656E7473203D202F3C212D2D2E2A3F2D2D3E2F';
wwv_flow_api.g_varchar2_table(108) := '696D673B0A202020202020202072657475726E20746578742E7265706C61636528636F6D6D656E74732C202727292E7265706C61636528746167732C2066756E6374696F6E2028612C206229207B0A20202020202020202020202072657475726E207361';
wwv_flow_api.g_varchar2_table(109) := '6665546167732E696E6465784F6628622E746F4C6F7765724361736528292920213D3D202D31203F2061203A2027273B0A20202020202020207D293B0A202020207D0A0A202020202F2A2A0A20202020202A204C6F636174657320616C6C206F66207468';
wwv_flow_api.g_varchar2_table(110) := '6520726571756573746564207461677320696E206120737472696E672E0A20202020202A2F0A2020202066756E6374696F6E206C6F636174655461677328746578742C207461674C69737429207B0A20202020202020207461674C697374203D20746167';
wwv_flow_api.g_varchar2_table(111) := '4C697374207C7C205B5D3B0A20202020202020207661722074616773203D202F3C5C2F3F285B612D7A5D5B612D7A302D395D2A295C625B5E3E5D2A3E2F696D3B0A20202020202020207661722073656C66436C6F73696E67203D202F5C2F5C737B302C7D';
wwv_flow_api.g_varchar2_table(112) := '3E242F6D3B0A2020202020202020766172206C6F636174696F6E73203D205B5D3B0A2020202020202020766172206D617463682C206C6F636174696F6E3B0A0A20202020202020207768696C652028286D61746368203D20746167732E65786563287465';
wwv_flow_api.g_varchar2_table(113) := '7874292920213D3D206E756C6C29207B0A202020202020202020202020696620287461674C6973742E6C656E677468203D3D3D2030207C7C207461674C6973742E696E6465784F66286D617463685B315D2920213D3D202D3129207B0A20202020202020';
wwv_flow_api.g_varchar2_table(114) := '2020202020202020206C6F636174696F6E203D207B0A20202020202020202020202020202020202020207461673A206D617463685B305D2C0A20202020202020202020202020202020202020206E616D653A206D617463685B315D2C0A20202020202020';
wwv_flow_api.g_varchar2_table(115) := '2020202020202020202020202073656C66436C6F73696E673A2073656C66436C6F73696E672E74657374286D617463685B305D292C0A202020202020202020202020202020202020202073746172743A206D617463682E696E6465782C0A202020202020';
wwv_flow_api.g_varchar2_table(116) := '2020202020202020202020202020656E643A206D617463682E696E646578202B206D617463685B305D2E6C656E677468202D20310A202020202020202020202020202020207D3B0A202020202020202020202020202020206C6F636174696F6E732E7075';
wwv_flow_api.g_varchar2_table(117) := '7368286C6F636174696F6E293B0A0A202020202020202020202020202020202F2F204E6F772072656D6F76652074686973207461672066726F6D2074686520737472696E670A202020202020202020202020202020202F2F20736F207468617420656163';
wwv_flow_api.g_varchar2_table(118) := '68206C6F636174696F6E2077696C6C20726570726573656E7420697420696E206120737472696E6720776974686F757420616E79206F662074686520746167730A2020202020202020202020202020202074657874203D20746578742E736C6963652830';
wwv_flow_api.g_varchar2_table(119) := '2C206C6F636174696F6E2E737461727429202B20746578742E736C696365286C6F636174696F6E2E656E64202B2031293B0A0A202020202020202020202020202020202F2F205265736574207468652072656765780A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(120) := '2020746167732E6C617374496E646578203D20303B0A2020202020202020202020207D0A20202020202020207D0A0A202020202020202072657475726E206C6F636174696F6E733B0A202020207D0A0A202020202F2F20506C7567696E2064656661756C';
wwv_flow_api.g_varchar2_table(121) := '742073657474696E67730A20202020242E666E2E7469636B65722E64656661756C7473203D207B0A202020202020202072616E646F6D3A202020202020202066616C73652C202F2F205768657468657220746F20646973706C6179207469636B65722069';
wwv_flow_api.g_varchar2_table(122) := '74656D7320696E20612072616E646F6D206F726465720A20202020202020206974656D53706565643A2020202020333030302C20202F2F20546865207061757365206F6E2065616368207469636B6572206974656D206265666F7265206265696E672072';
wwv_flow_api.g_varchar2_table(123) := '65706C616365640A2020202020202020637572736F7253706565643A20202035302C202020202F2F205370656564206174207768696368207468652063686172616374657273206172652074797065640A202020202020202070617573654F6E486F7665';
wwv_flow_api.g_varchar2_table(124) := '723A2020747275652C20202F2F205768657468657220746F207061757365207768656E20746865206D6F75736520686F76657273206F76657220746865207469636B65720A202020202020202066696E6973684F6E486F7665723A20747275652C20202F';
wwv_flow_api.g_varchar2_table(125) := '2F2057686574686572206F72206E6F7420746F20636F6D706C65746520746865207469636B6572206974656D20696E7374616E746C79207768656E206D6F75736564206F7665720A2020202020202020637572736F724F6E653A2020202020275F272C20';
wwv_flow_api.g_varchar2_table(126) := '20202F2F205468652073796D626F6C20666F72207468652066697273742070617274206F662074686520637572736F720A2020202020202020637572736F7254776F3A2020202020272D272C2020202F2F205468652073796D626F6C20666F7220746865';
wwv_flow_api.g_varchar2_table(127) := '207365636F6E642070617274206F662074686520637572736F720A2020202020202020666164653A20202020202020202020747275652C20202F2F205768657468657220746F2066616465206265747765656E207469636B6572206974656D73206F7220';
wwv_flow_api.g_varchar2_table(128) := '6E6F740A202020202020202066616465496E53706565643A2020203630302C2020202F2F205370656564206F662074686520666164652D696E20616E696D6174696F6E0A2020202020202020666164654F757453706565643A2020333030202020202F2F';
wwv_flow_api.g_varchar2_table(129) := '205370656564206F662074686520666164652D6F757420616E696D6174696F6E0A202020207D3B0A0A7D29286A5175657279293B0A';
null;
 
end;
/

 
begin
 
wwv_flow_api.create_plugin_file (
  p_id => 278292423983543471 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 278253801250469118 + wwv_flow_api.g_id_offset
 ,p_file_name => 'jquery.ticker.js'
 ,p_mime_type => 'application/javascript'
 ,p_file_content => wwv_flow_api.g_varchar2_table
  );
null;
 
end;
/

commit;
begin
execute immediate 'begin sys.dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/
set verify on
set feedback on
set define on
prompt  ...done
