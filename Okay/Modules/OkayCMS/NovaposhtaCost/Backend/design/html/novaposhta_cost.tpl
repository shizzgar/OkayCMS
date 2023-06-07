{$meta_title = $btr->settings_np scope=global}

<style>
    @media (min-width: 1200px) and (max-width: 1400px) {
        .col-xxl-6{
            width: 100%;
        }
    }
</style>

{*Название страницы*}
<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="heading_page">{$btr->settings_np|escape}</div>
    </div>
</div>

{*Вывод успешных сообщений*}
{if $message_success}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="alert alert--center alert--icon alert--success">
                <div class="alert__content">
                    <div class="alert__title">
                        {if $message_success == 'saved'}
                        {$btr->general_settings_saved|escape}
                        {/if}
                    </div>
                </div>
                {if $smarty.get.return}
                <a class="alert__button" href="{$smarty.get.return}">
                    {include file='svg_icon.tpl' svgId='return'}
                    <span>{$btr->general_back|escape}</span>
                </a>
                {/if}
            </div>
        </div>
    </div>
{/if}

<div class="row d_flex">
    <div class="col-lg-12 col-md-12">
        <div class="alert alert--icon">
            <div class="alert__content">
                <div class="alert__title">{$btr->alert_description|escape}</div>
                <p>{$btr->settings_np__description|escape}</p>
            </div>
        </div>
    </div>
</div>

{*Главная форма страницы*}
<form method="post" enctype="multipart/form-data">
    <input type=hidden name="session_id" value="{$smarty.session.id}">

    <div class="row row--xxl">
        <div class="col-lg-6 col-md-12 pr-0">
            <div class="boxed fn_toggle_wrap">
                <div class="heading_box">
                    {$btr->settings_np_options|escape}
                </div>
                {*Параметры элемента*}
                <div class="toggle_body_wrap on fn_card" >
                    <div class="row">
                        <div class="col-xxl-6 col-lg-6 col-md-12">
                            <div class="heading_label">
                                <a href="https://my.novaposhta.ua/settings/index#apikeys" target="_blank">{$btr->settings_np_key}</a>
                                <i class="fn_tooltips" title='{$btr->tooltip_settings_np_api}'>
                                    {include file='svg_icon.tpl' svgId='icon_tooltips'}
                                </i>
                            </div>
                            <div class="mb-1">
                                <input type="text" name="newpost_key" value="{$settings->newpost_key|escape}" class="form-control">
                            </div>
                        </div>
                        <div class="col-xxl-6 col-lg-6 col-md-12">
                            <div class="heading_label heading_label--required">
                                <span>{$btr->settings_np_city}</span>
                                <i class="fn_tooltips" title='{$btr->tooltip_settings_np_city}'>
                                    {include file='svg_icon.tpl' svgId='icon_tooltips'}
                                </i>
                            </div>
                            <div class="mb-1">
                                <input type="text" class="fn_newpost_city_name form-control" name="newpost_city_name" value="{$settings->newpost_city|newpost_city}">
                                <input type="hidden" name="newpost_city" value="{$settings->newpost_city|escape}">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12">
                            <div class="heading_label heading_label--required">
                                <span>{$btr->settings_np_weight}</span>
                                <i class="fn_tooltips" title='{$btr->tooltip_settings_np_weight}'>
                                    {include file='svg_icon.tpl' svgId='icon_tooltips'}
                                </i>
                            </div>
                            <div class="mb-1">
                                <input type="text" name="newpost_weight" value="{$settings->newpost_weight|escape}" class="form-control">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12">
                            <div class="heading_label">{$btr->settings_np_volume}
                                <i class="fn_tooltips" title='{$btr->tooltip_settings_np_volume}'>
                                    {include file='svg_icon.tpl' svgId='icon_tooltips'}
                                </i>
                            </div>
                            <div class="mb-1">
                                <input type="text" name="newpost_volume" value="{$settings->newpost_volume|escape}" class="form-control">
                            </div>
                        </div>

                        <!--TODO "Переделать валюты на автоопределение-->
                        {*<div class="col-lg-12 col-md-12">
                            <div class="heading_label">{$btr->settings_np_currency}*</div>
                            <div class="mb-1">
                                <select name="currency_id" class="selectpicker form-control" data-live-search="false">
                                    {foreach $all_currencies as $c}
                                    <option value="{$c->id}"{if $c->id == $settings->newpost_currency_id} selected{/if}>{$c->name|escape} ({$c->code|escape})</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>*}
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 mt-1">
                            <div class="activity_of_switch_item">
                                <div class="okay_switch okay_switch--nowrap clearfix">
                                    <label class="switch switch-default mr-1">
                                        <input class="switch-input" name="newpost_use_volume" value='1' type="checkbox" {if $settings->newpost_use_volume}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                    <label class="switch_label mr-0">{$btr->settings_np_include_volume}</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 mt-2">
                            <div class="activity_of_switch_item">
                                <div class="okay_switch okay_switch--nowrap clearfix">
                                    <label class="switch switch-default mr-1">
                                        <input class="switch-input" name="newpost_use_assessed_value" value='1' type="checkbox" {if $settings->newpost_use_assessed_value}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                    <label class="switch_label mr-0">{$btr->settings_np_include_assessed}</label>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-12 col-md-12 mt-1">
                            <button type="submit" class="btn btn_small btn_blue float-md-right">
                                {include file='svg_icon.tpl' svgId='checked'}
                                <span>{$btr->general_apply|escape}</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-md-12">
            <div class="boxed">
                <div class="heading_box">
                    {$btr->np_warehouses_data_info}
                </div>
                <div class="">
                    <!--TODO "Этот блок возможно не нужен"-->
                    {*if $settings->np_last_update_cities_date}
                    <div class="alert mb-2">
                        {$btr->settings_np_update_date}: <strong>{$settings->np_last_update_cities_date|date} {$settings->np_last_update_cities_date|time}</strong>
                    </div>
                    {/if*}

                    {if $settings->np_last_update_warehouses_date}
                    <div class="text_green text_600">
                        <div class="mb-1">
                            {$btr->settings_np_update_date} <strong>{$settings->np_last_update_warehouses_date|date} {$settings->np_last_update_warehouses_date|time}</strong>
                        </div>
                    </div>
                    {/if}

                    <div class="alert alert--icon alert--info">
                        <div class="alert__content">
                            <div class="alert__title">{$btr->alert_info}</div>
                            <p>{$btr->np_warehouses_data_description}</p>
                        </div>
                    </div>

                    {if $warehouses_types_data}
                        <div class="mb-2 mt-2 row">
                            {foreach $warehouses_types_data as $w_type}
                                <div class="col-md-6">
                                    <input name="np_warehouses_types[]" id="type_{$w_type@iteration}" value="{$w_type->getTypeRef()|escape}"  type="checkbox" {if in_array($w_type->getTypeRef(), $settings->np_warehouses_types)}checked=""{/if} />
                                    <label for="type_{$w_type@iteration}">
                                        {if $manager->lang == 'ru'}
                                            {$w_type->getNameRu()|escape}
                                        {else}
                                            {$w_type->getName()|escape}
                                        {/if}
                                    </label>
                                </div>
                            {/foreach}
                        </div>
                    {/if}

                    <div class="mt-2 mb-2">
                        <p class="mt-2 mb-2">{$btr->settings_np_update_label}</p>
                        <div class="fn_progress_block">
                        </div>
                        <div class="flex_np_update">

                            <div class="flex_np_update__btn">
                                <button type="button" class="btn btn_small btn-warning fn_update_cache">
                                    <span>{$btr->np_update_cache_now|escape}</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="alert alert--icon alert--error">
                        <div class="alert__content">
                            <div class="alert__title">Важно!</div>
                            <p>{$btr->np_warehouses_data_update_warning|escape}</p>
                        </div>
                    </div>

                    <div class="alert alert--icon alert--warning mt-2 mb-0">
                        <div class="alert__content" style="line-height: 1.4">
                            <div class="alert__title">Совет</div>
                            {$btr->np_cron_update_cache_1}
                            "<a href=""  class="fn_clipboard hint-bottom-middle-t-info-s-small-mobile" data-hint="Click to copy" data-hint-copied="✔ Copied to clipboard">php {$config->root_dir}ok scheduler:run</a>"
                            {$btr->np_cron_update_cache_2}
                        </div>
                    </div>

                    <!--TODO "Этот блок возможно не нужен"-->
                    {*<div class="row">
                        <div class="col-lg-6 col-md-6">
                            <div class="boxes_inline">
                                <div class="okay_switch clearfix">
                                    <label class="switch switch-default">
                                        <input class="switch-input" name="np_auto_update_data" value='1' type="checkbox" {if $settings->np_auto_update_data}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="heading_label">{$btr->settings_np_cache_lifetime}</div>
                            <div class="mb-1">
                                <input type="text" name="np_cache_lifetime" value="{$settings->np_cache_lifetime|escape}" placeholder="86400" class="form-control">
                            </div>
                        </div>
                    </div>*}
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="boxed fn_toggle_wrap">
                <div class="toggle_body_wrap on fn_card">
                    <div class="heading_box">{$btr->payment_np_cash_on_delivery_type}</div>
                    <div class="okay_list products_list fn_sort_list">
                        {*Шапка таблицы*}
                        <div class="okay_list_head">
                            <div class="okay_list_boding okay_list_drag"></div>
                            <div class="okay_list_heading okay_list_photo">{$btr->general_photo|escape}</div>
                            <div class="okay_list_heading okay_list_brands_name">{$btr->payment_np_payment_method_name|escape}</div>
                            <div class="okay_list_heading okay_list_close"></div>
                            <div class="okay_list_heading okay_list_setting"></div>
                            <div class="okay_list_heading okay_list_status" style="width: 200px;">{$btr->payment_np_cash_on_delivery|escape}</div>
                        </div>
                        <div class="okay_list_body sort_extended">
                            {foreach $payment_methods as $payment_method}
                                <div class="fn_step-1 fn_row okay_list_body_item fn_sort_item">
                                    <div class="okay_list_row ">
                                        <div class="okay_list_boding okay_list_drag"></div>
                                        <div class="okay_list_boding okay_list_photo">
                                            {if $payment_method->image}
                                                <img src="{$payment_method->image|resize:55:55:false:$config->resized_payments_dir}" alt="" /></a>
                                            {else}
                                                <img height="55" width="55" src="design/images/no_image.png"/>
                                            {/if}
                                        </div>
                                        <div class="okay_list_boding okay_list_brands_name">
                                            {$payment_method->name|escape}
                                        </div>
                                        <div class="okay_list_boding okay_list_close"></div>
                                        <div class="okay_list_setting"></div>

                                        <div class="okay_list_boding okay_list_status" style="width: 200px;">
                                            <label class="switch switch-default ">
                                                <input class="switch-input fn_ajax_action {if $payment_method->novaposhta_cost__cash_on_delivery}fn_active_class{/if}" data-controller="payment" data-action="novaposhta_cost__cash_on_delivery" data-id="{$payment_method->id}" name="novaposhta_cost__cash_on_delivery" value="1" type="checkbox"  {if $payment_method->novaposhta_cost__cash_on_delivery}checked=""{/if}/>
                                                <span class="switch-label"></span>
                                                <span class="switch-handle"></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>

<script src="{$rootUrl}/backend/design/js/piecon/piecon.js"></script>
<script src="{$rootUrl}/backend/design/js/autocomplete/jquery.autocomplete-min.js"></script>
{literal}
<script>
    sclipboard();

    $( ".fn_newpost_city_name" ).devbridgeAutocomplete( {
        serviceUrl: okay.router['OkayCMS_NovaposhtaCost_find_city'],
        minChars: 1,
        maxHeight: 320,
        noCache: true,
        onSelect: function(suggestion) {
            $('[name="newpost_city"]').val(suggestion.data.ref)
        },
        formatResult: function(suggestion, currentValue) {
            var reEscape = new RegExp( '(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join( '|\\' ) + ')', 'g' );
            var pattern = '(' + currentValue.replace( reEscape, '\\$1' ) + ')';
            return "<span>" + suggestion.value.replace( new RegExp( pattern, 'gi' ), '<strong>$1<\/strong>' ) + "<\/span>";
        }
    } );

    function do_update(page, importItem)
    {
        page = typeof(page) != 'undefined' ? page : 1;
        let data = {
            page: page,
            updateType: importItem.updateType
        };

        for (let paramKey in importItem.updateParams) {
            data[paramKey] = importItem.updateParams[paramKey];
        }

        $.ajax({
            url: "/backend/index.php?controller=OkayCMS.NovaposhtaCost.NovaposhtaCostAdmin@updateData",
            data: data,
            dataType: 'json',
            success: function(data) {
                if (data.hasOwnProperty('error')) {
                    importItem.progressBlock.find('.np_import_result')
                        .text(data.error)
                        .addClass('alert--error alert')
                        .removeClass('np_import_result')
                        .css('padding', '5px')
                        .show();
                    importItem.progressItem.hide();
                    importItem.resolve('result');
                } else if (data.hasOwnProperty('pagesNum') && data.pagesNum > 0 && page < data.pagesNum) {
                    importItem.progressItem.attr('value', Math.round(100 * page / data.pagesNum));
                    Piecon.setProgress(Math.round(100 * page / data.pagesNum));
                    do_update(++page, importItem);
                } else {
                    Piecon.setProgress(100);
                    importItem.progressItem.attr('value', 100).hide();
                    importItem.progressBlock.find('.np_import_result').fadeIn(500);
                    importItem.resolve('result');
                }
            },
            error: function(xhr, status, errorThrown) {
                alert(errorThrown+'\n'+xhr.responseText);
            }
        });

    }

    $(document).on('click', '.fn_update_cache', function () {
        $.ajax({
            url: "/backend/index.php?controller=OkayCMS.NovaposhtaCost.NovaposhtaCostAdmin@getUpdateTypes",
            dataType: 'json',
            success: function(data) {
                    if (data.hasOwnProperty('updateTypes')) {

                        function initFunction(updateElement) {
                            return new Promise((resolve, reject) => {
                                updateElement.resolve = resolve;
                                Piecon.setOptions({fallback: 'force'});
                                Piecon.setProgress(0);
                                do_update(1, updateElement);
                            });
                        }
                        let init = initFunction;

                        for (let key in data.updateTypes) {
                            let updateType = data.updateTypes[key];
                            let updateElement = {
                                progressItem: $('<progress id="progressbar_' + key + '" class="progress progress-xs progress-info"  value="0" max="100">sdfsdfsd</progress>'),
                                progressBlock: $('<div><p class="mb-0">' + updateType['updateName'] + '</p><div class="np_import_result" style="display: none"></div></div>'),
                                updateType: updateType['updateType'],
                                updateParams: updateType['updateParams'],
                                initProgress: function () {
                                    this.progressItem.appendTo(this.progressBlock);
                                    this.progressBlock.appendTo('.fn_progress_block');
                                }
                            };
                            updateElement.initProgress();

                            if (key == 0) {
                                init = init(updateElement);
                            } else {
                                init = init.then(
                                    result => initFunction(updateElement)
                                );
                            }
                        }
                    }

            },
            error: function(xhr, status, errorThrown) {
                alert(errorThrown+'\n'+xhr.responseText);
            }
        });
    });
</script>
{/literal}
