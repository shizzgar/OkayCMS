<?php

$lang['okaycms__integration_ic__description_title'] = "Интеграция с 1C";
$lang['okaycms__integration_ic__description_part_1'] = "Для настройки обмена данными сайта с 1С вам требуется указать в 1С в разделе Сервис - Обмен данными с Web-сайтом - Настроить обмен данными с Web-сайтом следующую ссылку";
$lang['okaycms__integration_ic__description_part_2'] = "и указать логин/пароль администратора сайта, у которого есть права для синхронизации с 1С. Можно сделать отдельного пользователя для работы с 1С";
$lang['okaycms__integration_ic__description_part_2_1'] = "В настройках указывается именно адрес страницы импорта, без GET параметров. Параметры подставляет сам 1С при тех или иных действиях.";
$lang['okaycms__integration_ic__description_part_3'] = "Более детально можно ознакомиться ниже, а также в статье на сайте";
$lang['okaycms__integration_ic__description_part_4'] = "Логика работы модуля приблизительно следующая. 1С вызывает указанный выше URL (далее - точка входа) с набором определенных GET параметров, которые запускают те или иные действия со стороны сайта.";
$lang['okaycms__integration_ic__description_part_5'] = "Ниже приведу несколько примеров этих параметров для понимания действий, которые запускает 1С на стороне сайта.";
$lang['okaycms__integration_ic__description_part_6'] = "На примере импорта товаров:";
$lang['okaycms__integration_ic__description_part_7'] = "Первым действием обычно идет так называемая инициализация, которая подготавливает папки к началу импорта, очищая их от файлов предыдущего цикла. Запускается при помощи ";
$lang['okaycms__integration_ic__description_part_8'] = "Далее 1С загружает набор ресурсов во временную папку на сайт, это могут быть изображения товаров или файлы XML с данными для импорта.";
$lang['okaycms__integration_ic__description_part_9'] = "При загрузке ресурсов в GET параметр filename указывается имя создаваемого файла, который при дальнейшей работе будет использоваться/вызван по этому имени. Само содержимое файла передается в теле запроса";
$lang['okaycms__integration_ic__description_part_10'] = "filename - имя создаваемого файла, может быть индивидуально под ваши задачи. В дальней 1С обращается в файлу по этому уникальному имени.";
$lang['okaycms__integration_ic__description_part_11'] = "После загрузки всех ресурсов запускается обычно импорт категорий и товаров";
$lang['okaycms__integration_ic__description_part_12'] = "Файл импорта категорий и товаров должен содержать в названии слово import. Дальнейшее название файла индивидуально. А также иметь расширение xml";
$lang['okaycms__integration_ic__description_part_13'] = "Дальнейшее продолжение импорта, это запуск импорта файла с количеством, ценами, единицами измерения которое обычно содержится в файле offers.xml (построение имени файла описано на примере import.xml) и запускается ";
$lang['okaycms__integration_ic__description_part_14'] = "Также есть возможность произвести импорт заказов из 1С на сайт, это делается при помощи загрузки файла с заказами и запуска по адресу ";
$lang['okaycms__integration_ic__description_part_15'] = "На этих действиях импорт товаров заканчивается.";
$lang['okaycms__integration_ic__description_part_16'] = "1С также может получить XML выгрузку новых заказов на сайте для экспорта заказов в 1С. Выводятся только новые заказы (начинающиеся с времени проведения прошлого запуска экспорта) при запуске ";
$lang['okaycms__integration_ic__settings'] = "Настройки параметров интеграции";
$lang['okaycms__integration_ic__settings_brandOptionName'] = "Название свойства товара, используемого как бренд";
$lang['okaycms__integration_ic__settings_guidPriceFrom1C'] = "ID типа цены в 1С, которую нужно загрузить как основную";
$lang['okaycms__integration_ic__settings_guidComparePriceFrom1C'] = "ID типа цены в 1С, которую нужно загрузить как старую";
$lang['okaycms__integration_ic__settings_fullUpdate'] = "Обновлять все данные при каждой синхронизации";
$lang['okaycms__integration_ic__settings_onlyEnabledCurrencies'] = "Учитывать только включенные валюты";
$lang['okaycms__integration_ic__settings_stockFrom1c'] = "Учитывать количество товара из 1с";
$lang['okaycms__integration_ic__settings_importProductsOnly'] = "Импортировать только товары, без услуг и прочего (ВидНоменклатуры == Товар)";
$lang['okaycms__integration_1c__settings_exportPurchasesDiscountsSeparate'] = "Экспортировать скидки товаров в заказе отдельно";
$lang['okaycms__integration_1c__settings_exportPurchasesDiscountsSeparate_tooltip'] = "Если настройка включена, то при наличии у товара в заказе скидок (скидки распространяются только на этот товар), к товару будет прилагаться скидка являющейся суммой всех скидок товара, а скидка прилагающаяся к заказу будет суммой только общих скидок заказа.";
$lang['okaycms__integration_ic__settings_eraseComparePrice'] = "Сбрасывать старую цену вариантов, если она не пришла с 1С";
$lang['okaycms__integration_ic__settings_eraseComparePriceEqual'] = "Сбрасывать старую цену вариантов, если равна либо меньше основной цены";
