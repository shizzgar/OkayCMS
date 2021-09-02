<?php


namespace Okay\Modules\OkayCMS\NovaposhtaCost\Init;


use Okay\Admin\Helpers\BackendExportHelper;
use Okay\Admin\Helpers\BackendImportHelper;
use Okay\Admin\Helpers\BackendOrdersHelper;
use Okay\Admin\Requests\BackendProductsRequest;
use Okay\Core\EntityFactory;
use Okay\Core\Modules\AbstractInit;
use Okay\Core\Modules\EntityField;
use Okay\Core\ServiceLocator;
use Okay\Core\Settings;
use Okay\Entities\PaymentsEntity;
use Okay\Entities\VariantsEntity;
use Okay\Helpers\CartHelper;
use Okay\Helpers\DeliveriesHelper;
use Okay\Helpers\OrdersHelper;
use Okay\Modules\OkayCMS\NovaposhtaCost\Entities\NPCitiesEntity;
use Okay\Modules\OkayCMS\NovaposhtaCost\Entities\NPCostDeliveryDataEntity;
use Okay\Modules\OkayCMS\NovaposhtaCost\Entities\NPWarehousesEntity;
use Okay\Modules\OkayCMS\NovaposhtaCost\Extenders\BackendExtender;
use Okay\Modules\OkayCMS\NovaposhtaCost\Extenders\FrontExtender;

class Init extends AbstractInit
{
    
    const VOLUME_FIELD = 'volume';
    const CASH_ON_DELIVERY = 'novaposhta_cost__cash_on_delivery';

    public function install()
    {
        $this->setModuleType(MODULE_TYPE_DELIVERY);
        $this->setBackendMainController('NovaposhtaCostAdmin');
        $this->migrateEntityTable(NPCostDeliveryDataEntity::class, [
            (new EntityField('id'))->setIndexPrimaryKey()->setTypeInt(11, false)->setAutoIncrement(),
            (new EntityField('order_id'))->setTypeInt(11)->setIndex(),
            (new EntityField('city_id'))->setTypeVarchar(255, true),
            (new EntityField('warehouse_id'))->setTypeVarchar(255, true),
            (new EntityField('delivery_term'))->setTypeVarchar(8, true),
            (new EntityField('redelivery'))->setTypeTinyInt(1, true),
            (new EntityField('city_name'))->setTypeVarchar(255, true),
            (new EntityField('area_name'))->setTypeVarchar(255, true),
            (new EntityField('region_name'))->setTypeVarchar(255, true),
            (new EntityField('street'))->setTypeVarchar(255, true),
            (new EntityField('house'))->setTypeVarchar(255, true),
            (new EntityField('apartment'))->setTypeVarchar(255, true),
        ]);
        
        $this->migrateEntityTable(NPCitiesEntity::class, [
            (new EntityField('id'))->setIndexPrimaryKey()->setTypeInt(11, false)->setAutoIncrement(),
            (new EntityField('ref'))->setTypeVarchar(255)->setIndex(),
            (new EntityField('name'))->setTypeVarchar(255, true)->setIsLang()->setIndex(100),
        ]);
        
        $this->migrateEntityTable(NPWarehousesEntity::class, [
            (new EntityField('id'))->setIndexPrimaryKey()->setTypeInt(11, false)->setAutoIncrement(),
            (new EntityField('ref'))->setTypeVarchar(255),
            (new EntityField('city_ref'))->setTypeVarchar(255)->setIndex(),
            (new EntityField('name'))->setTypeVarchar(255, true)->setIsLang()->setIndex(100),
        ]);

        $this->migrateEntityField(VariantsEntity::class, (new EntityField(self::VOLUME_FIELD))->setTypeDecimal('10,5'));
        $this->migrateEntityField(PaymentsEntity::class, (new EntityField(self::CASH_ON_DELIVERY))->setTypeTinyInt(1));
    }

    public function init()
    {

        $this->registerEntityField(VariantsEntity::class, self::VOLUME_FIELD);
        $this->registerEntityField(PaymentsEntity::class, self::CASH_ON_DELIVERY);
        $this->registerEntityField(NPWarehousesEntity::class, 'type');
        
        $this->addPermission('okaycms__novaposhta_cost');

        $this->addBackendBlock('product_variant', 'product_variant_block.tpl');
        $this->addBackendBlock('order_contact', 'order_contact_block.tpl');
        $this->addFrontBlock('front_cart_delivery', 'front_cart_delivery_block.tpl');
        
        $this->registerChainExtension(
            ['class' => DeliveriesHelper::class, 'method' => 'prepareDeliveryPriceInfo'],
            ['class' => FrontExtender::class, 'method' => 'setCartDeliveryPrice']
        );
        
        $this->registerChainExtension(
            ['class' => CartHelper::class, 'method' => 'getDefaultCartData'],
            ['class' => FrontExtender::class, 'method' => 'getDefaultCartData']
        );
        
        $this->registerChainExtension(
            ['class' => DeliveriesHelper::class, 'method' => 'getCartDeliveriesList'],
            ['class' => FrontExtender::class, 'method' => 'getCartDeliveriesList']
        );
        
        $this->registerQueueExtension(
            ['class' => OrdersHelper::class, 'method' => 'finalCreateOrderProcedure'],
            ['class' => FrontExtender::class, 'method' => 'setCartDeliveryDataProcedure']
        );

        $this->registerChainExtension(
            ['class' => BackendProductsRequest::class, 'method' => 'postVariants'],
            ['class' => BackendExtender::class, 'method' => 'correctVariantsVolume']
        );
        
        // В админке в заказе достаём данные по доставке
        $this->registerQueueExtension(
            ['class' => BackendOrdersHelper::class, 'method' => 'findOrderDelivery'],
            ['class' => BackendExtender::class, 'method' => 'getDeliveryDataProcedure']
        );

        // В админке в заказе обновляем данные по доставке
        $this->registerQueueExtension(
            ['class' => BackendOrdersHelper::class, 'method' => 'executeCustomPost'],
            ['class' => BackendExtender::class, 'method' => 'updateDeliveryDataProcedure']
        );

        // Добавляемся в импорт
        $this->addBackendBlock('import_fields_association', 'import_fields_association.tpl');

        $this->registerChainExtension(
            ['class' => BackendImportHelper::class, 'method' => 'parseVariantData'],
            ['class' => BackendExtender::class, 'method' => 'parseVariantData']
        );

        $this->registerChainExtension(
            ['class' => BackendExportHelper::class, 'method' => 'getColumnsNames'],
            ['class' => BackendExtender::class, 'method' => 'extendExportColumnsNames']
        );

        $this->registerChainExtension(
            ['class' => BackendExportHelper::class, 'method' => 'prepareVariantsData'],
            ['class' => BackendExtender::class, 'method' => 'extendExportPrepareVariantData']
        );
        
        $this->registerBackendController('NovaposhtaCostAdmin');
        $this->addBackendControllerPermission('NovaposhtaCostAdmin', 'okaycms__novaposhta_cost');

        $this->registerSchedulerTask(
            'okaycms__novaposhta_cost__parse_cities_to_cache',
            '* * * * *',
            'php '.dirname(__DIR__).'/cron/update_cache.php',
            'Parses NP cities and warehouses to the db cache'
        );
    }

    public function update_1_1_0()
    {
        $this->migrateEntityField(NPWarehousesEntity::class, (new EntityField('type'))->setTypeVarchar(100, true)->setDefault(''));
        
        $defaultWarehouseTypes = [
            '841339c7-591a-42e2-8233-7a0a00f0ed6f',
            '9a68df70-0267-42a8-bb5c-37f427e36ee4'
        ];

        $SL = ServiceLocator::getInstance();
        $settings = $SL->getService(Settings::class);
        $entityFactory = $SL->getService(EntityFactory::class);
        
        $settings->set('np_warehouses_types', $defaultWarehouseTypes);
        
        $warehousesTypesData = (array)json_decode(file_get_contents(dirname(__FILE__,2).'/tempData/typeData.json'));
        
        /** @var NPWarehousesEntity $warehousesEntity */
        $warehousesEntity = $entityFactory->get(NPWarehousesEntity::class);

        $warehouses = $warehousesEntity->mappedBy('ref')->noLimit()->find();
        foreach ($warehouses as $ref => $warehouse) {
            if(isset($warehousesTypesData[$ref])){
                $warehousesEntity->update((int)$warehouse->id,['type' => $warehousesTypesData[$ref]]); 
            } 
        }
        $warehousesEntity->removeRedundant();
    }
}
